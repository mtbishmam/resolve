import type { TrackingSnapshot } from "./tracking.js";

const title = document.querySelector<HTMLElement>("#mashup-problem")!;
const time = document.querySelector<HTMLOutputElement>("#mashup-time")!;
const status = document.querySelector<HTMLElement>("#mashup-state")!;
let snapshot: TrackingSnapshot | null = null;
let refreshing = false;

function format(seconds: number) {
  const n = Math.max(0, Math.floor(seconds));
  return [Math.floor(n / 3600), Math.floor(n / 60) % 60, n % 60]
    .map((part) => String(part).padStart(2, "0"))
    .join(":");
}

async function refresh() {
  if (refreshing) return;
  refreshing = true;
  try {
    const data: TrackingSnapshot = await chrome.runtime.sendMessage({
      type: "resolve-track-current",
    });
    if (data.status === "offline") throw new Error();
    snapshot = data;
    title.textContent = data.problem?.title ?? "Local mashup";
    time.hidden = !data.problem;
    renderTime();
    status.textContent =
      data.status === "error"
        ? `Local timer request failed (HTTP ${data.httpStatus}). Restart local ReSolve.`
        : data.status === "inactive"
          ? "Waiting for this tab to load"
          : data.status === "none"
            ? "No unfinished mashup"
            : data.status === "paused"
              ? "Mashup paused"
              : data.status === "scheduled"
                ? "Waiting for scheduled start"
                : !data.problem
                  ? "Open a problem from the current mashup"
                  : data.problem.seconds >= data.problem.limitSeconds
                    ? "One-hour limit reached"
                    : data.problem.ticking
                      ? "Tracking this URL"
                      : "Not tracking this URL";
  } catch {
    snapshot = null;
    title.textContent = "Local mashup";
    time.hidden = true;
    status.textContent = "Local ReSolve is offline";
  } finally {
    refreshing = false;
  }
}

function renderTime() {
  const problem = snapshot?.problem;
  if (!snapshot || !problem) return;
  const extra =
    problem.ticking && snapshot.observedAt !== undefined
      ? Math.max(0, Date.now() - snapshot.observedAt) / 1000
      : 0;
  const elapsed = extra
    ? Math.min(problem.limitSeconds, problem.seconds + extra)
    : problem.seconds;
  const formatted = format(elapsed);
  if (time.value !== formatted) time.value = formatted;
}

void refresh();
window.setInterval(() => void refresh(), 2000);
window.setInterval(renderTime, 250);
