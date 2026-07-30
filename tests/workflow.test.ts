import { describe, expect, it } from "vitest";
import {
  PROBLEM_STATES,
  PROBLEM_STATUSES,
  reviewTimerMinutes,
} from "@/lib/workflow";

describe("workflow model", () => {
  it("keeps State and Status as separate finite contracts", () => {
    expect(PROBLEM_STATES).toEqual(["retry", "revise", "resolve"]);
    expect(PROBLEM_STATUSES).toEqual([
      "backlog",
      "attempting",
      "pending_ac",
      "accepted",
    ]);
  });

  it("uses the requested review timer matrix", () => {
    expect(reviewTimerMinutes("revise", "easy")).toBe(10);
    expect(reviewTimerMinutes("revise", "medium")).toBe(20);
    expect(reviewTimerMinutes("revise", "hard")).toBe(30);
    expect(reviewTimerMinutes("revise", "extreme")).toBe(30);
    expect(reviewTimerMinutes("retry", "medium")).toBe(30);
    expect(reviewTimerMinutes("retry", "hard")).toBe(60);
    expect(reviewTimerMinutes("retry", "extreme")).toBe(90);
    expect(reviewTimerMinutes("resolve", "extreme")).toBe(90);
  });
});
