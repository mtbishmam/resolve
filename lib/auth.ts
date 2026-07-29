import { getChatGPTUser } from "@/app/chatgpt-auth";

export async function authorizeBrowserRequest(request: Request) {
  const host = new URL(request.url).hostname;
  if (host === "localhost" || host === "127.0.0.1") return true;
  return Boolean(await getChatGPTUser());
}
