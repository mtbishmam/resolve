import { describe, expect, it } from "vitest";
import {
  CaptureSchema,
  CreateMashupSchema,
  RecordMashupResultSchema,
  RecordReviewSchema,
  SaveReflectionSchema,
  TranscriptMessageSchema,
} from "@/lib/contracts";
import { expectedSourceFilename, normalizeProblemUrl } from "@/lib/identity";
import {
  INITIAL_INTERVALS,
  SCHEDULE_VERSION,
  nextReviewDate,
} from "@/lib/schedule";
import { sanitizeStatementMarkdown } from "@/lib/sanitize";

describe("canonical problem identity", () => {
  it.each([
    ["https://codeforces.com/contest/1554/problem/B", "codeforces", "1554:B"],
    [
      "https://codeforces.com/problemset/problem/1554/B?locale=en",
      "codeforces",
      "1554:B",
    ],
    ["https://cses.fi/problemset/task/1668/", "cses", "1668"],
    [
      "https://atcoder.jp/contests/abc446/tasks/abc446_d?lang=en",
      "atcoder",
      "abc446_d",
    ],
  ])("normalizes %s", (url, platform, problemKey) => {
    expect(normalizeProblemUrl(url)).toMatchObject({ platform, problemKey });
  });

  it("rejects CSES result URLs because the result id is not a problem id", () => {
    expect(() =>
      normalizeProblemUrl("https://cses.fi/problemset/result/14841190/"),
    ).toThrow("Unsupported CSES problem URL");
  });

  it("derives source names without using them as identity", () => {
    expect(
      expectedSourceFilename({
        platform: "codeforces",
        problemKey: "1554:B",
        title: "Cobb",
      }),
    ).toBe("1554B.cpp");
    expect(
      expectedSourceFilename({
        platform: "cses",
        problemKey: "1668",
        title: "Building Teams",
      }),
    ).toBe("Building_Teams.cpp");
    expect(
      expectedSourceFilename({
        platform: "atcoder",
        problemKey: "abc446_d",
        title: "Max Straight",
      }),
    ).toBe("abc446_d.cpp");
  });
});

describe("capture safety", () => {
  it("preserves TeX, strips HTML, and absolutizes image URLs", () => {
    const input =
      "<script>ignore()</script>\nLet $x^2$ work.\n![plot](/images/a.png)";
    const sanitized = sanitizeStatementMarkdown(
      input,
      "https://codeforces.com/contest/1/problem/A",
    );
    expect(sanitized).not.toContain("<script>");
    expect(sanitized).toContain("$x^2$");
    expect(sanitized).toContain("https://codeforces.com/images/a.png");
  });

  it("validates resolve.capture.v1", () => {
    const value = {
      schema: "resolve.capture.v1",
      capture_id: crypto.randomUUID(),
      captured_at: new Date().toISOString(),
      platform: "codeforces",
      problem_key: "1554:B",
      url: "https://codeforces.com/contest/1554/problem/B",
      problem: {
        contest_id: 1554,
        index: "B",
        title: "Cobb",
        rating: 1700,
        official_tags: ["math"],
      },
      statement: {
        format: "markdown",
        text: "Let $x$ be an integer.",
        assets: [],
      },
      provenance: {
        adapter: "codeforces",
        adapter_version: "1",
        language: "en",
      },
    };
    expect(CaptureSchema.parse(value).problem.title).toBe("Cobb");
  });
});

describe("append-only transcript and schedule contracts", () => {
  it("keeps message roles and content byte-for-byte", () => {
    const messages = [
      {
        role: "assistant" as const,
        content: "First question?\nExact spacing.",
      },
      { role: "user" as const, content: "  My answer stays padded.  " },
    ];
    const parsed = messages.map((message) =>
      TranscriptMessageSchema.parse(message),
    );
    expect(JSON.stringify(parsed)).toBe(JSON.stringify(messages));
  });

  it("uses the versioned demo ladder", () => {
    expect(SCHEDULE_VERSION).toBe("initial-v1");
    expect(INITIAL_INTERVALS).toEqual({
      recalled: 14,
      needed_cue: 7,
      forgot: 2,
      unresolved: 1,
    });
    expect(nextReviewDate("2026-07-30", "recalled")).toBe("2026-08-13");
  });
});

describe("reflection difficulty contract", () => {
  const input = {
    idempotency_key: "difficulty-contract-test",
    problem: {
      platform: "cses" as const,
      problem_key: "1668",
      url: "https://cses.fi/problemset/task/1668/",
      title: "Building Teams",
      contest: "CSES Graph Algorithms",
      problem_index: null,
      rating: null,
      official_tags: [],
      statement_markdown: "Assign every pupil to one of two teams.",
      statement_assets: [],
      metadata_status: "complete",
      metadata_provenance: {},
    },
    reflection: {
      source_path: null,
      source_snapshot: null,
      source_status: "missing" as const,
      transcript_messages: [],
      summary_markdown: "Bipartite coloring.",
      structured_summary: {},
      memory_cue: "Two colors.",
      confidence: null,
      first_review_date: "2026-07-31",
    },
  };

  it("requires adaptive difficulty for an unrated problem", () => {
    expect(SaveReflectionSchema.safeParse(input).success).toBe(false);
    expect(
      SaveReflectionSchema.parse({
        ...input,
        problem: { ...input.problem, difficulty: "easy" },
      }).problem.difficulty,
    ).toBe("easy");
  });

  it("derives difficulty later when a numeric rating is present", () => {
    expect(
      SaveReflectionSchema.parse({
        ...input,
        problem: {
          ...input.problem,
          platform: "codeforces",
          problem_key: "1554:B",
          url: "https://codeforces.com/contest/1554/problem/B",
          rating: 1700,
        },
      }).problem.difficulty,
    ).toBeUndefined();
  });

  it("accepts an unrated AtCoder problem with adaptive difficulty", () => {
    const parsed = SaveReflectionSchema.parse({
      ...input,
      problem: {
        ...input.problem,
        platform: "atcoder",
        problem_key: "abc446_d",
        url: "https://atcoder.jp/contests/abc446/tasks/abc446_d",
        title: "Max Straight",
        contest: "AtCoder Beginner Contest 446",
        problem_index: "D",
        difficulty: "medium",
      },
    });
    expect(parsed.problem.platform).toBe("atcoder");
    expect(parsed.problem.difficulty).toBe("medium");
  });
});

describe("mashup contract", () => {
  it("accepts a backdated five-hour focused session", () => {
    const parsed = CreateMashupSchema.parse({
      sprint_id: "sprint-2026-08",
      problem_ids: ["problem-a", "problem-b"],
      duration_seconds: 5 * 60 * 60,
      started_at: "2026-08-04T00:00:00.000Z",
    });
    expect(parsed.problem_ids).toHaveLength(2);
    expect(parsed.duration_seconds).toBe(18_000);
  });

  it("accepts notes for an existing mashup problem", () => {
    const parsed = RecordMashupResultSchema.parse({
      mashup_id: "mashup-a",
      problem_id: "problem-a",
      approaches: "Binary search on the answer",
      lemmas: "Feasibility is monotone",
      analysis: "O(n log n)",
    });
    expect(parsed.problem_id).toBe("problem-a");
  });
});

describe("review contract", () => {
  it("records a timed Retry before a reflection exists", () => {
    const parsed = RecordReviewSchema.parse({
      idempotency_key: "retry-without-reflection",
      problem_id: "problem-a",
      reflection_id: null,
      due_date: "2026-08-05",
      outcome: "unresolved",
      deepest_reveal: "none",
      timer_limit_seconds: 1800,
      timer_elapsed_seconds: 1811,
    });
    expect(parsed.reflection_id).toBeNull();
    expect(parsed.timer_elapsed_seconds).toBe(1811);
  });
});
