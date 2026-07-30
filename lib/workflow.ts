import type { Difficulty } from "@/lib/difficulty";

export const PROBLEM_STATES = ["retry", "revise", "resolve"] as const;
export const PROBLEM_STATUSES = [
  "backlog",
  "attempting",
  "pending_ac",
  "accepted",
] as const;

export type ProblemState = (typeof PROBLEM_STATES)[number];
export type ProblemStatus = (typeof PROBLEM_STATUSES)[number];

const REVIEW_MINUTES: Record<ProblemState, Record<Difficulty, number>> = {
  revise: { easy: 10, medium: 20, hard: 30, extreme: 30 },
  retry: { easy: 10, medium: 30, hard: 60, extreme: 90 },
  resolve: { easy: 10, medium: 30, hard: 60, extreme: 90 },
};

export function reviewTimerMinutes(
  state: ProblemState | null,
  difficulty: Difficulty | null,
) {
  return REVIEW_MINUTES[state ?? "resolve"][difficulty ?? "medium"];
}

export const STATE_DEFINITIONS: Record<ProblemState, string> = {
  revise:
    "Insta Solve: a problem you expect to solve again; review it under a short speed target.",
  retry:
    "Unsolved: a problem you previously could not finish and need to attempt again.",
  resolve:
    "Uncertain recall: a problem you solved or studied but are not sure you can reconstruct.",
};
