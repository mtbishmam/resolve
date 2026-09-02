import type { Platform } from "@/lib/contracts";

export type StatementSample = {
  input: string;
  output: string;
};

type SiteStatementProfile = {
  exampleHeading: string;
  sampleContext: RegExp;
  inputLabel: RegExp;
  outputLabel: RegExp;
};

/**
 * Every durable judge has a parser profile. The profile describes the
 * official sample labels; the output format is deliberately shared so the
 * statement reader never has to guess whether a sample is prose or data.
 */
export const SITE_STATEMENT_PARSERS: Record<Platform, SiteStatementProfile> = {
  codeforces: {
    exampleHeading: "Example",
    sampleContext: /^#{1,6}\s+Examples?\b[^\n]*$/im,
    inputLabel: /\bInput\b/i,
    outputLabel: /\bOutput\b/i,
  },
  cses: {
    exampleHeading: "Example",
    sampleContext: /^#{1,6}\s+Examples?\b[^\n]*$/im,
    inputLabel: /\bInput\b/i,
    outputLabel: /\bOutput\b/i,
  },
  atcoder: {
    exampleHeading: "Examples",
    sampleContext:
      /^#{1,6}\s+(?:Examples?|Sample\s+(?:Input|Output))\b[^\n]*$/im,
    inputLabel: /\b(?:Sample\s+)?Input\b/i,
    outputLabel: /\b(?:Sample\s+)?Output\b/i,
  },
  codechef: {
    exampleHeading: "Sample",
    sampleContext:
      /^#{1,6}\s+(?:Samples?|Sample\s+(?:Input|Output))\b[^\n]*$/im,
    inputLabel: /\b(?:Sample\s+)?Input\b/i,
    outputLabel: /\b(?:Sample\s+)?Output\b/i,
  },
  lightoj: {
    exampleHeading: "Sample",
    sampleContext:
      /^#{1,6}\s+(?:Samples?|Sample\s+(?:Input|Output))\b[^\n]*$/im,
    inputLabel: /\bSample\s+Input\b/i,
    outputLabel: /\bSample\s+Output\b/i,
  },
};

export function normalizePreformattedText(value: string) {
  return value
    .replace(/\r\n?/g, "\n")
    .split("\n")
    .map((line) => line.replace(/[ \t]+$/g, ""))
    .join("\n")
    .replace(/^\n+|\n+$/g, "");
}

export function formatStatementSamples(
  platform: Platform,
  samples: readonly StatementSample[],
) {
  if (!samples.length) {
    throw new Error(`${platform} samples must contain at least one example.`);
  }

  const profile = SITE_STATEMENT_PARSERS[platform];
  const blocks = samples.map((sample, index) => {
    const input = normalizePreformattedText(sample.input);
    const output = normalizePreformattedText(sample.output);
    if (!input || !output) {
      throw new Error(
        `${platform} samples must contain both input and output text.`,
      );
    }
    const suffix = samples.length > 1 ? ` ${index + 1}` : "";
    return [
      `### Input${suffix}\n\n`,
      "```text\n",
      input,
      "\n```\n\n",
      `### Output${suffix}\n\n`,
      "```text\n",
      output,
      "\n```\n",
    ].join("");
  });

  return `\n\n## ${profile.exampleHeading}\n\n${blocks.join("\n")}\n`;
}

function selectAtCoderEnglishStatement(markdown: string) {
  const matches = [...markdown.matchAll(/^#{1,6}\s+Problem Statement\s*$/gim)];
  if (!matches.length) return markdown;
  return markdown.slice(matches[matches.length - 1].index ?? 0).trim();
}

function parseTableCells(line: string) {
  const cells = line.trim().split("|");
  if (cells[0]?.trim() === "") cells.shift();
  if (cells[cells.length - 1]?.trim() === "") cells.pop();
  return cells.map((cell) => cell.trim());
}

function normalizeLightOJSampleTable(markdown: string) {
  const lines = markdown.split("\n");
  const output: string[] = [];

  for (let index = 0; index < lines.length; index += 1) {
    if (
      !/^\s*\|?\s*Sample Input\s*\|\s*Sample Output\s*\|?\s*$/i.test(
        lines[index],
      )
    ) {
      output.push(lines[index]);
      continue;
    }

    let row = index + 1;
    if (
      row < lines.length &&
      /^\s*\|?\s*:?-{3,}\s*\|\s*:?-{3,}\s*\|?\s*$/.test(lines[row])
    ) {
      row += 1;
    }
    const samples: StatementSample[] = [];
    while (row < lines.length && /^\s*[^\n|]+\s*\|/.test(lines[row])) {
      const cells = parseTableCells(lines[row]);
      if (cells.length >= 2 && cells[0] && cells[1]) {
        samples.push({ input: cells[0], output: cells[1] });
      }
      row += 1;
    }

    if (!samples.length) {
      output.push(lines[index]);
      continue;
    }

    output.push(formatStatementSamples("lightoj", samples).trim());
    index = row - 1;
  }

  return output.join("\n");
}

function canonicalizeSampleHeadings(platform: Platform, markdown: string) {
  const profile = SITE_STATEMENT_PARSERS[platform];
  const lines = markdown.split("\n");
  let inSampleSection = false;

  return lines
    .map((line) => {
      const heading = /^(#{1,6})\s+(.+?)\s*$/.exec(line);
      if (!heading) return line;
      const text = heading[2];
      const isSampleContext = profile.sampleContext.test(line);
      if (isSampleContext) inSampleSection = true;
      if (inSampleSection && profile.inputLabel.test(text)) {
        return "### Input";
      }
      if (inSampleSection && profile.outputLabel.test(text)) {
        return "### Output";
      }
      if (isSampleContext) return line;
      if (!inSampleSection) return line;
      if (heading[1].length <= 2) inSampleSection = false;
      return line;
    })
    .join("\n");
}

/**
 * Normalize one official-page capture before sanitization/persistence.
 * AtCoder pages can contain Japanese and English sections; LightOJ exposes
 * samples as a two-column Markdown table. Both cases need deterministic
 * normalization before the shared structural guard runs.
 */
export function normalizeStatementForPlatform(
  platform: Platform,
  markdown: string,
) {
  let normalized = markdown.replace(/\r\n?/g, "\n");
  if (platform === "atcoder") {
    normalized = selectAtCoderEnglishStatement(normalized);
  }
  if (platform === "lightoj") {
    normalized = normalizeLightOJSampleTable(normalized);
  }
  return canonicalizeSampleHeadings(platform, normalized);
}

function sampleSection(markdown: string, profile: SiteStatementProfile) {
  const start = profile.sampleContext.exec(markdown);
  if (!start || start.index === undefined) return null;
  const heading = /^(#{1,6})\s+/.exec(start[0]);
  const level = heading?.[1].length ?? 2;
  const afterHeading = markdown.slice(start.index + start[0].length);
  const prefix = `${start[0]}\n`;
  const lines = afterHeading.split("\n");
  let offset = 0;

  for (const line of lines) {
    const nextHeading = /^(#{1,6})\s+[^\n]+$/.exec(line);
    if (
      nextHeading &&
      nextHeading[1].length <= level &&
      !profile.sampleContext.test(line)
    ) {
      return prefix + afterHeading.slice(0, offset);
    }
    offset += line.length + 1;
  }
  return prefix + afterHeading;
}

/**
 * Reject lossy extraction for every persisted judge, not only Codeforces.
 * A sample section with input/output labels must contain separate fenced
 * blocks; otherwise prose extraction has destroyed the judge's sample data.
 */
export function assertStructuredStatement(
  platform: Platform,
  markdown: string,
) {
  const profile = SITE_STATEMENT_PARSERS[platform];
  const section = sampleSection(markdown, profile);
  if (!section) return;

  const hasInput = profile.inputLabel.test(section);
  const hasOutput = profile.outputLabel.test(section);
  const fencedBlocks = section.match(
    /```(?:text|plaintext)?\s*\n[\s\S]*?```/gi,
  );
  if (hasInput && hasOutput && (fencedBlocks?.length ?? 0) < 2) {
    throw new Error(
      `${platform} statement samples must preserve input and output as separate fenced text blocks.`,
    );
  }
}
