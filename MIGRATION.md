# Migration

## Current status

Eight explicitly selected, well-documented rows from the live Notion tracker
are included as a private MVP showcase. This is not a general or complete
Notion migration.

The reproducible selection report is `data/showcase-selection.json`; normalized
records are in `data/showcase.json`; idempotent inserts are in
`drizzle/0001_showcase.sql`. Imported raw properties remain in
`legacy_metadata_json`. Inferred demo learning fields and seeded schedules are
marked as such, and no historical review events were fabricated.

All other Notion problem rows remain unimported.

## August CP31 Sprint

The CP31 Sprint is a separate, explicitly authorized import from
`/Users/mtbishmam/code/cp-problem-exporter/lists/cp31`, not a Notion migration.
`data/cp31-august-2026.json` contains the reproducible 124-problem snapshot.
`drizzle/0004_sprint_mashups.sql` creates the Sprint/mashup schema and the
following numbered CP31 batch migrations apply the canonical upserts without
exceeding D1 statement-size limits.

The migration matches `(platform, problem_key)`. New canonical rows start as
Backlog with no State. Existing rows keep Status, State, archive timestamp,
review schedule, reflections, reviews, and any richer metadata or statement;
only August Sprint membership and the generated due date are assigned. The
generator is `scripts/generate-cp31-sprint-sql.mjs` and can be checked with
`npm run data:sprint`.

The source directory remains intact at `/Users/mtbishmam/code/cp-app` as a
recoverable reference. It should not be deleted until ReSolve implementation
and repository setup are verified.

## Future Notion import

The future importer should:

1. Read the exported CSV and Markdown.
2. Normalize judge URLs and derive canonical `(platform, problem_key)` values.
3. Detect duplicates before writing.
4. Map known properties into ReSolve fields.
5. Preserve unmapped properties in `legacy_metadata_json`.
6. Preserve source row identifiers and import timestamps.
7. Produce a dry-run report containing accepted rows, invalid rows,
   duplicates, collisions, and proposed mappings.
8. Require explicit approval before inserting any row.
9. Import in one recoverable transaction or batch with rollback support.
10. Verify row counts and canonical identities afterward.

Old titles such as `Problem - 1748B - Codeforces` must be normalized to the
official problem name while retaining platform and contest metadata separately.

## Source code

Competitive-programming files are not part of the data migration. ReSolve
references them by nullable absolute path or stores an optional snapshot during
reflection.

## Provider exit

Keep schema migrations, SQL exports, JSON exports, and Markdown exports so a
future move away from D1 does not require reconstructing records from the UI.
