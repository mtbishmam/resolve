import { createElement } from "react";
import { renderToStaticMarkup } from "react-dom/server";
import { describe, expect, it } from "vitest";
import Markdown, {
  normalizeStatementText,
  normalizeSymbolicInputBlocks,
} from "@/app/markdown";

describe("statement rendering", () => {
  it("renders TeX and an external image link", () => {
    const html = renderToStaticMarkup(
      createElement(
        Markdown,
        null,
        "For $x^2$, inspect the diagram.\n\n![diagram](https://example.com/problem.png)",
      ),
    );

    expect(html).toContain('class="katex"');
    expect(html).toContain('src="https://example.com/problem.png"');
    expect(html).toContain('alt="diagram"');
    expect(html).toContain("<figcaption>diagram</figcaption>");
  });

  it("repairs captured Codeforces TeX that lost MathJax delimiters", () => {
    expect(
      normalizeStatementText("1 \\le x \\le n and a_{l_i}, \\dots, a_{r_i}"),
    ).toBe("1 ≤ x ≤ n and a[l[i]], …, a[r[i]]");

    expect(
      normalizeStatementText(
        "Split into \\frac{n}{k} parts, where 1 \\le k \\le 2\\cdot10^5 and x \\bmod m = 0.",
      ),
    ).toBe("Split into (n)/(k) parts, where 1 ≤ k ≤ 2·10^5 and x mod m = 0.");
  });

  it("renders symbolic input formats as math while preserving real samples", () => {
    const statement = [
      "## Input",
      "",
      "```text",
      "N",
      "A_1 A_2 ... A_N",
      "```",
      "",
      "## Sample Input 1",
      "",
      "```text",
      "7",
      "3 4 3 5 7 6 2",
      "```",
    ].join("\n");
    const normalized = normalizeSymbolicInputBlocks(statement);
    expect(normalized).toContain("\\begin{gathered}");
    expect(normalized).toContain("A_1 \\quad A_2 \\quad \\ldots \\quad A_N");
    expect(normalized).toContain("```text\n7\n3 4 3 5 7 6 2\n```");

    const html = renderToStaticMarkup(
      createElement(Markdown, { statement: true }, statement),
    );
    expect(html).toContain("katex-display");
    expect(html).toContain("<pre>");
  });
});
