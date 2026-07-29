const RAW_HTML = /<\/?[A-Za-z][^>]*>/g;
const MARKDOWN_IMAGE = /!\[([^\]]*)\]\(([^)]+)\)/g;

export function sanitizeStatementMarkdown(markdown: string, baseUrl: string) {
  const clean = markdown.replace(RAW_HTML, "").replace(/\u0000/g, "");
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
