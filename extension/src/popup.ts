type CaptureAsset = { url: string; alt: string };

function captureCodeforcesProblem() {
  function text(element: Element | null) {
    return element?.textContent?.trim() ?? "";
  }

  function canonicalIdentity() {
    const match = location.pathname.match(
      /\/(?:contest\/(\d+)\/problem|problemset\/problem\/(\d+))\/([A-Za-z0-9]+)/,
    );
    if (!match) throw new Error("Open a Codeforces problem page first.");
    const contest = Number(match[1] ?? match[2]);
    const index = match[3].toUpperCase();
    return {
      contest,
      index,
      key: `${contest}:${index}`,
      url: `https://codeforces.com/contest/${contest}/problem/${index}`,
    };
  }

  function normalizeMath(value: string) {
    return value.replace(/\$\$\$([\s\S]*?)\$\$\$/g, (_match, math) => {
      const clean = String(math).trim();
      return clean.includes("\n") ? `$$\n${clean}\n$$` : `$${clean}$`;
    });
  }

  function blockToMarkdown(node: Element): string {
    if (node.matches(".tex-span, .tex-font-style-bf, .tex-font-style-it")) {
      return normalizeMath(text(node));
    }
    if (node.tagName === "IMG") {
      const image = node as HTMLImageElement;
      return `![${image.alt || "Problem diagram"}](${new URL(
        image.src,
        location.href,
      ).toString()})`;
    }
    if (node.tagName === "BR") return "\n";
    if (node.tagName === "PRE") {
      return `\n\n\`\`\`text\n${text(node)}\n\`\`\`\n\n`;
    }
    if (/^H[1-6]$/.test(node.tagName)) {
      return `\n\n## ${normalizeMath(text(node))}\n\n`;
    }
    if (node.tagName === "LI") {
      return `- ${[...node.childNodes]
        .map((child) =>
          child.nodeType === Node.TEXT_NODE
            ? child.textContent
            : blockToMarkdown(child as Element),
        )
        .join("")
        .trim()}\n`;
    }
    const inner = [...node.childNodes]
      .map((child) =>
        child.nodeType === Node.TEXT_NODE
          ? (child.textContent ?? "")
          : blockToMarkdown(child as Element),
      )
      .join("");
    return node.tagName === "P" || node.tagName === "DIV"
      ? `\n\n${normalizeMath(inner.trim())}\n\n`
      : normalizeMath(inner);
  }

  const identity = canonicalIdentity();
  const statement = document.querySelector(".problem-statement");
  if (!statement) throw new Error("Codeforces statement was not found.");
  const clone = statement.cloneNode(true) as HTMLElement;
  clone
    .querySelectorAll(
      ".header, .sample-test .title, .input-specification .section-title, .output-specification .section-title",
    )
    .forEach((node) => {
      if (node.matches(".section-title")) {
        node.replaceWith(
          Object.assign(document.createElement("h2"), {
            textContent: text(node),
          }),
        );
      }
    });
  const titleRaw = text(statement.querySelector(".title"));
  const title = titleRaw.replace(/^[A-Za-z0-9]+\.\s*/, "").trim();
  const ratingText = text(
    document.querySelector(".tag-box[title='Difficulty']"),
  ).replace("*", "");
  const tags = [...document.querySelectorAll(".tag-box")]
    .map((tag) => text(tag).replace("*", ""))
    .filter((tag) => tag && tag !== ratingText);
  const assets: CaptureAsset[] = [...statement.querySelectorAll("img")].map(
    (image) => ({
      url: new URL((image as HTMLImageElement).src, location.href).toString(),
      alt: (image as HTMLImageElement).alt || "Problem diagram",
    }),
  );
  const bodyNodes = [...clone.children].filter(
    (node) => !node.matches(".header"),
  );
  const markdown = bodyNodes
    .map(blockToMarkdown)
    .join("")
    .replace(/\n{3,}/g, "\n\n")
    .trim();
  return {
    schema: "resolve.capture.v1",
    capture_id: crypto.randomUUID(),
    captured_at: new Date().toISOString(),
    platform: "codeforces",
    problem_key: identity.key,
    url: identity.url,
    problem: {
      contest_id: identity.contest,
      index: identity.index,
      title,
      rating: ratingText ? Number(ratingText) : null,
      official_tags: tags,
    },
    statement: { format: "markdown", text: markdown, assets },
    provenance: {
      adapter: "codeforces",
      adapter_version: "1",
      language: document.documentElement.lang || "en",
    },
  };
}

const statusNode = document.querySelector<HTMLElement>("#status")!;
const button = document.querySelector<HTMLButtonElement>("#capture")!;
const recover = document.querySelector<HTMLButtonElement>("#recover")!;

async function copyCapture(capture: unknown) {
  await navigator.clipboard.writeText(JSON.stringify(capture, null, 2));
  await chrome.storage.local.set({
    latest_resolve_capture: capture,
    latest_resolve_capture_saved_at: new Date().toISOString(),
  });
}

button.addEventListener("click", async () => {
  button.disabled = true;
  statusNode.dataset.kind = "working";
  statusNode.textContent = "Reading the problem…";
  try {
    const [tab] = await chrome.tabs.query({
      active: true,
      currentWindow: true,
    });
    if (!tab?.id || !tab.url?.includes("codeforces.com")) {
      throw new Error("Open a Codeforces problem page first.");
    }
    const results = await chrome.scripting.executeScript({
      target: { tabId: tab.id },
      func: captureCodeforcesProblem,
    });
    const capture = results[0]?.result;
    if (!capture) throw new Error("The statement could not be captured.");
    await copyCapture(capture);
    statusNode.dataset.kind = "success";
    statusNode.textContent =
      "Copied. Paste it into Codex from the ReSolve project.";
  } catch (error) {
    statusNode.dataset.kind = "error";
    statusNode.textContent =
      error instanceof Error ? error.message : "Capture failed. Try again.";
  } finally {
    button.disabled = false;
  }
});

recover.addEventListener("click", async () => {
  const { latest_resolve_capture: capture } = await chrome.storage.local.get(
    "latest_resolve_capture",
  );
  if (!capture) {
    statusNode.dataset.kind = "error";
    statusNode.textContent = "No previous capture is stored.";
    return;
  }
  await navigator.clipboard.writeText(JSON.stringify(capture, null, 2));
  statusNode.dataset.kind = "success";
  statusNode.textContent = "Latest capture copied again.";
});
