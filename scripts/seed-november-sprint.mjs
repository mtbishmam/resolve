import { execFileSync } from "node:child_process";
import { readFileSync } from "node:fs";
import { resolve } from "node:path";

const root = resolve(import.meta.dirname, "..");
const { records } = JSON.parse(
  readFileSync(resolve(root, "data/cp31-august-2026.json"), "utf8"),
);
const order = [1600, 1700, 1800, 1900].flatMap((rating) => {
  const band = records.filter((record) => record.rating === rating);
  if (
    band.length !== 31 ||
    band.some(
      (record, index) =>
        record.order !== index + 1 ||
        !/^\d+:[A-Z0-9]+$/.test(record.problemKey),
    )
  ) {
    throw new Error(`Unexpected CP31 order for rating ${rating}`);
  }
  return band.map((record) => record.problemKey);
});
if (new Set(order).size !== 124) throw new Error("Duplicate CP31 identities");

const sql = `
INSERT OR IGNORE INTO sprints (
  id, name, month, source, target_json, starts_on, ends_on, created_at, updated_at
) VALUES
  ('sprint-2026-11', 'November Sprint', '2026-11', 'CP31 Sheet',
   '{"ratings":[1600,1700,1800,1900],"problems_per_band":31,"problems_per_day":5,"days_per_band":7,"plan_starts_on":"2026-11-09","plan_ends_on":"2026-12-06"}',
   '2026-11-09', '2026-12-06', '2026-11-09T00:00:00Z', '2026-11-09T00:00:00Z'),
  ('sprint-2026-12', 'December Sprint', '2026-12', NULL, '{}',
   '2026-12-01', '2026-12-31', '2026-11-09T00:00:00Z', '2026-11-09T00:00:00Z');

WITH cp31 AS (
  SELECT CAST(key AS INTEGER) AS position, value AS problem_key
  FROM json_each('${JSON.stringify(order)}')
)
UPDATE problems
SET cp31_position = cp31.position + 1,
    sprint_id = 'sprint-2026-11',
    due_date = date('2026-11-09', printf('+%d days', (cp31.position / 31) * 7 + (cp31.position % 31) / 5))
FROM cp31
WHERE problems.platform = 'codeforces' AND problems.problem_key = cp31.problem_key
  AND problems.cp31_position IS NULL;
`;

execFileSync(
  process.execPath,
  [
    resolve(root, "node_modules/wrangler/bin/wrangler.js"),
    "d1",
    "execute",
    "resolve-local",
    "--config",
    "wrangler.local.jsonc",
    "--local",
    "--persist-to",
    process.env.RESOLVE_LOCAL_STATE_DIR ?? ".wrangler/state",
    "--command",
    sql,
  ],
  { cwd: root, stdio: "inherit" },
);
