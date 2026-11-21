import { judgePage } from "./tracking.js";

export async function activeJudgePage() {
  const [tab] = await chrome.tabs.query({
    active: true,
    lastFocusedWindow: true,
  });
  return {
    id: tab?.id,
    url: judgePage(tab?.url),
    navigating: Boolean(tab?.pendingUrl),
  };
}
