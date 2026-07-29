import { z } from "zod";
import { authorizeBrowserRequest } from "@/lib/auth";
import { getProblemById, updateProblemProperties } from "@/db/queries";

export const dynamic = "force-dynamic";

const UpdateSchema = z
  .object({
    rating: z.number().int().positive().nullable().optional(),
    reviewStatus: z.enum(["retry", "revise", "resolve"]).optional(),
    nextReviewDate: z.string().date().nullable().optional(),
  })
  .strict();

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
  const parsed = UpdateSchema.safeParse(await request.json());
  if (!parsed.success) {
    return Response.json(
      { error: "Invalid properties", issues: parsed.error.issues },
      { status: 400 },
    );
  }
  const { id } = await context.params;
  if (!(await updateProblemProperties(id, parsed.data))) {
    return Response.json({ error: "Not found" }, { status: 404 });
  }
  return Response.json({ problem: await getProblemById(id) });
}
