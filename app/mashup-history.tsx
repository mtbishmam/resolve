"use client";

import { useEffect, useMemo, useState } from "react";
import type { Mashup, ProblemDetail, ProblemListItem } from "@/lib/contracts";

function duration(seconds: number) {
  const value = Math.max(0, Math.floor(seconds));
  const hours = Math.floor(value / 3600);
  const minutes = Math.floor((value % 3600) / 60);
  const remainder = value % 60;
  return [hours, minutes, remainder]
    .map((part) => String(part).padStart(2, "0"))
    .join(":");
}

export default function MashupHistory({
  problems,
  onClose,
}: {
  problems: ProblemListItem[];
  onClose: () => void;
}) {
  const [mashups, setMashups] = useState<Mashup[]>([]);
  const [loading, setLoading] = useState(true);
  const [expanded, setExpanded] = useState<string | null>(null);
  const [copied, setCopied] = useState<string | null>(null);
  const problemsById = useMemo(
    () => new Map(problems.map((problem) => [problem.id, problem])),
    [problems],
  );

  useEffect(() => {
    void fetch("/api/mashups")
      .then((response) => {
        if (!response.ok) throw new Error("Mashup history unavailable");
        return response.json() as Promise<{ mashups: Mashup[] }>;
      })
      .then(({ mashups: value }) => setMashups(value))
      .finally(() => setLoading(false));
  }, []);

  async function copyResult(mashup: Mashup, problemId: string) {
    const response = await fetch(
      `/api/problems/${encodeURIComponent(problemId)}`,
    );
    if (!response.ok) return;
    const { problem } = (await response.json()) as { problem: ProblemDetail };
    const notes = mashup.notesByProblem[problemId] ?? {
      approaches: "",
      lemmas: "",
      analysis: "",
    };
    const packet = [
      "resolve.mashup-result.v1",
      `mashup_id: ${mashup.id}`,
      `problem_id: ${problem.id}`,
      `date: ${mashup.startedAt}`,
      `problem: ${problem.title} (${problem.platform} ${problem.problemKey})`,
      `url: ${problem.url}`,
      "",
      "## Problem statement",
      problem.statementMarkdown,
      "",
      "## Approaches",
      notes.approaches || "Not recorded",
      "",
      "## Lemmas",
      notes.lemmas || "Not recorded",
      "",
      "## Analysis",
      notes.analysis || "Not recorded",
      "",
      "Use the ReSolve MCP record_mashup_result tool with the mashup_id and problem_id above. The problem already exists; do not create a new problem entry.",
    ].join("\n");
    await navigator.clipboard.writeText(packet);
    setCopied(`${mashup.id}:${problemId}`);
    window.setTimeout(() => setCopied(null), 1800);
  }

  async function removeMashup(mashup: Mashup) {
    if (
      !window.confirm("Delete this mashup and all of its saved result notes?")
    )
      return;
    const response = await fetch(
      `/api/mashups/${encodeURIComponent(mashup.id)}`,
      {
        method: "DELETE",
      },
    );
    if (response.ok) {
      setMashups((current) => current.filter((item) => item.id !== mashup.id));
    }
  }

  return (
    <div className="mashup-history-overlay" role="dialog" aria-modal="true">
      <section className="mashup-history-surface">
        <header>
          <div>
            <span>Focused contest archive</span>
            <h1>Mashups</h1>
          </div>
          <button onClick={onClose}>Close</button>
        </header>
        <div className="mashup-history-list">
          {loading ? <p>Loading mashup results…</p> : null}
          {!loading && mashups.length === 0 ? (
            <div className="empty-state">
              <strong>No mashups yet</strong>
              <p>Completed and saved mashups will appear here.</p>
            </div>
          ) : null}
          {mashups.map((mashup) => (
            <article key={mashup.id} className="mashup-result-card">
              <button
                className="mashup-result-summary"
                onClick={() =>
                  setExpanded((value) =>
                    value === mashup.id ? null : mashup.id,
                  )
                }
              >
                <div>
                  <span>
                    {new Intl.DateTimeFormat("en-GB", {
                      dateStyle: "medium",
                      timeStyle: "short",
                    }).format(new Date(mashup.startedAt))}
                  </span>
                  <strong>{mashup.problemIds.length} problem mashup</strong>
                </div>
                <em>
                  {mashup.status} · {duration(mashup.durationSeconds)}
                </em>
                <b>{expanded === mashup.id ? "−" : "+"}</b>
              </button>
              {expanded === mashup.id ? (
                <div className="mashup-result-body">
                  {mashup.problemIds.map((problemId, index) => {
                    const problem = problemsById.get(problemId);
                    const notes = mashup.notesByProblem[problemId] ?? {
                      approaches: "",
                      lemmas: "",
                      analysis: "",
                    };
                    const copyKey = `${mashup.id}:${problemId}`;
                    return (
                      <section key={problemId}>
                        <div className="mashup-result-problem-head">
                          <div>
                            <span>
                              Problem {index + 1} ·{" "}
                              {duration(
                                mashup.elapsedByProblem[problemId] ?? 0,
                              )}
                            </span>
                            <h2>{problem?.title ?? problemId}</h2>
                          </div>
                          <button
                            onClick={() => void copyResult(mashup, problemId)}
                          >
                            {copied === copyKey ? "Copied" : "Copy for ChatGPT"}
                          </button>
                        </div>
                        {(["approaches", "lemmas", "analysis"] as const).map(
                          (field) => (
                            <div className="mashup-result-field" key={field}>
                              <span>{field}</span>
                              <p>{notes[field] || "Not recorded"}</p>
                            </div>
                          ),
                        )}
                      </section>
                    );
                  })}
                  <button
                    className="delete-mashup"
                    onClick={() => void removeMashup(mashup)}
                  >
                    Delete mashup results
                  </button>
                </div>
              ) : null}
            </article>
          ))}
        </div>
      </section>
    </div>
  );
}
