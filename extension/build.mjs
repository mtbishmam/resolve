import { cp, mkdir, rm } from "node:fs/promises";
import { execFileSync } from "node:child_process";
import { resolve } from "node:path";

const root = import.meta.dirname;
const dist = resolve(root, "dist");
await rm(dist, { recursive: true, force: true });
await mkdir(dist, { recursive: true });
execFileSync(resolve(root, "..", "node_modules", ".bin", "tsc"), [
  "-p",
  resolve(root, "tsconfig.json"),
]);
for (const file of ["manifest.json", "popup.html", "popup.css"]) {
  await cp(resolve(root, file), resolve(dist, file));
}
console.log("Built extension/dist.");
