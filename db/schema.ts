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
    index("problems_rating_idx").on(table.rating),
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
    reflectionId: text("reflection_id")
      .notNull()
      .references(() => reflections.id, { onDelete: "cascade" }),
    dueDate: text("due_date").notNull(),
    reviewedAt: text("reviewed_at"),
    outcome: text("outcome"),
    deepestReveal: text("deepest_reveal"),
    recallNote: text("recall_note"),
    previousIntervalDays: integer("previous_interval_days"),
    nextReviewDate: text("next_review_date"),
    scheduleVersion: text("schedule_version").notNull(),
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
