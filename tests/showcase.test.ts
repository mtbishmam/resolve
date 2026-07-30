import { readFileSync } from "node:fs";
import { resolve } from "node:path";
import { describe, expect, it } from "vitest";

type ShowcaseRecord = {
  problem: {
    platform: string;
    title: string;
    problemKey: string;
    rating: number | null;
    difficulty: "easy" | "medium" | "hard" | "extreme";
    statementMarkdown: string;
    reviewStatus: string;
    importProvenance: { learning_field_warning: string };
  };
  reflection: {
    sourceStatus: string;
    transcriptMessages: unknown[];
  };
};

const showcase = JSON.parse(
  readFileSync(resolve(process.cwd(), "data/showcase.json"), "utf8"),
) as { records: ShowcaseRecord[] };
const selection = JSON.parse(
  readFileSync(resolve(process.cwd(), "data/showcase-selection.json"), "utf8"),
);

describe("showcase import", () => {
  it("contains only the approved small set", () => {
    expect(showcase.records).toHaveLength(8);
    expect(selection.selected_count).toBe(8);
    expect(
      new Set(showcase.records.map((record) => record.problem.platform)),
    ).toEqual(new Set(["codeforces", "cses"]));
  });

  it("keeps official names separate from identity metadata", () => {
    for (const { problem } of showcase.records) {
      expect(problem.title).not.toContain(problem.problemKey);
      expect(problem.title).not.toMatch(/^Problem\s*-/);
      expect(problem.statementMarkdown.length).toBeGreaterThan(150);
    }
  });

  it("demonstrates all required states and honest missing source", () => {
    const states = new Set(
      showcase.records.map((record) => record.problem.reviewStatus),
    );
    expect(states).toEqual(new Set(["retry", "revise", "resolve"]));
    expect(
      showcase.records.filter(
        (record) => record.reflection.sourceStatus === "missing",
      ),
    ).toHaveLength(1);
  });

  it("backfills difficulty only for the approved demo records", () => {
    for (const { problem } of showcase.records) {
      expect(["easy", "medium", "hard", "extreme"]).toContain(
        problem.difficulty,
      );
      if (problem.rating !== null) {
        const expected =
          problem.rating < 1600
            ? "easy"
            : problem.rating < 2400
              ? "medium"
              : problem.rating < 3000
                ? "hard"
                : "extreme";
        expect(problem.difficulty).toBe(expected);
      }
    }
  });

  it("marks inferred fields and never fabricates review history", () => {
    for (const { problem, reflection } of showcase.records) {
      expect(problem.importProvenance.learning_field_warning).toContain(
        "need user confirmation",
      );
      expect(reflection.transcriptMessages).toEqual([]);
    }
    expect(readFileSync("drizzle/0001_showcase.sql", "utf8")).not.toContain(
      "INSERT INTO reviews",
    );
  });
});
