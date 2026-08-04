"use client";

import {
  lazy,
  Suspense,
  useCallback,
  useEffect,
  useMemo,
  useRef,
  useState,
} from "react";
import type { Mashup, ProblemDetail, ProblemListItem } from "@/lib/contracts";

const MarkdownContent = lazy(() => import("./markdown"));

function formatClock(seconds: number) {
  const value = Math.max(0, Math.floor(seconds));
  const hours = Math.floor(value / 3600);
  const minutes = Math.floor((value % 3600) / 60);
  const remainder = value % 60;
  return [hours, minutes, remainder]
    .map((part) => String(part).padStart(2, "0"))
    .join(":");
}

export default function MashupSurface({
  initialMashup,
  problems,
  onClose,
  onComplete,
}: {
  initialMashup: Mashup;
  problems: ProblemListItem[];
  onClose: () => void;
  onComplete: () => Promise<void>;
}) {
  const [mashup, setMashup] = useState(initialMashup);
  const [activeId, setActiveId] = useState(
    initialMashup.activeProblemId ?? initialMashup.problemIds[0],
  );
  const [details, setDetails] = useState<Record<string, ProblemDetail>>({});
  const [elapsed, setElapsed] = useState(initialMashup.elapsedByProblem);
  const elapsedRef = useRef(initialMashup.elapsedByProblem);
  const [now, setNow] = useState(() => Date.now());
  const [saving, setSaving] = useState(false);
  const selected = useMemo(
    () =>
      mashup.problemIds
        .map((id) => problems.find((problem) => problem.id === id))
        .filter((problem): problem is ProblemListItem => Boolean(problem)),
    [mashup.problemIds, problems],
  );
  const activeProblem = selected.find((problem) => problem.id === activeId);
  const activeDetail = activeId ? details[activeId] : undefined;
  const globalElapsed = Math.max(
    0,
    Math.floor((now - Date.parse(mashup.startedAt)) / 1000),
  );
  const remaining = mashup.durationSeconds - globalElapsed;

  const persist = useCallback(
    async (
      patch: Partial<{
        active_problem_id: string | null;
        elapsed_by_problem: Record<string, number>;
        status: "active" | "completed";
      }> = {},
    ) => {
      const response = await fetch(`/api/mashups/${mashup.id}`, {
        method: "PATCH",
        headers: { "content-type": "application/json" },
        body: JSON.stringify({
          active_problem_id: activeId,
          elapsed_by_problem: elapsedRef.current,
          ...patch,
        }),
      });
      if (!response.ok) throw new Error("Mashup save failed");
      const data = (await response.json()) as { mashup: Mashup };
      setMashup(data.mashup);
      return data.mashup;
    },
    [activeId, mashup.id],
  );

  useEffect(() => {
    elapsedRef.current = elapsed;
  }, [elapsed]);

  useEffect(() => {
    const timer = window.setInterval(() => {
      setNow(Date.now());
      setElapsed((current) => ({
        ...current,
        [activeId]: (current[activeId] ?? 0) + 1,
      }));
    }, 1000);
    return () => window.clearInterval(timer);
  }, [activeId]);

  useEffect(() => {
    if (!activeId || details[activeId]) return;
    let cancelled = false;
    void fetch(`/api/problems/${encodeURIComponent(activeId)}`)
      .then((response) => {
        if (!response.ok) throw new Error("Statement unavailable");
        return response.json() as Promise<{ problem: ProblemDetail }>;
      })
      .then(({ problem }) => {
        if (!cancelled) {
          setDetails((current) => ({ ...current, [activeId]: problem }));
        }
      });
    return () => {
      cancelled = true;
    };
  }, [activeId, details]);

  useEffect(() => {
    const timer = window.setInterval(() => void persist(), 15_000);
    return () => window.clearInterval(timer);
  }, [persist]);

  async function changeProblem(problemId: string) {
    await persist({ active_problem_id: problemId });
    setActiveId(problemId);
  }

  async function complete() {
    setSaving(true);
    try {
      await persist({ status: "completed" });
      await onComplete();
    } finally {
      setSaving(false);
    }
  }

  return (
    <div className="mashup-overlay">
      <section className="mashup-surface">
        <header className="mashup-header">
          <div>
            <span>Focused mashup</span>
            <strong className={remaining < 0 ? "timer overtime" : "timer"}>
              {remaining < 0 ? "+" : ""}
              {formatClock(Math.abs(remaining))}
            </strong>
            <em>{formatClock(globalElapsed)} elapsed</em>
          </div>
          <div className="mashup-actions">
            <button
              onClick={() => {
                void persist().then(onClose);
              }}
            >
              Save & exit
            </button>
            <button
              className="primary"
              disabled={saving}
              onClick={() => void complete()}
            >
              {saving ? "Saving…" : "Finish mashup"}
            </button>
          </div>
        </header>

        <nav className="mashup-tabs" aria-label="Mashup problems">
          {selected.map((problem, index) => (
            <button
              key={problem.id}
              className={activeId === problem.id ? "active" : ""}
              onClick={() => void changeProblem(problem.id)}
            >
              <span>{index + 1}</span>
              <strong>{problem.title}</strong>
              <em>{formatClock(elapsed[problem.id] ?? 0)}</em>
            </button>
          ))}
        </nav>

        <article className="mashup-problem">
          {activeProblem ? (
            <div className="mashup-problem-title">
              <div>
                <span>
                  Codeforces · {activeProblem.problemKey} ·{" "}
                  {activeProblem.rating}
                </span>
                <h1>{activeProblem.title}</h1>
              </div>
              <a href={activeDetail?.url} target="_blank" rel="noreferrer">
                Open judge ↗
              </a>
            </div>
          ) : null}
          {activeDetail ? (
            <Suspense fallback={<p>Loading statement…</p>}>
              <MarkdownContent className="markdown-content">
                {activeDetail.statementMarkdown}
              </MarkdownContent>
            </Suspense>
          ) : (
            <p>Loading the stored problem statement…</p>
          )}
        </article>
      </section>
    </div>
  );
}
