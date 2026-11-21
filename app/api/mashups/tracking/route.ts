import { z } from "zod";
import { judgePage } from "@/extension/src/tracking";
import {
  getMashupProblemUrls,
  getOngoingMashup,
  getTrackedProblem,
  updateMashup,
} from "@/db/queries";
import type { Mashup } from "@/lib/contracts";
import { MASHUP_PROBLEM_LIMIT_SECONDS, mashupClock } from "@/lib/mashup-clock";

export const dynamic = "force-dynamic";

const headers = { "cache-control": "no-store" };
const TrackingSchema = z
  .object({ url: z.string().max(2048).nullable() })
  .strict();

function isLocal(request: Request) {
  return ["localhost", "127.0.0.1"].includes(new URL(request.url).hostname);
}

async function trackingResponse(
  mashup: Mashup | null,
  problem: Awaited<ReturnType<typeof getTrackedProblem>>,
  allowAdvance = false,
) {
  if (!mashup) return Response.json({ status: "none" }, { headers });
  const now = Date.now();
  const clock = mashupClock(mashup, now);
  const seconds = problem ? (clock.byProblem[problem.id] ?? 0) : 0;
  const timeUp = seconds >= MASHUP_PROBLEM_LIMIT_SECONDS;
  const tracking =
    clock.running && !clock.waiting && problem?.id === mashup.trackedProblemId;
  let nextUrl: string | null = null;
  if (problem && allowAdvance && tracking && timeUp) {
    const remaining = mashup.problemIds
      .slice(mashup.problemIds.indexOf(problem.id) + 1)
      .filter(
        (id) => (clock.byProblem[id] ?? 0) < MASHUP_PROBLEM_LIMIT_SECONDS,
      );
    if (remaining.length) {
      const urls = await getMashupProblemUrls(remaining);
      nextUrl =
        remaining.map((id) => judgePage(urls.get(id))).find(Boolean) ?? null;
    }
  }
  return Response.json(
    {
      status: !clock.running
        ? "paused"
        : clock.waiting
          ? "scheduled"
          : "running",
      problem: problem
        ? {
            title: problem.title,
            seconds,
            limitSeconds: MASHUP_PROBLEM_LIMIT_SECONDS,
            ticking: tracking && !timeUp,
          }
        : null,
      nextUrl,
      observedAt: now,
    },
    { headers },
  );
}

export async function GET(request: Request) {
  if (!isLocal(request)) return new Response(null, { status: 404 });
  const mashup = await getOngoingMashup();
  const url = judgePage(
    new URL(request.url).searchParams.get("url") ?? undefined,
  );
  return trackingResponse(
    mashup,
    mashup ? await getTrackedProblem(mashup, url) : null,
  );
}

export async function POST(request: Request) {
  if (!isLocal(request)) return new Response(null, { status: 404 });
  if (!request.headers.get("content-type")?.startsWith("application/json")) {
    return new Response(null, { status: 415 });
  }
  const input = TrackingSchema.safeParse(
    await request.json().catch(() => null),
  );
  if (!input.success) return new Response(null, { status: 400 });
  const mashup = await getOngoingMashup();
  if (!mashup) return trackingResponse(null, null);
  const problem = await getTrackedProblem(
    mashup,
    judgePage(input.data.url ?? undefined),
  );
  const updated = mashupClock(mashup, Date.now()).running
    ? await updateMashup(mashup.id, {}, { problemId: problem?.id ?? null })
    : mashup;
  return trackingResponse(updated, problem, true);
}
