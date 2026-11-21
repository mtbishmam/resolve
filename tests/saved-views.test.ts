import { beforeEach, describe, expect, it, vi } from "vitest";
import { authorizeBrowserRequest } from "@/lib/auth";
import { setDefaultView } from "@/db/queries";
import { PATCH } from "@/app/api/saved-views/route";

vi.mock("@/lib/auth", () => ({
  authorizeBrowserRequest: vi.fn(),
}));

vi.mock("@/db/queries", () => ({
  deleteCustomView: vi.fn(),
  listSavedViews: vi.fn(),
  saveCustomView: vi.fn(),
  setDefaultView: vi.fn(),
}));

function patch(body: unknown) {
  return PATCH(
    new Request("http://localhost/api/saved-views", {
      method: "PATCH",
      headers: { "content-type": "application/json" },
      body: JSON.stringify(body),
    }),
  );
}

describe("saved-view startup pin API", () => {
  beforeEach(() => {
    vi.resetAllMocks();
    vi.mocked(authorizeBrowserRequest).mockResolvedValue(true);
    vi.mocked(setDefaultView).mockResolvedValue(true);
  });

  it("pins a core or custom view as the startup view", async () => {
    const response = await patch({ id: "custom-1700", pinned: true });

    expect(response.status).toBe(200);
    expect(await response.json()).toEqual({ defaultViewId: "custom-1700" });
    expect(setDefaultView).toHaveBeenCalledWith("custom-1700", true);
  });

  it("clears the startup pin so the client can fall back to Due today", async () => {
    const response = await patch({ id: "view-all", pinned: false });

    expect(response.status).toBe(200);
    expect(await response.json()).toEqual({ defaultViewId: null });
    expect(setDefaultView).toHaveBeenCalledWith("view-all", false);
  });

  it("rejects malformed pin requests and unknown views", async () => {
    expect((await patch({ id: "view-all", pinned: "yes" })).status).toBe(400);
    vi.mocked(setDefaultView).mockResolvedValue(false);
    expect((await patch({ id: "missing", pinned: true })).status).toBe(404);
  });

  it("requires the browser session", async () => {
    vi.mocked(authorizeBrowserRequest).mockResolvedValue(false);

    expect((await patch({ id: "view-all", pinned: true })).status).toBe(401);
    expect(setDefaultView).not.toHaveBeenCalled();
  });
});
