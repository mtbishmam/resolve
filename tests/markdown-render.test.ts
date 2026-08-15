import { createElement } from "react";
import { renderToStaticMarkup } from "react-dom/server";
import { describe, expect, it } from "vitest";
import Markdown from "@/app/markdown";

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
});
