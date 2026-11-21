import { authorizeBrowserRequest } from "@/lib/auth";
import { CreateMashupSchema } from "@/lib/contracts";
import {
  createMashup,
  getOngoingMashup,
  listMashups,
  MashupRequestError,
} from "@/db/queries";

export const dynamic = "force-dynamic";

export async function GET(request: Request) {
  if (!(await authorizeBrowserRequest(request))) {
    return Response.json({ error: "Unauthorized" }, { status: 401 });
  }
  const params = new URL(request.url).searchParams;
  if (params.has("ongoing")) {
    return Response.json(
      { mashup: await getOngoingMashup() },
      { headers: { "cache-control": "no-store" } },
    );
  }
  const sprintId = params.get("sprintId");
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
  try {
    return Response.json(
      { mashup: await createMashup(parsed.data) },
      { status: 201 },
    );
  } catch (error) {
    if (error instanceof MashupRequestError) {
      return Response.json({ error: error.message }, { status: error.status });
    }
    throw error;
  }
}
