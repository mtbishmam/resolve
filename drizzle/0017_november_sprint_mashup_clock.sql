ALTER TABLE problems ADD COLUMN cp31_position INTEGER;
ALTER TABLE problems ADD COLUMN solved_override INTEGER CHECK (solved_override IN (0, 1));

ALTER TABLE mashups ADD COLUMN clock_elapsed_seconds REAL;
ALTER TABLE mashups ADD COLUMN clock_started_ms INTEGER;
ALTER TABLE mashups ADD COLUMN clock_seen_ms INTEGER;
ALTER TABLE mashups ADD COLUMN tracked_problem_id TEXT;
ALTER TABLE mashups ADD COLUMN revision INTEGER NOT NULL DEFAULT 0;
