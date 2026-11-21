import vinext from "vinext";
import { defineConfig } from "vite";
import hostingConfig from "./.openai/hosting.json" with { type: "json" };
import { sites } from "./build/sites-vite-plugin.ts";
import { localExtensionBridge } from "./build/local-extension-bridge.ts";

const { d1 } = hostingConfig;
const localBindingConfig = {
  main: "./worker/index.ts",
  compatibility_flags: ["nodejs_compat"],
  d1_databases: d1
    ? [
        {
          binding: d1,
          database_name: "resolve-local",
          database_id: "00000000-0000-4000-8000-000000000000",
        },
      ]
    : [],
};

export default defineConfig(async () => {
  process.env.WRANGLER_WRITE_LOGS ??= "false";
  process.env.MINIFLARE_REGISTRY_PATH ??= ".wrangler/registry";
  const { cloudflare } = await import("@cloudflare/vite-plugin");
  return {
    server: {
      host: "localhost",
      port: 3000,
      strictPort: true,
      watch: { useFsEvents: false, usePolling: true },
    },
    plugins: [
      localExtensionBridge(),
      vinext(),
      sites(),
      cloudflare({
        viteEnvironment: { name: "rsc", childEnvironments: ["ssr"] },
        config: localBindingConfig,
        remoteBindings: false,
        persistState: {
          path: process.env.RESOLVE_LOCAL_STATE_DIR ?? ".wrangler/state",
        },
      }),
    ],
  };
});
