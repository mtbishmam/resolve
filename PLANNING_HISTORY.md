# Planning history

This file preserves the important alternatives considered before ReSolve was
named and consolidated.

## Storage

Markdown alone was rejected as the source of truth because complex
filtering/sorting, cross-device writes, review history, and scheduling are
awkward in files.

A Git-synchronized local SQLite file was rejected because mobile access must
work while both computers are offline, and concurrent device writes should not
depend on Git conflict resolution.

Supabase/PostgreSQL was considered for its hosted database and visual editor,
but it added more platform and schema complexity than a single-user app needed.

Turso/libSQL was considered for a local stdio MCP plus hosted SQLite
architecture. It remains a viable alternative, but ReSync established a working
Cloudflare stack and ReSolve now favors a hosted MCP. D1 therefore reduces the
number of systems and keeps the web app, MCP, and database in one deployment.

D1 export and provider-independent JSON/Markdown exports remain required to
avoid lock-in.

Sprint membership stays on `problems` because it is a single active monthly
milestone assignment. Focused mashup sessions received their own table because
ordered membership, resumable status, backdated global time, and independent
per-problem elapsed counters are one immediate integrity unit and must survive
navigation or device refreshes.

## AI boundary

A standalone ChatGPT/OpenAI API interviewer was rejected for the MVP. Codex
already provides the interactive project, image, math, file, and tool surface.
The ChatGPT subscription and API billing are separate, so duplicating the
conversation through an API would add cost and complexity.

Codex conducts the interview and generates the structured summary. MCP owns
validation, persistence, idempotency, and review scheduling.

## Hosting

A free provider hostname is sufficient initially. A purchased domain is a
branding decision, not a technical requirement.

Mobile uses the hosted ReSolve web app. Mobile does not need the local source
repository or MCP process to browse statements and complete ordinary reviews.

## Reminders

Email was considered but deferred. The first reminder system is the in-app Due
today and overdue experience because the user expects to visit the app
frequently.

## Notion

The old Notion tracker informed the initial views and fields, including Revise,
Retry, Resolve, All, tags, summaries, gains, metacognition, difficulty, and
related DSA material.

ReSolve deliberately starts with a smaller data model. The later importer must
preserve properties that do not receive first-class fields.

## Naming

Practice solutions remain flattened under
`competitive-programming/practice`.

- Codeforces: `2179D.cpp`
- AtCoder: `abc468_b.cpp`
- CodeChef: `cc_swapsm.cpp`
- CSES: `Coin_Combinations_I.cpp`
- LeetCode: `lc_two_sum.cpp`

Filenames are source locators. Database identity is always the canonical
platform and problem key.
