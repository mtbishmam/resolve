import { createElement } from "react";
import { renderToStaticMarkup } from "react-dom/server";
import { describe, expect, it } from "vitest";
import Markdown, { normalizeStatementText } from "@/app/markdown";

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
  });
});
