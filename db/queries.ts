import type {
  ProblemDetail,
  ProblemListItem,
  RecordReviewInput,
  SaveReflectionInput,
} from "@/lib/contracts";
import { normalizeProblemUrl } from "@/lib/identity";
import { nextReviewDate, SCHEDULE_VERSION } from "@/lib/schedule";
import { sanitizeStatementMarkdown } from "@/lib/sanitize";
import { getD1 } from "./index";

type ListRow = {
  id: string;
  platform: "codeforces" | "cses";
  problem_key: string;
  title: string;
  contest: string | null;
  problem_index: string | null;
  rating: number | null;
  review_status: string;
  next_review_date: string | null;
  source_status: string | null;
  updated_at: string;
};

function parseJson<T>(value: string | null, fallback: T): T {
  if (!value) return fallback;
  try {
    return JSON.parse(value) as T;
  } catch {
    return fallback;
  }
}

function listItem(row: ListRow): ProblemListItem {
  return {
    id: row.id,
    platform: row.platform,
    problemKey: row.problem_key,
    title: row.title,
    contest: row.contest,
    problemIndex: row.problem_index,
    rating: row.rating,
    reviewStatus: row.review_status,
    nextReviewDate: row.next_review_date,
    sourceStatus: row.source_status,
    updatedAt: row.updated_at,
  };
}

export async function listProblems() {
  const d1 = await getD1();
  const result = await d1
    .prepare(
      `SELECT p.id, p.platform, p.problem_key, p.title, p.contest,
              p.problem_index, p.rating, p.review_status, p.next_review_date,
              r.source_status, p.updated_at
       FROM problems p
       LEFT JOIN reflections r ON r.id = (
         SELECT r2.id FROM reflections r2
         WHERE r2.problem_id = p.id
         ORDER BY r2.created_at DESC LIMIT 1
       )
       ORDER BY p.updated_at DESC`,
    )
    .all<ListRow>();
  return (result.results ?? []).map(listItem);
}

export async function getProblemById(
  id: string,
): Promise<ProblemDetail | null> {
  const d1 = await getD1();
  const problem = await d1
    .prepare(
      `SELECT p.*,
              r.id AS reflection_id,
              r.source_path,
              r.source_snapshot,
              r.source_status,
              r.transcript_messages_json,
              r.summary_markdown,
              r.structured_summary_json,
              r.memory_cue,
              r.confidence,
              r.first_review_date,
              r.created_at AS reflection_created_at
       FROM problems p
       LEFT JOIN reflections r ON r.id = (
         SELECT r2.id FROM reflections r2
         WHERE r2.problem_id = p.id
         ORDER BY r2.created_at DESC LIMIT 1
       )
       WHERE p.id = ?1`,
    )
    .bind(id)
    .first<Record<string, unknown>>();
  if (!problem) return null;
  const reviewResult = await d1
    .prepare(
      `SELECT id, due_date, reviewed_at, outcome, deepest_reveal, recall_note,
              next_review_date, schedule_version
       FROM reviews WHERE problem_id = ?1
       ORDER BY created_at DESC`,
    )
    .bind(id)
    .all<Record<string, string | null>>();

  return {
    id: String(problem.id),
    platform: problem.platform as "codeforces" | "cses",
    problemKey: String(problem.problem_key),
    title: String(problem.title),
    contest: (problem.contest as string | null) ?? null,
    problemIndex: (problem.problem_index as string | null) ?? null,
    rating: (problem.rating as number | null) ?? null,
    reviewStatus: String(problem.review_status),
    nextReviewDate: (problem.next_review_date as string | null) ?? null,
    sourceStatus: (problem.source_status as string | null) ?? null,
    updatedAt: String(problem.updated_at),
    url: String(problem.url),
    officialTags: parseJson(String(problem.official_tags_json), []),
    statementMarkdown: String(problem.statement_markdown),
    statementAssets: parseJson(String(problem.statement_assets_json), []),
    statementCapturedAt:
      (problem.statement_captured_at as string | null) ?? null,
    metadataStatus: String(problem.metadata_status),
    metadataProvenance: parseJson(String(problem.metadata_provenance_json), {}),
    legacyMetadata: parseJson(String(problem.legacy_metadata_json), {}),
    importSource: (problem.import_source as string | null) ?? null,
    importProvenance: parseJson(String(problem.import_provenance_json), {}),
    reflection: problem.reflection_id
      ? {
          id: String(problem.reflection_id),
          sourcePath: (problem.source_path as string | null) ?? null,
          sourceSnapshot: (problem.source_snapshot as string | null) ?? null,
          sourceStatus: String(problem.source_status),
          transcriptMessages: parseJson(
            String(problem.transcript_messages_json),
            [],
          ),
          summaryMarkdown: String(problem.summary_markdown),
          structuredSummary: parseJson(
            String(problem.structured_summary_json),
            {
              key_insight: "Not captured",
              wrong_mental_model: "Not captured",
              why_it_seemed_reasonable: "Not captured",
              breakthrough_observation: "Not captured",
              correct_trigger: "Not captured",
              missing_concepts: [],
              general_pattern: "Not captured",
              cognitive_mistakes: [],
              provenance: {},
            },
          ),
          memoryCue: String(problem.memory_cue),
          confidence: (problem.confidence as number | null) ?? null,
          firstReviewDate: (problem.first_review_date as string | null) ?? null,
          createdAt: String(problem.reflection_created_at),
        }
      : null,
    reviews: (reviewResult.results ?? []).map((review) => ({
      id: String(review.id),
      dueDate: String(review.due_date),
      reviewedAt: review.reviewed_at,
      outcome: review.outcome,
      deepestReveal: review.deepest_reveal,
      recallNote: review.recall_note,
      nextReviewDate: review.next_review_date,
      scheduleVersion: String(review.schedule_version),
    })),
  };
}

export async function getProblemByIdentity(
  platform: string,
  problemKey: string,
) {
  const d1 = await getD1();
  const row = await d1
    .prepare("SELECT id FROM problems WHERE platform = ?1 AND problem_key = ?2")
    .bind(platform, problemKey)
    .first<{ id: string }>();
  return row ? getProblemById(row.id) : null;
}

async function sha256(value: string) {
  const digest = await crypto.subtle.digest(
    "SHA-256",
    new TextEncoder().encode(value),
  );
  return [...new Uint8Array(digest)]
    .map((byte) => byte.toString(16).padStart(2, "0"))
    .join("");
}

export async function saveReflection(input: SaveReflectionInput) {
  const d1 = await getD1();
  const duplicate = await d1
    .prepare(
      `SELECT r.id AS reflection_id, r.problem_id, r.first_review_date
       FROM reflections r WHERE r.idempotency_key = ?1`,
    )
    .bind(input.idempotency_key)
    .first<{
      reflection_id: string;
      problem_id: string;
      first_review_date: string | null;
    }>();
  if (duplicate) return { ...duplicate, duplicate: true };

  const normalized = normalizeProblemUrl(input.problem.url);
  if (
    normalized.platform !== input.problem.platform ||
    normalized.problemKey !== input.problem.problem_key
  ) {
    throw new Error("Canonical problem identity does not match the URL");
  }

  const now = new Date().toISOString();
  const existing = await d1
    .prepare("SELECT id FROM problems WHERE platform = ?1 AND problem_key = ?2")
    .bind(input.problem.platform, input.problem.problem_key)
    .first<{ id: string }>();
  const problemId = existing?.id ?? crypto.randomUUID();
  const reflectionId = crypto.randomUUID();
  const sanitizedStatement = sanitizeStatementMarkdown(
    input.problem.statement_markdown,
    input.problem.url,
  );
  const transcriptJson = JSON.stringify(input.reflection.transcript_messages);

  const statements = [
    d1
      .prepare(
        `INSERT INTO problems (
          id, platform, problem_key, url, title, contest, problem_index, rating,
          official_tags_json, statement_markdown, statement_assets_json,
          statement_hash, statement_captured_at, metadata_status,
          metadata_provenance_json, legacy_metadata_json, import_source,
          import_provenance_json, review_status, next_review_date, created_at,
          updated_at
        ) VALUES (
          ?1, ?2, ?3, ?4, ?5, ?6, ?7, ?8, ?9, ?10, ?11, ?12, ?13, ?14,
          ?15, '{}', NULL, '{}', 'resolve', ?16, ?17, ?17
        )
        ON CONFLICT(platform, problem_key) DO UPDATE SET
          url = excluded.url,
          title = excluded.title,
          contest = excluded.contest,
          problem_index = excluded.problem_index,
          rating = excluded.rating,
          official_tags_json = excluded.official_tags_json,
          statement_markdown = excluded.statement_markdown,
          statement_assets_json = excluded.statement_assets_json,
          statement_hash = excluded.statement_hash,
          statement_captured_at = excluded.statement_captured_at,
          metadata_status = excluded.metadata_status,
          metadata_provenance_json = excluded.metadata_provenance_json,
          next_review_date = excluded.next_review_date,
          updated_at = excluded.updated_at`,
      )
      .bind(
        problemId,
        input.problem.platform,
        input.problem.problem_key,
        normalized.canonicalUrl,
        input.problem.title.trim(),
        input.problem.contest ?? null,
        input.problem.problem_index ?? null,
        input.problem.rating ?? null,
        JSON.stringify(input.problem.official_tags),
        sanitizedStatement,
        JSON.stringify(input.problem.statement_assets),
        await sha256(sanitizedStatement),
        now,
        input.problem.metadata_status,
        JSON.stringify(input.problem.metadata_provenance),
        input.reflection.first_review_date,
        now,
      ),
    d1
      .prepare(
        `INSERT INTO reflections (
          id, idempotency_key, problem_id, source_path, source_snapshot,
          source_status, transcript_messages_json, transcript_hash,
          summary_markdown, structured_summary_json, memory_cue, confidence,
          first_review_date, created_at
        ) VALUES (
          ?1, ?2, ?3, ?4, ?5, ?6, ?7, ?8, ?9, ?10, ?11, ?12, ?13, ?14
        )`,
      )
      .bind(
        reflectionId,
        input.idempotency_key,
        problemId,
        input.reflection.source_path ?? null,
        input.reflection.source_snapshot ?? null,
        input.reflection.source_status,
        transcriptJson,
        await sha256(transcriptJson),
        input.reflection.summary_markdown,
        JSON.stringify(input.reflection.structured_summary),
        input.reflection.memory_cue,
        input.reflection.confidence ?? null,
        input.reflection.first_review_date,
        now,
      ),
  ];

  try {
    await d1.batch(statements);
  } catch (error) {
    const raced = await d1
      .prepare(
        `SELECT id AS reflection_id, problem_id, first_review_date
         FROM reflections WHERE idempotency_key = ?1`,
      )
      .bind(input.idempotency_key)
      .first<{
        reflection_id: string;
        problem_id: string;
        first_review_date: string | null;
      }>();
    if (raced) return { ...raced, duplicate: true };
    throw error;
  }
  return {
    problem_id: problemId,
    reflection_id: reflectionId,
    first_review_date: input.reflection.first_review_date,
    duplicate: false,
  };
}

export async function listDueReviews(date: string) {
  const problems = await listProblems();
  return problems.filter(
    (problem) =>
      problem.nextReviewDate !== null && problem.nextReviewDate <= date,
  );
}

export async function recordReview(input: RecordReviewInput) {
  const d1 = await getD1();
  const duplicate = await d1
    .prepare(
      `SELECT id AS review_id, next_review_date
       FROM reviews WHERE idempotency_key = ?1`,
    )
    .bind(input.idempotency_key)
    .first<{ review_id: string; next_review_date: string | null }>();
  if (duplicate) return { ...duplicate, duplicate: true };

  const today = new Intl.DateTimeFormat("en-CA", {
    timeZone: "Asia/Dhaka",
    year: "numeric",
    month: "2-digit",
    day: "2-digit",
  }).format(new Date());
  const nextDate =
    input.next_review_date ?? nextReviewDate(today, input.outcome);
  const now = new Date().toISOString();
  const reviewId = crypto.randomUUID();
  await d1.batch([
    d1
      .prepare(
        `INSERT INTO reviews (
          id, idempotency_key, problem_id, reflection_id, due_date, reviewed_at,
          outcome, deepest_reveal, recall_note, previous_interval_days,
          next_review_date, schedule_version, created_at
        ) VALUES (
          ?1, ?2, ?3, ?4, ?5, ?6, ?7, ?8, ?9, ?10, ?11, ?12, ?6
        )`,
      )
      .bind(
        reviewId,
        input.idempotency_key,
        input.problem_id,
        input.reflection_id,
        input.due_date,
        now,
        input.outcome,
        input.deepest_reveal,
        input.recall_note,
        input.previous_interval_days ?? null,
        nextDate,
        SCHEDULE_VERSION,
      ),
    d1
      .prepare(
        `UPDATE problems
         SET next_review_date = ?1,
             review_status = CASE
               WHEN ?2 = 'recalled' THEN 'revise'
               WHEN ?2 = 'needed_cue' THEN 'revise'
               WHEN ?2 = 'forgot' THEN 'retry'
               ELSE 'resolve'
             END,
             updated_at = ?3
         WHERE id = ?4`,
      )
      .bind(nextDate, input.outcome, now, input.problem_id),
  ]);
  return { review_id: reviewId, next_review_date: nextDate, duplicate: false };
}

export async function updateProblemProperties(
  id: string,
  input: {
    rating?: number | null;
    reviewStatus?: "retry" | "revise" | "resolve";
    nextReviewDate?: string | null;
  },
) {
  const d1 = await getD1();
  const current = await d1
    .prepare(
      "SELECT rating, review_status, next_review_date FROM problems WHERE id = ?1",
    )
    .bind(id)
    .first<{
      rating: number | null;
      review_status: string;
      next_review_date: string | null;
    }>();
  if (!current) return false;
  await d1
    .prepare(
      `UPDATE problems SET rating = ?1, review_status = ?2,
       next_review_date = ?3, updated_at = ?4 WHERE id = ?5`,
    )
    .bind(
      input.rating === undefined ? current.rating : input.rating,
      input.reviewStatus ?? current.review_status,
      input.nextReviewDate === undefined
        ? current.next_review_date
        : input.nextReviewDate,
      new Date().toISOString(),
      id,
    )
    .run();
  return true;
}

export async function listSavedViews() {
  const d1 = await getD1();
  const result = await d1
    .prepare(
      `SELECT id, name, filter_json, sort_json, visible_columns_json, is_default
       FROM saved_views ORDER BY is_default DESC, created_at ASC`,
    )
    .all<{
      id: string;
      name: string;
      filter_json: string;
      sort_json: string;
      visible_columns_json: string;
      is_default: number;
    }>();
  return (result.results ?? []).map((view) => ({
    id: view.id,
    name: view.name,
    filter: parseJson(view.filter_json, {}),
    sort: parseJson(view.sort_json, []),
    visibleColumns: parseJson(view.visible_columns_json, []),
    isDefault: Boolean(view.is_default),
  }));
}

export async function saveCustomView(input: {
  name: string;
  filter: unknown;
  sort: unknown;
  visibleColumns: unknown;
}) {
  const d1 = await getD1();
  const id = crypto.randomUUID();
  const now = new Date().toISOString();
  await d1
    .prepare(
      `INSERT INTO saved_views (
        id, name, filter_json, sort_json, visible_columns_json, is_default,
        created_at, updated_at
      ) VALUES (?1, ?2, ?3, ?4, ?5, 0, ?6, ?6)`,
    )
    .bind(
      id,
      input.name,
      JSON.stringify(input.filter),
      JSON.stringify(input.sort),
      JSON.stringify(input.visibleColumns),
      now,
    )
    .run();
  return { id };
}
