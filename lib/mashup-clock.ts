import type { Mashup } from "./contracts";

// A lost client (crash, power loss) can never count beyond its last check-in.
// Allow for background Chromium tabs whose timers run only once per minute.
const LEASE_MS = 120_000;
export const MASHUP_PROBLEM_LIMIT_SECONDS = 60 * 60;
export const MASHUP_TAB_KEY = "resolve.open-mashup-tab";

export function backdatedProblemTime(
  startedAtMs: number,
  nowMs: number,
  firstProblemId: string,
) {
  const elapsed = Math.min(
    MASHUP_PROBLEM_LIMIT_SECONDS,
    Math.max(0, (nowMs - startedAtMs) / 1000),
  );
  return elapsed > 0 ? { [firstProblemId]: elapsed } : {};
}

type ClockFields = Pick<
  Mashup,
  | "status"
  | "startedAt"
  | "clockStartedMs"
  | "clockSeenMs"
  | "clockElapsedSeconds"
  | "trackedProblemId"
  | "elapsedByProblem"
>;

export function mashupClock(mashup: ClockFields, now: number) {
  const start = mashup.clockStartedMs;
  const lastSeen = Math.max(
    Date.parse(mashup.startedAt),
    mashup.clockSeenMs ?? 0,
  );
  const running =
    mashup.status === "active" && start !== null && now - lastSeen <= LEASE_MS;
  const delta =
    start === null
      ? 0
      : Math.max(0, ((running ? now : lastSeen) - start) / 1000);
  const id = mashup.trackedProblemId;
  const prior = id ? (mashup.elapsedByProblem[id] ?? 0) : 0;
  const problemDelta = Math.min(
    delta,
    Math.max(0, MASHUP_PROBLEM_LIMIT_SECONDS - prior),
  );
  return {
    running,
    waiting: running && start !== null && now < start,
    elapsed: mashup.clockElapsedSeconds + delta,
    byProblem:
      id && problemDelta > 0
        ? {
            ...mashup.elapsedByProblem,
            [id]: prior + problemDelta,
          }
        : mashup.elapsedByProblem,
  };
}

export function nextFiveMinuteBoundary(now: number) {
  return (Math.floor(now / 300_000) + 1) * 300_000;
}
