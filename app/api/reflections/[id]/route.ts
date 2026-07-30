import { authorizeBrowserRequest } from "@/lib/auth";
import { UpdateReflectionSchema } from "@/lib/contracts";
import { updateReflection } from "@/db/queries";

export async function PATCH(
  request: Request,
  context: { params: Promise<{ id: string }> },
) {
  if (!(await authorizeBrowserRequest(request))) {
    return Response.json({ error: "Unauthorized" }, { status: 401 });
  }
  const parsed = UpdateReflectionSchema.safeParse(await request.json());
  if (!parsed.success) {
    return Response.json(
      { error: "Invalid reflection", issues: parsed.error.issues },
      { status: 400 },
    );
  }
  const { id } = await context.params;
  if (!(await updateReflection(id, parsed.data))) {
    return Response.json({ error: "Not found" }, { status: 404 });
  }
  return Response.json({ updated: true });
}
