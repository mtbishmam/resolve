# ReSolve

The hosted app is cloud-synced through its private Cloudflare D1 database. The
problem index and opened details are cached in IndexedDB for instant startup,
then refreshed from D1 in the background. **Download for offline use** stores
every problem detail locally; the installed PWA can reopen cached reads while
online writes continue to sync to D1.

Workflow is split into nullable **State** (`Retry`, `Revise`, `Resolve`) and
**Status** (`Backlog`, `Attempting`, `Pending AC`, `Accepted`). Archiving
preserves both. Due Today is the default view, and November 2026 is the CP31 Sheet
sprint for existing 1600–1900 problems.

November uses all 124 canonical problems in the original CP31 order, with
five per day in each seven-day rating block from November 9 to December 6.
Default views preserve that order. The **Solved** column can override Codeforces
sync without changing a problem's solve Status. Select problems from any view,
or use **Mashup: next 5 unsolved** in the Sprint view.

ReSolve is a private, speed-first competitive-programming reflection and
active-recall system.

Production: <https://resolve.mtbishmam.chatgpt.site>

- Codex conducts adaptive reflections and writes through authenticated MCP.
- The web app provides a cache-first problem database, stored statement reader,
  saved views, editing, review history, and a progressive no-AI review flow.
- A canonical Codeforces (including Gym), AtCoder, CSES, CodeChef, or LightOJ URL is the
  fastest input; a pasted statement can start coaching immediately, with
  canonical identity resolved before MCP persistence.
- The Manifest V3 extension is an optional Codeforces snapshot fallback.

The user’s C++ solutions remain in
`/Users/mtbishmam/code/competitive-programming/practice`. ReSolve stores
nullable source references; a source file is never required.

## Local development

Use Node 22.13 or newer and npm. Stop an existing dev server before migrating.

```sh
cd /Users/mtbishmam/code/resolve
npm ci --ignore-scripts      # first time, or after dependencies change
npm run db:migrate:local
npm run db:sprint:local       # idempotent CP31 order and November dates
npm run dev
```

Open <http://localhost:3000>. Local D1 lives in `.wrangler/state`. The
migrations already include the checked-in showcase and CP31 data; do not
reapply the showcase seed to your working database. This does not import or
sync your hosted D1. For isolated testing, give Wrangler `--persist-to` and
set `RESOLVE_LOCAL_STATE_DIR` to the same test directory for the Sprint seed
and dev server.

Once set up, run `npm --prefix /Users/mtbishmam/code/resolve run dev` from
any folder. The Vite server is pinned to localhost port 3000 for the
extension and fails if that port is already in use. For dependency
maintenance, use `npm audit` and review the lockfile diff; do not use
`npm audit fix --force` to downgrade or replace the toolchain. The
dependency overrides in `package.json` and `pnpm-workspace.yaml` select
patched transitive releases until their upstream packages do.

In **November Sprint**, choose **Set Codeforces handle** once. Reloading the
app refreshes your public Codeforces submissions via the official API.
Accepted problems turn green. Choose **Solved**, **Unsolved**, or **Auto**
in the Solved column to override or restore automatic detection.

Choose any start time for a mashup. A future time waits; a past time starts
immediately with elapsed time counted globally and on the first problem.
**Now** picks the next five-minute mark.
Keep the mashup in its own tab and use **Open judge** to read on the judge
site. **Pause & exit** freezes all clocks and saves your notes. Use
**Unfinished mashup** to resume or delete it; only one unfinished session is
allowed. Finishing a session keeps its results and permits a new one.
Refreshing the same mashup tab reopens that contest on the last selected
problem, paused at its saved checkpoint. Click **Resume** to continue.
Approaches, Lemmas, Analysis, General pattern, Memory trigger, and Mistakes
autosave during a mashup and are available from each problem's **Practice
notes** tab. Edits saved there prefill future mashups. Deleting contest history
does not delete the problem notes. The **#** column (and mobile numbering)
follows the current filtered and sorted list.

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
- `record_mashup_result`
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
place of that flow. For an existing problem, ChatGPT first uses `get_problem`;
a reflection uses `save_reflection`, whose canonical upsert updates the same
row. A copied mashup packet includes `mashup_id` and `problem_id`, so ChatGPT
can call `record_mashup_result` when explicitly asked to save. That tool merges
the supplied practice fields into the existing mashup and problem—no problem
insert is performed. `get_problem` includes `practiceNotes` for post-solve
suggestions. Hosted MCP cannot read localhost D1; use the local MCP endpoint
from a local client or **Copy notes for ChatGPT** in the problem's Practice
notes tab. “I solved it,” “create problem,” and “push problem” trigger a key
insight and five-minute recognition path in chat, without changing the standing
Notion persistence workflow.

For URL-first use, provide the canonical judge URL. Codex validates identity,
retrieves the complete official statement, and calls `get_problem` before any
write. If the row exists, `update_problem` refreshes only its sanitized
statement content and provenance unless other properties are explicitly
supplied. It never substitutes the concise reflection summary for the complete
statement.

## Extension

```sh
npm run extension:build
```

Load `extension/dist` as an unpacked extension from `brave://extensions`
or `chrome://extensions` (enable Developer mode). If already installed,
reload it after rebuilding. The extension
tracks the active problem URL for the ongoing mashup at `http://localhost:3000`.
Its automatic top-right timer and the localhost mashup share the same elapsed
time; pin the extension to see elapsed minutes on its toolbar icon. After
an accumulated hour it opens the next problem with time left, in the same tab.
It contains no model calls, database credentials, or MCP token. Normal
URL-first coaching does not require the extension.

## Exports

Authenticated export routes are:

- `/api/export?format=json`
- `/api/export?format=markdown`
- `/api/export?format=sql`

With the local app running, `npm run export:local` saves all three formats under
the ignored `database-exports/` directory.

Start with [CONTEXT.md](CONTEXT.md), [PRODUCT.md](PRODUCT.md),
[ARCHITECTURE.md](ARCHITECTURE.md), [DATA_MODEL.md](DATA_MODEL.md), and the
[problem source adapter registry](PLATFORM_SOURCES.md).
