import { authorizeBrowserRequest } from "@/lib/auth";
import { listProblems } from "@/db/queries";

export const dynamic = "force-dynamic";

export async function GET(request: Request) {
  if (!(await authorizeBrowserRequest(request))) {
    return Response.json({ error: "Unauthorized" }, { status: 401 });
  }
  return Response.json(
    { problems: await listProblems(), refreshedAt: new Date().toISOString() },
    { headers: { "cache-control": "no-store" } },
  );
}
