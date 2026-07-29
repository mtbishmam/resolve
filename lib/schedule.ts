import type { z } from "zod";
import { ReviewOutcomeSchema } from "./contracts";

export const SCHEDULE_VERSION = "initial-v1";
export const INITIAL_INTERVALS: Record<
  z.infer<typeof ReviewOutcomeSchema>,
  number
> = {
  recalled: 14,
  needed_cue: 7,
  forgot: 2,
  unresolved: 1,
};

export function addCalendarDays(date: string, days: number) {
  const [year, month, day] = date.split("-").map(Number);
  const utc = new Date(Date.UTC(year, month - 1, day + days));
  return utc.toISOString().slice(0, 10);
}

export function nextReviewDate(
  reviewedDate: string,
  outcome: z.infer<typeof ReviewOutcomeSchema>,
) {
  return addCalendarDays(reviewedDate, INITIAL_INTERVALS[outcome]);
}
