import { PlatformSchema } from "./contracts";

export function normalizeProblemUrl(value: string) {
  const url = new URL(value.trim());
  const host = url.hostname.toLowerCase().replace(/^www\./, "");

  if (host === "codeforces.com" || host === "m1.codeforces.com") {
    const match = url.pathname.match(
      /\/(?:contest\/(\d+)\/problem|problemset\/problem\/(\d+))\/([A-Za-z0-9]+)/,
    );
    if (!match) throw new Error("Unsupported Codeforces problem URL");
    const contest = match[1] ?? match[2];
    const index = match[3].toUpperCase();
    return {
      platform: PlatformSchema.parse("codeforces"),
      problemKey: `${contest}:${index}`,
      contest,
      index,
      canonicalUrl: `https://codeforces.com/contest/${contest}/problem/${index}`,
    };
  }

  if (host === "cses.fi") {
    const match = url.pathname.match(/\/problemset\/task\/(\d+)/);
    if (!match) throw new Error("Unsupported CSES problem URL");
    return {
      platform: PlatformSchema.parse("cses"),
      problemKey: match[1],
      contest: "CSES Problem Set",
      index: match[1],
      canonicalUrl: `https://cses.fi/problemset/task/${match[1]}/`,
    };
  }

  throw new Error("Unsupported problem platform");
}

export function expectedSourceFilename(input: {
  platform: "codeforces" | "cses";
  problemKey: string;
  title: string;
}) {
  if (input.platform === "codeforces") {
    const [contest, index] = input.problemKey.split(":");
    return `${contest}${index}.cpp`;
  }
  return `${input.title.replace(/[^A-Za-z0-9]+/g, "_").replace(/^_|_$/g, "")}.cpp`;
}
