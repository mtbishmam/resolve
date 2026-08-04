import { authorizeBrowserRequest } from "@/lib/auth";
import { CreateMashupSchema } from "@/lib/contracts";
import { createMashup, listMashups } from "@/db/queries";

export const dynamic = "force-dynamic";

export async function GET(request: Request) {
  if (!(await authorizeBrowserRequest(request))) {
    return Response.json({ error: "Unauthorized" }, { status: 401 });
  }
  const sprintId = new URL(request.url).searchParams.get("sprintId");
  return Response.json({ mashups: await listMashups(sprintId) });
}

export async function POST(request: Request) {
  if (!(await authorizeBrowserRequest(request))) {
    return Response.json({ error: "Unauthorized" }, { status: 401 });
  }
  const parsed = CreateMashupSchema.safeParse(await request.json());
  if (!parsed.success) {
    return Response.json(
      { error: "Invalid mashup", issues: parsed.error.issues },
      { status: 400 },
    );
  }
  return Response.json(
    { mashup: await createMashup(parsed.data) },
    { status: 201 },
  );
}
