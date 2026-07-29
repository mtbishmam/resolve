import { getChatGPTUser } from "@/app/chatgpt-auth";
import { getMcpToken } from "@/db/index";

export async function authorizeBrowserRequest(request: Request) {
  const host = new URL(request.url).hostname;
  if (host === "localhost" || host === "127.0.0.1") return true;
  const configured = await getMcpToken();
  if (
    configured &&
    request.headers.get("authorization") === `Bearer ${configured}`
  ) {
    return true;
  }
  return Boolean(await getChatGPTUser());
}
