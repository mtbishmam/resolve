ALTER TABLE problems
ADD COLUMN difficulty TEXT
CHECK (difficulty IN ('easy', 'medium', 'hard', 'extreme'));

CREATE INDEX IF NOT EXISTS problems_difficulty_idx
ON problems (difficulty);

UPDATE problems
SET
  difficulty = CASE id
    WHEN 'cf-1554-b' THEN 'medium'
    WHEN 'cf-1486-b' THEN 'easy'
    WHEN 'cf-1702-e' THEN 'medium'
    WHEN 'cf-1305-c' THEN 'medium'
    WHEN 'cf-377-a' THEN 'medium'
    WHEN 'cf-2108-a' THEN 'easy'
    WHEN 'cses-1668' THEN 'easy'
    WHEN 'cses-1193' THEN 'easy'
  END,
  metadata_provenance_json = json_set(
    metadata_provenance_json,
    '$.difficulty',
    CASE
      WHEN platform = 'codeforces' THEN 'codeforces_rating_band_v1'
      ELSE 'notion_showcase_v1'
    END
  )
WHERE id IN (
  'cf-1554-b',
  'cf-1486-b',
  'cf-1702-e',
  'cf-1305-c',
  'cf-377-a',
  'cf-2108-a',
  'cses-1668',
  'cses-1193'
);

UPDATE saved_views
SET
  visible_columns_json = json_insert(
    visible_columns_json,
    '$[#]',
    'difficulty'
  ),
  updated_at = '2026-07-30T12:00:00.000Z'
WHERE id IN (
  'view-due-today',
  'view-retry',
  'view-revise',
  'view-resolve',
  'view-all'
)
AND NOT EXISTS (
  SELECT 1
  FROM json_each(saved_views.visible_columns_json)
  WHERE value = 'difficulty'
);
