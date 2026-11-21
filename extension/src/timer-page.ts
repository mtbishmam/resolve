// Manifest V3 content scripts are classic scripts, so keep this entry import-free.
(() => {
  const context = globalThis as typeof globalThis & {
    resolveJudgeTimer?: {
      host: HTMLElement;
      runtime: typeof chrome.runtime;
      dispose: () => void;
    };
  };
  if (
    context.resolveJudgeTimer?.host.isConnected &&
    context.resolveJudgeTimer.runtime.id
  )
    return;
  context.resolveJudgeTimer?.dispose();

  let snapshot: {
    status: string;
    observedAt?: number;
    problem?: {
      seconds: number;
      limitSeconds: number;
      ticking: boolean;
    } | null;
  } | null = null;
  let inFlight = false;
  let notifiedLimit = false;
  const host = document.createElement("div");
  host.id = "resolve-judge-timer";
  host.setAttribute("data-resolve-timer", "");
  host.hidden = true;
  const shadow = host.attachShadow({ mode: "open" });
  // Constructed styles stay scoped to our UI and don't require the judge
  // page to allow inline <style> elements in its Content Security Policy.
  const sheet = new CSSStyleSheet();
  sheet.replaceSync(`
    :host { all: initial !important; display: block !important;
      position: fixed !important; inset: 10px 14px auto auto !important;
      max-width: calc(100vw - 28px) !important;
      z-index: 2147483647 !important; pointer-events: none !important; }
    :host([hidden]) { display: none !important; }
    .timer { display: grid; gap: 4px; box-sizing: border-box; padding: 8px 12px;
      border: 1px solid #417d69; border-radius: 9px; color: #fff;
      background: #174f42; box-shadow: 0 3px 12px #0004;
      font: 12px/1.25 system-ui, sans-serif; user-select: none; }
    span { color: #deefe7; font-weight: 600; }
    output { font: 650 19px/1 ui-monospace, monospace; font-variant-numeric: tabular-nums; }
  `);
  shadow.adoptedStyleSheets = [sheet];
  const panel = document.createElement("div");
  panel.className = "timer";
  const label = document.createElement("span");
  const time = document.createElement("output");
  time.setAttribute("aria-live", "off");
  time.setAttribute("aria-label", "ReSolve problem time elapsed");
  panel.append(label, time);
  shadow.append(panel);
  const previous = document.getElementById("resolve-judge-timer");
  if (
    previous?.hasAttribute("data-resolve-timer") ||
    previous?.shadowRoot?.querySelector(
      'output[aria-label="ReSolve problem time elapsed"]',
    )
  ) {
    previous.remove();
  }
  document.documentElement.append(host);

  function render() {
    const problem = snapshot?.problem;
    host.hidden = !problem;
    if (!problem || !snapshot) return;
    const elapsed = problem.ticking
      ? Math.min(
          problem.limitSeconds,
          problem.seconds +
            Math.max(0, Date.now() - (snapshot.observedAt ?? Date.now())) /
              1000,
        )
      : problem.seconds;
    const whole = Math.floor(elapsed);
    const formatted = [
      Math.floor(whole / 3600),
      Math.floor(whole / 60) % 60,
      whole % 60,
    ]
      .map((part) => String(part).padStart(2, "0"))
      .join(":");
    if (time.value !== formatted) time.value = formatted;
    const atLimit = elapsed >= problem.limitSeconds;
    const caption =
      snapshot.status === "paused"
        ? "ReSolve · Paused"
        : snapshot.status === "scheduled"
          ? "ReSolve · Scheduled"
          : atLimit
            ? "ReSolve · Time up"
            : "ReSolve timer";
    if (label.textContent !== caption) label.textContent = caption;
    if (problem.ticking && atLimit && !notifiedLimit) {
      notifiedLimit = true;
      void sync();
    }
  }

  async function sync() {
    if (document.hidden || inFlight) return;
    inFlight = true;
    try {
      snapshot = await chrome.runtime.sendMessage({
        type: "resolve-track-current",
      });
    } catch {
      snapshot = null;
      host.hidden = true;
      if (!chrome.runtime?.id) {
        // A reloaded/disabled extension invalidates its old page scripts.
        dispose();
      }
    } finally {
      inFlight = false;
    }
    render();
  }

  const refresh = window.setInterval(() => void sync(), 3000);
  const tick = window.setInterval(render, 250);
  function dispose() {
    window.clearInterval(refresh);
    window.clearInterval(tick);
    document.removeEventListener("visibilitychange", sync);
    host.remove();
  }
  context.resolveJudgeTimer = { host, runtime: chrome.runtime, dispose };
  document.addEventListener("visibilitychange", sync);
  void sync();
})();
