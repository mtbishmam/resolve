import { createServer } from "node:http";
import { once } from "node:events";
import { describe, expect, it } from "vitest";
import { stripLocalExtensionOrigin } from "@/build/local-extension-bridge";

const extensionOrigin = "chrome-extension://abcdefghijklmnopabcdefghijklmnop";

describe("local extension bridge", () => {
  it("preserves Node's lazy header views and only strips the timer origin", async () => {
    const server = createServer((request, response) => {
      try {
        stripLocalExtensionOrigin(request);
        const i = request.rawHeaders.findIndex(
          (value, index) => index % 2 === 0 && value.toLowerCase() === "origin",
        );
        response.end(
          JSON.stringify({
            origin: request.headers.origin ?? null,
            distinct: request.headersDistinct.origin ?? null,
            raw: i === -1 ? null : request.rawHeaders[i + 1],
          }),
        );
      } catch (error) {
        response.statusCode = 500;
        response.end(String(error));
      }
    });
    server.listen(0, "127.0.0.1");
    try {
      await once(server, "listening");
      const address = server.address();
      if (!address || typeof address === "string")
        throw new Error("No test port");
      const send = (path: string, origin: string) =>
        fetch(`http://127.0.0.1:${address.port}${path}`, {
          method: "POST",
          headers: { origin },
        }).then((response) => response.json());
      expect(await send("/api/mashups/tracking?test", extensionOrigin)).toEqual(
        {
          origin: null,
          distinct: null,
          raw: null,
        },
      );
      expect(await send("/api/problems", extensionOrigin)).toEqual({
        origin: extensionOrigin,
        distinct: [extensionOrigin],
        raw: extensionOrigin,
      });
      const website = "https://codeforces.com";
      expect(await send("/api/mashups/tracking", website)).toEqual({
        origin: website,
        distinct: [website],
        raw: website,
      });
    } finally {
      server.close();
    }
  });
});
