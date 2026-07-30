import {
  getProblemByIdentity,
  listDueReviews,
  recordReview,
  saveReflection,
  updateProblemProperties,
  updateReflection,
} from "@/db/queries";
import { getMcpToken } from "@/db/index";
import {
  DifficultySchema,
  ProblemStateSchema,
  ProblemStatusSchema,
  RecordReviewSchema,
  SaveReflectionSchema,
  UpdateReflectionSchema,
} from "@/lib/contracts";
import { z } from "zod";

export const dynamic = "force-dynamic";

type RpcRequest = {
  jsonrpc: "2.0";
  id?: string | number | null;
  method: string;
  params?: Record<string, unknown>;
};

const tools = [
  {
    name: "save_reflection",
    description:
      "Atomically and idempotently save a canonical problem and exact ordered reflection transcript. Numeric ratings derive difficulty automatically; unrated problems require an adaptive easy, medium, hard, or extreme difficulty.",
    inputSchema: {
      type: "object",
      required: ["idempotency_key", "problem", "reflection"],
      properties: {
        idempotency_key: { type: "string" },
        problem: {
          type: "object",
          required: [
            "platform",
            "problem_key",
            "url",
            "title",
            "official_tags",
            "statement_markdown",
            "statement_assets",
          ],
          properties: {
            platform: { enum: ["codeforces", "cses"] },
            problem_key: { type: "string" },
            url: { type: "string", format: "uri" },
            title: { type: "string" },
            contest: { type: ["string", "null"] },
            problem_index: { type: ["string", "null"] },
            rating: {
              type: ["integer", "null"],
              minimum: 1,
              maximum: 3500,
            },
            difficulty: {
              type: ["string", "null"],
              enum: ["easy", "medium", "hard", "extreme", null],
            },
            official_tags: { type: "array", items: { type: "string" } },
            statement_markdown: { type: "string" },
            statement_assets: { type: "array" },
            metadata_status: { type: "string" },
            metadata_provenance: { type: "object" },
            state: {
              type: ["string", "null"],
              enum: ["retry", "revise", "resolve", null],
            },
            status: {
              enum: ["backlog", "attempting", "pending_ac", "accepted"],
            },
            due_date: { type: ["string", "null"], format: "date" },
            sprint_id: { type: ["string", "null"] },
          },
        },
        reflection: { type: "object" },
      },
    },
  },
  {
    name: "get_problem",
    description:
      "Get one ReSolve problem by canonical platform and problem key.",
    inputSchema: {
      type: "object",
      required: ["platform", "problem_key"],
      properties: {
        platform: { enum: ["codeforces", "cses"] },
        problem_key: { type: "string" },
      },
    },
  },
  {
    name: "list_due_reviews",
    description: "List problems due on or before an Asia/Dhaka calendar date.",
    inputSchema: {
      type: "object",
      required: ["date"],
      properties: { date: { type: "string", format: "date" } },
    },
  },
  {
    name: "record_review",
    description:
      "Atomically append a review event and update the next-review projection.",
    inputSchema: {
      type: "object",
      required: [
        "idempotency_key",
        "problem_id",
        "reflection_id",
        "due_date",
        "outcome",
        "deepest_reveal",
      ],
      properties: {
        idempotency_key: { type: "string" },
        problem_id: { type: "string" },
        reflection_id: { type: "string" },
        due_date: { type: "string", format: "date" },
        outcome: {
          enum: ["recalled", "needed_cue", "forgot", "unresolved"],
        },
        deepest_reveal: {
          enum: [
            "none",
            "memory_cue",
            "key_insight",
            "full_reflection",
            "source",
          ],
        },
        recall_note: { type: "string" },
        next_review_date: { type: "string", format: "date" },
        timer_limit_seconds: { type: "integer", minimum: 1 },
        timer_elapsed_seconds: { type: "integer", minimum: 0 },
      },
    },
  },
  {
    name: "update_problem",
    description:
      "Edit workflow properties without changing State or Status unless explicitly supplied. Archiving preserves both.",
    inputSchema: {
      type: "object",
      required: ["problem_id"],
      properties: {
        problem_id: { type: "string" },
        rating: { type: ["integer", "null"] },
        difficulty: {
          type: ["string", "null"],
          enum: ["easy", "medium", "hard", "extreme", null],
        },
        state: {
          type: ["string", "null"],
          enum: ["retry", "revise", "resolve", null],
        },
        status: {
          type: ["string", "null"],
          enum: ["backlog", "attempting", "pending_ac", "accepted", null],
        },
        archived: { type: "boolean" },
        due_date: { type: ["string", "null"], format: "date" },
        next_review_date: { type: ["string", "null"], format: "date" },
        official_tags: { type: "array", items: { type: "string" } },
      },
    },
  },
  {
    name: "update_reflection",
    description:
      "Edit generated reflection fields. The ordered raw transcript remains immutable.",
    inputSchema: {
      type: "object",
      required: ["reflection_id"],
      properties: {
        reflection_id: { type: "string" },
        summaryMarkdown: { type: "string" },
        structuredSummary: { type: "object" },
        memoryCue: { type: "string" },
        confidence: { type: ["number", "null"], minimum: 0, maximum: 5 },
      },
    },
  },
];

const McpProblemUpdateSchema = z.object({
  problem_id: z.string().min(1),
  rating: z.number().int().positive().max(3500).nullable().optional(),
  difficulty: DifficultySchema.nullable().optional(),
  state: ProblemStateSchema.nullable().optional(),
  status: ProblemStatusSchema.nullable().optional(),
  archived: z.boolean().optional(),
  due_date: z.string().date().nullable().optional(),
  next_review_date: z.string().date().nullable().optional(),
  official_tags: z.array(z.string()).optional(),
});

function rpc(id: RpcRequest["id"], result: unknown) {
  return Response.json({ jsonrpc: "2.0", id: id ?? null, result });
}

function rpcError(
  id: RpcRequest["id"],
  code: number,
  message: string,
  data?: unknown,
) {
  return Response.json({
    jsonrpc: "2.0",
    id: id ?? null,
    error: { code, message, data },
  });
}

async function authorized(request: Request) {
  const bearer = request.headers.get("authorization");
  const configured = await getMcpToken();
  const hostname = new URL(request.url).hostname;
  const expected =
    configured ??
    (hostname === "localhost" || hostname === "127.0.0.1"
      ? "resolve-local-mcp-token"
      : null);
  return expected !== null && bearer === `Bearer ${expected}`;
}

export async function POST(request: Request) {
  if (!(await authorized(request))) {
    return Response.json({ error: "Unauthorized" }, { status: 401 });
  }
  let payload: RpcRequest;
  try {
    payload = (await request.json()) as RpcRequest;
  } catch {
    return rpcError(null, -32700, "Parse error");
  }
  if (payload.jsonrpc !== "2.0" || !payload.method) {
    return rpcError(payload.id, -32600, "Invalid Request");
  }
  try {
    if (payload.method === "initialize") {
      return rpc(payload.id, {
        protocolVersion: "2025-06-18",
        capabilities: { tools: { listChanged: false } },
        serverInfo: { name: "resolve", version: "0.1.0" },
      });
    }
    if (payload.method === "notifications/initialized") {
      return new Response(null, { status: 202 });
    }
    if (payload.method === "tools/list") {
      return rpc(payload.id, { tools });
    }
    if (payload.method === "tools/call") {
      const name = String(payload.params?.name ?? "");
      const args = payload.params?.arguments ?? {};
      let result: unknown;
      if (name === "save_reflection") {
        result = await saveReflection(SaveReflectionSchema.parse(args));
      } else if (name === "get_problem") {
        const input = args as { platform?: string; problem_key?: string };
        if (!input.platform || !input.problem_key) {
          throw new Error("platform and problem_key are required");
        }
        result = await getProblemByIdentity(input.platform, input.problem_key);
      } else if (name === "list_due_reviews") {
        const date = String((args as { date?: string }).date ?? "");
        if (!/^\d{4}-\d{2}-\d{2}$/.test(date)) {
          throw new Error("date must use YYYY-MM-DD");
        }
        result = await listDueReviews(date);
      } else if (name === "record_review") {
        result = await recordReview(RecordReviewSchema.parse(args));
      } else if (name === "update_problem") {
        const input = McpProblemUpdateSchema.parse(args);
        result = {
          updated: await updateProblemProperties(input.problem_id, {
            rating: input.rating,
            difficulty: input.difficulty,
            state: input.state,
            status: input.status,
            archived: input.archived,
            dueDate: input.due_date,
            nextReviewDate: input.next_review_date,
            officialTags: input.official_tags,
          }),
        };
      } else if (name === "update_reflection") {
        const { reflection_id, ...fields } = z
          .object({ reflection_id: z.string().min(1) })
          .passthrough()
          .parse(args);
        const input = UpdateReflectionSchema.parse(fields);
        result = {
          updated: await updateReflection(reflection_id, input),
        };
      } else {
        return rpcError(payload.id, -32602, `Unknown tool: ${name}`);
      }
      return rpc(payload.id, {
        content: [{ type: "text", text: JSON.stringify(result) }],
        structuredContent: result,
        isError: false,
      });
    }
    if (payload.method === "ping") return rpc(payload.id, {});
    return rpcError(payload.id, -32601, "Method not found");
  } catch (error) {
    return rpc(payload.id, {
      content: [
        {
          type: "text",
          text: error instanceof Error ? error.message : "Unknown error",
        },
      ],
      isError: true,
    });
  }
}

export async function GET() {
  return Response.json(
    { name: "ReSolve MCP", transport: "stateless-streamable-http" },
    { status: 405, headers: { allow: "POST" } },
  );
}
