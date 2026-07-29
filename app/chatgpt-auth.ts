import { headers } from "next/headers";
import { redirect } from "next/navigation";

export type ReSolveUser = {
  displayName: string;
  email: string;
};

export async function getChatGPTUser(): Promise<ReSolveUser | null> {
  const requestHeaders = await headers();
  const email = requestHeaders.get("oai-authenticated-user-email");
  if (!email) return null;
  const encodedName = requestHeaders.get("oai-authenticated-user-full-name");
  const encoding = requestHeaders.get(
    "oai-authenticated-user-full-name-encoding",
  );
  let name: string | null = null;
  if (encodedName && encoding === "percent-encoded-utf-8") {
    try {
      name = decodeURIComponent(encodedName);
    } catch {
      name = null;
    }
  }
  return { displayName: name ?? email, email };
}

export async function requireChatGPTUser(returnTo = "/") {
  const user = await getChatGPTUser();
  if (user) return user;
  redirect(
    `/signin-with-chatgpt?return_to=${encodeURIComponent(
      returnTo.startsWith("/") && !returnTo.startsWith("//") ? returnTo : "/",
    )}`,
  );
}
