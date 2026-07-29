import { execFileSync } from "node:child_process";
import { mkdtemp, rm } from "node:fs/promises";
import { tmpdir } from "node:os";
import { join, resolve } from "node:path";
import assert from "node:assert/strict";

const root = resolve(import.meta.dirname, "..");
const temp = await mkdtemp(join(tmpdir(), "resolve-d1-test-"));
const wrangler = resolve(root, "node_modules", ".bin", "wrangler");
const config = resolve(root, "wrangler.local.jsonc");

function d1(args) {
  return execFileSync(
    wrangler,
    [
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
  d1(["--file", resolve(root, "drizzle", "0001_showcase.sql")]);
  const counts = query(`SELECT
    (SELECT COUNT(*) FROM problems) AS problems,
    (SELECT COUNT(*) FROM reflections) AS reflections,
    (SELECT COUNT(*) FROM reviews) AS reviews,
    (SELECT COUNT(*) FROM saved_views) AS saved_views,
    (SELECT COUNT(*) FROM reflections WHERE source_status = 'missing') AS missing_source`);
  assert.deepEqual(counts[0], {
    problems: 8,
    reflections: 8,
    reviews: 0,
    saved_views: 5,
    missing_source: 1,
  });
  const identities = query(
    "SELECT COUNT(*) AS total, COUNT(DISTINCT platform || ':' || problem_key) AS unique_count FROM problems",
  );
  assert.equal(identities[0].total, identities[0].unique_count);
  console.log("D1 migrations and double seed passed.");
} finally {
  await rm(temp, { recursive: true, force: true });
}
