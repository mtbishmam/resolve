import { z } from "zod";
import { DIFFICULTIES, type Difficulty } from "@/lib/difficulty";
import {
  PROBLEM_STATES,
  PROBLEM_STATUSES,
  type ProblemState,
  type ProblemStatus,
} from "@/lib/workflow";

export const PlatformSchema = z.enum(["codeforces", "cses", "atcoder"]);
export const DifficultySchema = z.enum(DIFFICULTIES);
export const ProblemStateSchema = z.enum(PROBLEM_STATES);
export const ProblemStatusSchema = z.enum(PROBLEM_STATUSES);
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
    rating: z.number().int().positive().max(3500).nullable().optional(),
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

const SaveProblemSchema = z
  .object({
    platform: PlatformSchema,
    problem_key: z.string().min(1),
    url: z.string().url(),
    title: z.string().min(1),
    contest: z.string().nullable().optional(),
    problem_index: z.string().nullable().optional(),
    rating: z.number().int().positive().max(3500).nullable().optional(),
    difficulty: DifficultySchema.nullable().optional(),
    official_tags: z.array(z.string()).default([]),
    statement_markdown: z.string().default(""),
    statement_assets: z
      .array(z.object({ url: z.string().url(), alt: z.string().default("") }))
      .default([]),
    metadata_status: z.string().default("complete"),
    metadata_provenance: z.record(z.string(), z.string()).default({}),
    state: ProblemStateSchema.nullable().optional(),
    status: ProblemStatusSchema.optional().default("backlog"),
    due_date: z.string().date().nullable().optional(),
    sprint_id: z.string().nullable().optional(),
  })
  .superRefine((problem, context) => {
    if (problem.rating == null && problem.difficulty == null) {
      context.addIssue({
        code: "custom",
        path: ["difficulty"],
        message: "Difficulty is required when a problem has no numeric rating",
      });
    }
  });

export const SaveReflectionSchema = z.object({
  idempotency_key: z.string().min(8).max(200),
  problem: SaveProblemSchema,
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
  reflection_id: z.string().min(1).nullable().optional(),
  due_date: z.string().date(),
  outcome: ReviewOutcomeSchema,
  deepest_reveal: RevealLevelSchema,
  recall_note: z.string().max(4000).default(""),
  next_review_date: z.string().date().optional(),
  previous_interval_days: z.number().int().nonnegative().nullable().optional(),
  timer_limit_seconds: z.number().int().positive().optional(),
  timer_elapsed_seconds: z.number().int().nonnegative().optional(),
});

export const CreateMashupSchema = z
  .object({
    sprint_id: z.string().min(1).nullable().optional(),
    problem_ids: z.array(z.string().min(1)).min(1).max(124),
    duration_seconds: z
      .number()
      .int()
      .positive()
      .max(24 * 60 * 60),
    started_at: z.string().datetime(),
  })
  .refine((input) => Date.parse(input.started_at) <= Date.now(), {
    path: ["started_at"],
    message: "Mashup start time cannot be in the future",
  });

export const UpdateMashupSchema = z
  .object({
    active_problem_id: z.string().min(1).nullable().optional(),
    elapsed_by_problem: z
      .record(z.string(), z.number().int().nonnegative())
      .optional(),
    status: z.enum(["active", "completed"]).optional(),
  })
  .strict();

export const UpdateReflectionSchema = z
  .object({
    summaryMarkdown: z.string().optional(),
    structuredSummary: StructuredSummarySchema.optional(),
    memoryCue: z.string().optional(),
    confidence: z.number().min(0).max(5).nullable().optional(),
  })
  .strict();

export type SaveReflectionInput = z.infer<typeof SaveReflectionSchema>;
export type RecordReviewInput = z.infer<typeof RecordReviewSchema>;
export type CreateMashupInput = z.infer<typeof CreateMashupSchema>;
export type UpdateMashupInput = z.infer<typeof UpdateMashupSchema>;

export type Mashup = {
  id: string;
  sprintId: string | null;
  problemIds: string[];
  activeProblemId: string | null;
  elapsedByProblem: Record<string, number>;
  durationSeconds: number;
  startedAt: string;
  endedAt: string | null;
  status: "active" | "completed";
  createdAt: string;
  updatedAt: string;
};

export type ProblemListItem = {
  id: string;
  platform: "codeforces" | "cses" | "atcoder";
  problemKey: string;
  title: string;
  contest: string | null;
  problemIndex: string | null;
  rating: number | null;
  difficulty: Difficulty | null;
  state: ProblemState | null;
  status: ProblemStatus | null;
  archivedAt: string | null;
  dueDate: string | null;
  sprintId: string | null;
  nextReviewDate: string | null;
  officialTags: string[];
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
    timerLimitSeconds: number | null;
    timerElapsedSeconds: number | null;
  }>;
};
