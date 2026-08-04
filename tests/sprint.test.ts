import { readFileSync } from "node:fs";
import { resolve } from "node:path";
import { describe, expect, it } from "vitest";

type SprintRecord = {
  problemKey: string;
  rating: number;
  dueDate: string;
};

const snapshot = JSON.parse(
  readFileSync(
    resolve(import.meta.dirname, "..", "data", "cp31-august-2026.json"),
    "utf8",
  ),
) as { records: SprintRecord[] };

describe("August CP31 Sprint snapshot", () => {
  it("contains 31 unique canonical problems in each requested band", () => {
    expect(snapshot.records).toHaveLength(124);
    expect(
      new Set(snapshot.records.map((problem) => problem.problemKey)).size,
    ).toBe(124);
    for (const rating of [1600, 1700, 1800, 1900]) {
      expect(
        snapshot.records.filter((problem) => problem.rating === rating),
      ).toHaveLength(31);
    }
  });

  it("uses the shifted August 5 through September 1 schedule", () => {
    const ranges = new Map([
      [1600, ["2026-08-05", "2026-08-11"]],
      [1700, ["2026-08-12", "2026-08-18"]],
      [1800, ["2026-08-19", "2026-08-25"]],
      [1900, ["2026-08-26", "2026-09-01"]],
    ]);
    for (const [rating, [first, last]] of ranges) {
      const band = snapshot.records.filter(
        (problem) => problem.rating === rating,
      );
      expect(band[0].dueDate).toBe(first);
      expect(band.at(-1)?.dueDate).toBe(last);
      const perDay = Object.values(
        Object.groupBy(band, (problem) => problem.dueDate),
      ).map((problems) => problems?.length ?? 0);
      expect(perDay).toEqual([5, 5, 5, 5, 5, 5, 1]);
    }
  });
});
