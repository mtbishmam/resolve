const RAW_HTML = /<\/?[A-Za-z][^>]*>/g;
const MARKDOWN_IMAGE = /!\[([^\]]*)\]\(([^)]+)\)/g;

/** Repair common escaping introduced when captured Markdown crosses a JSON/clipboard boundary. */
export function normalizeCapturedMarkdown(markdown: string) {
  return markdown
    .replace(/\\(`{1,3})/g, "$1")
    .replace(/\\\[([\s\S]*?)\\\]/g, (_match, body: string) => `$$${body}$$`)
    .replace(/\\\(([^\n]*?)\\\)/g, (_match, body: string) => `$${body}$`);
}

export function sanitizeStatementMarkdown(markdown: string, baseUrl: string) {
  const clean = normalizeCapturedMarkdown(
    markdown.replace(RAW_HTML, "").replace(/\u0000/g, ""),
  );
  return clean.replace(
    MARKDOWN_IMAGE,
    (_match, alt: string, rawUrl: string) => {
      try {
        const absolute = new URL(rawUrl.trim(), baseUrl);
        if (!["https:", "http:"].includes(absolute.protocol)) return alt;
        return `![${alt}](${absolute.toString()})`;
      } catch {
        return alt;
      }
    },
  );
}
