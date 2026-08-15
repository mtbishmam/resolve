import { PlatformSchema, type Platform } from "./contracts";

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

  if (host === "atcoder.jp") {
    const match = url.pathname.match(/\/contests\/([^/]+)\/tasks\/([^/]+)/);
    if (!match) throw new Error("Unsupported AtCoder problem URL");
    const contest = match[1].toLowerCase();
    const task = match[2].toLowerCase();
    return {
      platform: PlatformSchema.parse("atcoder"),
      problemKey: task,
      contest,
      index: task.startsWith(`${contest}_`)
        ? task.slice(contest.length + 1).toUpperCase()
        : task.toUpperCase(),
      canonicalUrl: `https://atcoder.jp/contests/${contest}/tasks/${task}`,
    };
  }

  if (host === "codechef.com") {
    const segments = url.pathname.split("/").filter(Boolean);
    const problemsIndex = segments.lastIndexOf("problems");
    const code = segments[problemsIndex + 1]?.toUpperCase();
    if (problemsIndex < 0 || !code || !/^[A-Z0-9_]+$/.test(code)) {
      throw new Error("Unsupported CodeChef problem URL");
    }
    const contestSegment =
      problemsIndex === 1 && segments[0].toLowerCase() !== "practice"
        ? segments[0]
        : null;
    return {
      platform: PlatformSchema.parse("codechef"),
      problemKey: code,
      contest: contestSegment ?? "CodeChef",
      index: code,
      canonicalUrl: `https://www.codechef.com/problems/${code}`,
    };
  }

  if (host === "lightoj.com") {
    const match = url.pathname.match(/^\/problem\/([a-z0-9-]+)\/?$/i);
    if (!match) throw new Error("Unsupported LightOJ problem URL");
    const slug = match[1].toLowerCase();
    return {
      platform: PlatformSchema.parse("lightoj"),
      problemKey: slug,
      contest: "LightOJ",
      index: null,
      canonicalUrl: `https://lightoj.com/problem/${slug}`,
    };
  }

  throw new Error("Unsupported problem platform");
}

export function expectedSourceFilename(input: {
  platform: Platform;
  problemKey: string;
  title: string;
}) {
  if (input.platform === "codeforces") {
    const [contest, index] = input.problemKey.split(":");
    return `${contest}${index}.cpp`;
  }
  if (input.platform === "atcoder") return `${input.problemKey}.cpp`;
  if (input.platform === "codechef") {
    return `cc_${input.problemKey.toLowerCase()}.cpp`;
  }
  if (input.platform === "lightoj") {
    return `loj_${input.problemKey.toLowerCase().replace(/[^a-z0-9]+/g, "_")}.cpp`;
  }
  return `${input.title.replace(/[^A-Za-z0-9]+/g, "_").replace(/^_|_$/g, "")}.cpp`;
}
