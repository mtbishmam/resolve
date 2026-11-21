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
import { createPortal } from "react-dom";
import type {
  Mashup,
  ProblemDetail,
  ProblemListItem,
  UpdateMashupInput,
} from "@/lib/contracts";
import {
  mashupDraftKey,
  parseMashupDraft,
  type MashupDraft,
} from "@/lib/mashup-draft";
import type { PracticeNoteField } from "@/lib/practice-notes";
import {
  MASHUP_PROBLEM_LIMIT_SECONDS,
  MASHUP_TAB_KEY,
  mashupClock,
} from "@/lib/mashup-clock";
import PracticeNoteFields from "./practice-note-fields";

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
  local,
}: {
  initialMashup: Mashup;
  problems: ProblemListItem[];
  onClose: (mashup: Mashup) => void;
  onComplete: () => Promise<void>;
  local: boolean;
}) {
  const [mashup, setMashup] = useState(initialMashup);
  const draftKey = mashupDraftKey(initialMashup.id);
  const [initialDraft] = useState<MashupDraft>(() => {
    try {
      return parseMashupDraft(
        sessionStorage.getItem(draftKey),
        initialMashup.problemIds,
      );
    } catch {
      return { notes: {} };
    }
  });
  const [activeId, setActiveId] = useState(
    initialDraft.activeProblemId ??
      initialMashup.activeProblemId ??
      initialMashup.problemIds[0],
  );
  const [details, setDetails] = useState<Record<string, ProblemDetail>>({});
  const [pendingNotes, setPendingNotes] = useState(initialDraft.notes);
  const draft = useRef<MashupDraft>(initialDraft);
  const [draftError, setDraftError] = useState(false);
  const saves = useRef<Promise<unknown>>(Promise.resolve());
  const [now, setNow] = useState(() => Date.now());
  const [saving, setSaving] = useState(false);
  const [error, setError] = useState("");
  const endpoint = `/api/mashups/${initialMashup.id}`;
  const selected = useMemo(
    () =>
      mashup.problemIds
        .map((id) => problems.find((problem) => problem.id === id))
        .filter((problem): problem is ProblemListItem => Boolean(problem)),
    [mashup.problemIds, problems],
  );
  const activeProblem = selected.find((problem) => problem.id === activeId);
  const activeDetail = activeId ? details[activeId] : undefined;
  const clock = mashupClock(mashup, now);
  const globalElapsed = clock.elapsed;
  const remaining = mashup.durationSeconds - globalElapsed;

  const storeDraft = useCallback(() => {
    try {
      if (
        draft.current.activeProblemId ||
        Object.keys(draft.current.notes).length
      ) {
        sessionStorage.setItem(draftKey, JSON.stringify(draft.current));
      } else {
        sessionStorage.removeItem(draftKey);
      }
      setDraftError(false);
    } catch {
      setDraftError(true);
    }
  }, [draftKey]);

  const persist = useCallback(
    (patch: UpdateMashupInput = {}) => {
      const save = saves.current
        .catch(() => undefined)
        .then(async () => {
          const pending = draft.current;
          const response = await fetch(endpoint, {
            method: "PATCH",
            headers: { "content-type": "application/json" },
            body: JSON.stringify({
              ...patch,
              ...(pending.activeProblemId
                ? { active_problem_id: pending.activeProblemId }
                : {}),
              ...(Object.keys(pending.notes).length
                ? { notes_by_problem: pending.notes }
                : {}),
            }),
            signal: AbortSignal.timeout(10_000),
          });
          if (!response.ok)
            throw new Error("Mashup save failed. Please retry.");
          const data = (await response.json()) as { mashup: Mashup };
          const notes = { ...draft.current.notes };
          for (const [id, value] of Object.entries(pending.notes)) {
            if (notes[id] === value) delete notes[id];
          }
          draft.current = {
            activeProblemId:
              draft.current.activeProblemId === pending.activeProblemId
                ? undefined
                : draft.current.activeProblemId,
            notes,
          };
          if (Object.keys(pending.notes).length) setPendingNotes(notes);
          storeDraft();
          setMashup((current) =>
            data.mashup.revision >= current.revision ? data.mashup : current,
          );
          setNow(Date.now());
          setError("");
          return data.mashup;
        });
      saves.current = save;
      return save;
    },
    [endpoint, storeDraft],
  );

  useEffect(() => {
    if (!Object.keys(pendingNotes).length && !draft.current.activeProblemId)
      return;
    const timer = window.setTimeout(() => {
      void persist().catch(() =>
        setError("Could not save mashup notes. Retrying at the next check-in."),
      );
    }, 800);
    return () => window.clearTimeout(timer);
  }, [pendingNotes, persist]);

  useEffect(() => {
    const timer = window.setInterval(() => {
      setNow(Date.now());
    }, 1000);
    return () => window.clearInterval(timer);
  }, []);

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
      })
      .catch(() => {
        if (!cancelled) setError("The stored statement is unavailable.");
      });
    return () => {
      cancelled = true;
    };
  }, [activeId, details]);

  useEffect(() => {
    sessionStorage.setItem(MASHUP_TAB_KEY, initialMashup.id);
    function refreshClock() {
      if (document.hidden) return;
      void fetch(endpoint, {
        cache: "no-store",
        signal: AbortSignal.timeout(8_000),
      })
        .then(async (response) => {
          if (!response.ok) return;
          const { mashup: next } = (await response.json()) as {
            mashup: Mashup;
          };
          setMashup((current) =>
            next.revision >= current.revision ? next : current,
          );
          setNow(Date.now());
        })
        .catch(() => undefined);
    }
    function pauseOnExit() {
      const body = new Blob(["{}"], { type: "application/json" });
      if (navigator.sendBeacon?.(endpoint, body)) return;
      void fetch(endpoint, {
        method: "POST",
        headers: { "content-type": "application/json" },
        body,
        keepalive: true,
      }).catch(() => undefined);
    }
    function restorePage(event: PageTransitionEvent) {
      if (event.persisted) {
        void persist({ clock_action: "recover" }).catch(() => refreshClock());
      } else {
        refreshClock();
      }
    }
    const heartbeat = window.setInterval(() => {
      void persist({ clock_action: "heartbeat" }).catch(() =>
        setError("Could not check in with the local timer."),
      );
    }, 20_000);
    const refresh = window.setInterval(refreshClock, 2000);
    window.addEventListener("focus", refreshClock);
    window.addEventListener("pagehide", pauseOnExit);
    window.addEventListener("pageshow", restorePage);
    document.addEventListener("visibilitychange", refreshClock);
    return () => {
      window.clearInterval(heartbeat);
      window.clearInterval(refresh);
      window.removeEventListener("focus", refreshClock);
      window.removeEventListener("pagehide", pauseOnExit);
      window.removeEventListener("pageshow", restorePage);
      document.removeEventListener("visibilitychange", refreshClock);
    };
  }, [endpoint, initialMashup.id, persist]);

  async function changeProblem(problemId: string) {
    setActiveId(problemId);
    draft.current = { ...draft.current, activeProblemId: problemId };
    storeDraft();
    await persist().catch(() => setError("Could not save problem selection."));
  }

  async function changeClock(action: "pause" | "resume" | "finish") {
    setSaving(true);
    try {
      const updated = await persist({ clock_action: action });
      if (action !== "resume") sessionStorage.removeItem(MASHUP_TAB_KEY);
      if (action === "pause") onClose(updated);
      if (action === "finish") await onComplete();
    } catch (error) {
      setError(
        error instanceof Error ? error.message : "Could not save mashup.",
      );
    } finally {
      setSaving(false);
    }
  }

  function updateNote(field: PracticeNoteField, value: string) {
    if (!activeId) return;
    const updated = {
      ...draft.current.notes[activeId],
      [field]: value,
    };
    const notes = { ...draft.current.notes, [activeId]: updated };
    draft.current = { ...draft.current, notes };
    storeDraft();
    setPendingNotes(notes);
  }

  const activeNotes = {
    ...mashup.notesByProblem[activeId],
    ...pendingNotes[activeId],
  };

  return createPortal(
    <div className="mashup-overlay">
      <section className="mashup-surface">
        <div className="mashup-sticky">
          <header className="mashup-header">
            <div>
              <span>Focused mashup</span>
              <strong className={remaining < 0 ? "timer overtime" : "timer"}>
                {remaining < 0 ? "+" : ""}
                {formatClock(Math.abs(remaining))}
              </strong>
              <em>
                {clock.waiting
                  ? `Starts in ${formatClock(Math.ceil((Date.parse(mashup.startedAt) - now) / 1000))}`
                  : !clock.running
                    ? "Paused"
                    : `${formatClock(globalElapsed)} elapsed`}
              </em>
            </div>
            <div className="mashup-actions">
              {!clock.running ? (
                <button
                  disabled={saving}
                  onClick={() => void changeClock("resume")}
                >
                  Resume
                </button>
              ) : null}
              <button
                disabled={saving}
                onClick={() => void changeClock("pause")}
              >
                Pause & exit
              </button>
              <button
                className="primary"
                disabled={saving}
                onClick={() => void changeClock("finish")}
              >
                {saving ? "Saving…" : "Finish mashup"}
              </button>
            </div>
          </header>

          <nav className="mashup-tabs" aria-label="Mashup problems">
            {selected.map((problem, index) => {
              const elapsed = clock.byProblem[problem.id] ?? 0;
              const timeUp = elapsed >= MASHUP_PROBLEM_LIMIT_SECONDS;
              const ticking =
                !timeUp &&
                clock.running &&
                !clock.waiting &&
                mashup.trackedProblemId === problem.id;
              return (
                <button
                  key={problem.id}
                  className={activeId === problem.id ? "active" : ""}
                  onClick={() => void changeProblem(problem.id)}
                >
                  <span>{index + 1}</span>
                  <strong>{problem.title}</strong>
                  <em>
                    {formatClock(elapsed)}
                    {timeUp ? " · time up" : ticking ? " · tracking" : ""}
                  </em>
                </button>
              );
            })}
          </nav>
        </div>
        {error ? (
          <p className="mashup-notice form-error" role="alert">
            {error}
          </p>
        ) : null}
        {draftError ? (
          <p className="mashup-notice form-error" role="alert">
            Browser draft storage is unavailable. Wait for autosave before
            refreshing.
          </p>
        ) : null}
        {local ? (
          <p className="mashup-notice">
            The ReSolve extension shows the same problem timer on judge pages
            and advances after one hour. Keep this mashup open in a separate
            tab.
          </p>
        ) : null}

        <article className="mashup-problem">
          <div className="mashup-statement">
            {activeProblem ? (
              <div className="mashup-problem-title">
                <div>
                  <span>
                    {activeProblem.platform} · {activeProblem.problemKey} ·{" "}
                    {activeProblem.rating ?? "Unrated"}
                  </span>
                  <h1>{activeProblem.title}</h1>
                </div>
                {activeDetail?.url ? (
                  <a href={activeDetail.url} target="_blank" rel="noreferrer">
                    Open judge ↗
                  </a>
                ) : null}
              </div>
            ) : null}
            {activeDetail ? (
              <Suspense fallback={<p>Loading statement…</p>}>
                <MarkdownContent className="markdown-content" statement>
                  {activeDetail.statementMarkdown}
                </MarkdownContent>
              </Suspense>
            ) : (
              <p>Loading the stored problem statement…</p>
            )}
          </div>
          <aside className="mashup-notes">
            <div>
              <span>Working result</span>
              <em role="status">
                {Object.keys(pendingNotes).length
                  ? "Saving notes…"
                  : "Saved automatically"}
              </em>
            </div>
            <PracticeNoteFields
              notes={activeNotes}
              onChange={updateNote}
              disabled={saving}
            />
          </aside>
        </article>
      </section>
    </div>,
    document.body,
  );
}
