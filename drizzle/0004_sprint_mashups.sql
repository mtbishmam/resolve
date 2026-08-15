CREATE TABLE IF NOT EXISTS mashups (
  id TEXT PRIMARY KEY NOT NULL,
  sprint_id TEXT REFERENCES sprints(id) ON DELETE SET NULL,
  problem_ids_json TEXT NOT NULL DEFAULT '[]',
  active_problem_id TEXT,
  elapsed_by_problem_json TEXT NOT NULL DEFAULT '{}',
  duration_seconds INTEGER NOT NULL,
  started_at TEXT NOT NULL,
  ended_at TEXT,
  status TEXT NOT NULL DEFAULT 'active'
    CHECK (status IN ('active', 'completed')),
  created_at TEXT NOT NULL,
  updated_at TEXT NOT NULL
);

CREATE INDEX IF NOT EXISTS mashups_sprint_created_idx
ON mashups (sprint_id, created_at);

CREATE INDEX IF NOT EXISTS mashups_status_updated_idx
ON mashups (status, updated_at);

CREATE TABLE reviews_v2 (
  id TEXT PRIMARY KEY NOT NULL,
  idempotency_key TEXT,
  problem_id TEXT NOT NULL REFERENCES problems(id) ON DELETE CASCADE,
  reflection_id TEXT REFERENCES reflections(id) ON DELETE CASCADE,
  due_date TEXT NOT NULL,
  reviewed_at TEXT,
  outcome TEXT,
  deepest_reveal TEXT,
  recall_note TEXT,
  previous_interval_days INTEGER,
  next_review_date TEXT,
  schedule_version TEXT NOT NULL,
  timer_limit_seconds INTEGER,
  timer_elapsed_seconds INTEGER,
  created_at TEXT NOT NULL
);

INSERT INTO reviews_v2 (
  id, idempotency_key, problem_id, reflection_id, due_date, reviewed_at,
  outcome, deepest_reveal, recall_note, previous_interval_days,
  next_review_date, schedule_version, timer_limit_seconds,
  timer_elapsed_seconds, created_at
)
SELECT
  id, idempotency_key, problem_id, reflection_id, due_date, reviewed_at,
  outcome, deepest_reveal, recall_note, previous_interval_days,
  next_review_date, schedule_version, timer_limit_seconds,
  timer_elapsed_seconds, created_at
FROM reviews;

DROP TABLE reviews;

ALTER TABLE reviews_v2 RENAME TO reviews;

CREATE UNIQUE INDEX reviews_idempotency_unique
ON reviews (idempotency_key);

CREATE INDEX reviews_problem_idx
ON reviews (problem_id, created_at);

CREATE INDEX reviews_due_idx ON reviews (due_date);

UPDATE problems SET
  status = CASE WHEN status = 'backlog' THEN NULL ELSE status END,
  sprint_id = NULL,
  due_date = NULL
WHERE sprint_id = 'sprint-2026-08';

UPDATE sprints SET
  source = 'CP31 Sheet',
  target_json = '{"ratings":[1600,1700,1800,1900],"problems_per_band":31,"problems_per_day":5,"days_per_band":7,"plan_starts_on":"2026-08-05","plan_ends_on":"2026-09-01"}',
  starts_on = '2026-08-05',
  ends_on = '2026-09-01',
  updated_at = '2026-08-04T00:00:00.000Z'
WHERE id = 'sprint-2026-08';
