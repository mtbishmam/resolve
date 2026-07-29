import assert from "node:assert/strict";
import { readdir, readFile, realpath } from "node:fs/promises";
import { join, relative, resolve } from "node:path";

const root = resolve(import.meta.dirname, "..");
const expected = {
  productName: "ReSolve",
  workspace: "/Users/mtbishmam/code/resolve",
  sitesSlug: "resolve",
  productionHostname: "resolve.mtbishmam.chatgpt.site",
  productionUrl: "https://resolve.mtbishmam.chatgpt.site",
  captureSchema: "resolve.capture.v1",
};

const identity = JSON.parse(
  await readFile(join(root, "identity.json"), "utf8"),
);
const hosting = JSON.parse(
  await readFile(join(root, ".openai", "hosting.json"), "utf8"),
);
const packageJson = JSON.parse(
  await readFile(join(root, "package.json"), "utf8"),
);
const manifest = JSON.parse(
  await readFile(join(root, "extension", "manifest.json"), "utf8"),
);
const contracts = await readFile(join(root, "lib", "contracts.ts"), "utf8");
const popup = await readFile(
  join(root, "extension", "src", "popup.ts"),
  "utf8",
);

assert.deepEqual(identity, expected);
assert.equal(await realpath(root), expected.workspace);
assert.equal(process.cwd(), expected.workspace);
assert.equal(packageJson.name, expected.sitesSlug);
assert.equal(hosting.project_id, "appgprj_6a6a88e999008191a92c6d26e9c1a015");
assert.equal(hosting.d1, "DB");
assert.equal(hosting.r2, null);
assert.equal(manifest.name, `${expected.productName} Capture`);
assert.equal(manifest.homepage_url, expected.productionUrl);
assert(contracts.includes(`z.literal("${expected.captureSchema}")`));
assert(popup.includes(`schema: "${expected.captureSchema}"`));

const forbiddenHostname = [
  "resolve-cp-recall",
  "mtbishmam",
  "chatgpt",
  "site",
].join(".");
const sourceRoots = ["app", "extension", "lib", "worker"];

async function sourceFiles(directory) {
  const entries = await readdir(directory, { withFileTypes: true });
  const files = [];
  for (const entry of entries) {
    const path = join(directory, entry.name);
    if (entry.isDirectory()) {
      if (entry.name === "dist") continue;
      files.push(...(await sourceFiles(path)));
    } else if (/\.(?:json|md|ts|tsx)$/.test(entry.name)) {
      files.push(path);
    }
  }
  return files;
}

for (const sourceRoot of sourceRoots) {
  for (const file of await sourceFiles(join(root, sourceRoot))) {
    const value = await readFile(file, "utf8");
    assert(
      !value.includes(forbiddenHostname),
      `Legacy production hostname remains in ${relative(root, file)}`,
    );
  }
}

console.log("ReSolve identity guard passed.");
