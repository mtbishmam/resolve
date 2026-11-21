import type { IncomingMessage } from "node:http";
import type { Plugin } from "vite";

// vinext blocks non-local Origin headers in dev, including requests from
// installed Chromium extensions. Make an exception for the timer route only;
// never add extension origins to the app-wide dev allowlist.
export function stripLocalExtensionOrigin(request: IncomingMessage) {
  if (
    !/^(?:localhost|127\.0\.0\.1)(?::\d+)?$/i.test(
      request.headers.host ?? "",
    ) ||
    request.url?.split("?", 1)[0] !== "/api/mashups/tracking" ||
    (request.method !== "GET" && request.method !== "POST") ||
    !/^chrome-extension:\/\/[a-p]{32}$/.test(request.headers.origin ?? "")
  )
    return;

  // Node builds headersDistinct lazily using its original header count.
  // Materialize it before shortening rawHeaders and keep all views in sync.
  const distinct = request.headersDistinct;
  delete request.headers.origin;
  if (distinct) delete distinct.origin;
  for (let i = request.rawHeaders.length - 2; i >= 0; i -= 2) {
    if (request.rawHeaders[i].toLowerCase() === "origin")
      request.rawHeaders.splice(i, 2);
  }
}

export function localExtensionBridge(): Plugin {
  return {
    name: "resolve-local-extension-bridge",
    apply: "serve",
    enforce: "pre",
    configureServer(server) {
      server.middlewares.use((request, _response, next) => {
        stripLocalExtensionOrigin(request);
        next();
      });
    },
  };
}
