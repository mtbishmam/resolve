import { z } from "zod";
import { authorizeBrowserRequest } from "@/lib/auth";
import { listSavedViews, saveCustomView } from "@/db/queries";

const ViewSchema = z.object({
  name: z.string().min(1).max(80),
  filter: z.unknown(),
  sort: z.unknown(),
  visibleColumns: z.unknown(),
});

export async function GET(request: Request) {
  if (!(await authorizeBrowserRequest(request))) {
    return Response.json({ error: "Unauthorized" }, { status: 401 });
  }
  return Response.json({ views: await listSavedViews() });
}

export async function POST(request: Request) {
  if (!(await authorizeBrowserRequest(request))) {
    return Response.json({ error: "Unauthorized" }, { status: 401 });
  }
  const parsed = ViewSchema.safeParse(await request.json());
  if (!parsed.success) {
    return Response.json({ error: "Invalid saved view" }, { status: 400 });
  }
  return Response.json(await saveCustomView(parsed.data), { status: 201 });
}
