import { mkdir, writeFile } from "node:fs/promises";
import { resolve } from "node:path";

const root = resolve(import.meta.dirname, "..");
const base = process.env.RESOLVE_BASE_URL ?? "http://localhost:3000";
const stamp = new Date().toISOString().replaceAll(":", "-");
const out = resolve(root, "database-exports", stamp);
await mkdir(out, { recursive: true });

for (const [format, extension] of [
  ["json", "json"],
  ["markdown", "md"],
  ["sql", "sql"],
]) {
  const response = await fetch(`${base}/api/export?format=${format}`);
  if (!response.ok) {
    throw new Error(`Export ${format} failed with ${response.status}`);
  }
  await writeFile(
    resolve(out, `resolve-export.${extension}`),
    Buffer.from(await response.arrayBuffer()),
  );
}
console.log(`Wrote JSON, Markdown, and SQL exports to ${out}`);
