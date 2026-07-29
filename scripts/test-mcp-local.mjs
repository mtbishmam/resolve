import assert from "node:assert/strict";
import { execFileSync } from "node:child_process";
import { resolve } from "node:path";

const root = resolve(import.meta.dirname, "..");
const base = process.env.RESOLVE_BASE_URL ?? "http://localhost:3000";
let id = 0;

async function rpc(method, params) {
  const response = await fetch(`${base}/mcp`, {
    method: "POST",
    headers: {
      authorization: "Bearer resolve-local-mcp-token",
      "content-type": "application/json",
      accept: "application/json, text/event-stream",
    },
    body: JSON.stringify({ jsonrpc: "2.0", id: ++id, method, params }),
  });
  assert.equal(response.status, 200);
  return response.json();
}

async function call(name, args) {
  const response = await rpc("tools/call", {
    name,
    arguments: args,
  });
  assert.equal(response.result.isError, false, JSON.stringify(response));
  return response.result.structuredContent;
}

const transcript = [
  { role: "assistant", content: "Exact question?\nLine two." },
  { role: "user", content: "  Exact answer with spaces.  " },
];

try {
  const initialized = await rpc("initialize", {
    protocolVersion: "2025-06-18",
    capabilities: {},
    clientInfo: { name: "resolve-test", version: "1" },
  });
  assert.equal(initialized.result.serverInfo.name, "resolve");
  const listed = await rpc("tools/list", {});
  assert.deepEqual(
    listed.result.tools.map((tool) => tool.name),
    ["save_reflection", "get_problem", "list_due_reviews", "record_review"],
  );
  const input = {
    idempotency_key: "mcp-test-save-9999-a",
    problem: {
      platform: "codeforces",
      problem_key: "9999:A",
      url: "https://codeforces.com/contest/9999/problem/A",
      title: "MCP Integration Fixture",
      contest: "Codeforces 9999",
      problem_index: "A",
      rating: 800,
      official_tags: ["math"],
      statement_markdown:
        "Fixture with $x^2$.\n\n![diagram](https://codeforces.com/favicon.ico)",
      statement_assets: [
        { url: "https://codeforces.com/favicon.ico", alt: "diagram" },
      ],
      metadata_status: "complete",
      metadata_provenance: { title: "test_fixture" },
    },
    reflection: {
      source_path: null,
      source_snapshot: null,
      source_status: "missing",
      transcript_messages: transcript,
      summary_markdown: "Fixture summary",
      structured_summary: {
        key_insight: "Fixture insight",
        wrong_mental_model: "Not captured",
        why_it_seemed_reasonable: "Not captured",
        breakthrough_observation: "Fixture observation",
        correct_trigger: "Fixture trigger",
        missing_concepts: [],
        general_pattern: "Fixture pattern",
        cognitive_mistakes: [],
        provenance: {},
      },
      memory_cue: "Fixture cue",
      confidence: 3,
      first_review_date: "2026-07-31",
    },
  };
  const first = await call("save_reflection", input);
  const second = await call("save_reflection", input);
  assert.equal(first.problem_id, second.problem_id);
  assert.equal(second.duplicate, true);

  const stored = await call("get_problem", {
    platform: "codeforces",
    problem_key: "9999:A",
  });
  assert.equal(
    JSON.stringify(stored.reflection.transcriptMessages),
    JSON.stringify(transcript),
  );
  assert.equal(stored.reflection.sourceStatus, "missing");

  const due = await call("list_due_reviews", { date: "2026-07-31" });
  assert(due.some((problem) => problem.id === first.problem_id));

  const review = await call("record_review", {
    idempotency_key: "mcp-test-review-9999-a",
    problem_id: first.problem_id,
    reflection_id: first.reflection_id,
    due_date: "2026-07-31",
    outcome: "needed_cue",
    deepest_reveal: "memory_cue",
    recall_note: "Integration recall",
    next_review_date: "2026-08-06",
  });
  const duplicateReview = await call("record_review", {
    idempotency_key: "mcp-test-review-9999-a",
    problem_id: first.problem_id,
    reflection_id: first.reflection_id,
    due_date: "2026-07-31",
    outcome: "needed_cue",
    deepest_reveal: "memory_cue",
    recall_note: "Integration recall",
    next_review_date: "2026-08-06",
  });
  assert.equal(review.review_id, duplicateReview.review_id);
  assert.equal(duplicateReview.duplicate, true);
  console.log("All four MCP tools passed.");
} finally {
  const wrangler = resolve(root, "node_modules", ".bin", "wrangler");
  execFileSync(
    wrangler,
    [
      "d1",
      "execute",
      "resolve-local",
      "--config",
      resolve(root, "wrangler.local.jsonc"),
      "--local",
      "--persist-to",
      resolve(root, ".wrangler", "state"),
      "--command",
      "DELETE FROM problems WHERE platform = 'codeforces' AND problem_key = '9999:A'",
    ],
    { cwd: root, stdio: "ignore" },
  );
}
