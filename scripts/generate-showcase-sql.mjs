import { readFile, writeFile } from "node:fs/promises";
import { resolve } from "node:path";

const root = resolve(import.meta.dirname, "..");
const data = JSON.parse(
  await readFile(resolve(root, "data", "showcase.json"), "utf8"),
);
const q = (value) =>
  value === null || value === undefined
    ? "NULL"
    : `'${String(value).replaceAll("'", "''")}'`;
const json = (value) => q(JSON.stringify(value));
const statements = [];

for (const { problem, reflection } of data.records) {
  statements.push(`INSERT INTO problems (
  id, platform, problem_key, url, title, contest, problem_index, rating,
  official_tags_json, statement_markdown, statement_assets_json, statement_hash,
  statement_captured_at, metadata_status, metadata_provenance_json,
  legacy_metadata_json, import_source, import_provenance_json, review_status,
  next_review_date, created_at, updated_at
) VALUES (
  ${q(problem.id)}, ${q(problem.platform)}, ${q(problem.problemKey)}, ${q(problem.url)},
  ${q(problem.title)}, ${q(problem.contest)}, ${q(problem.problemIndex)}, ${q(problem.rating)},
  ${json(problem.officialTags)}, ${q(problem.statementMarkdown)}, ${json(problem.statementAssets)},
  ${q(problem.statementHash)}, ${q(problem.statementCapturedAt)}, ${q(problem.metadataStatus)},
  ${json(problem.metadataProvenance)}, ${json(problem.legacyMetadata)}, ${q(problem.importSource)},
  ${json(problem.importProvenance)}, ${q(problem.reviewStatus)}, ${q(problem.nextReviewDate)},
  ${q(problem.createdAt)}, ${q(problem.updatedAt)}
) ON CONFLICT(platform, problem_key) DO UPDATE SET
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
  legacy_metadata_json = excluded.legacy_metadata_json,
  import_source = excluded.import_source,
  import_provenance_json = excluded.import_provenance_json,
  updated_at = excluded.updated_at;`);

  statements.push(`INSERT INTO reflections (
  id, idempotency_key, problem_id, source_path, source_snapshot, source_status,
  transcript_messages_json, transcript_hash, summary_markdown,
  structured_summary_json, memory_cue, confidence, first_review_date, created_at
) VALUES (
  ${q(reflection.id)}, ${q(reflection.idempotencyKey)}, ${q(problem.id)},
  ${q(reflection.sourcePath)}, ${q(reflection.sourceSnapshot)}, ${q(reflection.sourceStatus)},
  ${json(reflection.transcriptMessages)}, ${q(reflection.transcriptHash)},
  ${q(reflection.summaryMarkdown)}, ${json(reflection.structuredSummary)},
  ${q(reflection.memoryCue)}, ${q(reflection.confidence)}, ${q(reflection.firstReviewDate)},
  ${q(reflection.createdAt)}
) ON CONFLICT(idempotency_key) DO NOTHING;`);
}

for (const view of data.views) {
  statements.push(`INSERT INTO saved_views (
  id, name, filter_json, sort_json, visible_columns_json, is_default,
  created_at, updated_at
) VALUES (
  ${q(view.id)}, ${q(view.name)}, ${json({
    schema: "resolve.filter.v1",
    ...view.filter,
  })}, ${json(view.sort)}, ${json(view.visibleColumns)}, ${view.isDefault ? 1 : 0},
  '2026-07-30T00:00:00.000Z', '2026-07-30T00:00:00.000Z'
) ON CONFLICT(id) DO UPDATE SET
  name = excluded.name,
  filter_json = excluded.filter_json,
  sort_json = excluded.sort_json,
  visible_columns_json = excluded.visible_columns_json,
  is_default = excluded.is_default,
  updated_at = excluded.updated_at;`);
}

await writeFile(
  resolve(root, "drizzle", "0001_showcase.sql"),
  `${statements.join("\n\n")}\n`,
);
console.log(`Wrote ${statements.length} idempotent seed statements.`);
