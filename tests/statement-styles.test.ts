import { readFileSync } from "node:fs";
import { describe, expect, it } from "vitest";

const styles = readFileSync(
  new URL("../app/globals.css", import.meta.url),
  "utf8",
);

describe("statement code-block styles", () => {
  it("does not reserve an empty header line above sample input", () => {
    expect(styles).toMatch(
      /\.markdown \.code-block pre\s*\{[^}]*padding:\s*14px 72px 14px 14px;/s,
    );
  });

  it("keeps the copied checkmark centered in a fixed icon box", () => {
    expect(styles).toMatch(
      /\.code-copy-icon\s*\{[^}]*flex:\s*0 0 11px;[^}]*width:\s*11px;[^}]*height:\s*11px;/s,
    );
    expect(styles).toMatch(
      /\.code-copy-button\.copied \.code-copy-icon::before\s*\{[^}]*inset:\s*0;[^}]*line-height:\s*11px;[^}]*text-align:\s*center;/s,
    );
  });
});
