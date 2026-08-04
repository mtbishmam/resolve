import { authorizeBrowserRequest } from "@/lib/auth";
import { UpdateMashupSchema } from "@/lib/contracts";
import { getMashup, updateMashup } from "@/db/queries";

export const dynamic = "force-dynamic";

export async function GET(
  request: Request,
  context: { params: Promise<{ id: string }> },
) {
  if (!(await authorizeBrowserRequest(request))) {
    return Response.json({ error: "Unauthorized" }, { status: 401 });
  }
  const mashup = await getMashup((await context.params).id);
  if (!mashup) return Response.json({ error: "Not found" }, { status: 404 });
  return Response.json({ mashup });
}

export async function PATCH(
  request: Request,
  context: { params: Promise<{ id: string }> },
) {
  if (!(await authorizeBrowserRequest(request))) {
    return Response.json({ error: "Unauthorized" }, { status: 401 });
  }
  const parsed = UpdateMashupSchema.safeParse(await request.json());
  if (!parsed.success) {
    return Response.json(
      { error: "Invalid mashup update", issues: parsed.error.issues },
      { status: 400 },
    );
  }
  const mashup = await updateMashup((await context.params).id, parsed.data);
  if (!mashup) return Response.json({ error: "Not found" }, { status: 404 });
  return Response.json({ mashup });
}
