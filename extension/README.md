# ReSolve Capture

The green icon is shared with the web app. Adapter v2 captures Codeforces source
TeX exactly once, preserves sample newlines, and keeps the latest capture for
recovery. Reload the unpacked extension after rebuilding `extension/dist`.

Run `npm run extension:build`, then load `extension/dist` as an unpacked
Manifest V3 extension. On a Codeforces problem page, **Capture problem** copies
one `resolve.capture.v1` JSON object and retains the latest capture in extension
storage for recovery.

The extension has no database credentials, MCP token, or model call.
Its ReSolve homepage is <https://resolve.mtbishmam.chatgpt.site>.
