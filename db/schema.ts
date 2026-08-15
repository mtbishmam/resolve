import {
  index,
  integer,
  sqliteTable,
  text,
  uniqueIndex,
} from "drizzle-orm/sqlite-core";

export const problems = sqliteTable(
  "problems",
  {
    id: text("id").primaryKey(),
    platform: text("platform").notNull(),
    problemKey: text("problem_key").notNull(),
    url: text("url").notNull(),
    title: text("title").notNull(),
    contest: text("contest"),
    problemIndex: text("problem_index"),
    rating: integer("rating"),
    difficulty: text("difficulty"),
    officialTagsJson: text("official_tags_json").notNull().default("[]"),
    statementMarkdown: text("statement_markdown").notNull().default(""),
    statementAssetsJson: text("statement_assets_json").notNull().default("[]"),
    statementHash: text("statement_hash"),
    statementCapturedAt: text("statement_captured_at"),
    metadataStatus: text("metadata_status").notNull().default("pending"),
    metadataProvenanceJson: text("metadata_provenance_json")
      .notNull()
      .default("{}"),
    legacyMetadataJson: text("legacy_metadata_json").notNull().default("{}"),
    importSource: text("import_source"),
    importProvenanceJson: text("import_provenance_json")
      .notNull()
      .default("{}"),
    reviewStatus: text("review_status").notNull().default("resolve"),
    state: text("state"),
    status: text("status"),
    archivedAt: text("archived_at"),
    dueDate: text("due_date"),
    sprintId: text("sprint_id"),
    nextReviewDate: text("next_review_date"),
    createdAt: text("created_at").notNull(),
    updatedAt: text("updated_at").notNull(),
  },
  (table) => [
    uniqueIndex("problems_identity_unique").on(
      table.platform,
      table.problemKey,
    ),
    index("problems_due_idx").on(table.nextReviewDate),
    index("problems_status_idx").on(table.reviewStatus),
    index("problems_workflow_state_idx").on(table.state),
    index("problems_workflow_status_idx").on(table.status),
    index("problems_archived_idx").on(table.archivedAt),
    index("problems_sprint_due_idx").on(table.sprintId, table.dueDate),
    index("problems_rating_idx").on(table.rating),
    index("problems_difficulty_idx").on(table.difficulty),
    index("problems_updated_idx").on(table.updatedAt),
  ],
);

export const reflections = sqliteTable(
  "reflections",
  {
    id: text("id").primaryKey(),
    idempotencyKey: text("idempotency_key").notNull(),
    problemId: text("problem_id")
      .notNull()
      .references(() => problems.id, { onDelete: "cascade" }),
    sourcePath: text("source_path"),
    sourceSnapshot: text("source_snapshot"),
    sourceStatus: text("source_status").notNull(),
    transcriptMessagesJson: text("transcript_messages_json")
      .notNull()
      .default("[]"),
    transcriptHash: text("transcript_hash").notNull(),
    summaryMarkdown: text("summary_markdown").notNull(),
    structuredSummaryJson: text("structured_summary_json")
      .notNull()
      .default("{}"),
    memoryCue: text("memory_cue").notNull(),
    confidence: integer("confidence"),
    firstReviewDate: text("first_review_date"),
    createdAt: text("created_at").notNull(),
  },
  (table) => [
    uniqueIndex("reflections_idempotency_unique").on(table.idempotencyKey),
    index("reflections_problem_idx").on(table.problemId, table.createdAt),
  ],
);

export const reviews = sqliteTable(
  "reviews",
  {
    id: text("id").primaryKey(),
    idempotencyKey: text("idempotency_key"),
    problemId: text("problem_id")
      .notNull()
      .references(() => problems.id, { onDelete: "cascade" }),
    reflectionId: text("reflection_id").references(() => reflections.id, {
      onDelete: "cascade",
    }),
    dueDate: text("due_date").notNull(),
    reviewedAt: text("reviewed_at"),
    outcome: text("outcome"),
    deepestReveal: text("deepest_reveal"),
    recallNote: text("recall_note"),
    previousIntervalDays: integer("previous_interval_days"),
    nextReviewDate: text("next_review_date"),
    scheduleVersion: text("schedule_version").notNull(),
    timerLimitSeconds: integer("timer_limit_seconds"),
    timerElapsedSeconds: integer("timer_elapsed_seconds"),
    createdAt: text("created_at").notNull(),
  },
  (table) => [
    uniqueIndex("reviews_idempotency_unique").on(table.idempotencyKey),
    index("reviews_problem_idx").on(table.problemId, table.createdAt),
    index("reviews_due_idx").on(table.dueDate),
  ],
);

export const savedViews = sqliteTable("saved_views", {
  id: text("id").primaryKey(),
  name: text("name").notNull(),
  filterJson: text("filter_json").notNull().default("{}"),
  sortJson: text("sort_json").notNull().default("[]"),
  visibleColumnsJson: text("visible_columns_json").notNull().default("[]"),
  isDefault: integer("is_default", { mode: "boolean" })
    .notNull()
    .default(false),
  createdAt: text("created_at").notNull(),
  updatedAt: text("updated_at").notNull(),
});

export const sprints = sqliteTable(
  "sprints",
  {
    id: text("id").primaryKey(),
    name: text("name").notNull(),
    month: text("month").notNull(),
    source: text("source"),
    targetJson: text("target_json").notNull().default("{}"),
    startsOn: text("starts_on").notNull(),
    endsOn: text("ends_on").notNull(),
    createdAt: text("created_at").notNull(),
    updatedAt: text("updated_at").notNull(),
  },
  (table) => [uniqueIndex("sprints_month_unique").on(table.month)],
);

export const mashups = sqliteTable(
  "mashups",
  {
    id: text("id").primaryKey(),
    sprintId: text("sprint_id").references(() => sprints.id, {
      onDelete: "set null",
    }),
    problemIdsJson: text("problem_ids_json").notNull().default("[]"),
    activeProblemId: text("active_problem_id"),
    elapsedByProblemJson: text("elapsed_by_problem_json")
      .notNull()
      .default("{}"),
    notesByProblemJson: text("notes_by_problem_json").notNull().default("{}"),
    durationSeconds: integer("duration_seconds").notNull(),
    startedAt: text("started_at").notNull(),
    endedAt: text("ended_at"),
    status: text("status").notNull().default("active"),
    createdAt: text("created_at").notNull(),
    updatedAt: text("updated_at").notNull(),
  },
  (table) => [
    index("mashups_sprint_created_idx").on(table.sprintId, table.createdAt),
    index("mashups_status_updated_idx").on(table.status, table.updatedAt),
  ],
);
