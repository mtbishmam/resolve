type CaptureAsset = { url: string; alt: string };

function captureCodeforcesProblem() {
  // Chrome serializes only this function when executeScript runs it. Keep the
  // parser helpers inside the injected function so the browser uses the same
  // deterministic sample formatter rather than a closure that disappears.
  function normalizePreformattedText(value: string) {
    return value
      .replace(/\r\n?/g, "\n")
      .split("\n")
      .map((line) => line.replace(/[ \t]+$/g, ""))
      .join("\n")
      .replace(/^\n+|\n+$/g, "");
  }

  function formatCodeforcesSampleMarkdown(input: string, output: string) {
    const inputText = normalizePreformattedText(input);
    const outputText = normalizePreformattedText(output);
    if (!inputText || !outputText) {
      throw new Error(
        "A Codeforces sample must contain input and output text.",
      );
    }
    return [
      "\n\n### Input\n\n",
      "```text\n",
      inputText,
      "\n```\n\n",
      "### Output\n\n",
      "```text\n",
      outputText,
      "\n```\n\n",
    ].join("");
  }

  function hasStructuredCodeforcesSamples(markdown: string) {
    const fencedBlocks = markdown.match(
      /```(?:text|plaintext)?\s*\n[\s\S]*?```/gi,
    );
    return Boolean(
      /#{2,6}\s+Example(?:s)?\b/i.test(markdown) &&
      /#{2,6}\s+Input\b/i.test(markdown) &&
      /#{2,6}\s+Output\b/i.test(markdown) &&
      (fencedBlocks?.length ?? 0) >= 2,
    );
  }

  function text(element: Element | null) {
    return element?.textContent?.trim() ?? "";
  }

  function canonicalIdentity() {
    const match = location.pathname.match(
      /\/(?:(contest|gym)\/(\d+)\/problem|problemset\/problem\/(\d+))\/([A-Za-z0-9]+)/,
    );
    if (!match) throw new Error("Open a Codeforces problem page first.");
    const route = match[1] === "gym" ? "gym" : "contest";
    const contest = Number(match[2] ?? match[3]);
    const index = match[4].toUpperCase();
    return {
      contest,
      index,
      key: `${contest}:${index}`,
      url: `https://codeforces.com/${route}/${contest}/problem/${index}`,
    };
  }

  function normalizeMath(value: string) {
    return value.replace(/\$\$\$([\s\S]*?)\$\$\$/g, (_match, math) => {
      const clean = String(math).trim();
      return clean.includes("\n") ? `$$\n${clean}\n$$` : `$${clean}$`;
    });
  }

  function blockToMarkdown(node: Element): string {
    if (
      node.matches(
        ".MathJax, .MathJax_Preview, .MJX_Assistive_MathML, .input-output-copier",
      )
    ) {
      return "";
    }
    if (
      node.tagName === "SCRIPT" &&
      (node as HTMLScriptElement).type.startsWith("math/tex")
    ) {
      const source = node.textContent?.trim() ?? "";
      return (node as HTMLScriptElement).type.includes("mode=display")
        ? `\n\n$$\n${source}\n$$\n\n`
        : `$${source}$`;
    }
    if (node.tagName === "IMG") {
      const image = node as HTMLImageElement;
      return `![${image.alt || "Problem diagram"}](${new URL(
        image.src,
        location.href,
      ).toString()})`;
    }
    if (node.tagName === "BR") return "\n";
    if (node.matches(".sample-test")) {
      const inputs = [...node.querySelectorAll(".input > pre")];
      const outputs = [...node.querySelectorAll(".output > pre")];
      if (!inputs.length || inputs.length !== outputs.length) {
        throw new Error(
          "Codeforces sample input/output blocks are incomplete.",
        );
      }
      return inputs
        .map((input, index) => {
          const inputLines = [...input.children].length
            ? [...input.children]
                .map((line) => line.textContent ?? "")
                .join("\n")
            : (input.textContent ?? "");
          const output = outputs[index];
          const outputLines = [...output.children].length
            ? [...output.children]
                .map((line) => line.textContent ?? "")
                .join("\n")
            : (output.textContent ?? "");
          return formatCodeforcesSampleMarkdown(inputLines, outputLines);
        })
        .join("");
    }
    if (node.tagName === "PRE") {
      const lines = [...node.children].length
        ? [...node.children].map((line) => line.textContent ?? "").join("\n")
        : (node.textContent ?? "");
      return `\n\n\`\`\`text\n${normalizePreformattedText(lines)}\n\`\`\`\n\n`;
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
    if (
      node.matches(
        ".sample-test > .input > .title, .sample-test > .output > .title",
      )
    ) {
      return `\n\n## ${node.closest(".input") ? "Input" : "Output"}\n\n`;
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
  clone.querySelectorAll(".section-title").forEach((node) => {
    node.replaceWith(
      Object.assign(document.createElement("h2"), {
        textContent: text(node),
      }),
    );
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
  if (
    statement.querySelector(".sample-test") &&
    !hasStructuredCodeforcesSamples(markdown)
  ) {
    throw new Error(
      "Codeforces samples could not be parsed into separate text blocks.",
    );
  }
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
      adapter_version: "2",
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
