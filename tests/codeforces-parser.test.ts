import { describe, expect, it } from "vitest";
import {
  formatCodeforcesSampleMarkdown,
  hasStructuredCodeforcesSamples,
  normalizePreformattedText,
} from "../extension/src/codeforces-parser";

describe("Codeforces sample parser", () => {
  it("preserves sample line breaks and separates input from output", () => {
    const markdown = formatCodeforcesSampleMarkdown(
      "3\r\n3\n1 2 2 1\n2 3 3 2\n",
      "3 2 1\n",
    );

    expect(markdown).toBe(
      "\n\n### Input\n\n```text\n3\n3\n1 2 2 1\n2 3 3 2\n```\n\n### Output\n\n```text\n3 2 1\n```\n\n",
    );
    expect(hasStructuredCodeforcesSamples(`## Example${markdown}`)).toBe(true);
  });

  it("rejects empty sample sides instead of storing an incomplete capture", () => {
    expect(() => formatCodeforcesSampleMarkdown("", "3 2 1")).toThrow(
      "must contain input and output",
    );
  });

  it("normalizes browser line endings and trailing whitespace only", () => {
    expect(normalizePreformattedText("a  \r\nb\t\n")).toBe("a\nb");
  });

  it("does not mistake flattened example text for structured samples", () => {
    expect(
      hasStructuredCodeforcesSamples(
        "## Example\n\nInput: 3 3 1 2 2 1 Output: 3 2 1",
      ),
    ).toBe(false);
  });
});
