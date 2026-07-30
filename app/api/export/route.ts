import { authorizeBrowserRequest } from "@/lib/auth";
import {
  getProblemById,
  listProblems,
  listSavedViews,
  listSprints,
} from "@/db/queries";
import { getD1 } from "@/db/index";

export const dynamic = "force-dynamic";

export async function GET(request: Request) {
  if (!(await authorizeBrowserRequest(request))) {
    return Response.json({ error: "Unauthorized" }, { status: 401 });
  }
  const format = new URL(request.url).searchParams.get("format") ?? "json";
  const problems = await listProblems();
  const details = await Promise.all(
    problems.map((problem) => getProblemById(problem.id)),
  );
  if (format === "json") {
    return new Response(
      JSON.stringify(
        {
          schema: "resolve.export.v1",
          exportedAt: new Date().toISOString(),
          problems: details,
          savedViews: await listSavedViews(),
          sprints: await listSprints(),
        },
        null,
        2,
      ),
      {
        headers: {
          "content-type": "application/json; charset=utf-8",
          "content-disposition": 'attachment; filename="resolve-export.json"',
        },
      },
    );
  }
  if (format === "markdown") {
    const body = details
      .filter(Boolean)
      .map((problem) => {
        const reflection = problem!.reflection;
        return [
          `# ${problem!.title}`,
          `${problem!.platform} · ${problem!.problemKey}`,
          reflection ? `## Memory cue\n\n${reflection.memoryCue}` : "",
          reflection
            ? `## Reflection\n\n${reflection.summaryMarkdown}`
            : "## Reflection\n\nNot captured",
          `## Next review\n\n${problem!.nextReviewDate ?? "Not scheduled"}`,
        ]
          .filter(Boolean)
          .join("\n\n");
      })
      .join("\n\n---\n\n");
    return new Response(body, {
      headers: {
        "content-type": "text/markdown; charset=utf-8",
        "content-disposition": 'attachment; filename="resolve-export.md"',
      },
    });
  }
  if (format === "sql") {
    const d1 = await getD1();
    const tableNames = [
      "problems",
      "reflections",
      "reviews",
      "saved_views",
      "sprints",
    ];
    const output: string[] = [
      "-- ReSolve provider-independent data export",
      "BEGIN TRANSACTION;",
    ];
    for (const table of tableNames) {
      const rows = await d1
        .prepare(`SELECT * FROM ${table}`)
        .all<Record<string, unknown>>();
      for (const row of rows.results ?? []) {
        const columns = Object.keys(row);
        const values = columns.map((column) => {
          const value = row[column];
          if (value === null) return "NULL";
          if (typeof value === "number") return String(value);
          return `'${String(value).replaceAll("'", "''")}'`;
        });
        output.push(
          `INSERT INTO ${table} (${columns.join(", ")}) VALUES (${values.join(", ")});`,
        );
      }
    }
    output.push("COMMIT;");
    return new Response(output.join("\n"), {
      headers: {
        "content-type": "application/sql; charset=utf-8",
        "content-disposition": 'attachment; filename="resolve-export.sql"',
      },
    });
  }
  return Response.json({ error: "Unknown export format" }, { status: 400 });
}
