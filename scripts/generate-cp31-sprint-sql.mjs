import { readFile, writeFile } from "node:fs/promises";
import { resolve } from "node:path";

const root = resolve(import.meta.dirname, "..");
const source = JSON.parse(
  await readFile(resolve(root, "data", "cp31-august-2026.json"), "utf8"),
);

const q = (value) =>
  value === null || value === undefined
    ? "NULL"
    : `'${String(value).replaceAll("'", "''")}'`;
const json = (value) => q(JSON.stringify(value));
const schemaStatements = [
  `CREATE TABLE IF NOT EXISTS mashups (
  id TEXT PRIMARY KEY NOT NULL,
  sprint_id TEXT REFERENCES sprints(id) ON DELETE SET NULL,
  problem_ids_json TEXT NOT NULL DEFAULT '[]',
  active_problem_id TEXT,
  elapsed_by_problem_json TEXT NOT NULL DEFAULT '{}',
  duration_seconds INTEGER NOT NULL,
  started_at TEXT NOT NULL,
  ended_at TEXT,
  status TEXT NOT NULL DEFAULT 'active'
    CHECK (status IN ('active', 'completed')),
  created_at TEXT NOT NULL,
  updated_at TEXT NOT NULL
);`,
  `CREATE INDEX IF NOT EXISTS mashups_sprint_created_idx
ON mashups (sprint_id, created_at);`,
  `CREATE INDEX IF NOT EXISTS mashups_status_updated_idx
ON mashups (status, updated_at);`,
  `CREATE TABLE reviews_v2 (
  id TEXT PRIMARY KEY NOT NULL,
  idempotency_key TEXT,
  problem_id TEXT NOT NULL REFERENCES problems(id) ON DELETE CASCADE,
  reflection_id TEXT REFERENCES reflections(id) ON DELETE CASCADE,
  due_date TEXT NOT NULL,
  reviewed_at TEXT,
  outcome TEXT,
  deepest_reveal TEXT,
  recall_note TEXT,
  previous_interval_days INTEGER,
  next_review_date TEXT,
  schedule_version TEXT NOT NULL,
  timer_limit_seconds INTEGER,
  timer_elapsed_seconds INTEGER,
  created_at TEXT NOT NULL
);`,
  `INSERT INTO reviews_v2 (
  id, idempotency_key, problem_id, reflection_id, due_date, reviewed_at,
  outcome, deepest_reveal, recall_note, previous_interval_days,
  next_review_date, schedule_version, timer_limit_seconds,
  timer_elapsed_seconds, created_at
)
SELECT
  id, idempotency_key, problem_id, reflection_id, due_date, reviewed_at,
  outcome, deepest_reveal, recall_note, previous_interval_days,
  next_review_date, schedule_version, timer_limit_seconds,
  timer_elapsed_seconds, created_at
FROM reviews;`,
  `DROP TABLE reviews;`,
  `ALTER TABLE reviews_v2 RENAME TO reviews;`,
  `CREATE UNIQUE INDEX reviews_idempotency_unique
ON reviews (idempotency_key);`,
  `CREATE INDEX reviews_problem_idx
ON reviews (problem_id, created_at);`,
  `CREATE INDEX reviews_due_idx ON reviews (due_date);`,
  `UPDATE problems SET
  status = CASE WHEN status = 'backlog' THEN NULL ELSE status END,
  sprint_id = NULL,
  due_date = NULL
WHERE sprint_id = 'sprint-2026-08';`,
  `UPDATE sprints SET
  source = 'CP31 Sheet',
  target_json = '{"ratings":[1600,1700,1800,1900],"problems_per_band":31,"problems_per_day":5,"days_per_band":7,"plan_starts_on":"2026-08-05","plan_ends_on":"2026-09-01"}',
  starts_on = '2026-08-05',
  ends_on = '2026-09-01',
  updated_at = '2026-08-04T00:00:00.000Z'
WHERE id = 'sprint-2026-08';`,
];

const problemStatements = [];
for (const problem of source.records) {
  const provenance = {
    title: "codeforces_problem_page_2026_08_04",
    rating: "cp31_band_and_codeforces_page_2026_08_04",
    difficulty: "codeforces_rating_band_v1",
    official_tags: "codeforces_problem_page_2026_08_04",
    statement: "codeforces_problem_page_2026_08_04",
    sprint: "cp31_local_ordered_lists_2026_08_04",
  };
  problemStatements.push(`INSERT INTO problems (
  id, platform, problem_key, url, title, contest, problem_index, rating,
  difficulty, official_tags_json, statement_markdown, statement_assets_json,
  statement_hash, statement_captured_at, metadata_status,
  metadata_provenance_json, legacy_metadata_json, import_source,
  import_provenance_json, review_status, state, status, archived_at, due_date,
  sprint_id, next_review_date, created_at, updated_at
) VALUES (
  ${q(problem.id)}, 'codeforces', ${q(problem.problemKey)}, ${q(problem.url)},
  ${q(problem.title)}, ${q(problem.contest)}, ${q(problem.problemIndex)},
  ${q(problem.rating)}, ${q(problem.difficulty)}, ${json(problem.officialTags)},
  ${q(problem.statementMarkdown)}, ${json(problem.statementAssets)},
  ${q(problem.statementHash)}, ${q(problem.statementCapturedAt)}, 'complete',
  ${json(provenance)}, '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":${problem.order}}',
  'resolve', NULL, 'backlog', NULL, ${q(problem.dueDate)},
  'sprint-2026-08', NULL, '2026-08-04T00:00:00.000Z',
  '2026-08-04T00:00:00.000Z'
) ON CONFLICT(platform, problem_key) DO UPDATE SET
  url = excluded.url,
  title = CASE WHEN problems.title = '' THEN excluded.title ELSE problems.title END,
  contest = COALESCE(problems.contest, excluded.contest),
  problem_index = COALESCE(problems.problem_index, excluded.problem_index),
  rating = COALESCE(problems.rating, excluded.rating),
  difficulty = COALESCE(problems.difficulty, excluded.difficulty),
  official_tags_json = CASE
    WHEN problems.official_tags_json = '[]' THEN excluded.official_tags_json
    ELSE problems.official_tags_json END,
  statement_markdown = CASE
    WHEN problems.statement_markdown = '' THEN excluded.statement_markdown
    ELSE problems.statement_markdown END,
  statement_assets_json = CASE
    WHEN problems.statement_markdown = '' THEN excluded.statement_assets_json
    ELSE problems.statement_assets_json END,
  statement_hash = COALESCE(problems.statement_hash, excluded.statement_hash),
  statement_captured_at = COALESCE(
    problems.statement_captured_at,
    excluded.statement_captured_at
  ),
  metadata_status = CASE
    WHEN problems.statement_markdown = '' THEN excluded.metadata_status
    ELSE problems.metadata_status END,
  metadata_provenance_json = json_patch(
    excluded.metadata_provenance_json,
    problems.metadata_provenance_json
  ),
  status = COALESCE(problems.status, 'backlog'),
  due_date = excluded.due_date,
  sprint_id = excluded.sprint_id,
  import_provenance_json = json_patch(
    excluded.import_provenance_json,
    problems.import_provenance_json
  ),
  updated_at = excluded.updated_at;`);
}

await writeFile(
  resolve(root, "drizzle", "0004_sprint_mashups.sql"),
  `${schemaStatements.join("\n\n")}\n`,
);

const batchSize = 15;
const batchTags = [];
for (let offset = 0; offset < problemStatements.length; offset += batchSize) {
  const batchNumber = Math.floor(offset / batchSize) + 1;
  const migrationNumber = String(batchNumber + 4).padStart(4, "0");
  const suffix = String(batchNumber).padStart(2, "0");
  const tag = `${migrationNumber}_cp31_batch_${suffix}`;
  batchTags.push(tag);
  const batch = problemStatements.slice(offset, offset + batchSize);
  if (offset + batchSize >= problemStatements.length) batch.push("PRAGMA optimize;");
  await writeFile(
    resolve(root, "drizzle", `${tag}.sql`),
    `${batch.join("\n\n")}\n`,
  );
}

const journalPath = resolve(root, "drizzle", "meta", "_journal.json");
const journal = JSON.parse(await readFile(journalPath, "utf8"));
journal.entries = journal.entries.filter(
  (entry) => !String(entry.tag).includes("_cp31_batch_"),
);
for (const [index, tag] of batchTags.entries()) {
  journal.entries.push({
    idx: index + 5,
    version: "6",
    when: 1785801600000 + (index + 1) * 1000,
    tag,
    breakpoints: true,
  });
}
await writeFile(journalPath, `${JSON.stringify(journal, null, 2)}\n`);

console.log(
  `Wrote ${source.records.length} CP31 sprint upserts in ${batchTags.length} batches.`,
);
