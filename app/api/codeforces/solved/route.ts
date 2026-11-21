import { authorizeBrowserRequest } from "@/lib/auth";

export const dynamic = "force-dynamic";

type Submission = {
  verdict?: string;
  contestId?: number;
  problem?: { contestId?: number; index?: string };
};

export async function GET(request: Request) {
  if (!(await authorizeBrowserRequest(request))) {
    return Response.json({ error: "Unauthorized" }, { status: 401 });
  }
  const handle = new URL(request.url).searchParams.get("handle")?.trim() ?? "";
  if (!/^[A-Za-z0-9_.-]{1,50}$/.test(handle)) {
    return Response.json(
      { error: "Enter a valid Codeforces handle." },
      { status: 400 },
    );
  }
  try {
    const url = new URL("https://codeforces.com/api/user.status");
    url.searchParams.set("handle", handle);
    const response = await fetch(url, {
      cache: "no-store",
      signal: AbortSignal.timeout(20_000),
    });
    const data = (await response.json()) as {
      status?: string;
      result?: Submission[];
    };
    if (!response.ok || data.status !== "OK" || !Array.isArray(data.result))
      throw new Error();
    const solved = new Set<string>();
    for (const submission of data.result) {
      const contest = submission.problem?.contestId ?? submission.contestId;
      const index = submission.problem?.index;
      if (submission.verdict === "OK" && contest && index)
        solved.add(`${contest}:${index.toUpperCase()}`);
    }
    return Response.json(
      { solved: [...solved] },
      { headers: { "cache-control": "no-store" } },
    );
  } catch {
    return Response.json(
      { error: "Could not sync Codeforces. Check the handle and retry." },
      { status: 502 },
    );
  }
}
