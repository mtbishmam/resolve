import { execFileSync } from "node:child_process";
import { mkdtemp, readdir, rm } from "node:fs/promises";
import { tmpdir } from "node:os";
import { join, resolve } from "node:path";
import assert from "node:assert/strict";

const root = resolve(import.meta.dirname, "..");
const temp = await mkdtemp(join(tmpdir(), "resolve-d1-test-"));
const wrangler = resolve(
  root,
  "node_modules",
  "wrangler",
  "bin",
  "wrangler.js",
);
const config = resolve(root, "wrangler.local.jsonc");

function d1(args) {
  return execFileSync(
    process.execPath,
    [
      wrangler,
      "d1",
      "execute",
      "resolve-local",
      "--config",
      config,
      "--local",
      "--persist-to",
      temp,
      ...args,
    ],
    { cwd: root, encoding: "utf8", env: { ...process.env, NO_COLOR: "1" } },
  );
}

function query(sql) {
  const output = d1(["--command", sql, "--json"]);
  const start = output.indexOf("[");
  return JSON.parse(output.slice(start))[0].results;
}

try {
  d1(["--file", resolve(root, "drizzle", "0000_resolve_mvp.sql")]);
  d1(["--file", resolve(root, "drizzle", "0001_showcase.sql")]);
  d1([
    "--command",
    `INSERT INTO problems (
       id, platform, problem_key, url, title, contest, problem_index, rating,
       official_tags_json, statement_markdown, statement_assets_json,
       statement_hash, statement_captured_at, metadata_status,
       metadata_provenance_json, legacy_metadata_json, import_source,
       import_provenance_json, review_status, next_review_date, created_at,
       updated_at
     )
     SELECT
       'cf-not-a-demo', platform, '9999:A',
       'https://codeforces.com/contest/9999/problem/A', 'Not a demo', contest,
       'A', 1700, official_tags_json, statement_markdown,
       statement_assets_json, statement_hash, statement_captured_at,
       metadata_status, metadata_provenance_json, legacy_metadata_json,
       import_source, import_provenance_json, review_status, next_review_date,
       created_at, updated_at
     FROM problems WHERE id = 'cf-1554-b'`,
  ]);
  d1(["--file", resolve(root, "drizzle", "0002_problem_difficulty.sql")]);
  d1([
    "--command",
    `INSERT INTO saved_views (
       id, name, filter_json, sort_json, visible_columns_json, is_default,
       created_at, updated_at
     ) VALUES (
       'rereerere-test', 'Rereerere',
       '{"schema":"resolve.filter.v1","status":["retry"]}', '[]', '[]', 0,
       '2026-07-30T00:00:00.000Z', '2026-07-30T00:00:00.000Z'
     )`,
  ]);
  d1(["--file", resolve(root, "drizzle", "0003_workflow_sprints.sql")]);
  d1(["--file", resolve(root, "drizzle", "0004_sprint_mashups.sql")]);
  const sprintBatches = (await readdir(resolve(root, "drizzle")))
    .filter((file) => /^00\d\d_cp31_batch_\d\d\.sql$/.test(file))
    .sort();
  for (const batch of sprintBatches) {
    d1(["--file", resolve(root, "drizzle", batch)]);
  }
  d1([
    "--command",
    `INSERT INTO reviews (
       id, idempotency_key, problem_id, reflection_id, due_date, reviewed_at,
       outcome, deepest_reveal, recall_note, previous_interval_days,
       next_review_date, schedule_version, timer_limit_seconds,
       timer_elapsed_seconds, created_at
     ) VALUES (
       'retry-without-reflection', 'retry-without-reflection',
       (SELECT id FROM problems WHERE sprint_id = 'sprint-2026-08' LIMIT 1),
       NULL, '2026-08-05', '2026-08-05T00:00:00.000Z', 'unresolved',
       'none', '', NULL, '2026-08-06', 'initial-v1', 1800, 1811,
       '2026-08-05T00:00:00.000Z'
     )`,
  ]);
  d1(["--file", resolve(root, "drizzle", "0001_showcase.sql")]);
  const counts = query(`SELECT
    (SELECT COUNT(*) FROM problems) AS problems,
    (SELECT COUNT(*) FROM reflections) AS reflections,
    (SELECT COUNT(*) FROM reviews) AS reviews,
    (SELECT COUNT(*) FROM saved_views) AS saved_views,
    (SELECT COUNT(*) FROM reflections WHERE source_status = 'missing') AS missing_source`);
  assert.deepEqual(counts[0], {
    problems: 131,
    reflections: 8,
    reviews: 1,
    saved_views: 8,
    missing_source: 1,
  });
  const identities = query(
    "SELECT COUNT(*) AS total, COUNT(DISTINCT platform || ':' || problem_key) AS unique_count FROM problems",
  );
  assert.equal(identities[0].total, identities[0].unique_count);
  const difficulties = query(
    `SELECT difficulty, COUNT(*) AS total
     FROM problems GROUP BY difficulty ORDER BY difficulty`,
  );
  assert.deepEqual(difficulties, [
    { difficulty: null, total: 1 },
    { difficulty: "easy", total: 4 },
    { difficulty: "medium", total: 126 },
  ]);
  const viewsWithDifficulty = query(
    `SELECT COUNT(*) AS total FROM saved_views
     WHERE EXISTS (
       SELECT 1 FROM json_each(saved_views.visible_columns_json)
       WHERE value = 'difficulty'
     )`,
  );
  assert.equal(viewsWithDifficulty[0].total, 7);
  const workflow = query(`SELECT
    (SELECT COUNT(*) FROM problems WHERE state IS NOT NULL) AS preserved_states,
    (SELECT COUNT(*) FROM problems WHERE status = 'backlog') AS sprint_backlog,
    (SELECT COUNT(*) FROM sprints) AS sprints,
    (SELECT COUNT(*) FROM problems WHERE sprint_id = 'sprint-2026-08') AS sprint_problems,
    (SELECT MIN(due_date) FROM problems WHERE sprint_id = 'sprint-2026-08') AS first_due,
    (SELECT MAX(due_date) FROM problems WHERE sprint_id = 'sprint-2026-08') AS last_due,
    (SELECT COUNT(*) FROM mashups) AS mashups,
    (SELECT COUNT(*) FROM reviews WHERE reflection_id IS NULL
      AND timer_limit_seconds = 1800 AND timer_elapsed_seconds = 1811) AS reflectionless_reviews,
    (SELECT json_extract(filter_json, '$.state') FROM saved_views
      WHERE id = 'rereerere-test') AS migrated_filter`);
  assert.equal(workflow[0].preserved_states, 9);
  assert.ok(workflow[0].sprint_backlog > 0);
  assert.equal(workflow[0].sprints, 2);
  assert.equal(workflow[0].sprint_problems, 124);
  assert.equal(workflow[0].first_due, "2026-08-05");
  assert.equal(workflow[0].last_due, "2026-09-01");
  assert.equal(workflow[0].mashups, 0);
  assert.equal(workflow[0].reflectionless_reviews, 1);
  assert.equal(workflow[0].migrated_filter, '["retry"]');
  console.log("D1 migrations and double seed passed.");
} finally {
  await rm(temp, { recursive: true, force: true });
}
