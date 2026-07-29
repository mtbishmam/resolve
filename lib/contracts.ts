import { z } from "zod";

export const PlatformSchema = z.enum(["codeforces", "cses"]);
export const ReviewOutcomeSchema = z.enum([
  "recalled",
  "needed_cue",
  "forgot",
  "unresolved",
]);
export const RevealLevelSchema = z.enum([
  "none",
  "memory_cue",
  "key_insight",
  "full_reflection",
  "source",
]);

export const TranscriptMessageSchema = z.object({
  role: z.enum(["user", "assistant", "system"]),
  content: z.string(),
});

export const CaptureSchema = z.object({
  schema: z.literal("resolve.capture.v1"),
  capture_id: z.string().uuid(),
  captured_at: z.string().datetime(),
  platform: z.literal("codeforces"),
  problem_key: z.string().regex(/^\d+:[A-Za-z0-9]+$/),
  url: z.string().url(),
  problem: z.object({
    contest_id: z.number().int().positive(),
    index: z.string().min(1).max(4),
    title: z.string().min(1),
    rating: z.number().int().positive().nullable().optional(),
    official_tags: z.array(z.string()).default([]),
  }),
  statement: z.object({
    format: z.literal("markdown"),
    text: z.string(),
    assets: z
      .array(z.object({ url: z.string().url(), alt: z.string().default("") }))
      .default([]),
  }),
  provenance: z.object({
    adapter: z.literal("codeforces"),
    adapter_version: z.string(),
    language: z.string(),
  }),
});

export const StructuredSummarySchema = z.object({
  key_insight: z.string().default("Not captured"),
  wrong_mental_model: z.string().default("Not captured"),
  why_it_seemed_reasonable: z.string().default("Not captured"),
  breakthrough_observation: z.string().default("Not captured"),
  correct_trigger: z.string().default("Not captured"),
  missing_concepts: z.array(z.string()).default([]),
  general_pattern: z.string().default("Not captured"),
  cognitive_mistakes: z.array(z.string()).default([]),
  provenance: z.record(z.string(), z.string()).default({}),
});

export const SaveReflectionSchema = z.object({
  idempotency_key: z.string().min(8).max(200),
  problem: z.object({
    platform: PlatformSchema,
    problem_key: z.string().min(1),
    url: z.string().url(),
    title: z.string().min(1),
    contest: z.string().nullable().optional(),
    problem_index: z.string().nullable().optional(),
    rating: z.number().int().positive().nullable().optional(),
    official_tags: z.array(z.string()).default([]),
    statement_markdown: z.string().default(""),
    statement_assets: z
      .array(z.object({ url: z.string().url(), alt: z.string().default("") }))
      .default([]),
    metadata_status: z.string().default("complete"),
    metadata_provenance: z.record(z.string(), z.string()).default({}),
  }),
  reflection: z.object({
    source_path: z.string().nullable().optional(),
    source_snapshot: z.string().nullable().optional(),
    source_status: z.enum(["found", "missing", "ambiguous"]).default("missing"),
    transcript_messages: z.array(TranscriptMessageSchema),
    summary_markdown: z.string(),
    structured_summary: StructuredSummarySchema,
    memory_cue: z.string(),
    confidence: z.number().min(0).max(5).nullable().optional(),
    first_review_date: z.string().date(),
  }),
});

export const RecordReviewSchema = z.object({
  idempotency_key: z.string().min(8).max(200),
  problem_id: z.string().min(1),
  reflection_id: z.string().min(1),
  due_date: z.string().date(),
  outcome: ReviewOutcomeSchema,
  deepest_reveal: RevealLevelSchema,
  recall_note: z.string().max(4000).default(""),
  next_review_date: z.string().date().optional(),
  previous_interval_days: z.number().int().nonnegative().nullable().optional(),
});

export type SaveReflectionInput = z.infer<typeof SaveReflectionSchema>;
export type RecordReviewInput = z.infer<typeof RecordReviewSchema>;

export type ProblemListItem = {
  id: string;
  platform: "codeforces" | "cses";
  problemKey: string;
  title: string;
  contest: string | null;
  problemIndex: string | null;
  rating: number | null;
  reviewStatus: string;
  nextReviewDate: string | null;
  sourceStatus: string | null;
  updatedAt: string;
};

export type ProblemDetail = ProblemListItem & {
  url: string;
  officialTags: string[];
  statementMarkdown: string;
  statementAssets: Array<{ url: string; alt: string }>;
  statementCapturedAt: string | null;
  metadataStatus: string;
  metadataProvenance: Record<string, string>;
  legacyMetadata: Record<string, unknown>;
  importSource: string | null;
  importProvenance: Record<string, unknown>;
  reflection: null | {
    id: string;
    sourcePath: string | null;
    sourceSnapshot: string | null;
    sourceStatus: string;
    transcriptMessages: Array<{
      role: "user" | "assistant" | "system";
      content: string;
    }>;
    summaryMarkdown: string;
    structuredSummary: z.infer<typeof StructuredSummarySchema>;
    memoryCue: string;
    confidence: number | null;
    firstReviewDate: string | null;
    createdAt: string;
  };
  reviews: Array<{
    id: string;
    dueDate: string;
    reviewedAt: string | null;
    outcome: string | null;
    deepestReveal: string | null;
    recallNote: string | null;
    nextReviewDate: string | null;
    scheduleVersion: string;
  }>;
};
