import { createHash } from "node:crypto";
import { access, mkdir, writeFile } from "node:fs/promises";
import { resolve } from "node:path";

const root = resolve(import.meta.dirname, "..");
const practiceRoot = "/Users/mtbishmam/code/competitive-programming/practice";

const selection = [
  {
    id: "cf-1554-b",
    platform: "codeforces",
    problemKey: "1554:B",
    objectiveRow: 2846,
    notionRow: "https://app.notion.com/2a4f02b8a3264c268248b292b7aac3b2",
    sourceFilename: "1554B.cpp",
    reviewStatus: "retry",
    nextReviewDate: "2026-07-30",
    reason:
      "Strong Retry example with detailed constraint-driven metacognition and a reusable brute-force bound.",
    notes: {
      summary: null,
      gains:
        "a[i] <= n, means that the maximum value of any (a[i] | a[j]) can be atmost 2 * n\ni * j / a[i] | a[j] for all pairs cannot be calculated fast enough anyhow\nThe fact that a[i] <= n && k <= 100 both combined the critical factor",
      metacognition:
        "// why is k so small?\n// a[i] <= n?\n\n/* Lemmas\n    1. We'll have to do an exhaustive search\n*/\n\n/* Solutions\n    1. per bit by bit operation?\n    2. brute force to deduce pattern\n    3. binary search?\n*/\n\n/* Problems\n    I don't know how to do i * j fast for all pairs yet\n    I don't know how to do (ai | aj) for all pairs yet\n    I can't figure out what small k implies yet\n    Does a[i] <= n imply something?\n*/",
      tags: ["Retry", "Bitwise", "All Pairs"],
      difficulty: "1700",
    },
    structured: {
      key_insight:
        "The combined bounds a[i] <= n and k <= 100 make only a short suffix of indices worth checking.",
      wrong_mental_model:
        "I don't know how to do i * j fast for all pairs yet; I don't know how to do (ai | aj) for all pairs yet.",
      why_it_seemed_reasonable: "Not captured",
      breakthrough_observation:
        "a[i] <= n bounds every bitwise OR by less than 2n, while the i*j term grows with large indices.",
      correct_trigger: "Ask: why is k so small, and why is a[i] <= n?",
      missing_concepts: ["Bounding competing terms"],
      general_pattern:
        "When one term is globally bounded, restrict exhaustive search to where the unbounded term is largest.",
      cognitive_mistakes: [],
      memory_cue: "Bound the OR penalty; scan the high-index suffix.",
    },
  },
  {
    id: "cf-1486-b",
    platform: "codeforces",
    problemKey: "1486:B",
    objectiveRow: 2446,
    notionRow: "https://app.notion.com/31325e4e074344fe9ce199d31f3fd468",
    sourceFilename: "1486B.cpp",
    reviewStatus: "retry",
    nextReviewDate: "2026-07-29",
    reason:
      "Detailed Retry geometry row showing an incorrect distance model and a clear median trigger.",
    notes: {
      summary: "A good problem about manhattan distance",
      gains:
        "Should've thought about medians and such, need to implement a method that atleast makes me consider those options. Another important lesson: for geometry problems if we can solve it for one dimension, then we can maybe extend it to two dimensions",
      metacognition:
        "/* Analysis\n    The minimum distance between any two points is the min di\n    after getting the min_dis, we'll just check how many pairs have that min_dis?\n\n*/\n\n/* Sols\n    1. get min distance between any pair of nodes\n    then, get the node with the maxmum number of\n\n    2. Compress all coordinates, then get the lower and upper bounds on both x & y and do a n^2 solution?\n*/",
      tags: ["Retry", "Lesson", "Geometry"],
      difficulty: "1500",
    },
    structured: {
      key_insight:
        "Manhattan distance separates by dimension; each coordinate is minimized by the median interval.",
      wrong_mental_model:
        "Find the minimum distance between pairs of given points, then count pairs at that distance.",
      why_it_seemed_reasonable:
        "The objective mentions distance, so pairwise distances looked like the direct quantity to minimize.",
      breakthrough_observation:
        "Solve the one-dimensional absolute-distance problem, then multiply the valid x and y choices.",
      correct_trigger:
        "For Manhattan geometry, solve one dimension first and consider medians.",
      missing_concepts: ["Median minimizes absolute deviations"],
      general_pattern:
        "Separable objectives can be optimized independently per coordinate.",
      cognitive_mistakes: [
        "Focused on pairwise distances instead of the chosen meeting point",
      ],
      memory_cue: "Manhattan -> split axes -> median intervals.",
    },
  },
  {
    id: "cf-1702-e",
    platform: "codeforces",
    problemKey: "1702:E",
    objectiveRow: 3651,
    notionRow: "https://app.notion.com/3f42663170344d0ea7ebe9c58afc7d51",
    sourceFilename: "1702E.cpp",
    reviewStatus: "resolve",
    nextReviewDate: "2026-07-30",
    reason:
      "Resolve example with a strong recognition trigger connecting two-set division to bipartiteness.",
    notes: {
      summary: null,
      gains:
        "If the question asks you to divide between two  sets or similar think about bipartite check. Here, the division is between the edges rather than the nodes, and we’re checking if a bipartition is possible or not.\nBipartite Check = even-length cycles, which means no odd-length cycles can be present. So, we can use a bipartite check to find out even-length cycles as well",
      metacognition: null,
      tags: ["Resolve", "Bipartite Check", "Lesson"],
      difficulty: "1600",
    },
    structured: {
      key_insight:
        "Model every pair as an edge; degree must be at most two and every component must be bipartite.",
      wrong_mental_model: "Not captured",
      why_it_seemed_reasonable: "Not captured",
      breakthrough_observation:
        "The requested split into two sets is a bipartite-coloring condition.",
      correct_trigger:
        "When a problem asks to divide objects between two sets, test a bipartite model.",
      missing_concepts: [],
      general_pattern:
        "Two-way compatibility constraints often become graph 2-coloring.",
      cognitive_mistakes: [],
      memory_cue: "Two sets -> build the graph -> degree 2 + bipartite.",
    },
  },
  {
    id: "cf-1305-c",
    platform: "codeforces",
    problemKey: "1305:C",
    objectiveRow: 1509,
    notionRow: "https://app.notion.com/4346a2a85c264acda409b34652c6c8e2",
    sourceFilename: "1305C.cpp",
    reviewStatus: "resolve",
    nextReviewDate: "2026-08-02",
    reason:
      "Resolve number-theory example where pigeonhole reasoning collapses an apparent all-pairs product.",
    notes: {
      summary: null,
      gains:
        "Should've thought about piegonhole principle. Modular Arithmetic and pigeonhole principle go hand to hand",
      metacognition: null,
      tags: [
        "Resolve",
        "All Pairs",
        "Modular Arithmetic",
        "Pigeonhole Principle",
      ],
      difficulty: "1600",
    },
    structured: {
      key_insight:
        "If n > m, two values share a residue modulo m, so one pair difference is divisible by m and the whole product is zero.",
      wrong_mental_model: "Not captured",
      why_it_seemed_reasonable: "Not captured",
      breakthrough_observation:
        "There are only m residues, but more than m array values.",
      correct_trigger:
        "When values are reduced modulo m and n > m, check pigeonhole immediately.",
      missing_concepts: [],
      general_pattern:
        "A zero factor can collapse a product; search for forced collisions before optimizing multiplication.",
      cognitive_mistakes: [],
      memory_cue: "n > m -> repeated residue -> zero product.",
    },
  },
  {
    id: "cf-377-a",
    platform: "codeforces",
    problemKey: "377:A",
    objectiveRow: 7220,
    notionRow: "https://app.notion.com/134cb296d7c74853ac4f7d754058a1d2",
    sourceFilename: "377A.cpp",
    reviewStatus: "revise",
    nextReviewDate: "2026-07-31",
    reason:
      "Revise grid-search example with a concrete implementation lesson about traversal depth and validity checks.",
    notes: {
      summary: null,
      gains:
        "The maximum length path can be n * m in a grid of n * m. And from now on let's try to put all the conditions like !vis[x][y] && a[x][y] =! '#' in the isvalid function",
      metacognition: null,
      tags: ["Revise", "BFS"],
      difficulty: "1600",
    },
    structured: {
      key_insight:
        "Traverse one connected component of empty cells and mark exactly k cells from the traversal tail.",
      wrong_mental_model: "Not captured",
      why_it_seemed_reasonable: "Not captured",
      breakthrough_observation:
        "Keeping a connected prefix of a DFS/BFS order leaves the unmarked cells connected.",
      correct_trigger:
        "Need to remove cells while preserving connectivity -> keep a traversal prefix.",
      missing_concepts: ["Grid traversal depth can reach n*m"],
      general_pattern:
        "A traversal order can provide a connectivity-preserving keep/remove boundary.",
      cognitive_mistakes: [],
      memory_cue: "Traverse all dots; turn the last k into X.",
    },
  },
  {
    id: "cf-2108-a",
    platform: "codeforces",
    problemKey: "2108:A",
    objectiveRow: null,
    notionRow: "https://app.notion.com/289067fc316a4068ab2c7892e43acce1",
    sourceFilename: "2108A.cpp",
    reviewStatus: "resolve",
    nextReviewDate: "2026-08-01",
    reason:
      "Newer easy Resolve example with a useful permutation invariant and an intentionally missing local source.",
    notes: {
      summary: null,
      gains:
        "If they're talking about permutations, do the following - \n1. Think about the first permutation and the last permutation & get answers for both. Those are usually the lower and upper bounds\n2. Given the first permutation, we can reach  any other permutation by doing adjacent swaps where a[i] < a[j] for i < j\n3. Now, calculate the rate of change for any permutation with respect to the initial permutation",
      metacognition: null,
      tags: ["Resolve", "Inversions"],
      difficulty: "800",
    },
    structured: {
      key_insight:
        "Track how the target expression changes under an adjacent inversion swap, starting from the identity permutation.",
      wrong_mental_model: "Not captured",
      why_it_seemed_reasonable: "Not captured",
      breakthrough_observation:
        "Every permutation is reachable from the identity by adjacent swaps, exposing a stable change rule.",
      correct_trigger:
        "For a permutation statistic, compare identity and reverse order, then inspect one adjacent swap.",
      missing_concepts: [],
      general_pattern:
        "Analyze a permutation statistic through generators such as adjacent swaps.",
      cognitive_mistakes: [],
      memory_cue: "Identity -> adjacent swaps -> invariant change.",
    },
  },
  {
    id: "cses-1668",
    platform: "cses",
    problemKey: "1668",
    taskId: "1668",
    notionRow: "https://app.notion.com/0d3cbbaaa41f46c1884a9ac22aff6455",
    sourceFilename: "Building_Teams.cpp",
    reviewStatus: "revise",
    nextReviewDate: "2026-08-03",
    reason:
      "CSES platform example with concise implementation notes distinguishing bipartite checking from cycle detection.",
    notes: {
      summary:
        "Bipartition (UG) + Print → DFS\nOnly col array and c params added\nFor Cycle Detection + Print → DFS\nOnly par array and p params added",
      gains:
        "Using a global flag rather than recursive functional values is better\nBipartite Check and Cycle Detection aren't the same",
      metacognition: null,
      tags: ["Bipartite Check", "Lesson", "Graph Theory"],
      difficulty: "Easy",
    },
    structured: {
      key_insight:
        "DFS-color every connected component with two colors and reject any same-color edge.",
      wrong_mental_model: "Bipartite check and cycle detection are the same.",
      why_it_seemed_reasonable:
        "Both workflows traverse an undirected graph and inspect already visited neighbors.",
      breakthrough_observation:
        "Cycle detection tracks parents; bipartite checking tracks color parity.",
      correct_trigger:
        "Two teams with no internal friendship is exactly a graph 2-coloring request.",
      missing_concepts: [],
      general_pattern:
        "Name the invariant stored by DFS rather than reusing traversal code mechanically.",
      cognitive_mistakes: ["Conflated two DFS invariants"],
      memory_cue: "Two teams = two colors, all components.",
    },
  },
  {
    id: "cses-1193",
    platform: "cses",
    problemKey: "1193",
    taskId: "1193",
    notionRow: "https://app.notion.com/2a6dd19d238e43a7ab9107f4815fcb47",
    sourceFilename: "Labyrinth.cpp",
    reviewStatus: "resolve",
    nextReviewDate: "2026-08-04",
    reason:
      "CSES BFS example with a compact path-reconstruction summary and a concrete TLE prevention lesson.",
    notes: {
      summary: "SSSP (Grid) + Print → BFS",
      gains:
        "Mark vis[nx][ny] before exploring (nx, ny), otherwise you might get TLE",
      metacognition: null,
      tags: ["BFS", "Graph Theory"],
      difficulty: "Easy",
    },
    structured: {
      key_insight:
        "BFS from A while storing each cell's incoming move, then backtrack from B.",
      wrong_mental_model: "Not captured",
      why_it_seemed_reasonable: "Not captured",
      breakthrough_observation:
        "Mark a neighbor visited when enqueuing it, not when dequeuing it.",
      correct_trigger:
        "Unweighted shortest path with reconstruction -> BFS plus parent direction.",
      missing_concepts: [],
      general_pattern:
        "Claim BFS nodes at enqueue time to prevent duplicate work.",
      cognitive_mistakes: [],
      memory_cue: "BFS, mark on push, backtrack directions.",
    },
  },
];

function decodeEntities(value) {
  return value
    .replaceAll("&lt;", "<")
    .replaceAll("&gt;", ">")
    .replaceAll("&amp;", "&")
    .replaceAll("&quot;", '"')
    .replaceAll("&#x27;", "'")
    .replaceAll("&nbsp;", " ");
}

function csesHtmlToMarkdown(html) {
  const fragment = html.match(/<div class="md">([\s\S]*?)<\/div>/)?.[1];
  if (!fragment) throw new Error("CSES statement block not found");
  return decodeEntities(
    fragment
      .replace(
        /<span class="math math-(?:inline|display)">([\s\S]*?)<\/span>/g,
        (_, math) => `$${math.trim()}$`,
      )
      .replace(/<h1[^>]*>([\s\S]*?)<\/h1>/g, "\n\n## $1\n\n")
      .replace(
        /<pre>([\s\S]*?)<\/pre>/g,
        (_, code) => `\n\n\`\`\`text\n${code.trim()}\n\`\`\`\n\n`,
      )
      .replace(/<li>([\s\S]*?)<\/li>/g, "- $1\n")
      .replace(/<\/?ul>/g, "\n")
      .replace(/<p>([\s\S]*?)<\/p>/g, "\n\n$1\n\n")
      .replace(/<br\s*\/?>/g, "\n")
      .replace(/<[^>]+>/g, "")
      .replace(/\n{3,}/g, "\n\n")
      .trim(),
  );
}

function codeforcesMarkdown(row) {
  const examples = (row.examples ?? [])
    .map(
      (example) =>
        `Input:\n\n\`\`\`text\n${example.input.trim()}\n\`\`\`\n\nOutput:\n\n\`\`\`text\n${example.output.trim()}\n\`\`\``,
    )
    .join("\n\n");
  return [
    row.description,
    "## Input",
    row.input_format,
    "## Output",
    row.output_format,
    examples ? `## Examples\n\n${examples}` : "",
    row.note ? `## Note\n\n${row.note}` : "",
  ]
    .filter(Boolean)
    .join("\n\n");
}

async function exists(path) {
  try {
    await access(path);
    return true;
  } catch {
    return false;
  }
}

async function loadCodeforcesRows() {
  const result = new Map();
  await Promise.all(
    selection
      .filter(
        (item) => item.objectiveRow !== undefined && item.objectiveRow !== null,
      )
      .map(async (item) => {
        const url = new URL("https://datasets-server.huggingface.co/rows");
        url.searchParams.set("dataset", "touristgpt/finecf-problems");
        url.searchParams.set("config", "default");
        url.searchParams.set("split", "train");
        url.searchParams.set("offset", String(item.objectiveRow));
        url.searchParams.set("length", "1");
        const response = await fetch(url);
        if (!response.ok)
          throw new Error(`Problem dataset failed: ${response.status}`);
        const row = (await response.json()).rows?.[0]?.row;
        if (!row || row.id !== item.problemKey.replace(":", "/")) {
          throw new Error(`Unexpected objective row for ${item.problemKey}`);
        }
        result.set(item.problemKey, row);
      }),
  );
  return result;
}

async function loadNewCodeforcesStatement(contest, index) {
  const response = await fetch(
    `https://cf-problemset.herokuapp.com/contest/${contest}/${index}/`,
  );
  if (!response.ok) throw new Error("Codeforces statement mirror failed");
  const html = await response.text();
  const candidates = [...html.matchAll(/<td><p[^>]*>([\s\S]*?)<\/p><\/td>/g)];
  const raw = candidates
    .map((match) => match[1])
    .sort((a, b) => b.length - a.length)[0];
  if (!raw) throw new Error("Flattened Codeforces statement not found");
  return decodeEntities(
    raw
      .replace(/<[^>]+>/g, " ")
      .replace(/\s+/g, " ")
      .trim(),
  );
}

const cfRows = await loadCodeforcesRows();
const cfApi = await (
  await fetch("https://codeforces.com/api/problemset.problems")
).json();
const cfMetadata = new Map(
  cfApi.result.problems.map((problem) => [
    `${problem.contestId}:${problem.index}`,
    problem,
  ]),
);

const records = [];
for (const item of selection) {
  let title;
  let contest;
  let problemIndex;
  let rating;
  let officialTags;
  let statementMarkdown;
  let url;
  let statementProvenance;

  if (item.platform === "codeforces") {
    const meta = cfMetadata.get(item.problemKey);
    if (!meta)
      throw new Error(`Codeforces metadata missing for ${item.problemKey}`);
    const [contestId, index] = item.problemKey.split(":");
    title = meta.name;
    contest = `Codeforces ${contestId}`;
    problemIndex = index;
    rating = meta.rating ?? null;
    officialTags = meta.tags ?? [];
    url = `https://codeforces.com/contest/${contestId}/problem/${index}`;
    const row = cfRows.get(item.problemKey);
    statementMarkdown = row
      ? codeforcesMarkdown(row)
      : await loadNewCodeforcesStatement(contestId, index);
    statementProvenance = row
      ? "huggingface_snapshot_of_codeforces"
      : "cf_problemset_mirror_snapshot";
  } else {
    url = `https://cses.fi/problemset/task/${item.taskId}/`;
    const response = await fetch(url);
    if (!response.ok) throw new Error(`CSES task failed: ${item.taskId}`);
    const html = await response.text();
    title = decodeEntities(html.match(/<h1>([^<]+)<\/h1>/)?.[1] ?? "");
    contest = "CSES Problem Set";
    problemIndex = item.taskId;
    rating = null;
    officialTags = item.notes.tags.filter(
      (tag) => !["Resolve", "Retry", "Revise", "Lesson"].includes(tag),
    );
    statementMarkdown = csesHtmlToMarkdown(html);
    statementProvenance = "cses_official";
  }

  const sourcePath = resolve(practiceRoot, item.sourceFilename);
  const sourceFound = await exists(sourcePath);
  const now = "2026-07-30T00:00:00.000Z";
  const transcript = [];
  const structured = {
    key_insight: item.structured.key_insight,
    wrong_mental_model: item.structured.wrong_mental_model,
    why_it_seemed_reasonable: item.structured.why_it_seemed_reasonable,
    breakthrough_observation: item.structured.breakthrough_observation,
    correct_trigger: item.structured.correct_trigger,
    missing_concepts: item.structured.missing_concepts,
    general_pattern: item.structured.general_pattern,
    cognitive_mistakes: item.structured.cognitive_mistakes,
    provenance: {
      key_insight: "codex_inferred_demo",
      wrong_mental_model:
        item.structured.wrong_mental_model === "Not captured"
          ? "not_captured"
          : "source_derived",
      correct_trigger: "codex_inferred_demo",
      general_pattern: "codex_inferred_demo",
    },
  };
  records.push({
    selectionReason: item.reason,
    problem: {
      id: item.id,
      platform: item.platform,
      problemKey: item.problemKey,
      url,
      title,
      contest,
      problemIndex,
      rating,
      officialTags,
      statementMarkdown,
      statementAssets: [],
      statementHash: createHash("sha256")
        .update(statementMarkdown)
        .digest("hex"),
      statementCapturedAt: now,
      metadataStatus: "complete",
      metadataProvenance: {
        title:
          item.platform === "codeforces" ? "codeforces_api" : "cses_official",
        rating:
          item.platform === "codeforces" ? "codeforces_api" : "not_captured",
        official_tags:
          item.platform === "codeforces" ? "codeforces_api" : "notion_original",
        statement: statementProvenance,
      },
      legacyMetadata: {
        notion_properties: {
          Summary: item.notes.summary,
          Gains: item.notes.gains,
          Metacognition: item.notes.metacognition,
          Tags: item.notes.tags,
          Difficulty: item.notes.difficulty,
        },
      },
      importSource: "notion_showcase_v1",
      importProvenance: {
        notion_row_url: item.notionRow,
        selected_because: item.reason,
        imported_at: now,
        seeded_demo_schedule: true,
        learning_field_warning:
          "Codex-inferred demo fields need user confirmation and are not original wording.",
      },
      reviewStatus: item.reviewStatus,
      nextReviewDate: item.nextReviewDate,
      createdAt: now,
      updatedAt: now,
    },
    reflection: {
      id: `${item.id}-reflection-1`,
      idempotencyKey: `showcase:${item.id}:reflection:1`,
      sourcePath: sourceFound ? sourcePath : null,
      sourceSnapshot: null,
      sourceStatus: sourceFound ? "found" : "missing",
      transcriptMessages: transcript,
      transcriptHash: createHash("sha256")
        .update(JSON.stringify(transcript))
        .digest("hex"),
      summaryMarkdown: (
        item.notes.summary ??
        item.notes.gains ??
        "Not captured"
      ).replace(/[ \t]+$/gm, ""),
      structuredSummary: structured,
      memoryCue: item.structured.memory_cue,
      confidence: null,
      firstReviewDate: item.nextReviewDate,
      createdAt: now,
    },
  });
}

const views = [
  ["view-due-today", "Due today", { due: "today" }],
  ["view-retry", "Retry", { status: ["retry"] }],
  ["view-revise", "Revise", { status: ["revise"] }],
  ["view-resolve", "Resolve", { status: ["resolve"] }],
  ["view-all", "All problems", {}],
].map(([id, name, filter], index) => ({
  id,
  name,
  filter,
  sort: [{ id: "nextReviewDate", desc: false }],
  visibleColumns: [
    "title",
    "platform",
    "rating",
    "reviewStatus",
    "nextReviewDate",
  ],
  isDefault: index === 0,
}));

await mkdir(resolve(root, "data"), { recursive: true });
await writeFile(
  resolve(root, "data", "showcase.json"),
  `${JSON.stringify({ schema: "resolve.showcase.v1", records, views }, null, 2)}\n`,
);
await writeFile(
  resolve(root, "data", "showcase-selection.json"),
  `${JSON.stringify(
    {
      schema: "resolve.showcase-selection.v1",
      source_database:
        "https://app.notion.com/p/243d8db956388087825bcff2d6778cae",
      selected_count: records.length,
      selected: records.map((record) => ({
        platform: record.problem.platform,
        problem_key: record.problem.problemKey,
        title: record.problem.title,
        reason: record.selectionReason,
        notion_row_url: record.problem.importProvenance.notion_row_url,
        source_status: record.reflection.sourceStatus,
      })),
    },
    null,
    2,
  )}\n`,
);
console.log(`Wrote ${records.length} showcase records.`);
