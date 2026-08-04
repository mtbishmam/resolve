import type {
  CreateMashupInput,
  Mashup,
  ProblemDetail,
  ProblemListItem,
  RecordReviewInput,
  SaveReflectionInput,
  UpdateMashupInput,
} from "@/lib/contracts";
import { difficultyFromRating, type Difficulty } from "@/lib/difficulty";
import { normalizeProblemUrl } from "@/lib/identity";
import { nextReviewDate, SCHEDULE_VERSION } from "@/lib/schedule";
import { sanitizeStatementMarkdown } from "@/lib/sanitize";
import type { ProblemState, ProblemStatus } from "@/lib/workflow";
import { getD1 } from "./index";

function parseJson<T>(value: unknown, fallback: T): T {
  if (typeof value !== "string" || !value) return fallback;
  try {
    return JSON.parse(value) as T;
  } catch {
    return fallback;
  }
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

function listItem(row: Record<string, unknown>): ProblemListItem {
  return {
    id: String(row.id),
    platform: row.platform as "codeforces" | "cses" | "atcoder",
    problemKey: String(row.problem_key),
    title: String(row.title),
    contest: (row.contest as string | null) ?? null,
    problemIndex: (row.problem_index as string | null) ?? null,
    rating: (row.rating as number | null) ?? null,
    difficulty: (row.difficulty as Difficulty | null) ?? null,
    state: (row.state as ProblemState | null) ?? null,
    status: (row.status as ProblemStatus | null) ?? null,
    archivedAt: (row.archived_at as string | null) ?? null,
    dueDate: (row.due_date as string | null) ?? null,
    sprintId: (row.sprint_id as string | null) ?? null,
    nextReviewDate: (row.next_review_date as string | null) ?? null,
    officialTags: parseJson(row.official_tags_json, []),
    sourceStatus: (row.source_status as string | null) ?? null,
    updatedAt: String(row.updated_at),
  };
}

export async function listProblems() {
  const d1 = await getD1();
  const result = await d1
    .prepare(
      `SELECT p.id, p.platform, p.problem_key, p.title, p.contest,
              p.problem_index, p.rating, p.difficulty, p.state, p.status,
              p.archived_at, p.due_date, p.sprint_id, p.next_review_date,
              p.official_tags_json, r.source_status, p.updated_at
       FROM problems p
       LEFT JOIN reflections r ON r.id = (
         SELECT r2.id FROM reflections r2
         WHERE r2.problem_id = p.id
         ORDER BY r2.created_at DESC LIMIT 1
       )
       ORDER BY p.updated_at DESC`,
    )
    .all<Record<string, unknown>>();
  return (result.results ?? []).map(listItem);
}

export async function getProblemById(
  id: string,
): Promise<ProblemDetail | null> {
  const d1 = await getD1();
  const problem = await d1
    .prepare(
      `SELECT p.*, r.id AS reflection_id, r.source_path, r.source_snapshot,
              r.source_status, r.transcript_messages_json, r.summary_markdown,
              r.structured_summary_json, r.memory_cue, r.confidence,
              r.first_review_date, r.created_at AS reflection_created_at
       FROM problems p
       LEFT JOIN reflections r ON r.id = (
         SELECT r2.id FROM reflections r2 WHERE r2.problem_id = p.id
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
              next_review_date, schedule_version, timer_limit_seconds,
              timer_elapsed_seconds
       FROM reviews WHERE problem_id = ?1 ORDER BY created_at DESC`,
    )
    .bind(id)
    .all<Record<string, unknown>>();
  const base = listItem(problem);
  return {
    ...base,
    url: String(problem.url),
    officialTags: parseJson(problem.official_tags_json, []),
    statementMarkdown: String(problem.statement_markdown),
    statementAssets: parseJson(problem.statement_assets_json, []),
    statementCapturedAt:
      (problem.statement_captured_at as string | null) ?? null,
    metadataStatus: String(problem.metadata_status),
    metadataProvenance: parseJson(problem.metadata_provenance_json, {}),
    legacyMetadata: parseJson(problem.legacy_metadata_json, {}),
    importSource: (problem.import_source as string | null) ?? null,
    importProvenance: parseJson(problem.import_provenance_json, {}),
    reflection: problem.reflection_id
      ? {
          id: String(problem.reflection_id),
          sourcePath: (problem.source_path as string | null) ?? null,
          sourceSnapshot: (problem.source_snapshot as string | null) ?? null,
          sourceStatus: String(problem.source_status),
          transcriptMessages: parseJson(problem.transcript_messages_json, []),
          summaryMarkdown: String(problem.summary_markdown),
          structuredSummary: parseJson(problem.structured_summary_json, {
            key_insight: "Not captured",
            wrong_mental_model: "Not captured",
            why_it_seemed_reasonable: "Not captured",
            breakthrough_observation: "Not captured",
            correct_trigger: "Not captured",
            missing_concepts: [],
            general_pattern: "Not captured",
            cognitive_mistakes: [],
            provenance: {},
          }),
          memoryCue: String(problem.memory_cue),
          confidence: (problem.confidence as number | null) ?? null,
          firstReviewDate: (problem.first_review_date as string | null) ?? null,
          createdAt: String(problem.reflection_created_at),
        }
      : null,
    reviews: (reviewResult.results ?? []).map((review) => ({
      id: String(review.id),
      dueDate: String(review.due_date),
      reviewedAt: (review.reviewed_at as string | null) ?? null,
      outcome: (review.outcome as string | null) ?? null,
      deepestReveal: (review.deepest_reveal as string | null) ?? null,
      recallNote: (review.recall_note as string | null) ?? null,
      nextReviewDate: (review.next_review_date as string | null) ?? null,
      scheduleVersion: String(review.schedule_version),
      timerLimitSeconds:
        review.timer_limit_seconds == null
          ? null
          : Number(review.timer_limit_seconds),
      timerElapsedSeconds:
        review.timer_elapsed_seconds == null
          ? null
          : Number(review.timer_elapsed_seconds),
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

export async function saveReflection(input: SaveReflectionInput) {
  const d1 = await getD1();
  const duplicate = await d1
    .prepare(
      `SELECT id AS reflection_id, problem_id, first_review_date
       FROM reflections WHERE idempotency_key = ?1`,
    )
    .bind(input.idempotency_key)
    .first<Record<string, string | null>>();
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
  const statement = sanitizeStatementMarkdown(
    input.problem.statement_markdown,
    input.problem.url,
  );
  const transcriptJson = JSON.stringify(input.reflection.transcript_messages);
  const rating = input.problem.rating ?? null;
  const difficulty =
    rating === null
      ? (input.problem.difficulty ?? null)
      : difficultyFromRating(rating);
  const metadataProvenance = {
    ...input.problem.metadata_provenance,
    difficulty:
      rating === null
        ? "codex_adaptive_v1"
        : `${input.problem.platform}_rating_band_v1`,
  };

  try {
    await d1.batch([
      d1
        .prepare(
          `INSERT INTO problems (
            id, platform, problem_key, url, title, contest, problem_index,
            rating, difficulty, official_tags_json, statement_markdown,
            statement_assets_json, statement_hash, statement_captured_at,
            metadata_status, metadata_provenance_json, legacy_metadata_json,
            import_source, import_provenance_json, review_status, state, status,
            due_date, sprint_id, next_review_date, created_at, updated_at
          ) VALUES (
            ?1, ?2, ?3, ?4, ?5, ?6, ?7, ?8, ?9, ?10, ?11, ?12, ?13, ?14,
            ?15, ?16, '{}', NULL, '{}', ?17, ?18, ?19, ?20, ?21, ?22, ?23, ?23
          )
          ON CONFLICT(platform, problem_key) DO UPDATE SET
            url=excluded.url, title=excluded.title, contest=excluded.contest,
            problem_index=excluded.problem_index, rating=excluded.rating,
            difficulty=excluded.difficulty,
            official_tags_json=excluded.official_tags_json,
            statement_markdown=excluded.statement_markdown,
            statement_assets_json=excluded.statement_assets_json,
            statement_hash=excluded.statement_hash,
            statement_captured_at=excluded.statement_captured_at,
            metadata_status=excluded.metadata_status,
            metadata_provenance_json=excluded.metadata_provenance_json,
            review_status=excluded.review_status,
            state=excluded.state,
            status=excluded.status,
            next_review_date=excluded.next_review_date,
            updated_at=excluded.updated_at`,
        )
        .bind(
          problemId,
          input.problem.platform,
          input.problem.problem_key,
          normalized.canonicalUrl,
          input.problem.title.trim(),
          input.problem.contest ?? null,
          input.problem.problem_index ?? null,
          rating,
          difficulty,
          JSON.stringify(input.problem.official_tags),
          statement,
          JSON.stringify(input.problem.statement_assets),
          await sha256(statement),
          now,
          input.problem.metadata_status,
          JSON.stringify(metadataProvenance),
          input.problem.state ?? "resolve",
          input.problem.state ?? null,
          input.problem.status,
          input.problem.due_date ?? null,
          input.problem.sprint_id ?? null,
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
    ]);
  } catch (error) {
    const raced = await d1
      .prepare(
        `SELECT id AS reflection_id, problem_id, first_review_date
         FROM reflections WHERE idempotency_key = ?1`,
      )
      .bind(input.idempotency_key)
      .first<Record<string, string | null>>();
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
  return (await listProblems()).filter(
    (problem) =>
      problem.archivedAt === null &&
      problem.nextReviewDate !== null &&
      problem.nextReviewDate <= date,
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
    .first<Record<string, string | null>>();
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
          next_review_date, schedule_version, timer_limit_seconds,
          timer_elapsed_seconds, created_at
        ) VALUES (
          ?1, ?2, ?3, ?4, ?5, ?6, ?7, ?8, ?9, ?10, ?11, ?12, ?13, ?14, ?6
        )`,
      )
      .bind(
        reviewId,
        input.idempotency_key,
        input.problem_id,
        input.reflection_id ?? null,
        input.due_date,
        now,
        input.outcome,
        input.deepest_reveal,
        input.recall_note,
        input.previous_interval_days ?? null,
        nextDate,
        SCHEDULE_VERSION,
        input.timer_limit_seconds ?? null,
        input.timer_elapsed_seconds ?? null,
      ),
    d1
      .prepare(
        `UPDATE problems
         SET next_review_date = ?1,
             archived_at = CASE
               WHEN state = 'revise' AND ?2 = 'recalled' THEN ?3
               ELSE archived_at
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
    difficulty?: Difficulty | null;
    state?: ProblemState | null;
    status?: ProblemStatus | null;
    archived?: boolean;
    dueDate?: string | null;
    sprintId?: string | null;
    nextReviewDate?: string | null;
    officialTags?: string[];
  },
) {
  const d1 = await getD1();
  const current = await d1
    .prepare(
      `SELECT rating, difficulty, state, status, archived_at, due_date, sprint_id,
              next_review_date, official_tags_json
       FROM problems WHERE id = ?1`,
    )
    .bind(id)
    .first<Record<string, unknown>>();
  if (!current) return false;
  const rating =
    input.rating === undefined
      ? ((current.rating as number | null) ?? null)
      : input.rating;
  const difficulty =
    rating !== null
      ? difficultyFromRating(rating)
      : input.difficulty !== undefined
        ? input.difficulty
        : input.rating === null
          ? null
          : ((current.difficulty as Difficulty | null) ?? null);
  const provenance =
    difficulty === null
      ? null
      : rating !== null
        ? "codeforces_rating_band_v1"
        : "manual_property_edit_v1";
  const state =
    input.state === undefined
      ? ((current.state as ProblemState | null) ?? null)
      : input.state;
  const status =
    input.status === undefined
      ? ((current.status as ProblemStatus | null) ?? null)
      : input.status;
  const archivedAt =
    input.archived === undefined
      ? ((current.archived_at as string | null) ?? null)
      : input.archived
        ? new Date().toISOString()
        : null;
  const tags =
    input.officialTags === undefined
      ? parseJson<string[]>(current.official_tags_json, [])
      : [
          ...new Set(
            input.officialTags.map((tag) => tag.trim()).filter(Boolean),
          ),
        ];
  const now = new Date().toISOString();
  await d1
    .prepare(
      `UPDATE problems SET rating=?1, difficulty=?2, state=?3,
       review_status=COALESCE(?3, review_status), status=?4, archived_at=?5,
       due_date=?6, sprint_id=?7, next_review_date=?8, official_tags_json=?9,
       metadata_provenance_json=CASE WHEN ?10 IS NULL
         THEN json_remove(metadata_provenance_json, '$.difficulty')
         ELSE json_set(metadata_provenance_json, '$.difficulty', ?10) END,
       updated_at=?11 WHERE id=?12`,
    )
    .bind(
      rating,
      difficulty,
      state,
      status,
      archivedAt,
      input.dueDate === undefined ? current.due_date : input.dueDate,
      input.sprintId === undefined ? current.sprint_id : input.sprintId,
      input.nextReviewDate === undefined
        ? current.next_review_date
        : input.nextReviewDate,
      JSON.stringify(tags),
      provenance,
      now,
      id,
    )
    .run();
  return true;
}

export async function updateReflection(
  id: string,
  input: {
    summaryMarkdown?: string;
    structuredSummary?: Record<string, unknown>;
    memoryCue?: string;
    confidence?: number | null;
  },
) {
  const d1 = await getD1();
  const current = await d1
    .prepare(
      `SELECT summary_markdown, structured_summary_json, memory_cue, confidence
       FROM reflections WHERE id=?1`,
    )
    .bind(id)
    .first<Record<string, unknown>>();
  if (!current) return false;
  await d1
    .prepare(
      `UPDATE reflections SET summary_markdown=?1,
       structured_summary_json=?2, memory_cue=?3, confidence=?4 WHERE id=?5`,
    )
    .bind(
      input.summaryMarkdown ?? current.summary_markdown,
      input.structuredSummary === undefined
        ? current.structured_summary_json
        : JSON.stringify(input.structuredSummary),
      input.memoryCue ?? current.memory_cue,
      input.confidence === undefined ? current.confidence : input.confidence,
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
       FROM saved_views ORDER BY CASE id
         WHEN 'view-due-today' THEN 1 WHEN 'view-revise' THEN 2
         WHEN 'view-retry' THEN 3 WHEN 'view-resolve' THEN 4
         WHEN 'view-all' THEN 5 WHEN 'view-pending-ac' THEN 6
         WHEN 'view-archived' THEN 7 ELSE 100 END, created_at`,
    )
    .all<Record<string, unknown>>();
  return (result.results ?? []).map((view) => ({
    id: String(view.id),
    name: String(view.name),
    filter: parseJson(view.filter_json, {}),
    sort: parseJson(view.sort_json, []),
    visibleColumns: parseJson(view.visible_columns_json, []),
    isDefault: Boolean(view.is_default),
    isCore: String(view.id).startsWith("view-"),
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

export async function deleteCustomView(id: string) {
  if (id.startsWith("view-")) return false;
  const d1 = await getD1();
  const result = await d1
    .prepare("DELETE FROM saved_views WHERE id=?1")
    .bind(id)
    .run();
  return Number(result.meta.changes ?? 0) > 0;
}

export async function listSprints() {
  const d1 = await getD1();
  const result = await d1
    .prepare(
      `SELECT id, name, month, source, target_json, starts_on, ends_on
       FROM sprints ORDER BY month`,
    )
    .all<Record<string, unknown>>();
  return (result.results ?? []).map((row) => ({
    id: String(row.id),
    name: String(row.name),
    month: String(row.month),
    source: (row.source as string | null) ?? null,
    target: parseJson(row.target_json, {}),
    startsOn: String(row.starts_on),
    endsOn: String(row.ends_on),
  }));
}

function mashupItem(row: Record<string, unknown>): Mashup {
  return {
    id: String(row.id),
    sprintId: (row.sprint_id as string | null) ?? null,
    problemIds: parseJson<string[]>(row.problem_ids_json, []),
    activeProblemId: (row.active_problem_id as string | null) ?? null,
    elapsedByProblem: parseJson<Record<string, number>>(
      row.elapsed_by_problem_json,
      {},
    ),
    durationSeconds: Number(row.duration_seconds),
    startedAt: String(row.started_at),
    endedAt: (row.ended_at as string | null) ?? null,
    status: row.status as "active" | "completed",
    createdAt: String(row.created_at),
    updatedAt: String(row.updated_at),
  };
}

export async function listMashups(sprintId?: string | null) {
  const d1 = await getD1();
  const statement = sprintId
    ? d1
        .prepare(
          `SELECT * FROM mashups WHERE sprint_id = ?1 ORDER BY created_at DESC`,
        )
        .bind(sprintId)
    : d1.prepare(`SELECT * FROM mashups ORDER BY created_at DESC`);
  const result = await statement.all<Record<string, unknown>>();
  return (result.results ?? []).map(mashupItem);
}

export async function createMashup(input: CreateMashupInput) {
  const d1 = await getD1();
  const placeholders = input.problem_ids.map((_, index) => `?${index + 1}`);
  const existing = await d1
    .prepare(`SELECT id FROM problems WHERE id IN (${placeholders.join(", ")})`)
    .bind(...input.problem_ids)
    .all<{ id: string }>();
  if ((existing.results ?? []).length !== input.problem_ids.length) {
    throw new Error("One or more selected problems do not exist");
  }
  const id = crypto.randomUUID();
  const now = new Date().toISOString();
  const initialElapsed = {
    [input.problem_ids[0]]: Math.max(
      0,
      Math.floor((Date.parse(now) - Date.parse(input.started_at)) / 1000),
    ),
  };
  await d1
    .prepare(
      `INSERT INTO mashups (
        id, sprint_id, problem_ids_json, active_problem_id,
        elapsed_by_problem_json, duration_seconds, started_at, ended_at,
        status, created_at, updated_at
      ) VALUES (?1, ?2, ?3, ?4, ?5, ?6, ?7, NULL, 'active', ?8, ?8)`,
    )
    .bind(
      id,
      input.sprint_id ?? null,
      JSON.stringify(input.problem_ids),
      input.problem_ids[0],
      JSON.stringify(initialElapsed),
      input.duration_seconds,
      input.started_at,
      now,
    )
    .run();
  return (await getMashup(id))!;
}

export async function getMashup(id: string) {
  const d1 = await getD1();
  const row = await d1
    .prepare(`SELECT * FROM mashups WHERE id = ?1`)
    .bind(id)
    .first<Record<string, unknown>>();
  return row ? mashupItem(row) : null;
}

export async function updateMashup(id: string, input: UpdateMashupInput) {
  const current = await getMashup(id);
  if (!current) return null;
  const problemIds = new Set(current.problemIds);
  if (
    input.active_problem_id !== undefined &&
    input.active_problem_id !== null &&
    !problemIds.has(input.active_problem_id)
  ) {
    throw new Error("The active problem is not part of this mashup");
  }
  const elapsed =
    input.elapsed_by_problem === undefined
      ? current.elapsedByProblem
      : Object.fromEntries(
          Object.entries(input.elapsed_by_problem).filter(([problemId]) =>
            problemIds.has(problemId),
          ),
        );
  const status = input.status ?? current.status;
  const now = new Date().toISOString();
  const d1 = await getD1();
  await d1
    .prepare(
      `UPDATE mashups SET active_problem_id = ?1,
       elapsed_by_problem_json = ?2, status = ?3,
       ended_at = CASE WHEN ?3 = 'completed' THEN COALESCE(ended_at, ?4)
                       ELSE NULL END,
       updated_at = ?4 WHERE id = ?5`,
    )
    .bind(
      input.active_problem_id === undefined
        ? current.activeProblemId
        : input.active_problem_id,
      JSON.stringify(elapsed),
      status,
      now,
      id,
    )
    .run();
  return getMashup(id);
}
