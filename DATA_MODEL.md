# Data model

`problems.state` is nullable `retry | revise | resolve`.
`problems.status` is nullable for untouched legacy rows and otherwise
`backlog | attempting | pending_ac | accepted`. `archived_at` does not alter
either. `due_date` is the sprint deadline; `next_review_date` remains the
spaced-review projection.

The durable `sprints` table stores monthly milestone identity, date range,
source, and target. Reviews persist `timer_limit_seconds` and
`timer_elapsed_seconds`. Saved-view `resolve.filter.v2` separates `state`,
`status`, `tags`, `archived`, and `due`.

The app uses five tables. JSON is used for evolving structures, but stable
filter and scheduling fields remain ordinary columns.

## `problems`

One row per canonical judge problem.

Core fields:

- `id`
- `platform`
- `problem_key`
- `url`
- `title`
- `contest`
- `problem_index`
- `rating`
- `difficulty`
- `official_tags_json`
- `statement_markdown`
- `statement_assets_json`
- `statement_hash`
- `statement_captured_at`
- `metadata_status`
- `legacy_metadata_json`
- `import_source`
- `metadata_provenance_json`
- `import_provenance_json`
- `status`
- `state`
- `archived_at`
- `next_review_date`
- `created_at`
- `updated_at`

`status`, `state`, `archived_at`, and `next_review_date` are fast list
projections. Completed review history remains append-only in `reviews`.

Constraints:

- Unique `(platform, problem_key)`
- Supported platforms are `codeforces`, `cses`, and `atcoder`.
- AtCoder uses the task slug as `problem_key`, for example `abc446_d`; the
  source filename is derived separately as `abc446_d.cpp`.
- `title` is only the official problem name
- URLs and filenames are not identities
- Statement assets contain absolute external URLs initially
- `difficulty` is nullable for genuinely unclassified legacy rows and otherwise
  one of `easy`, `medium`, `hard`, or `extreme`
- A numeric rating deterministically owns its difficulty band; unrated problems
  receive adaptive difficulty during reflection
- Migrations preserve valid imported difficulty and do not invent values for
  unclassified rows; the initial difficulty migration backfills only the eight
  approved showcase records
- `status` is one of `backlog`, `attempting`, `pending_ac`, or `accepted`
- `state` is nullable and otherwise one of `retry`, `revise`, or `resolve`
- Valid combinations are:
  - `backlog` with no State
  - `attempting` with `retry` or no State
  - `pending_ac` with `revise`, `resolve`, or no State
  - `accepted` with `revise`, `resolve`, or no State
- `archived_at` is nullable and does not replace or clear Status or State
- Existing `review_status` values migrate losslessly to `state`
- Existing rows without reliable judge evidence retain an unclassified nullable
  Status until the user classifies them; migrations must not invent an accepted
  verdict
- New and updated problems must use a classified Status

## `reflections`

One problem may have multiple reflections.

Core fields:

- `id`
- `idempotency_key`
- `problem_id`
- `source_path`
- `source_snapshot`
- `source_status`
- `transcript_messages_json`
- `transcript_hash`
- `summary_markdown`
- `structured_summary_json`
- `memory_cue`
- `confidence`
- `first_review_date`
- `created_at`

Rules:

- `source_path` and `source_snapshot` are nullable
- Missing source is not an error
- Transcript messages preserve ordered roles and exact content
- Existing transcripts are immutable
- Later summaries create a new version or reflection rather than modifying the
  raw transcript

## `reviews`

Append-only review history.

Core fields:

- `id`
- `idempotency_key`
- `problem_id`
- `reflection_id`
- `due_date`
- `reviewed_at`
- `outcome`
- `deepest_reveal`
- `recall_note`
- `previous_interval_days`
- `next_review_date`
- `schedule_version`
- `created_at`

Initial outcomes:

- `recalled`
- `needed_cue`
- `forgot`
- `unresolved`

Initial reveal levels:

- `none`
- `memory_cue`
- `key_insight`
- `full_reflection`
- `source`

The next review date is never the only record of review state; every completed
attempt remains queryable.

## `saved_views`

Reusable Notion-like database views.

Core fields:

- `id`
- `name`
- `filter_json`
- `sort_json`
- `visible_columns_json`
- `is_default`
- `created_at`
- `updated_at`

Filters and sorts use a versioned expression format so future fields can be
introduced without rewriting existing views.

The built-in **Pending AC** view filters for `status = pending_ac` and
`archived_at IS NULL`. Archived problems remain reachable through an archived
view.

## Dates

Review due dates are calendar dates interpreted in `Asia/Dhaka`. Event
timestamps are stored as UTC instants.

## Exportability

ReSolve must support:

- SQL database export
- JSON export preserving every field
- Markdown export for human-readable reflections
- Stable IDs and schema versions

Provider-specific features must not become the only representation of
important data.
