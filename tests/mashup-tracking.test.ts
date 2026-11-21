import { beforeEach, describe, expect, it, vi } from "vitest";
import { GET, POST } from "@/app/api/mashups/tracking/route";
import {
  getMashupProblemUrls,
  getOngoingMashup,
  getTrackedProblem,
  updateMashup,
} from "@/db/queries";
import type { Mashup } from "@/lib/contracts";

vi.mock("@/db/queries", () => ({
  getMashupProblemUrls: vi.fn(),
  getOngoingMashup: vi.fn(),
  getTrackedProblem: vi.fn(),
  updateMashup: vi.fn(),
}));

const currentUrl = "https://codeforces.com/contest/1983/problem/D";
const nextUrl = "https://atcoder.jp/contests/abc446/tasks/abc446_d";
const endpoint = "http://localhost:3000/api/mashups/tracking";

function report(url: string | null, endpointUrl = endpoint) {
  return POST(
    new Request(endpointUrl, {
      method: "POST",
      headers: { "content-type": "application/json" },
      body: JSON.stringify({ url }),
    }),
  );
}

describe("local extension clock API", () => {
  let mashup: Mashup;
  beforeEach(() => {
    vi.resetAllMocks();
    const now = Date.now();
    const startedAt = new Date(now).toISOString();
    mashup = {
      id: "mashup",
      sprintId: null,
      problemIds: ["current", "expired", "next"],
      activeProblemId: "next",
      elapsedByProblem: { current: 3600, expired: 3600 },
      notesByProblem: {},
      durationSeconds: 18_000,
      startedAt,
      endedAt: null,
      status: "active",
      createdAt: startedAt,
      updatedAt: startedAt,
      clockElapsedSeconds: 7200,
      clockStartedMs: now,
      clockSeenMs: now,
      trackedProblemId: "current",
      revision: 1,
    };
    vi.mocked(getOngoingMashup).mockResolvedValue(mashup);
    vi.mocked(getTrackedProblem).mockResolvedValue({
      id: "current",
      title: "Swap Dilemma",
    });
    vi.mocked(updateMashup).mockResolvedValue(mashup);
    vi.mocked(getMashupProblemUrls).mockResolvedValue(
      new Map([["next", nextUrl]]),
    );
  });

  it("advances an expired active URL in mashup order, skipping expired problems", async () => {
    const response = await report(currentUrl + "?locale=en#example");
    expect(getTrackedProblem).toHaveBeenCalledWith(mashup, currentUrl);
    expect(getMashupProblemUrls).toHaveBeenCalledWith(["next"]);
    expect(await response.json()).toMatchObject({
      status: "running",
      problem: { seconds: 3600, ticking: false },
      nextUrl,
    });
  });

  it("does not advance a paused mashup or a read-only lookup", async () => {
    const lookup = new URL(endpoint);
    lookup.searchParams.set("url", currentUrl);
    expect(await (await GET(new Request(lookup))).json()).toMatchObject({
      nextUrl: null,
    });
    mashup.clockStartedMs = null;
    expect(await (await report(currentUrl)).json()).toMatchObject({
      status: "paused",
      nextUrl: null,
    });
    expect(updateMashup).not.toHaveBeenCalled();
  });

  it("leaves the final problem open and refuses hosted requests", async () => {
    mashup.problemIds = ["current"];
    expect(await (await report(currentUrl)).json()).toMatchObject({
      nextUrl: null,
    });
    expect(
      (await report(currentUrl, "https://resolve.example/api/mashups/tracking"))
        .status,
    ).toBe(404);
  });
});
