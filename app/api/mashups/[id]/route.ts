import { authorizeBrowserRequest } from "@/lib/auth";
import { UpdateMashupSchema } from "@/lib/contracts";
import {
  deleteMashup,
  getMashup,
  MashupRequestError,
  updateMashup,
} from "@/db/queries";

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
  return Response.json(
    { mashup },
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
  const parsed = UpdateMashupSchema.safeParse(await request.json());
  if (!parsed.success) {
    return Response.json(
      { error: "Invalid mashup update", issues: parsed.error.issues },
      { status: 400 },
    );
  }
  try {
    const mashup = await updateMashup((await context.params).id, parsed.data);
    if (!mashup) return Response.json({ error: "Not found" }, { status: 404 });
    return Response.json({ mashup });
  } catch (error) {
    if (error instanceof MashupRequestError) {
      return Response.json({ error: error.message }, { status: error.status });
    }
    throw error;
  }
}

// sendBeacon uses POST. Restrict this unload path to pausing one session.
export async function POST(
  request: Request,
  context: { params: Promise<{ id: string }> },
) {
  if (!(await authorizeBrowserRequest(request))) {
    return Response.json({ error: "Unauthorized" }, { status: 401 });
  }
  if (!request.headers.get("content-type")?.startsWith("application/json")) {
    return new Response(null, { status: 415 });
  }
  try {
    const mashup = await updateMashup((await context.params).id, {
      clock_action: "pause",
    });
    return new Response(null, { status: mashup ? 204 : 404 });
  } catch (error) {
    if (error instanceof MashupRequestError)
      return new Response(null, { status: error.status });
    throw error;
  }
}

export async function DELETE(
  request: Request,
  context: { params: Promise<{ id: string }> },
) {
  if (!(await authorizeBrowserRequest(request))) {
    return Response.json({ error: "Unauthorized" }, { status: 401 });
  }
  const deleted = await deleteMashup((await context.params).id);
  if (!deleted) return Response.json({ error: "Not found" }, { status: 404 });
  return Response.json({ deleted: true });
}
