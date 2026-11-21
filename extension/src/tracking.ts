export const TRACKING_API = "http://localhost:3000/api/mashups/tracking";

export type TrackingSnapshot = {
  status:
    | "none"
    | "paused"
    | "scheduled"
    | "running"
    | "offline"
    | "inactive"
    | "error";
  problem?: {
    title: string;
    seconds: number;
    limitSeconds: number;
    ticking: boolean;
  } | null;
  observedAt?: number;
  nextUrl?: string | null;
  httpStatus?: number;
};

// Never send queries, fragments, non-judge browsing history, or page contents.
export function judgePage(value?: string) {
  try {
    const url = new URL(value ?? "");
    if (url.protocol !== "https:" || url.port || url.username || url.password)
      return null;
    const host = url.hostname.replace(/^www\./, "");
    const path = url.pathname;
    const allowed =
      (["codeforces.com", "m1.codeforces.com"].includes(host) &&
        /^\/(?:contest\/\d+\/problem|gym\/\d+\/problem|problemset\/problem\/\d+)\/[a-z0-9]+\/?$/i.test(
          path,
        )) ||
      (host === "atcoder.jp" &&
        /^\/contests\/[^/]+\/tasks\/[^/]+\/?$/.test(path)) ||
      (host === "cses.fi" && /^\/problemset\/task\/\d+\/?$/.test(path)) ||
      (host === "codechef.com" && /\/problems\/[a-z0-9_]+\/?$/i.test(path)) ||
      (host === "lightoj.com" && /^\/problem\/[a-z0-9-]+\/?$/i.test(path));
    return allowed ? url.origin + path : null;
  } catch {
    return null;
  }
}
