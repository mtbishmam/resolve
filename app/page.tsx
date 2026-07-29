import { headers } from "next/headers";
import { requireChatGPTUser } from "./chatgpt-auth";
import ReSolveApp from "./resolve-app";

export const dynamic = "force-dynamic";

async function Viewer() {
  const requestHeaders = await headers();
  const host = requestHeaders.get("host") ?? "";
  const local = host.startsWith("localhost") || host.startsWith("127.0.0.1");
  const user = local
    ? { displayName: "Local workspace", email: "local@resolve" }
    : await requireChatGPTUser("/");
  return <ReSolveApp viewer={user} local={local} />;
}

export default function Page() {
  return <Viewer />;
}
