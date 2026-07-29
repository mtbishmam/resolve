import { drizzle } from "drizzle-orm/d1";
import * as schema from "./schema";

export async function getD1(): Promise<D1Database> {
  const { env } = await import("cloudflare:workers");
  const runtimeEnv = env as unknown as { DB?: D1Database };
  if (!runtimeEnv.DB) throw new Error("ReSolve D1 binding DB is unavailable");
  return runtimeEnv.DB;
}

export async function getMcpToken() {
  const { env } = await import("cloudflare:workers");
  const runtimeEnv = env as unknown as { RESOLVE_MCP_TOKEN?: string };
  return typeof runtimeEnv.RESOLVE_MCP_TOKEN === "string"
    ? runtimeEnv.RESOLVE_MCP_TOKEN
    : null;
}

export async function getDb() {
  return drizzle(await getD1(), { schema });
}
