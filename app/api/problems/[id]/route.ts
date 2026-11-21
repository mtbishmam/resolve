import { z } from "zod";
import { authorizeBrowserRequest } from "@/lib/auth";
import {
  DifficultySchema,
  PracticeNotesSchema,
  ProblemStateSchema,
  ProblemStatusSchema,
} from "@/lib/contracts";
import {
  getProblemById,
  updatePracticeNotes,
  updateProblemProperties,
} from "@/db/queries";

export const dynamic = "force-dynamic";

const UpdateSchema = z
  .object({
    rating: z.number().int().positive().max(3500).nullable().optional(),
    difficulty: DifficultySchema.nullable().optional(),
    state: ProblemStateSchema.nullable().optional(),
    status: ProblemStatusSchema.nullable().optional(),
    solvedOverride: z.boolean().nullable().optional(),
    archived: z.boolean().optional(),
    dueDate: z.string().date().nullable().optional(),
    sprintId: z.string().min(1).nullable().optional(),
    nextReviewDate: z.string().date().nullable().optional(),
    officialTags: z.array(z.string().min(1).max(80)).max(100).optional(),
  })
  .strict();
const PatchSchema = z.union([
  z.strictObject({ practiceNotes: PracticeNotesSchema }),
  UpdateSchema,
]);

export async function GET(
  request: Request,
  context: { params: Promise<{ id: string }> },
) {
  if (!(await authorizeBrowserRequest(request))) {
    return Response.json({ error: "Unauthorized" }, { status: 401 });
  }
  const { id } = await context.params;
  const problem = await getProblemById(id);
  if (!problem) return Response.json({ error: "Not found" }, { status: 404 });
  return Response.json(
    { problem },
    { headers: { "cache-control": "no-store" } },
  );
}

export async function PATCH(
  request: Request,
  context: { params: Promise<{ id: string }> },
) {
  if (!(await authorizeBrowserRequest(request))) {
    return Response.json({ error: "Unauthorized" }, { status: 401 });
  }
  const parsed = PatchSchema.safeParse(await request.json());
  if (!parsed.success) {
    return Response.json(
      { error: "Invalid properties", issues: parsed.error.issues },
      { status: 400 },
    );
  }
  const { id } = await context.params;
  const updated =
    "practiceNotes" in parsed.data
      ? await updatePracticeNotes(id, parsed.data.practiceNotes)
      : await updateProblemProperties(id, parsed.data);
  if (!updated) {
    return Response.json({ error: "Not found" }, { status: 404 });
  }
  return Response.json({ problem: await getProblemById(id) });
}
