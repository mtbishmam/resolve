import { authorizeBrowserRequest } from "@/lib/auth";
import { listSprints } from "@/db/queries";

export async function GET(request: Request) {
  if (!(await authorizeBrowserRequest(request))) {
    return Response.json({ error: "Unauthorized" }, { status: 401 });
  }
  return Response.json({ sprints: await listSprints() });
}
