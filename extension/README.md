# ReSolve Capture

The green icon is shared with the web app. Adapter v2 captures Codeforces source
TeX exactly once, preserves sample newlines, and keeps the latest capture for
recovery. Reload the unpacked extension after rebuilding `extension/dist`.
The timer attaches to the active judge tab, even if it was already open.

Run `npm run extension:build`, then load `extension/dist` as an unpacked
Manifest V3 extension. On a Codeforces problem page, **Capture problem** copies
one `resolve.capture.v1` JSON object and retains the latest capture in extension
storage for recovery.

The extension has no database credentials, MCP token, or model call.
Its ReSolve homepage is <https://resolve.mtbishmam.chatgpt.site>.

For URL-first coaching, the extension is optional. For local mashup timing,
start or resume a mashup at `http://localhost:3000`, keep that tab open, and
open its judge problems in other tabs. The active Codeforces, AtCoder, CSES,
CodeChef, or LightOJ problem URL selects the running problem timer if it
belongs to the mashup. Switching to a non-member URL stops the problem timer;
the global timer continues. Switching to a native editor leaves the last
selected browser problem running. A compact, non-interactive timer opens at
the top-right of the judge page, just below the browser toolbar. Pin ReSolve
Capture to see elapsed minutes on its toolbar icon too. The on-page timer
keeps ticking while you interact with the problem, unlike the native capture
popup, which closes when focus moves away. Both show the same elapsed time
as the localhost mashup. For automatic display, allow ReSolve Capture's site
access on your judge (not only on click). After one
accumulated hour, the extension opens the next problem with time left in the
same tab, in mashup order. On the last problem it shows **Time up** and leaves
the page open. No judge pages are blocked. Pause the mashup in ReSolve to stop
every timer.

The tracker sends only supported problem URL paths (without query or fragment)
or a no-problem signal to localhost. It does not send browsing events to the
hosted site.
