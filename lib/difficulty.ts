export const DIFFICULTIES = ["easy", "medium", "hard", "extreme"] as const;

export type Difficulty = (typeof DIFFICULTIES)[number];

const RATING_BANDS: Record<Difficulty, { start: number; end: number }> = {
  easy: { start: 0, end: 1599 },
  medium: { start: 1600, end: 2399 },
  hard: { start: 2400, end: 2999 },
  extreme: { start: 3000, end: 3500 },
};

export function difficultyFromRating(rating: number): Difficulty {
  if (rating < 1600) return "easy";
  if (rating < 2400) return "medium";
  if (rating < 3000) return "hard";
  return "extreme";
}

export function effectiveRatingRange(
  start: number | null,
  end: number | null,
): { start: number; end: number } | null {
  if (start !== null && !Number.isFinite(start)) start = null;
  if (end !== null && !Number.isFinite(end)) end = null;
  if (start === null && end === null) return null;
  const first = start ?? end!;
  const second = end ?? start!;
  return {
    start: Math.min(first, second),
    end: Math.max(first, second),
  };
}

export function matchesRatingRange(
  problem: { rating: number | null; difficulty: Difficulty | null },
  start: number | null,
  end: number | null,
) {
  const range = effectiveRatingRange(start, end);
  if (!range) return true;
  if (problem.rating !== null) {
    return problem.rating >= range.start && problem.rating <= range.end;
  }
  if (!problem.difficulty) return false;
  const band = RATING_BANDS[problem.difficulty];
  return band.start <= range.end && band.end >= range.start;
}
