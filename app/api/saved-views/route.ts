import { z } from "zod";
import { authorizeBrowserRequest } from "@/lib/auth";
import {
  deleteCustomView,
  listSavedViews,
  saveCustomView,
  setDefaultView,
} from "@/db/queries";

const ViewSchema = z.object({
  name: z.string().min(1).max(80),
  filter: z.unknown(),
  sort: z.unknown(),
  visibleColumns: z.unknown(),
});

const DefaultViewSchema = z.object({
  id: z.string().min(1).max(128),
  pinned: z.boolean(),
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

export async function PATCH(request: Request) {
  if (!(await authorizeBrowserRequest(request))) {
    return Response.json({ error: "Unauthorized" }, { status: 401 });
  }
  const parsed = DefaultViewSchema.safeParse(await request.json());
  if (!parsed.success) {
    return Response.json({ error: "Invalid default view" }, { status: 400 });
  }
  if (!(await setDefaultView(parsed.data.id, parsed.data.pinned))) {
    return Response.json(
      { error: "View not found or is not the pinned view" },
      { status: 404 },
    );
  }
  return Response.json({
    defaultViewId: parsed.data.pinned ? parsed.data.id : null,
  });
}

export async function DELETE(request: Request) {
  if (!(await authorizeBrowserRequest(request))) {
    return Response.json({ error: "Unauthorized" }, { status: 401 });
  }
  const id = new URL(request.url).searchParams.get("id");
  if (!id) return Response.json({ error: "Missing id" }, { status: 400 });
  if (!(await deleteCustomView(id))) {
    return Response.json(
      { error: "Core views cannot be deleted" },
      { status: 409 },
    );
  }
  return new Response(null, { status: 204 });
}
