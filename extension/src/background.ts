import { activeJudgePage } from "./active-tab.js";
import { judgePage, TRACKING_API, type TrackingSnapshot } from "./tracking.js";

let pending: Promise<unknown> = Promise.resolve();
const badgeByTab = new Map<number, string>();
const defaultTitle = "ReSolve mashup timer and capture";

async function updateBadge(
  tabId: number | undefined,
  snapshot?: TrackingSnapshot,
) {
  if (tabId === undefined) return;
  const problem = snapshot?.problem;
  const text = problem ? `${Math.floor(problem.seconds / 60)}m` : "";
  const color = problem?.ticking ? "#174f42" : "#586872";
  const title = problem
    ? `ReSolve timer · ${problem.title} · ${text} elapsed`
    : defaultTitle;
  const key = JSON.stringify([text, color, title]);
  if (badgeByTab.get(tabId) === key) return;
  try {
    await Promise.all([
      chrome.action.setBadgeText({ tabId, text }),
      chrome.action.setBadgeBackgroundColor({ tabId, color }),
      chrome.action.setTitle({ tabId, title }),
    ]);
    badgeByTab.set(tabId, key);
  } catch {
    // The tab may have closed while the clock request was in flight.
  }
}

function trackActiveUrl(
  senderTabId?: number,
  installTimer = false,
): Promise<TrackingSnapshot> {
  const task = pending
    .catch(() => undefined)
    .then(async (): Promise<TrackingSnapshot> => {
      let tabId: number | undefined;
      try {
        const tab = await activeJudgePage();
        if (senderTabId !== undefined && tab.id !== senderTabId)
          return { status: "inactive" };
        // A pending navigation may still expose the previous URL as tab.url.
        // Don't re-select it; the onUpdated event will report the new page.
        if (tab.navigating) {
          await updateBadge(tab.id);
          return { status: "inactive" };
        }
        tabId = tab.id;
        if (installTimer && tab.url && tabId !== undefined) {
          // Static scripts don't attach retroactively to already-open tabs
          // after an extension reload. The page script is idempotent.
          await chrome.scripting
            .executeScript({
              target: { tabId },
              files: ["timer-page.js"],
            })
            .catch(() => undefined);
        }
        const response = await fetch(TRACKING_API, {
          method: "POST",
          headers: { "content-type": "application/json" },
          body: JSON.stringify({ url: tab.url }),
          credentials: "omit",
          signal: AbortSignal.timeout(3000),
        });
        if (!response.ok) {
          await updateBadge(tabId);
          return { status: "error", httpStatus: response.status };
        }
        const snapshot = (await response.json()) as TrackingSnapshot;
        await updateBadge(tabId, snapshot);
        const next = judgePage(snapshot.nextUrl ?? undefined);
        if (next && tab.id !== undefined && tab.url && next !== tab.url) {
          const current = await activeJudgePage();
          if (
            current.id === tab.id &&
            current.url === tab.url &&
            !current.navigating
          ) {
            await chrome.tabs
              .update(tab.id, { url: next })
              .catch(() => undefined);
          }
        }
        return snapshot;
      } catch {
        await updateBadge(tabId);
        // Local ReSolve is optional; capture works without it.
        return { status: "offline" };
      }
    });
  pending = task;
  return task;
}

const attachAndTrack = () => void trackActiveUrl(undefined, true);
chrome.runtime.onInstalled.addListener(() => {
  void chrome.storage.local.set({
    resolve_extension_version: chrome.runtime.getManifest().version,
  });
  attachAndTrack();
});

chrome.runtime.onStartup.addListener(attachAndTrack);
chrome.tabs.onActivated.addListener(attachAndTrack);
chrome.tabs.onUpdated.addListener((_tabId, change, tab) => {
  if (tab.active && (change.url !== undefined || change.status === "complete"))
    attachAndTrack();
});
chrome.tabs.onRemoved.addListener((tabId) => {
  badgeByTab.delete(tabId);
  attachAndTrack();
});
chrome.windows.onFocusChanged.addListener((windowId) => {
  if (windowId !== chrome.windows.WINDOW_ID_NONE) attachAndTrack();
});
chrome.runtime.onMessage.addListener((message, sender, reply) => {
  if (
    message?.type !== "resolve-track-current" ||
    sender.id !== chrome.runtime.id
  )
    return;
  void trackActiveUrl(sender.tab?.id).then(reply);
  return true;
});
