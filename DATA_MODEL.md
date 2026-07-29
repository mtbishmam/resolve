# Data model

The MVP uses four tables. JSON is used for evolving structures, but stable
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
- `review_status`
- `next_review_date`
- `created_at`
- `updated_at`

`review_status` and `next_review_date` are fast list projections. Completed
review history remains append-only in `reviews`.

Constraints:

- Unique `(platform, problem_key)`
- `title` is only the official problem name
- URLs and filenames are not identities
- Statement assets contain absolute external URLs initially

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
