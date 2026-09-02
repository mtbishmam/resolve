import { describe, expect, it } from "vitest";
import {
  assertStructuredStatement,
  formatStatementSamples,
  normalizeStatementForPlatform,
} from "@/lib/statement-parser";

describe("statement parser contract", () => {
  it.each([
    ["codeforces", "## Example\n\nInput: 3 3 1 2 2 1 Output: 3 2 1"],
    ["cses", "## Example\n\nInput: 5 3 1 2 1 3 Output: 1 2 2 1 2"],
    ["atcoder", "### Sample Input 1\n1 2\n### Sample Output 1\n3"],
    ["codechef", "## Sample Input\n1 2\n## Sample Output\n3"],
    ["lightoj", "## Sample\n\nSample Input: 1 2 3 Sample Output: Case 1: 6"],
  ] as const)("rejects flattened %s samples", (platform, statement) => {
    expect(() => assertStructuredStatement(platform, statement)).toThrow(
      `${platform} statement samples must preserve input and output as separate fenced text blocks`,
    );
  });

  it.each(["codeforces", "cses", "atcoder", "codechef", "lightoj"] as const)(
    "formats %s samples into separate text blocks",
    (platform) => {
      const statement = formatStatementSamples(platform, [
        { input: "2\r\n1 2", output: "3\n" },
        { input: "4\n5", output: "9" },
      ]);

      expect(statement).toContain("```text\n2\n1 2\n```");
      expect(statement).toContain("```text\n3\n```");
      expect(statement.match(/```text/g)).toHaveLength(4);
      expect(() =>
        assertStructuredStatement(platform, statement),
      ).not.toThrow();
    },
  );

  it("selects AtCoder's English statement section", () => {
    const normalized = normalizeStatementForPlatform(
      "atcoder",
      "### 問題文\n日本語の本文\n\n### Problem Statement\nEnglish body\n\n### Sample Input 1\n\n1\n\n### Sample Output 1\n\n2",
    );

    expect(normalized).not.toContain("日本語の本文");
    expect(normalized).toContain("English body");
    expect(normalized).toContain("### Input");
    expect(normalized).toContain("### Output");
  });

  it("turns LightOJ's two-column sample table into fenced blocks", () => {
    const normalized = normalizeStatementForPlatform(
      "lightoj",
      "## Sample\n\nSample Input  | Sample Output\n--- | ---\n3 0 0 5 0 | Case 1: 0",
    );

    expect(normalized).toContain("### Input");
    expect(normalized).toContain("```text\n3 0 0 5 0\n```");
    expect(normalized).toContain("### Output");
    expect(normalized).toContain("```text\nCase 1: 0\n```");
    expect(() =>
      assertStructuredStatement("lightoj", normalized),
    ).not.toThrow();
  });

  it("does not require samples for statements that have none", () => {
    expect(() =>
      assertStructuredStatement("cses", "## Input\n\nRead n."),
    ).not.toThrow();
  });
});
