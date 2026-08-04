"use client";

import ReactMarkdown from "react-markdown";
import rehypeKatex from "rehype-katex";
import rehypeSanitize, { defaultSchema } from "rehype-sanitize";
import remarkGfm from "remark-gfm";
import remarkMath from "remark-math";

const schema = {
  ...defaultSchema,
  attributes: {
    ...defaultSchema.attributes,
    code: [...(defaultSchema.attributes?.code ?? []), ["className"]],
    span: [...(defaultSchema.attributes?.span ?? []), ["className"]],
    div: [...(defaultSchema.attributes?.div ?? []), ["className"]],
  },
};

const TEX_REPLACEMENTS: Array<[RegExp, string]> = [
  [/\\leq?\b/g, "≤"],
  [/\\geq?\b/g, "≥"],
  [/\\neq\b/g, "≠"],
  [/\\(?:dots|ldots)\b/g, "…"],
  [/\\cdot\b/g, "·"],
  [/\\times\b/g, "×"],
  [/\\infty\b/g, "∞"],
  [/\\to\b/g, "→"],
];

export function normalizeStatementText(value: string) {
  return value
    .split(/(```[\s\S]*?```|`[^`]*`|\$\$[\s\S]*?\$\$|\$[^$\n]*\$)/g)
    .map((part) => {
      if (/^(`|\$)/.test(part)) return part;
      let clean = part;
      for (const [pattern, replacement] of TEX_REPLACEMENTS) {
        clean = clean.replace(pattern, replacement);
      }
      // Captured Codeforces statements sometimes lose MathJax delimiters.
      // Array subscripts are clearer as indexed text than raw TeX in that case.
      for (let pass = 0; pass < 3; pass += 1) {
        clean = clean.replace(/([A-Za-z0-9])_\{([^{}]+)\}/g, "$1[$2]");
        clean = clean.replace(/([A-Za-z0-9])_([A-Za-z0-9]+)/g, "$1[$2]");
      }
      return clean;
    })
    .join("");
}

export default function Markdown({
  children,
  className = "",
  statement = false,
}: {
  children: string;
  className?: string;
  statement?: boolean;
}) {
  return (
    <div className={`markdown ${className}`}>
      <ReactMarkdown
        remarkPlugins={[remarkGfm, remarkMath]}
        rehypePlugins={[[rehypeSanitize, schema], rehypeKatex]}
        components={{
          a: (props) => <a {...props} target="_blank" rel="noreferrer" />,
          img: ({ src, alt }) => (
            <figure>
              {/* eslint-disable-next-line @next/next/no-img-element */}
              <img src={src ?? ""} alt={alt ?? ""} loading="lazy" />
              {alt ? <figcaption>{alt}</figcaption> : null}
            </figure>
          ),
        }}
      >
        {statement ? normalizeStatementText(children) : children}
      </ReactMarkdown>
    </div>
  );
}
