ALTER TABLE problems ADD COLUMN state TEXT
  CHECK (state IS NULL OR state IN ('retry', 'revise', 'resolve'));
ALTER TABLE problems ADD COLUMN status TEXT
  CHECK (status IS NULL OR status IN ('backlog', 'attempting', 'pending_ac', 'accepted'));
ALTER TABLE problems ADD COLUMN archived_at TEXT;
ALTER TABLE problems ADD COLUMN due_date TEXT;
ALTER TABLE problems ADD COLUMN sprint_id TEXT;

-- Preserve the existing State classification exactly. Legacy rows intentionally
-- keep nullable Status until the user classifies their real verdict.
UPDATE problems SET state = review_status WHERE review_status IN ('retry', 'revise', 'resolve');

CREATE INDEX IF NOT EXISTS problems_workflow_state_idx ON problems (state);
CREATE INDEX IF NOT EXISTS problems_workflow_status_idx ON problems (status);
CREATE INDEX IF NOT EXISTS problems_archived_idx ON problems (archived_at);
CREATE INDEX IF NOT EXISTS problems_sprint_due_idx ON problems (sprint_id, due_date);

ALTER TABLE reviews ADD COLUMN timer_limit_seconds INTEGER;
ALTER TABLE reviews ADD COLUMN timer_elapsed_seconds INTEGER;

CREATE TABLE IF NOT EXISTS sprints (
  id TEXT PRIMARY KEY NOT NULL,
  name TEXT NOT NULL,
  month TEXT NOT NULL,
  source TEXT,
  target_json TEXT NOT NULL DEFAULT '{}',
  starts_on TEXT NOT NULL,
  ends_on TEXT NOT NULL,
  created_at TEXT NOT NULL,
  updated_at TEXT NOT NULL
);
CREATE UNIQUE INDEX IF NOT EXISTS sprints_month_unique ON sprints (month);

INSERT INTO sprints (
  id, name, month, source, target_json, starts_on, ends_on, created_at, updated_at
) VALUES
  (
    'sprint-2026-08', 'August Sprint', '2026-08', 'CP31 Sheet',
    '{"ratings":[1600,1700,1800,1900],"problems_per_band":31,"problems_per_day":5,"days_per_band":7}',
    '2026-08-01', '2026-08-31', '2026-07-30T00:00:00.000Z', '2026-07-30T00:00:00.000Z'
  ),
  (
    'sprint-2026-09', 'September Sprint', '2026-09', NULL,
    '{"status":"to_be_decided"}',
    '2026-09-01', '2026-09-30', '2026-07-30T00:00:00.000Z', '2026-07-30T00:00:00.000Z'
  )
ON CONFLICT(month) DO UPDATE SET
  name = excluded.name,
  source = excluded.source,
  target_json = excluded.target_json,
  starts_on = excluded.starts_on,
  ends_on = excluded.ends_on,
  updated_at = excluded.updated_at;

-- Assign only problems that already exist. Missing CP31 rows are never fabricated.
WITH ranked AS (
  SELECT id, rating,
         ROW_NUMBER() OVER (PARTITION BY rating ORDER BY problem_key) - 1 AS offset
  FROM problems
  WHERE rating IN (1600, 1700, 1800, 1900)
)
UPDATE problems
SET
  sprint_id = 'sprint-2026-08',
  due_date = date(
    '2026-08-01',
    printf(
      '+%d days',
      (SELECT ((rating - 1600) / 100) * 7 + CAST(offset / 5 AS INTEGER)
       FROM ranked WHERE ranked.id = problems.id)
    )
  ),
  status = COALESCE(status, 'backlog')
WHERE id IN (SELECT id FROM ranked);

-- Filter v2 separates workflow Status from nullable State. This fixes legacy
-- saved views whose "status" field actually meant Retry/Revise/Resolve.
UPDATE saved_views
SET filter_json = json_set(
      json_remove(filter_json, '$.status'),
      '$.schema', 'resolve.filter.v2',
      '$.state', json_extract(filter_json, '$.status')
    ),
    updated_at = '2026-07-30T00:00:00.000Z'
WHERE json_type(filter_json, '$.status') = 'array'
  AND EXISTS (
    SELECT 1 FROM json_each(json_extract(filter_json, '$.status'))
    WHERE value IN ('retry', 'revise', 'resolve')
  );

INSERT INTO saved_views (
  id, name, filter_json, sort_json, visible_columns_json, is_default,
  created_at, updated_at
) VALUES
  (
    'view-pending-ac', 'Pending AC',
    '{"schema":"resolve.filter.v2","status":["pending_ac"],"archived":false}',
    '[{"id":"dueDate","desc":false}]',
    '["title","platform","rating","difficulty","state","status","dueDate"]',
    0, '2026-07-30T00:00:00.000Z', '2026-07-30T00:00:00.000Z'
  ),
  (
    'view-archived', 'Archived',
    '{"schema":"resolve.filter.v2","archived":true}',
    '[{"id":"updatedAt","desc":true}]',
    '["title","platform","rating","difficulty","state","status"]',
    0, '2026-07-30T00:00:00.000Z', '2026-07-30T00:00:00.000Z'
  )
ON CONFLICT(id) DO UPDATE SET
  name = excluded.name,
  filter_json = excluded.filter_json,
  sort_json = excluded.sort_json,
  visible_columns_json = excluded.visible_columns_json,
  updated_at = excluded.updated_at;

UPDATE saved_views
SET filter_json = CASE id
  WHEN 'view-due-today' THEN '{"schema":"resolve.filter.v2","due":"today","archived":false}'
  WHEN 'view-retry' THEN '{"schema":"resolve.filter.v2","state":["retry"],"archived":false}'
  WHEN 'view-revise' THEN '{"schema":"resolve.filter.v2","state":["revise"],"archived":false}'
  WHEN 'view-resolve' THEN '{"schema":"resolve.filter.v2","state":["resolve"],"archived":false}'
  WHEN 'view-all' THEN '{"schema":"resolve.filter.v2","archived":false}'
  ELSE filter_json
END,
is_default = CASE WHEN id = 'view-due-today' THEN 1 ELSE 0 END,
updated_at = '2026-07-30T00:00:00.000Z'
WHERE id IN ('view-due-today', 'view-retry', 'view-revise', 'view-resolve', 'view-all');
