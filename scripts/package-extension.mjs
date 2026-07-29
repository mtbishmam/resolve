import assert from "node:assert/strict";
import { execFileSync } from "node:child_process";
import { mkdir, readFile, readdir, rm } from "node:fs/promises";
import { join, resolve } from "node:path";

const root = resolve(import.meta.dirname, "..");
const extension = join(root, "extension");
const dist = join(extension, "dist");
const artifacts = join(root, "artifacts");
const archive = join(artifacts, "resolve-capture-extension.zip");

execFileSync(process.execPath, [join(extension, "build.mjs")], {
  cwd: root,
  stdio: "inherit",
});

const files = await readdir(dist, { recursive: true });
assert(files.includes("manifest.json"));
assert(files.includes("popup.html"));
assert(files.includes("popup.js"));
assert(files.includes("background.js"));

const forbiddenNames = [".env", "credentials", "secret", "token"];
const forbiddenContent = [
  "RESOLVE_MCP_TOKEN",
  "OAI-Sites-Authorization",
  "resolve-cp-recall.mtbishmam.chatgpt.site",
];

for (const relativePath of files) {
  const path = join(dist, relativePath);
  const lowered = relativePath.toLowerCase();
  assert(
    !forbiddenNames.some((name) => lowered.includes(name)),
    `Forbidden extension filename: ${relativePath}`,
  );
  try {
    const value = await readFile(path, "utf8");
    assert(
      !forbiddenContent.some((needle) => value.includes(needle)),
      `Forbidden extension content: ${relativePath}`,
    );
  } catch (error) {
    if (error?.code !== "EISDIR") throw error;
  }
}

await mkdir(artifacts, { recursive: true });
await rm(archive, { force: true });
execFileSync("/usr/bin/zip", ["-q", "-r", "-X", archive, "."], {
  cwd: dist,
});

console.log(`Packaged ${archive}`);
