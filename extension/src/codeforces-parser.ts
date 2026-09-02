/**
 * Codeforces samples must remain line-oriented all the way into Markdown.
 * Keep this formatter independent from the DOM so it can be regression-tested
 * without a browser runtime.
 */
export function normalizePreformattedText(value: string) {
  return value
    .replace(/\r\n?/g, "\n")
    .split("\n")
    .map((line) => line.replace(/[ \t]+$/g, ""))
    .join("\n")
    .replace(/^\n+|\n+$/g, "");
}

export function formatCodeforcesSampleMarkdown(input: string, output: string) {
  const inputText = normalizePreformattedText(input);
  const outputText = normalizePreformattedText(output);
  if (!inputText || !outputText) {
    throw new Error("A Codeforces sample must contain input and output text.");
  }

  return [
    "\n\n### Input\n\n",
    "```text\n",
    inputText,
    "\n```\n\n",
    "### Output\n\n",
    "```text\n",
    outputText,
    "\n```\n\n",
  ].join("");
}

export function hasStructuredCodeforcesSamples(markdown: string) {
  const fencedBlocks = markdown.match(
    /```(?:text|plaintext)?\s*\n[\s\S]*?```/gi,
  );
  return Boolean(
    /#{2,6}\s+Example(?:s)?\b/i.test(markdown) &&
    /#{2,6}\s+Input\b/i.test(markdown) &&
    /#{2,6}\s+Output\b/i.test(markdown) &&
    (fencedBlocks?.length ?? 0) >= 2,
  );
}
