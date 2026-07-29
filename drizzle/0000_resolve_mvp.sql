PRAGMA foreign_keys = ON;

CREATE TABLE IF NOT EXISTS problems (
  id TEXT PRIMARY KEY NOT NULL,
  platform TEXT NOT NULL,
  problem_key TEXT NOT NULL,
  url TEXT NOT NULL,
  title TEXT NOT NULL,
  contest TEXT,
  problem_index TEXT,
  rating INTEGER,
  official_tags_json TEXT NOT NULL DEFAULT '[]',
  statement_markdown TEXT NOT NULL DEFAULT '',
  statement_assets_json TEXT NOT NULL DEFAULT '[]',
  statement_hash TEXT,
  statement_captured_at TEXT,
  metadata_status TEXT NOT NULL DEFAULT 'pending',
  metadata_provenance_json TEXT NOT NULL DEFAULT '{}',
  legacy_metadata_json TEXT NOT NULL DEFAULT '{}',
  import_source TEXT,
  import_provenance_json TEXT NOT NULL DEFAULT '{}',
  review_status TEXT NOT NULL DEFAULT 'resolve',
  next_review_date TEXT,
  created_at TEXT NOT NULL,
  updated_at TEXT NOT NULL
);

CREATE UNIQUE INDEX IF NOT EXISTS problems_identity_unique
  ON problems (platform, problem_key);
CREATE INDEX IF NOT EXISTS problems_due_idx ON problems (next_review_date);
CREATE INDEX IF NOT EXISTS problems_status_idx ON problems (review_status);
CREATE INDEX IF NOT EXISTS problems_rating_idx ON problems (rating);
CREATE INDEX IF NOT EXISTS problems_updated_idx ON problems (updated_at);

CREATE TABLE IF NOT EXISTS reflections (
  id TEXT PRIMARY KEY NOT NULL,
  idempotency_key TEXT NOT NULL,
  problem_id TEXT NOT NULL REFERENCES problems(id) ON DELETE CASCADE,
  source_path TEXT,
  source_snapshot TEXT,
  source_status TEXT NOT NULL,
  transcript_messages_json TEXT NOT NULL DEFAULT '[]',
  transcript_hash TEXT NOT NULL,
  summary_markdown TEXT NOT NULL,
  structured_summary_json TEXT NOT NULL DEFAULT '{}',
  memory_cue TEXT NOT NULL,
  confidence INTEGER,
  first_review_date TEXT,
  created_at TEXT NOT NULL
);

CREATE UNIQUE INDEX IF NOT EXISTS reflections_idempotency_unique
  ON reflections (idempotency_key);
CREATE INDEX IF NOT EXISTS reflections_problem_idx
  ON reflections (problem_id, created_at);

CREATE TABLE IF NOT EXISTS reviews (
  id TEXT PRIMARY KEY NOT NULL,
  idempotency_key TEXT,
  problem_id TEXT NOT NULL REFERENCES problems(id) ON DELETE CASCADE,
  reflection_id TEXT NOT NULL REFERENCES reflections(id) ON DELETE CASCADE,
  due_date TEXT NOT NULL,
  reviewed_at TEXT,
  outcome TEXT,
  deepest_reveal TEXT,
  recall_note TEXT,
  previous_interval_days INTEGER,
  next_review_date TEXT,
  schedule_version TEXT NOT NULL,
  created_at TEXT NOT NULL
);

CREATE UNIQUE INDEX IF NOT EXISTS reviews_idempotency_unique
  ON reviews (idempotency_key);
CREATE INDEX IF NOT EXISTS reviews_problem_idx
  ON reviews (problem_id, created_at);
CREATE INDEX IF NOT EXISTS reviews_due_idx ON reviews (due_date);

CREATE TABLE IF NOT EXISTS saved_views (
  id TEXT PRIMARY KEY NOT NULL,
  name TEXT NOT NULL,
  filter_json TEXT NOT NULL DEFAULT '{}',
  sort_json TEXT NOT NULL DEFAULT '[]',
  visible_columns_json TEXT NOT NULL DEFAULT '[]',
  is_default INTEGER NOT NULL DEFAULT 0,
  created_at TEXT NOT NULL,
  updated_at TEXT NOT NULL
);
