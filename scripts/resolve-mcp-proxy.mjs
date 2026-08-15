#!/usr/bin/env node

import { execFileSync } from "node:child_process";
import { createInterface } from "node:readline";

const DEFAULT_ENDPOINT = "https://resolve.mtbishmam.chatgpt.site/api/mcp";
const KEYCHAIN_SERVICE = "site.chatgpt.mtbishmam.resolve.canonical";

function credential(environmentKey, keychainAccount) {
  const configured = process.env[environmentKey]?.trim();
  if (configured) return configured;
  try {
    return execFileSync(
      "/usr/bin/security",
      [
        "find-generic-password",
        "-s",
        KEYCHAIN_SERVICE,
        "-a",
        keychainAccount,
        "-w",
      ],
      { encoding: "utf8", stdio: ["ignore", "pipe", "ignore"] },
    ).trim();
  } catch {
    throw new Error(
      `ReSolve credential ${keychainAccount} is unavailable. Pair or configure the ReSolve MCP credentials first.`,
    );
  }
}

const endpoint = process.env.RESOLVE_MCP_URL?.trim() || DEFAULT_ENDPOINT;
const apiToken = credential("RESOLVE_MCP_TOKEN", "mcp-token");
let sitesBypassToken = null;
try {
  sitesBypassToken = credential(
    "RESOLVE_SITES_BYPASS_TOKEN",
    "sites-bypass-token",
  );
} catch {
  // Local endpoints do not need the Sites access-layer bypass header.
}

async function forward(message) {
  const headers = {
    accept: "application/json, text/event-stream",
    authorization: `Bearer ${apiToken}`,
    "content-type": "application/json",
  };
  if (sitesBypassToken) {
    headers["oai-sites-authorization"] = `Bearer ${sitesBypassToken}`;
  }

  const response = await fetch(endpoint, {
    method: "POST",
    headers,
    body: JSON.stringify(message),
  });

  if (response.status === 204) return [];
  const body = await response.text();
  if (!response.ok) {
    const detail = response.headers.get("content-type")?.includes("text/html")
      ? "The Sites access layer rejected the request. Configure the ReSolve Sites bypass credential."
      : body.slice(0, 500);
    return [
      {
        jsonrpc: "2.0",
        id: message.id ?? null,
        error: {
          code: -32001,
          message: `ReSolve MCP returned HTTP ${response.status}. ${detail}`,
        },
      },
    ];
  }

  if (response.headers.get("content-type")?.includes("text/event-stream")) {
    return body
      .split("\n")
      .filter((line) => line.startsWith("data:"))
      .map((line) => line.slice(5).trim())
      .filter(Boolean)
      .map((line) => JSON.parse(line));
  }
  return body ? [JSON.parse(body)] : [];
}

const lines = createInterface({ input: process.stdin, crlfDelay: Infinity });
for await (const line of lines) {
  if (!line.trim()) continue;
  let message;
  try {
    message = JSON.parse(line);
  } catch {
    process.stdout.write(
      `${JSON.stringify({
        jsonrpc: "2.0",
        id: null,
        error: { code: -32700, message: "Invalid JSON" },
      })}\n`,
    );
    continue;
  }
  try {
    for (const reply of await forward(message)) {
      process.stdout.write(`${JSON.stringify(reply)}\n`);
    }
  } catch (error) {
    process.stdout.write(
      `${JSON.stringify({
        jsonrpc: "2.0",
        id: message.id ?? null,
        error: {
          code: -32000,
          message:
            error instanceof Error ? error.message : "ReSolve MCP proxy failed",
        },
      })}\n`,
    );
  }
}
