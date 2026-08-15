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
  [/\\leq?(?![A-Za-z])/g, "≤"],
  [/\\geq?(?![A-Za-z])/g, "≥"],
  [/\\lt(?![A-Za-z])/g, "<"],
  [/\\gt(?![A-Za-z])/g, ">"],
  [/\\neq(?![A-Za-z])/g, "≠"],
  [/\\ne(?![A-Za-z])/g, "≠"],
  [/\\equiv(?![A-Za-z])/g, "≡"],
  [/\\(?:dots|ldots|cdots)(?![A-Za-z])/g, "…"],
  [/\\cdot(?![A-Za-z])/g, "·"],
  [/\\times(?![A-Za-z])/g, "×"],
  [/\\infty(?![A-Za-z])/g, "∞"],
  [/\\(?:to|rightarrow)(?![A-Za-z])/g, "→"],
  [/\\leftrightarrow(?![A-Za-z])/g, "↔"],
  [/\\notin(?![A-Za-z])/g, "∉"],
  [/\\in(?![A-Za-z])/g, "∈"],
  [/\\oplus(?![A-Za-z])/g, "⊕"],
  [/\\(?:bmod|mod)(?![A-Za-z])/g, "mod"],
  [/\\mid(?![A-Za-z])/g, "|"],
  [/\\prod(?![A-Za-z])/g, "∏"],
  [/\\sum(?![A-Za-z])/g, "∑"],
  [/\\ell(?![A-Za-z])/g, "ℓ"],
  [/\\lfloor(?![A-Za-z])/g, "⌊"],
  [/\\rfloor(?![A-Za-z])/g, "⌋"],
  [/\\(?:lvert|rvert)(?![A-Za-z])/g, "|"],
  [/\\dagger(?![A-Za-z])/g, "†"],
  [/\\ddagger(?![A-Za-z])/g, "‡"],
];

function normalizeLooseTex(value: string) {
  let clean = value;

  for (let pass = 0; pass < 4; pass += 1) {
    clean = clean.replace(/\\(?:d?frac)\{([^{}]+)\}\{([^{}]+)\}/g, "($1)/($2)");
    clean = clean.replace(/\\color\{[^{}]+\}\{([^{}]*)\}/g, "$1");
    clean = clean.replace(
      /\\(?:mathrm|mathsf|mathtt|mathbf|textrm|texttt|textbf|text|operatorname|underline|underbrace|cancel)\{([^{}]*)\}/g,
      "$1",
    );
  }

  for (const [pattern, replacement] of TEX_REPLACEMENTS) {
    clean = clean.replace(pattern, replacement);
  }

  clean = clean
    .replace(/\\(?:left|right|limits|displaystyle|Big|require|tt)\b/g, "")
    .replace(/\\([&%])/g, "$1")
    .replace(/\\\s+/g, " ");

  return clean;
}

function isSymbolicInputBlock(value: string) {
  const lines = value
    .trim()
    .split("\n")
    .map((line) => line.trim())
    .filter(Boolean);
  if (lines.length === 0 || lines.length > 12) return false;
  if (lines.some((line) => line.length > 180)) return false;

  const words = lines
    .join(" ")
    .replace(/\\[A-Za-z]+/g, "")
    .replace(/\.\.\./g, "")
    .match(/[A-Za-z]+/g);
  return Boolean(words?.length && words.every((word) => word.length <= 3));
}

function symbolicLineToTex(value: string) {
  return value
    .trim()
    .replace(/^\$|\$$/g, "")
    .replace(/\.\.\./g, "\\ldots")
    .replace(/<=/g, "\\le ")
    .replace(/>=/g, "\\ge ")
    .replace(/\s+/g, " \\quad ");
}

export function normalizeSymbolicInputBlocks(value: string) {
  const lines = value.split("\n");
  const output: string[] = [];
  let section = "";

  for (let index = 0; index < lines.length; index += 1) {
    const line = lines[index];
    const heading = line.match(/^#{1,6}\s+(.+?)\s*$/);
    if (heading) section = heading[1].trim().toLowerCase();

    const fence = line.match(/^```(?:text|plaintext)?\s*$/i);
    if (!fence) {
      output.push(line);
      continue;
    }

    const block: string[] = [];
    let end = index + 1;
    while (end < lines.length && !/^```\s*$/.test(lines[end])) {
      block.push(lines[end]);
      end += 1;
    }

    const isInputFormat = /^(?:input|input format)$/.test(section);
    if (
      end < lines.length &&
      isInputFormat &&
      isSymbolicInputBlock(block.join("\n"))
    ) {
      output.push(
        "$$",
        "\\begin{gathered}",
        block
          .map(symbolicLineToTex)
          .filter(Boolean)
          .join(" \\\\" + "\n"),
        "\\end{gathered}",
        "$$",
      );
      index = end;
      continue;
    }

    output.push(line, ...block);
    if (end < lines.length) {
      output.push(lines[end]);
      index = end;
    }
  }

  return output.join("\n");
}

export function normalizeStatementText(value: string) {
  return normalizeSymbolicInputBlocks(value)
    .split(/(```[\s\S]*?```|`[^`]*`|\$\$[\s\S]*?\$\$|\$[^$\n]*\$)/g)
    .map((part) => {
      if (/^(`|\$)/.test(part)) return part;
      let clean = normalizeLooseTex(part);
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
  children = "",
  className = "",
  statement = false,
}: {
  children?: string;
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
