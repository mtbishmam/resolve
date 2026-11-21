import { describe, expect, it } from "vitest";
import {
  backdatedProblemTime,
  mashupClock,
  nextFiveMinuteBoundary,
} from "@/lib/mashup-clock";
import { judgePage } from "../extension/src/tracking";

const mashup = {
  status: "active",
  startedAt: new Date(100_000).toISOString(),
  clockElapsedSeconds: 10,
  clockStartedMs: 100_000,
  clockSeenMs: 104_000,
  trackedProblemId: "a",
  elapsedByProblem: { a: 3, b: 5 },
} satisfies Parameters<typeof mashupClock>[0];

describe("local mashup clock", () => {
  it("projects a timestamp-based timer even when the app is not in the foreground", () => {
    expect(mashupClock(mashup, 107_500)).toEqual({
      running: true,
      waiting: false,
      elapsed: 17.5,
      byProblem: { a: 10.5, b: 5 },
    });
    expect(
      mashupClock({ ...mashup, trackedProblemId: null }, 107_500).byProblem,
    ).toEqual({ a: 3, b: 5 });
  });

  it("does not count before the start or while paused", () => {
    expect(mashupClock(mashup, 99_000)).toMatchObject({
      waiting: true,
      elapsed: 10,
    });
    expect(
      mashupClock({ ...mashup, clockStartedMs: null }, 107_000),
    ).toMatchObject({ running: false, elapsed: 10 });
  });

  it("counts elapsed time immediately when a mashup is manually backdated", () => {
    const startedAt = Date.parse("2026-11-10T09:00:00.000Z");
    const now = startedAt + 2 * 60_000;
    expect(
      mashupClock(
        {
          ...mashup,
          startedAt: new Date(startedAt).toISOString(),
          clockStartedMs: startedAt,
          clockSeenMs: now,
        },
        now,
      ),
    ).toMatchObject({ running: true, waiting: false, elapsed: 130 });
  });

  it("credits backdated time to the first problem with the normal one-hour cap", () => {
    const now = Date.parse("2026-11-10T12:00:00.000Z");
    expect(backdatedProblemTime(now - 2 * 60_000, now, "first")).toEqual({
      first: 120,
    });
    expect(backdatedProblemTime(now - 2 * 60 * 60_000, now, "first")).toEqual({
      first: 3600,
    });
    expect(backdatedProblemTime(now + 60_000, now, "first")).toEqual({});
  });

  it("freezes an abandoned session at the last checkpoint", () => {
    expect(mashupClock(mashup, 230_000)).toMatchObject({
      running: false,
      elapsed: 14,
      byProblem: { a: 7, b: 5 },
    });
  });

  it("caps problem time across resumed visits without stopping the global clock", () => {
    const capped = { ...mashup, elapsedByProblem: { a: 3599, b: 5 } };
    expect(mashupClock(capped, 104_000)).toMatchObject({
      elapsed: 14,
      byProblem: { a: 3600, b: 5 },
    });
    expect(
      mashupClock({ ...capped, trackedProblemId: "b" }, 106_000).byProblem,
    ).toEqual({ a: 3599, b: 11 });
    expect(
      mashupClock({ ...capped, elapsedByProblem: { a: 3700 } }, 106_000)
        .byProblem,
    ).toEqual({ a: 3700 }); // preserve historical totals
  });

  it("rounds Now to the next five-minute boundary", () => {
    const now = (hhmm: string) => Date.parse(`2026-11-09T${hhmm}:00+06:00`);
    expect(nextFiveMinuteBoundary(now("12:02"))).toBe(now("12:05"));
    expect(nextFiveMinuteBoundary(now("11:58"))).toBe(now("12:00"));
    expect(nextFiveMinuteBoundary(now("12:00"))).toBe(now("12:05"));
  });
});

describe("extension URL privacy", () => {
  it("strips query and fragment from supported judge links", () => {
    expect(
      judgePage(
        "https://codeforces.com/problemset/problem/2041/D?locale=en#example",
      ),
    ).toBe("https://codeforces.com/problemset/problem/2041/D");
    expect(
      judgePage("https://atcoder.jp/contests/abc446/tasks/abc446_d?lang=en"),
    ).toBe("https://atcoder.jp/contests/abc446/tasks/abc446_d");
  });
  it("does not send other tabs or non-problem pages", () => {
    expect(judgePage("https://codeforces.com/profile/example")).toBeNull();
    expect(judgePage("https://example.com/secret")).toBeNull();
    expect(
      judgePage("https://codeforces.com:9000/contest/1983/problem/D"),
    ).toBeNull();
  });
});
