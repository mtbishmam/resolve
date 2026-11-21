ALTER TABLE problems ADD COLUMN practice_notes_json TEXT NOT NULL DEFAULT '{}';
--> statement-breakpoint
-- Preserve legacy work even if its mashup is later deleted. Pick the latest
-- nonblank value independently for each field; old empty defaults are not edits.
WITH candidates AS (
  SELECT entry.key AS problem_id, note.key AS field, note.value,
         ROW_NUMBER() OVER (
           PARTITION BY entry.key, note.key
           ORDER BY m.updated_at DESC, m.created_at DESC, m.id DESC
         ) AS priority
  FROM mashups AS m, json_each(m.notes_by_problem_json) AS entry,
       json_each(CASE WHEN entry.type = 'object' THEN entry.value ELSE '{}' END) AS note
  WHERE note.type = 'text' AND trim(note.value) <> ''
    AND note.key IN ('approaches', 'lemmas', 'analysis', 'pattern', 'memory_trigger', 'mistakes')
), recovered AS (
  SELECT problem_id, json_group_object(field, value) AS notes
  FROM candidates WHERE priority = 1 GROUP BY problem_id
)
UPDATE problems SET practice_notes_json = recovered.notes
FROM recovered WHERE problems.id = recovered.problem_id;
