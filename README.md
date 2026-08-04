# ReSolve

The hosted app is cloud-synced through its private Cloudflare D1 database. The
problem index is cached in IndexedDB for instant startup, then refreshed from D1
in the background; writes require a network connection.

Workflow is split into nullable **State** (`Retry`, `Revise`, `Resolve`) and
**Status** (`Backlog`, `Attempting`, `Pending AC`, `Accepted`). Archiving
preserves both. Due Today is the default view, and August 2026 is the CP31 Sheet
sprint for existing 1600–1900 problems.

August is seeded from the checked-in CP31 snapshot: 124 canonical problems,
five per day within each seven-day rating block, starting August 5 and ending
September 1. Click the Sprint card to edit its rows inline or select problems
for a persistent focused mashup with global and per-problem timers.

ReSolve is a private, speed-first competitive-programming reflection and
active-recall system.

Production: <https://resolve.mtbishmam.chatgpt.site>

- Codex conducts adaptive reflections and writes through authenticated MCP.
- The web app provides a cache-first problem database, stored statement reader,
  saved views, editing, review history, and a progressive no-AI review flow.
- The Manifest V3 extension produces one `resolve.capture.v1` Codeforces
  capture for pasting into Codex.

The user’s C++ solutions remain in
`/Users/mtbishmam/code/competitive-programming/practice`. ReSolve stores
nullable source references; a source file is never required.

## Local development

Use Node 22.13 or newer.

```sh
npm install
npm run db:migrate:local
npm run db:seed:local
npm run dev
```

Open `http://localhost:3000`.

## Verification

```sh
npm run format:check
npm run lint
npm run typecheck
npm run test
npm run test:db
npm run identity:check
npm run extension:build
npm run build
node scripts/test-mcp-local.mjs # while npm run dev is running
```

`test:db` creates an isolated empty local D1 database, runs the migrations,
applies the showcase seed twice, and verifies counts and idempotency.

## Showcase import

Only eight explicitly selected Notion rows are included. The checked-in
selection report is `data/showcase-selection.json`; the reproducible import
snapshot is `data/showcase.json`; the idempotent D1 seed is
`drizzle/0001_showcase.sql`.

Run `npm run data:refresh` to refetch objective judge metadata/statements and
regenerate the seed. The source Notion database is never edited. The complete
Notion tracker is not imported.

Imported raw Notion properties remain in `legacy_metadata_json`. Any
Codex-derived showcase learning field is marked `codex_inferred_demo` and needs
confirmation. Seeded next-review dates are explicitly marked demo projections;
no completed reviews are fabricated.

## MCP

The hosted stateless Streamable HTTP endpoint is `/api/mcp`. `/mcp` remains a
local compatibility alias. Hosted use requires the
server-side `RESOLVE_MCP_TOKEN`; local use accepts
`resolve-local-mcp-token` only on localhost.

Tools:

- `list_sprints`
- `save_reflection`
- `get_problem`
- `list_due_reviews`
- `record_review`
- `update_problem`
- `update_reflection`

Writes are Zod-validated, batched atomically in D1, and idempotent. Transcript
messages retain exact ordered roles and content.

If a CP31 problem already exists, the canonical upsert attaches the Sprint and
due date without replacing its workflow, archive, reviews, reflections, or
richer content. A later `save_reflection` preserves that Sprint schedule while
applying the Status and State supplied by the completed reflection.

For ChatGPT developer testing, add the public HTTPS `/api/mcp` endpoint as a
Streamable HTTP connection and refresh its metadata after deployment. The
hosted ChatGPT surface can use its authenticated session. Generic remote MCP
hosting requires MCP OAuth 2.1; ChatGPT does not accept a custom API key in
place of that flow. The selected GPT model does not change the protocol or data
rules—the model discovers and calls the same seven tools.

## Extension

```sh
npm run extension:build
```

Load `extension/dist` as an unpacked Chromium extension. It contains no model
calls, database credentials, or MCP token.

## Exports

Authenticated export routes are:

- `/api/export?format=json`
- `/api/export?format=markdown`
- `/api/export?format=sql`

With the local app running, `npm run export:local` saves all three formats under
the ignored `database-exports/` directory.

Start with [CONTEXT.md](CONTEXT.md), [PRODUCT.md](PRODUCT.md),
[ARCHITECTURE.md](ARCHITECTURE.md), and [DATA_MODEL.md](DATA_MODEL.md).
