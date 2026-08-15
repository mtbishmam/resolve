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

The app uses six tables. JSON is used for evolving structures, but stable
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
- `due_date`
- `sprint_id`
- `next_review_date`
- `created_at`
- `updated_at`

`status`, `state`, `archived_at`, and `next_review_date` are fast list
projections. Completed review history remains append-only in `reviews`.

Constraints:

- Unique `(platform, problem_key)`
- Supported platforms are `codeforces`, `cses`, `atcoder`, `codechef`, and
  `lightoj`.
- AtCoder uses the task slug as `problem_key`, for example `abc446_d`; the
  source filename is derived separately as `abc446_d.cpp`.
- CodeChef uses the uppercase problem code; LightOJ uses the lowercase problem
  slug.
- `title` is only the official problem name
- URLs and filenames are not identities
- Statement assets contain absolute external URLs initially
- `statement_markdown` stores the complete normalized judge statement, not the
  concise `reflections.summary_markdown`
- A statement refresh on an existing canonical row updates statement content,
  hash, capture time, assets, and provenance while preserving workflow and
  learning history
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
- `summary_markdown` contains only an objective, concise summary of the
  problem statement. It must not contain the user's approach, mistakes, stuck
  point, breakthrough, solution, or other metacognitive commentary.
- `structured_summary_json` contains the learning analysis derived from the
  user's reasoning, including the wrong mental model, failure, breakthrough,
  trigger, pattern, and missing concepts.
- `memory_cue` is a separate short reconstruction trigger, not a replacement
  for either the problem summary or the transcript.
- Later summaries create a new version or reflection rather than modifying the
  raw transcript

## `reviews`

Append-only review history.

Core fields:

- `id`
- `idempotency_key`
- `problem_id`
- `reflection_id` (nullable for Retry or Resolve sessions recorded before a
  reflection exists)
- `due_date`
- `reviewed_at`
- `outcome`
- `deepest_reveal`
- `recall_note`
- `previous_interval_days`
- `next_review_date`
- `schedule_version`
- `timer_limit_seconds`
- `timer_elapsed_seconds`
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

## `sprints`

One durable monthly milestone definition.

Core fields:

- `id`
- `name`
- `month`
- `source`
- `target_json`
- `starts_on`
- `ends_on`
- `created_at`
- `updated_at`

Membership lives on `problems.sprint_id`; `problems.due_date` is the daily
Sprint deadline and is independent from spaced-review scheduling.

## `mashups`

One persisted focused contest session.

Core fields:

- `id`
- `sprint_id`
- `problem_ids_json`
- `active_problem_id`
- `elapsed_by_problem_json`
- `notes_by_problem_json`
- `duration_seconds`
- `started_at`
- `ended_at`
- `status`
- `created_at`
- `updated_at`

Problem order is preserved. `started_at` may be earlier than creation time;
that difference becomes elapsed global time and is initially attributed to the
first problem. Per-problem elapsed seconds are saved during tab switches,
periodically, and on exit or completion.

`notes_by_problem_json` is keyed by an existing problem ID and stores three
strings: `approaches`, `lemmas`, and `analysis`. The MCP write path validates
membership in `problem_ids_json`; it cannot create a problem row.

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
