import { describe, expect, it } from "vitest";
import {
  difficultyFromRating,
  effectiveRatingRange,
  matchesRatingRange,
  type Difficulty,
} from "@/lib/difficulty";

function problem(rating: number | null, difficulty: Difficulty | null) {
  return { rating, difficulty };
}

describe("difficulty bands", () => {
  it.each([
    [1599, "easy"],
    [1600, "medium"],
    [2399, "medium"],
    [2400, "hard"],
    [2999, "hard"],
    [3000, "extreme"],
    [3500, "extreme"],
  ] as const)("maps rating %i to %s", (rating, difficulty) => {
    expect(difficultyFromRating(rating)).toBe(difficulty);
  });
});

describe("rating range filters", () => {
  it("turns either single endpoint into an exact-rating filter", () => {
    expect(effectiveRatingRange(1600, null)).toEqual({
      start: 1600,
      end: 1600,
    });
    expect(effectiveRatingRange(null, 2300)).toEqual({
      start: 2300,
      end: 2300,
    });
  });

  it("normalizes a reversed range and ignores invalid empty input", () => {
    expect(effectiveRatingRange(2400, 1600)).toEqual({
      start: 1600,
      end: 2400,
    });
    expect(effectiveRatingRange(Number.NaN, null)).toBeNull();
  });

  it("matches rated problems inclusively", () => {
    expect(matchesRatingRange(problem(1600, "medium"), 1600, null)).toBe(true);
    expect(matchesRatingRange(problem(1601, "medium"), 1600, null)).toBe(false);
    expect(matchesRatingRange(problem(2400, "hard"), 1600, 2400)).toBe(true);
  });

  it("matches unrated problems when their difficulty band overlaps", () => {
    expect(matchesRatingRange(problem(null, "medium"), 1600, null)).toBe(true);
    expect(matchesRatingRange(problem(null, "medium"), 2300, null)).toBe(true);
    expect(matchesRatingRange(problem(null, "medium"), 2400, null)).toBe(false);
    expect(matchesRatingRange(problem(null, "hard"), 1600, 2400)).toBe(true);
    expect(matchesRatingRange(problem(null, null), 1600, 2400)).toBe(false);
  });
});
