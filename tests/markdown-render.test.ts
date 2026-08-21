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

  it("normalizes MathJax delimiters and escaped Markdown fences", () => {
    const statement = [
      String.raw`Inline \(A_i\) and display \[\sum_{i=1}^{9} A_i\].`,
      "",
      "\\`\\`\\`",
      "T",
      "\\`\\`\\`",
    ].join("\n");
    const normalized = normalizeStatementText(statement);

    expect(normalized).toContain("$A_i$");
    expect(normalized).toContain("$$\\sum_{i=1}^{9} A_i$$");
    expect(normalized).toContain("```\nT\n```");

    const html = renderToStaticMarkup(
      createElement(Markdown, { statement: true }, statement),
    );
    expect(html).toContain('class="katex"');
    expect(html).toContain("<pre>");
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

  it("renders indexed case schematics and vertical dots as math", () => {
    const statement = [
      "## Input",
      "",
      "```text",
      "T",
      "case_1",
      "case_2",
      "\\vdots",
      "case_T",
      "```",
    ].join("\n");
    const normalized = normalizeSymbolicInputBlocks(statement);

    expect(normalized).toContain("\\begin{gathered}");
    expect(normalized).toContain("case_1");
    expect(normalized).toContain("\\vdots");
    expect(normalized).not.toContain("```text");

    const html = renderToStaticMarkup(
      createElement(Markdown, { statement: true }, statement),
    );
    expect(html).toContain("katex-display");
    expect(html).toContain("⋮");
  });

  it("turns loose vertical-dot commands into the intended glyph", () => {
    expect(normalizeStatementText(String.raw`Continue with \vdots here.`)).toBe(
      "Continue with ⋮ here.",
    );
  });

  it("keeps example input and output left-alignable with independent copy buttons", () => {
    const statement = [
      "## Example",
      "",
      "### Input",
      "",
      "```text",
      "2",
      "67C",
      "C76",
      "```",
      "",
      "### Output",
      "",
      "```text",
      "1",
      "0",
      "```",
    ].join("\n");
    const normalized = normalizeSymbolicInputBlocks(statement);
    expect(normalized).not.toContain("\\begin{gathered}");
    expect(normalized).toContain("```text\n2\n67C\nC76\n```");

    const html = renderToStaticMarkup(
      createElement(Markdown, { statement: true }, statement),
    );
    expect(html.match(/data-code-block="true"/g)).toHaveLength(2);
    expect(html.match(/aria-label="Copy code block"/g)).toHaveLength(2);
    expect(html).toContain('<pre><code class="language-text">2\n67C\nC76');
    expect(html).toContain('<pre><code class="language-text">1\n0');
  });
});
