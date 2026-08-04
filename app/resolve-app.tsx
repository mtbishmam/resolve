"use client";

import {
  createColumnHelper,
  flexRender,
  getCoreRowModel,
  getSortedRowModel,
  type SortingState,
  type VisibilityState,
  useReactTable,
} from "@tanstack/react-table";
import { useVirtualizer } from "@tanstack/react-virtual";
import { get as idbGet, set as idbSet } from "idb-keyval";
import Image from "next/image";
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
import {
  DIFFICULTIES,
  matchesRatingRange,
  type Difficulty,
} from "@/lib/difficulty";
import { INITIAL_INTERVALS, addCalendarDays } from "@/lib/schedule";
import {
  PROBLEM_STATES,
  PROBLEM_STATUSES,
  STATE_DEFINITIONS,
  reviewTimerMinutes,
  type ProblemState,
  type ProblemStatus,
} from "@/lib/workflow";
import MashupSurface from "./mashup-surface";
import MashupHistory from "./mashup-history";

const MarkdownContent = lazy(() => import("./markdown"));

function Markdown({
  children,
  className,
  statement = false,
}: {
  children: string;
  className?: string;
  statement?: boolean;
}) {
  return (
    <Suspense fallback={<div className="markdown-loading">Loading text…</div>}>
      <MarkdownContent className={className} statement={statement}>
        {children}
      </MarkdownContent>
    </Suspense>
  );
}

type Viewer = { displayName: string; email: string };
type SavedView = {
  id: string;
  name: string;
  filter: {
    due?: "today";
    state?: ProblemState[];
    status?: ProblemStatus[];
    tags?: string[];
    archived?: boolean;
    search?: string;
    platform?: string;
    difficulty?: Difficulty;
    ratingStart?: number;
    ratingEnd?: number;
  };
  sort: SortingState;
  visibleColumns: string[];
  isDefault: boolean;
  isCore: boolean;
};
type Sprint = {
  id: string;
  name: string;
  month: string;
  source: string | null;
  target: Record<string, unknown>;
  startsOn: string;
  endsOn: string;
};
type Reveal =
  | "none"
  | "memory_cue"
  | "key_insight"
  | "full_reflection"
  | "source";
type Outcome = keyof typeof INITIAL_INTERVALS;

const CACHE_KEY = "resolve.problem-index.v2";
const COLUMN_CACHE_KEY = "resolve.column-visibility.v1";
const detailCacheKey = (id: string) => `resolve.problem-detail.v1:${id}`;
const REVEALS: Reveal[] = [
  "none",
  "memory_cue",
  "key_insight",
  "full_reflection",
  "source",
];
const columnHelper = createColumnHelper<ProblemListItem>();

function todayDhaka() {
  return new Intl.DateTimeFormat("en-CA", {
    timeZone: "Asia/Dhaka",
    year: "numeric",
    month: "2-digit",
    day: "2-digit",
  }).format(new Date());
}

function formatTimer(seconds: number) {
  const value = Math.max(0, Math.floor(seconds));
  const hours = Math.floor(value / 3600);
  const minutes = Math.floor((value % 3600) / 60);
  const remainder = value % 60;
  return hours
    ? [hours, minutes, remainder]
        .map((part) => String(part).padStart(2, "0"))
        .join(":")
    : [minutes, remainder]
        .map((part) => String(part).padStart(2, "0"))
        .join(":");
}

function localDateTimeInput(date = new Date()) {
  const offset = date.getTimezoneOffset() * 60_000;
  return new Date(date.getTime() - offset).toISOString().slice(0, 16);
}

function dateLabel(date: string | null) {
  if (!date) return "Not scheduled";
  const today = todayDhaka();
  if (date === today) return "Today";
  if (date < today) {
    const delta = Math.round(
      (Date.parse(`${today}T00:00:00Z`) - Date.parse(`${date}T00:00:00Z`)) /
        86_400_000,
    );
    return `${delta}d overdue`;
  }
  return new Intl.DateTimeFormat("en-US", {
    month: "short",
    day: "numeric",
    timeZone: "Asia/Dhaka",
  }).format(new Date(`${date}T00:00:00+06:00`));
}

function statusLabel(status: string) {
  return status.charAt(0).toUpperCase() + status.slice(1);
}

function platformLabel(platform: string) {
  if (platform === "codeforces") return "Codeforces";
  if (platform === "cses") return "CSES";
  return "AtCoder";
}

function DifficultyTag({ difficulty }: { difficulty: Difficulty | null }) {
  if (!difficulty) return <span className="difficulty-empty">—</span>;
  return (
    <span className={`difficulty difficulty-${difficulty}`}>
      {statusLabel(difficulty)}
    </span>
  );
}

function Secondary({ problem }: { problem: ProblemListItem }) {
  return (
    <span className="secondary">
      {problem.contest}
      {problem.problemIndex ? ` · ${problem.problemIndex}` : ""}
    </span>
  );
}

function matchesSavedView(
  problem: ProblemListItem,
  filter: SavedView["filter"],
  today: string,
) {
  const query = filter.search?.trim().toLowerCase() ?? "";
  return (
    (filter.due !== "today" ||
      ((problem.dueDate ?? problem.nextReviewDate) !== null &&
        (problem.dueDate ?? problem.nextReviewDate)! <= today)) &&
    (filter.archived === undefined ||
      filter.archived === (problem.archivedAt !== null)) &&
    (!filter.state?.length ||
      (problem.state !== null && filter.state.includes(problem.state))) &&
    (!filter.status?.length ||
      (problem.status !== null && filter.status.includes(problem.status))) &&
    (!filter.tags?.length ||
      filter.tags.every((tag) => problem.officialTags.includes(tag))) &&
    (!filter.platform ||
      filter.platform === "all" ||
      filter.platform === problem.platform) &&
    (!filter.difficulty || filter.difficulty === problem.difficulty) &&
    matchesRatingRange(
      problem,
      filter.ratingStart ?? null,
      filter.ratingEnd ?? null,
    ) &&
    (!query ||
      [
        problem.title,
        problem.platform,
        problem.problemKey,
        problem.contest ?? "",
      ]
        .join(" ")
        .toLowerCase()
        .includes(query))
  );
}

export default function ReSolveApp({
  viewer,
  local,
}: {
  viewer: Viewer;
  local: boolean;
}) {
  const [problems, setProblems] = useState<ProblemListItem[]>([]);
  const [views, setViews] = useState<SavedView[]>([]);
  const [sprints, setSprints] = useState<Sprint[]>([]);
  const [activeSprintId, setActiveSprintId] = useState<string | null>(null);
  const [selectedProblemIds, setSelectedProblemIds] = useState<Set<string>>(
    new Set(),
  );
  const [mashupBuilderOpen, setMashupBuilderOpen] = useState(false);
  const [mashupStart, setMashupStart] = useState(localDateTimeInput);
  const [mashupHours, setMashupHours] = useState("5");
  const [mashupError, setMashupError] = useState("");
  const [creatingMashup, setCreatingMashup] = useState(false);
  const [activeMashup, setActiveMashup] = useState<Mashup | null>(null);
  const [profileOpen, setProfileOpen] = useState(false);
  const [mashupHistoryOpen, setMashupHistoryOpen] = useState(false);
  const [offlineProgress, setOfflineProgress] = useState<string | null>(null);
  const [activeViewId, setActiveViewId] = useState("view-due-today");
  const [selectedId, setSelectedId] = useState<string | null>(null);
  const [detail, setDetail] = useState<ProblemDetail | null>(null);
  const [detailLoading, setDetailLoading] = useState(false);
  const [search, setSearch] = useState("");
  const [stateFilter, setStateFilter] = useState<ProblemState[]>([]);
  const [workflowStatusFilter, setWorkflowStatusFilter] = useState<
    ProblemStatus[]
  >([]);
  const [tagFilter, setTagFilter] = useState<string[]>([]);
  const [platformFilter, setPlatformFilter] = useState("all");
  const [difficultyFilter, setDifficultyFilter] = useState<Difficulty | "all">(
    "all",
  );
  const [ratingStart, setRatingStart] = useState("");
  const [ratingEnd, setRatingEnd] = useState("");
  const [sorting, setSorting] = useState<SortingState>([
    { id: "dueDate", desc: false },
  ]);
  const [visibility, setVisibility] = useState<VisibilityState>({});
  const [visibilityReady, setVisibilityReady] = useState(false);
  const [filtersOpen, setFiltersOpen] = useState(false);
  const [columnsOpen, setColumnsOpen] = useState(false);
  const [reviewOpen, setReviewOpen] = useState(false);
  const [syncing, setSyncing] = useState(true);
  const [mobileSection, setMobileSection] = useState("today");
  const [drawerWidth, setDrawerWidth] = useState(720);
  const [fullPage, setFullPage] = useState(false);
  const searchRef = useRef<HTMLInputElement>(null);
  const today = todayDhaka();

  const refresh = useCallback(async () => {
    setSyncing(true);
    try {
      const [problemResponse, viewResponse, sprintResponse] = await Promise.all(
        [
          fetch("/api/problems"),
          fetch("/api/saved-views"),
          fetch("/api/sprints"),
        ],
      );
      if (!problemResponse.ok || !viewResponse.ok || !sprintResponse.ok) {
        throw new Error("Unable to refresh ReSolve");
      }
      const problemData = (await problemResponse.json()) as {
        problems: ProblemListItem[];
      };
      const viewData = (await viewResponse.json()) as { views: SavedView[] };
      const sprintData = (await sprintResponse.json()) as { sprints: Sprint[] };
      setProblems(problemData.problems);
      setViews(viewData.views);
      setSprints(sprintData.sprints);
      await idbSet(CACHE_KEY, problemData.problems);
    } finally {
      setSyncing(false);
    }
  }, []);

  useEffect(() => {
    let cancelled = false;
    void idbGet<ProblemListItem[]>(CACHE_KEY).then((cached) => {
      if (!cancelled && cached?.length) setProblems(cached);
    });
    void refresh();
    return () => {
      cancelled = true;
    };
  }, [refresh]);

  useEffect(() => {
    void idbGet<VisibilityState>(COLUMN_CACHE_KEY).then((cached) => {
      if (cached) setVisibility(cached);
      setVisibilityReady(true);
    });
    if ("serviceWorker" in navigator) {
      void navigator.serviceWorker.register("/sw.js");
    }
  }, []);

  useEffect(() => {
    if (visibilityReady) void idbSet(COLUMN_CACHE_KEY, visibility);
  }, [visibility, visibilityReady]);

  useEffect(() => {
    function focusSearch(event: KeyboardEvent) {
      if ((event.metaKey || event.ctrlKey) && event.key.toLowerCase() === "k") {
        event.preventDefault();
        searchRef.current?.focus();
        searchRef.current?.select();
      }
    }
    window.addEventListener("keydown", focusSearch);
    return () => window.removeEventListener("keydown", focusSearch);
  }, []);

  const selectedRequestRef = useRef<string | null>(null);
  const loadDetail = useCallback(async (id: string) => {
    selectedRequestRef.current = id;
    setSelectedId(id);
    const cached = await idbGet<ProblemDetail>(detailCacheKey(id));
    if (selectedRequestRef.current !== id) return;
    if (cached) setDetail(cached);
    setDetailLoading(!cached);
    try {
      const response = await fetch(`/api/problems/${encodeURIComponent(id)}`);
      if (!response.ok) throw new Error("Problem details unavailable");
      const data = (await response.json()) as { problem: ProblemDetail };
      await idbSet(detailCacheKey(id), data.problem);
      if (selectedRequestRef.current === id) setDetail(data.problem);
    } finally {
      if (selectedRequestRef.current === id) setDetailLoading(false);
    }
  }, []);

  const activeView = views.find((view) => view.id === activeViewId);
  const activeSprint = sprints.find((sprint) => sprint.id === activeSprintId);
  const filteredProblems = useMemo(() => {
    const query = search.trim().toLowerCase();
    return problems.filter((problem) => {
      const dueMatch =
        activeSprintId !== null ||
        activeView?.filter.due !== "today" ||
        ((problem.dueDate ?? problem.nextReviewDate) !== null &&
          (problem.dueDate ?? problem.nextReviewDate)! <= today);
      const viewMatch = activeSprintId
        ? problem.sprintId === activeSprintId
        : !activeView
          ? problem.archivedAt === null
          : matchesSavedView(problem, activeView.filter, today);
      const stateMatch =
        !stateFilter.length ||
        (problem.state !== null && stateFilter.includes(problem.state));
      const workflowMatch =
        !workflowStatusFilter.length ||
        (problem.status !== null &&
          workflowStatusFilter.includes(problem.status));
      const tagsMatch =
        !tagFilter.length ||
        tagFilter.every((tag) => problem.officialTags.includes(tag));
      const platformMatch =
        platformFilter === "all" || problem.platform === platformFilter;
      const difficultyMatch =
        difficultyFilter === "all" || problem.difficulty === difficultyFilter;
      const ratingMatch = matchesRatingRange(
        problem,
        ratingStart === "" ? null : Number(ratingStart),
        ratingEnd === "" ? null : Number(ratingEnd),
      );
      const textMatch =
        !query ||
        [
          problem.title,
          problem.platform,
          problem.problemKey,
          problem.contest ?? "",
        ]
          .join(" ")
          .toLowerCase()
          .includes(query);
      return (
        dueMatch &&
        viewMatch &&
        stateMatch &&
        workflowMatch &&
        tagsMatch &&
        platformMatch &&
        difficultyMatch &&
        ratingMatch &&
        textMatch
      );
    });
  }, [
    activeView,
    activeSprintId,
    difficultyFilter,
    platformFilter,
    problems,
    ratingEnd,
    ratingStart,
    search,
    stateFilter,
    workflowStatusFilter,
    tagFilter,
    today,
  ]);

  function selectView(view: SavedView) {
    setActiveSprintId(null);
    setActiveViewId(view.id);
    setSearch(view.filter.search ?? "");
    setStateFilter(view.filter.state ?? []);
    setWorkflowStatusFilter(view.filter.status ?? []);
    setTagFilter(view.filter.tags ?? []);
    setPlatformFilter(view.filter.platform ?? "all");
    setDifficultyFilter(view.filter.difficulty ?? "all");
    setRatingStart(
      view.filter.ratingStart === undefined
        ? ""
        : String(view.filter.ratingStart),
    );
    setRatingEnd(
      view.filter.ratingEnd === undefined ? "" : String(view.filter.ratingEnd),
    );
    if (view.sort.length) {
      setSorting(
        view.sort.map((sort) => ({
          ...sort,
          id: sort.id === "nextReviewDate" ? "dueDate" : sort.id,
        })),
      );
    }
  }

  async function saveCurrentView() {
    const name = window.prompt("Name this view");
    if (!name?.trim()) return;
    const visibleColumns = table
      .getVisibleLeafColumns()
      .map((column) => column.id);
    const response = await fetch("/api/saved-views", {
      method: "POST",
      headers: { "content-type": "application/json" },
      body: JSON.stringify({
        name: name.trim(),
        filter: {
          schema: "resolve.filter.v1",
          search,
          state: stateFilter,
          status: workflowStatusFilter,
          tags: tagFilter,
          platform: platformFilter,
          difficulty: difficultyFilter === "all" ? undefined : difficultyFilter,
          ratingStart: ratingStart === "" ? undefined : Number(ratingStart),
          ratingEnd: ratingEnd === "" ? undefined : Number(ratingEnd),
        },
        sort: sorting,
        visibleColumns,
      }),
    });
    if (response.ok) await refresh();
  }

  const updateProblem = useCallback(
    async (
      id: string,
      patch: Partial<{
        rating: number | null;
        difficulty: Difficulty | null;
        state: ProblemState | null;
        status: ProblemStatus | null;
        archived: boolean;
        dueDate: string | null;
        nextReviewDate: string | null;
        officialTags: string[];
      }>,
    ) => {
      setProblems((current) =>
        current.map((problem) =>
          problem.id === id
            ? {
                ...problem,
                ...(patch.state !== undefined ? { state: patch.state } : {}),
                ...(patch.status !== undefined ? { status: patch.status } : {}),
                ...(patch.dueDate !== undefined
                  ? { dueDate: patch.dueDate }
                  : {}),
              }
            : problem,
        ),
      );
      const response = await fetch(`/api/problems/${id}`, {
        method: "PATCH",
        headers: { "content-type": "application/json" },
        body: JSON.stringify(patch),
      });
      if (!response.ok) {
        await refresh();
        throw new Error("Problem update failed");
      }
      const data = (await response.json()) as { problem: ProblemDetail };
      if (detail?.id === id) setDetail(data.problem);
      setProblems((current) => {
        const next = current.map((problem) =>
          problem.id === id ? { ...problem, ...data.problem } : problem,
        );
        void idbSet(CACHE_KEY, next);
        return next;
      });
      await idbSet(detailCacheKey(id), data.problem);
      return data.problem;
    },
    [detail?.id, refresh],
  );

  const columns = useMemo(
    () => [
      columnHelper.accessor("title", {
        header: "Problem",
        size: 390,
        cell: ({ row }) => (
          <button
            className="problem-cell"
            onClick={() => void loadDetail(row.original.id)}
          >
            <span>{row.original.title}</span>
            <Secondary problem={row.original} />
          </button>
        ),
      }),
      columnHelper.accessor("platform", {
        header: "Platform",
        size: 128,
        cell: ({ getValue }) => (
          <span className={`platform platform-${getValue()}`}>
            {platformLabel(getValue())}
          </span>
        ),
      }),
      columnHelper.accessor("rating", {
        header: "Rating",
        size: 92,
        cell: ({ getValue }) => (
          <span className="rating">{getValue() ?? "—"}</span>
        ),
      }),
      columnHelper.accessor("difficulty", {
        header: "Difficulty",
        size: 102,
        sortingFn: (rowA, rowB) => {
          const order: Record<Difficulty, number> = {
            easy: 0,
            medium: 1,
            hard: 2,
            extreme: 3,
          };
          const first = rowA.original.difficulty;
          const second = rowB.original.difficulty;
          return (first ? order[first] : 4) - (second ? order[second] : 4);
        },
        cell: ({ getValue }) => <DifficultyTag difficulty={getValue()} />,
      }),
      columnHelper.accessor("state", {
        header: "State",
        size: 116,
        cell: ({ getValue, row }) => (
          <select
            className={`inline-select status-${getValue() ?? "none"}`}
            aria-label={`State for ${row.original.title}`}
            value={getValue() ?? ""}
            onChange={(event) =>
              void updateProblem(row.original.id, {
                state: event.target.value
                  ? (event.target.value as ProblemState)
                  : null,
              })
            }
          >
            <option value="">None</option>
            {PROBLEM_STATES.map((state) => (
              <option key={state} value={state}>
                {statusLabel(state)}
              </option>
            ))}
          </select>
        ),
      }),
      columnHelper.accessor("status", {
        header: "Status",
        size: 118,
        cell: ({ getValue, row }) => (
          <select
            className={`inline-select workflow-${getValue() ?? "unclassified"}`}
            aria-label={`Status for ${row.original.title}`}
            value={getValue() ?? ""}
            onChange={(event) =>
              void updateProblem(row.original.id, {
                status: event.target.value
                  ? (event.target.value as ProblemStatus)
                  : null,
              })
            }
          >
            <option value="">Unclassified</option>
            {PROBLEM_STATUSES.map((status) => (
              <option key={status} value={status}>
                {statusLabel(status.replace("_", " "))}
              </option>
            ))}
          </select>
        ),
      }),
      columnHelper.accessor("dueDate", {
        header: "Due date",
        size: 132,
        sortingFn: "datetime",
        cell: ({ getValue, row }) => {
          const value = getValue();
          return (
            <input
              className={
                value && value <= today ? "inline-date overdue" : "inline-date"
              }
              aria-label={`Due date for ${row.original.title}`}
              type="date"
              value={value ?? ""}
              onChange={(event) =>
                void updateProblem(row.original.id, {
                  dueDate: event.target.value || null,
                })
              }
            />
          );
        },
      }),
    ],
    [loadDetail, today, updateProblem],
  );

  // TanStack Table intentionally exposes mutable instance methods.
  // eslint-disable-next-line react-hooks/incompatible-library
  const table = useReactTable({
    data: filteredProblems,
    columns,
    state: { sorting, columnVisibility: visibility },
    onSortingChange: setSorting,
    onColumnVisibilityChange: setVisibility,
    getCoreRowModel: getCoreRowModel(),
    getSortedRowModel: getSortedRowModel(),
    enableMultiSort: true,
  });

  const closeDetail = () => {
    setSelectedId(null);
    setDetail(null);
    setFullPage(false);
  };

  async function updateDetail(
    patch: Partial<{
      rating: number | null;
      difficulty: Difficulty | null;
      state: ProblemState | null;
      status: ProblemStatus | null;
      archived: boolean;
      dueDate: string | null;
      nextReviewDate: string | null;
      officialTags: string[];
    }>,
  ) {
    if (!detail) return;
    await updateProblem(detail.id, patch);
  }

  async function createMashup() {
    if (selectedProblemIds.size === 0 || creatingMashup) return;
    const startedAt = Date.parse(mashupStart);
    const durationSeconds = Math.round(Number(mashupHours) * 3600);
    if (
      !Number.isFinite(startedAt) ||
      startedAt > Date.now() ||
      durationSeconds < 15 * 60 ||
      durationSeconds > 24 * 60 * 60
    ) {
      setMashupError(
        "Choose a past start time and a duration from 0.25 to 24 hours.",
      );
      return;
    }
    setMashupError("");
    setCreatingMashup(true);
    try {
      const response = await fetch("/api/mashups", {
        method: "POST",
        headers: { "content-type": "application/json" },
        body: JSON.stringify({
          sprint_id: activeSprint?.id ?? null,
          problem_ids: [...selectedProblemIds],
          duration_seconds: durationSeconds,
          started_at: new Date(startedAt).toISOString(),
        }),
      });
      if (!response.ok) throw new Error("Mashup creation failed");
      const data = (await response.json()) as { mashup: Mashup };
      setMashupBuilderOpen(false);
      setActiveMashup(data.mashup);
    } catch {
      setMashupError("The mashup could not be saved. Try again.");
    } finally {
      setCreatingMashup(false);
    }
  }

  async function downloadOfflineData() {
    setProfileOpen(false);
    let completed = 0;
    setOfflineProgress(`Downloading 0/${problems.length}`);
    const queue = [...problems];
    const workers = Array.from({ length: 6 }, async () => {
      while (queue.length) {
        const problem = queue.shift();
        if (!problem) return;
        try {
          const response = await fetch(
            `/api/problems/${encodeURIComponent(problem.id)}`,
          );
          if (response.ok) {
            const data = (await response.json()) as { problem: ProblemDetail };
            await idbSet(detailCacheKey(problem.id), data.problem);
          }
        } finally {
          completed += 1;
          setOfflineProgress(`Downloading ${completed}/${problems.length}`);
        }
      }
    });
    await Promise.all(workers);
    setOfflineProgress(`${problems.length} problems available offline`);
    window.setTimeout(() => setOfflineProgress(null), 3500);
  }

  return (
    <main className="app-shell">
      <aside className="sidebar">
        <div className="brand-row">
          <Image
            className="brand-mark"
            src="/resolve-logo.png"
            alt=""
            width={34}
            height={34}
            priority
          />
          <div>
            <strong>ReSolve</strong>
            <span>Recall what matters</span>
          </div>
        </div>
        <div className="sidebar-heading">Core views</div>
        <nav className="view-nav" aria-label="Core views">
          {views
            .filter((view) => view.isCore)
            .map((view) => {
              const count = problems.filter((problem) =>
                matchesSavedView(problem, view.filter, today),
              ).length;
              return (
                <button
                  key={view.id}
                  className={activeViewId === view.id ? "active" : ""}
                  onClick={() => selectView(view)}
                >
                  <span
                    className={`view-dot ${view.id.replace("view-", "")}`}
                  />
                  <span>{view.name}</span>
                  <em>{count}</em>
                </button>
              );
            })}
        </nav>
        <div className="sidebar-heading saved-heading">Saved views</div>
        <nav className="view-nav" aria-label="Saved views">
          {views
            .filter((view) => !view.isCore)
            .map((view) => {
              const count = problems.filter((problem) =>
                matchesSavedView(problem, view.filter, today),
              ).length;
              return (
                <div className="saved-view-row" key={view.id}>
                  <button
                    className={activeViewId === view.id ? "active" : ""}
                    onClick={() => selectView(view)}
                  >
                    <span className="view-dot custom" />
                    <span>{view.name}</span>
                    <em>{count}</em>
                  </button>
                  <button
                    className="delete-view"
                    aria-label={`Delete ${view.name}`}
                    onClick={async () => {
                      const response = await fetch(
                        `/api/saved-views?id=${encodeURIComponent(view.id)}`,
                        { method: "DELETE" },
                      );
                      if (response.ok) {
                        setActiveViewId("view-due-today");
                        await refresh();
                      }
                    }}
                  >
                    ×
                  </button>
                </div>
              );
            })}
        </nav>
        <button className="new-view" onClick={() => void saveCurrentView()}>
          <span>＋</span> Save current view
        </button>
        <div className="sidebar-spacer" />
        {sprints[0] ? (
          <button
            className={`sprint-card ${activeSprintId === sprints[0].id ? "active" : ""}`}
            onClick={() => {
              setActiveSprintId(sprints[0].id);
              setSorting([{ id: "dueDate", desc: false }]);
            }}
          >
            <span>Current sprint</span>
            <strong>{sprints[0].name}</strong>
            <em>{sprints[0].source ?? "To be decided"}</em>
            <p>
              {
                problems.filter(
                  (problem) =>
                    problem.sprintId === sprints[0].id &&
                    problem.status === "accepted",
                ).length
              }
              /
              {
                problems.filter((problem) => problem.sprintId === sprints[0].id)
                  .length
              }{" "}
              accepted
            </p>
          </button>
        ) : null}
        {sprints[1] ? (
          <div className="next-sprint">
            <span>Next sprint</span>
            <strong>{sprints[1].name}</strong>
            <em>{sprints[1].source ?? "To be decided"}</em>
          </div>
        ) : null}
        <div className="storage-card">
          <span className="pulse" />
          <div>
            <strong>{syncing ? "Refreshing" : "Cache ready"}</strong>
            <span>{problems.length} problems · D1 source of truth</span>
          </div>
        </div>
        <div className="viewer">
          <span>{viewer.displayName.slice(0, 1).toUpperCase()}</span>
          <div>
            <strong>{viewer.displayName}</strong>
            <em>{local ? "Private local mode" : "Private workspace"}</em>
          </div>
        </div>
      </aside>

      <section
        className={`workspace ${selectedId ? "drawer-open" : ""} ${
          drawerWidth > 700 || fullPage ? "drawer-overlay" : ""
        }`}
        style={{ "--drawer-width": `${drawerWidth}px` } as React.CSSProperties}
      >
        <header className="topbar">
          <div>
            <Image
              className="mobile-brand-mark"
              src="/resolve-logo.png"
              alt="ReSolve"
              width={28}
              height={28}
              priority
            />
            <div className="eyebrow">
              {activeSprint ? "Monthly milestone" : "Problem library"}
            </div>
            <h1>{activeSprint?.name ?? activeView?.name ?? "All problems"}</h1>
            <p>
              {filteredProblems.length} problems
              {activeSprint
                ? ` · ${activeSprint.source ?? "Source to be decided"} · ${activeSprint.startsOn} to ${activeSprint.endsOn}`
                : activeView?.filter.due === "today"
                  ? " ready for active recall"
                  : " in this view"}
            </p>
          </div>
          <div className="profile-wrap">
            <button
              className="avatar"
              title={viewer.email}
              aria-expanded={profileOpen}
              onClick={() => setProfileOpen((value) => !value)}
            >
              {viewer.displayName.slice(0, 1).toUpperCase()}
            </button>
            {profileOpen ? (
              <div className="profile-menu">
                <strong>{viewer.displayName}</strong>
                <span>{viewer.email}</span>
                <button
                  onClick={() => {
                    setProfileOpen(false);
                    setMashupHistoryOpen(true);
                  }}
                >
                  Mashups
                </button>
                <button onClick={() => void downloadOfflineData()}>
                  Download for offline use
                </button>
              </div>
            ) : null}
          </div>
        </header>

        <div className="toolbar">
          <label className="search">
            <span>⌕</span>
            <input
              ref={searchRef}
              value={search}
              onChange={(event) => setSearch(event.target.value)}
              placeholder="Search name, contest, or key…"
            />
            <kbd>⌘ K</kbd>
          </label>
          <div className="toolbar-actions">
            <button
              className="mashup-launch"
              disabled={selectedProblemIds.size === 0}
              onClick={() => setMashupBuilderOpen(true)}
            >
              Create mashup
              {selectedProblemIds.size ? (
                <b>{selectedProblemIds.size}</b>
              ) : null}
            </button>
            <button
              className={filtersOpen ? "active" : ""}
              onClick={() => setFiltersOpen((value) => !value)}
            >
              Filters
              {stateFilter.length ||
              workflowStatusFilter.length ||
              tagFilter.length ||
              platformFilter !== "all" ||
              difficultyFilter !== "all" ||
              ratingStart ||
              ratingEnd ? (
                <b>
                  {stateFilter.length +
                    workflowStatusFilter.length +
                    Number(tagFilter.length > 0) +
                    Number(platformFilter !== "all") +
                    Number(difficultyFilter !== "all") +
                    Number(Boolean(ratingStart || ratingEnd))}
                </b>
              ) : null}
            </button>
            <button
              className={sorting.length ? "active" : ""}
              onClick={() =>
                setSorting((current) =>
                  current[0]?.desc
                    ? [{ id: "dueDate", desc: false }]
                    : [{ id: "dueDate", desc: true }],
                )
              }
            >
              Sort {sorting[0]?.desc ? "↓" : "↑"}
            </button>
            <div className="column-menu-wrap">
              <button onClick={() => setColumnsOpen((value) => !value)}>
                Columns
              </button>
              {columnsOpen ? (
                <div className="column-menu">
                  {table.getAllLeafColumns().map((column) => (
                    <label key={column.id}>
                      <input
                        type="checkbox"
                        checked={column.getIsVisible()}
                        onChange={column.getToggleVisibilityHandler()}
                      />
                      {typeof column.columnDef.header === "string"
                        ? column.columnDef.header
                        : column.id}
                    </label>
                  ))}
                </div>
              ) : null}
            </div>
            <button
              className="save-view"
              onClick={() => void saveCurrentView()}
            >
              Save view
            </button>
          </div>
        </div>

        {filtersOpen ? (
          <div className="filter-row">
            <div>
              <span>State</span>
              {PROBLEM_STATES.map((status) => (
                <button
                  key={status}
                  className={stateFilter.includes(status) ? "selected" : ""}
                  onClick={() =>
                    setStateFilter((current) =>
                      current.includes(status)
                        ? current.filter((value) => value !== status)
                        : [...current, status],
                    )
                  }
                >
                  {statusLabel(status)}
                </button>
              ))}
            </div>
            <label>
              Status
              <select
                value={workflowStatusFilter[0] ?? "all"}
                onChange={(event) =>
                  setWorkflowStatusFilter(
                    event.target.value === "all"
                      ? []
                      : [event.target.value as ProblemStatus],
                  )
                }
              >
                <option value="all">All</option>
                {PROBLEM_STATUSES.map((status) => (
                  <option key={status} value={status}>
                    {statusLabel(status.replace("_", " "))}
                  </option>
                ))}
              </select>
            </label>
            <label>
              Tags
              <select
                value={tagFilter[0] ?? "all"}
                onChange={(event) =>
                  setTagFilter(
                    event.target.value === "all" ? [] : [event.target.value],
                  )
                }
              >
                <option value="all">All</option>
                {[
                  ...new Set(
                    problems.flatMap((problem) => problem.officialTags),
                  ),
                ]
                  .sort()
                  .map((tag) => (
                    <option key={tag} value={tag}>
                      {tag}
                    </option>
                  ))}
              </select>
            </label>
            <label>
              Platform
              <select
                value={platformFilter}
                onChange={(event) => setPlatformFilter(event.target.value)}
              >
                <option value="all">All</option>
                <option value="codeforces">Codeforces</option>
                <option value="cses">CSES</option>
                <option value="atcoder">AtCoder</option>
              </select>
            </label>
            <label>
              Difficulty
              <select
                value={difficultyFilter}
                onChange={(event) =>
                  setDifficultyFilter(event.target.value as Difficulty | "all")
                }
              >
                <option value="all">All</option>
                {DIFFICULTIES.map((difficulty) => (
                  <option key={difficulty} value={difficulty}>
                    {statusLabel(difficulty)}
                  </option>
                ))}
              </select>
            </label>
            <label>
              Start rating
              <input
                type="number"
                value={ratingStart}
                onChange={(event) => setRatingStart(event.target.value)}
                placeholder="Any"
              />
            </label>
            <label>
              End rating
              <input
                type="number"
                value={ratingEnd}
                onChange={(event) => setRatingEnd(event.target.value)}
                placeholder="Any"
              />
            </label>
            <button
              className="clear-filters"
              onClick={() => {
                setStateFilter([]);
                setWorkflowStatusFilter([]);
                setTagFilter([]);
                setPlatformFilter("all");
                setDifficultyFilter("all");
                setRatingStart("");
                setRatingEnd("");
              }}
            >
              Clear
            </button>
          </div>
        ) : null}

        <ProblemTable
          table={table}
          selectedId={selectedId}
          onSelect={loadDetail}
          selectable
          selectedProblemIds={selectedProblemIds}
          onSelectedProblemIds={setSelectedProblemIds}
        />
        <ProblemCards
          problems={table.getRowModel().rows.map((row) => row.original)}
          onSelect={loadDetail}
          onReview={(problem) => {
            void loadDetail(problem.id).then(() => setReviewOpen(true));
          }}
          selectable
          selectedProblemIds={selectedProblemIds}
          onSelectedProblemIds={setSelectedProblemIds}
        />

        <footer className="table-footer">
          <span>
            Showing {filteredProblems.length} of {problems.length}
          </span>
          <span>
            {syncing
              ? "Refreshing from D1…"
              : "Cached first · refreshed in background"}
          </span>
        </footer>
      </section>

      {selectedId && !reviewOpen ? (
        <DetailDrawer
          key={selectedId}
          detail={detail}
          loading={detailLoading}
          onClose={closeDetail}
          onReview={() => {
            setReviewOpen(true);
          }}
          onUpdate={updateDetail}
          width={drawerWidth}
          onWidth={setDrawerWidth}
          fullPage={fullPage}
          onFullPage={setFullPage}
        />
      ) : null}

      {reviewOpen && detail ? (
        <ReviewSurface
          problem={detail}
          onClose={() => setReviewOpen(false)}
          onComplete={async () => {
            setReviewOpen(false);
            await loadDetail(detail.id);
            await refresh();
          }}
        />
      ) : null}

      {mashupBuilderOpen ? (
        <div className="modal-backdrop">
          <section className="mashup-builder" role="dialog" aria-modal="true">
            <span>Focused contest</span>
            <h2>Create a mashup</h2>
            <p>
              {selectedProblemIds.size} selected problems. The first problem
              receives any elapsed time before the chosen start.
            </p>
            <label>
              Start time
              <input
                type="datetime-local"
                max={localDateTimeInput()}
                value={mashupStart}
                onChange={(event) => setMashupStart(event.target.value)}
              />
            </label>
            <label>
              Global timer (hours)
              <input
                type="number"
                min="0.25"
                max="24"
                step="0.25"
                value={mashupHours}
                onChange={(event) => setMashupHours(event.target.value)}
              />
            </label>
            {mashupError ? <p className="form-error">{mashupError}</p> : null}
            <div>
              <button onClick={() => setMashupBuilderOpen(false)}>
                Cancel
              </button>
              <button
                className="primary"
                disabled={creatingMashup}
                onClick={() => void createMashup()}
              >
                {creatingMashup ? "Creating…" : "Start mashup"}
              </button>
            </div>
          </section>
        </div>
      ) : null}

      {activeMashup ? (
        <MashupSurface
          initialMashup={activeMashup}
          problems={problems}
          onClose={() => setActiveMashup(null)}
          onComplete={async () => {
            setActiveMashup(null);
            setSelectedProblemIds(new Set());
            await refresh();
          }}
        />
      ) : null}

      {mashupHistoryOpen ? (
        <MashupHistory
          problems={problems}
          onClose={() => setMashupHistoryOpen(false)}
        />
      ) : null}

      {offlineProgress ? (
        <div className="sync-toast" role="status">
          {offlineProgress}
        </div>
      ) : null}

      {mobileSection === "views" ? (
        <section className="mobile-panel">
          <div className="mobile-panel-title">
            <Image src="/resolve-logo.png" alt="" width={30} height={30} />
            <div>
              <span>ReSolve</span>
              <h2>Views</h2>
            </div>
          </div>
          <div className="mobile-panel-list">
            {views.map((view) => (
              <button
                key={view.id}
                onClick={() => {
                  selectView(view);
                  setMobileSection(
                    view.id === "view-due-today" ? "today" : "problems",
                  );
                }}
              >
                <span className={`view-dot ${view.id.replace("view-", "")}`} />
                <strong>{view.name}</strong>
                <em>
                  {
                    problems.filter((problem) =>
                      matchesSavedView(problem, view.filter, today),
                    ).length
                  }
                </em>
              </button>
            ))}
            {sprints.map((sprint) => (
              <button
                key={sprint.id}
                onClick={() => {
                  setActiveSprintId(sprint.id);
                  setMobileSection("problems");
                }}
              >
                <span className="view-dot sprint" />
                <strong>{sprint.name}</strong>
                <em>
                  {
                    problems.filter((problem) => problem.sprintId === sprint.id)
                      .length
                  }
                </em>
              </button>
            ))}
          </div>
        </section>
      ) : null}

      {mobileSection === "settings" ? (
        <section className="mobile-panel">
          <div className="mobile-panel-title">
            <Image src="/resolve-logo.png" alt="" width={30} height={30} />
            <div>
              <span>ReSolve</span>
              <h2>Settings</h2>
            </div>
          </div>
          <div className="mobile-settings">
            <button onClick={() => setMashupHistoryOpen(true)}>
              <strong>Mashups</strong>
              <span>History, notes, copy, and delete</span>
            </button>
            <button onClick={() => void downloadOfflineData()}>
              <strong>Download for offline use</strong>
              <span>Cache every problem and refresh online</span>
            </button>
            <div>
              <strong>Sync status</strong>
              <span>
                {syncing ? "Refreshing…" : `${problems.length} problems cached`}
              </span>
            </div>
          </div>
        </section>
      ) : null}

      <nav className="mobile-nav" aria-label="Mobile navigation">
        {[
          ["today", "◷", "Today"],
          ["problems", "▦", "Problems"],
          ["views", "◎", "Views"],
          ["settings", "⚙", "Settings"],
        ].map(([id, icon, label]) => (
          <button
            key={id}
            className={mobileSection === id ? "active" : ""}
            onClick={() => {
              setMobileSection(id);
              if (id === "today") {
                const due = views.find((view) => view.id === "view-due-today");
                if (due) {
                  selectView(due);
                  setMobileSection("today");
                }
              } else if (id === "problems") {
                const all = views.find((view) => view.id === "view-all");
                if (all) {
                  selectView(all);
                  setMobileSection("problems");
                }
              }
            }}
          >
            <span>{icon}</span>
            {label}
          </button>
        ))}
      </nav>
    </main>
  );
}

function ProblemTable({
  table,
  selectedId,
  onSelect,
  selectable,
  selectedProblemIds,
  onSelectedProblemIds,
}: {
  table: ReturnType<typeof useReactTable<ProblemListItem>>;
  selectedId: string | null;
  onSelect: (id: string) => Promise<void>;
  selectable: boolean;
  selectedProblemIds: Set<string>;
  onSelectedProblemIds: (ids: Set<string>) => void;
}) {
  const parentRef = useRef<HTMLDivElement>(null);
  const rows = table.getRowModel().rows;
  // TanStack Virtual intentionally exposes mutable instance methods.
  // eslint-disable-next-line react-hooks/incompatible-library
  const virtualizer = useVirtualizer({
    count: rows.length,
    getScrollElement: () => parentRef.current,
    estimateSize: () => 63,
    overscan: 8,
  });
  return (
    <div className="table-frame">
      <div className="table-scroll" ref={parentRef}>
        <div className="table-head">
          {selectable ? (
            <label className="selection-cell select-all">
              <input
                type="checkbox"
                aria-label="Select all visible problems"
                checked={
                  rows.length > 0 &&
                  rows.every((row) => selectedProblemIds.has(row.original.id))
                }
                onChange={(event) => {
                  const next = new Set(selectedProblemIds);
                  rows.forEach((row) => {
                    if (event.target.checked) next.add(row.original.id);
                    else next.delete(row.original.id);
                  });
                  onSelectedProblemIds(next);
                }}
              />
            </label>
          ) : null}
          {table.getHeaderGroups().map((headerGroup) =>
            headerGroup.headers.map((header) => (
              <button
                key={header.id}
                style={{ width: header.getSize() }}
                onClick={header.column.getToggleSortingHandler()}
              >
                {flexRender(
                  header.column.columnDef.header,
                  header.getContext(),
                )}
                {{ asc: " ↑", desc: " ↓" }[
                  header.column.getIsSorted() as string
                ] ?? ""}
              </button>
            )),
          )}
        </div>
        <div
          className="virtual-body"
          style={{ height: virtualizer.getTotalSize() }}
        >
          {virtualizer.getVirtualItems().map((virtualRow) => {
            const row = rows[virtualRow.index];
            return (
              <div
                key={row.id}
                className={`table-row ${
                  selectedId === row.original.id ? "selected" : ""
                }`}
                style={{
                  height: virtualRow.size,
                  transform: `translateY(${virtualRow.start}px)`,
                }}
                onClick={(event) => {
                  if (
                    (event.target as HTMLElement).closest(
                      "button, input, select, textarea, a, label",
                    )
                  )
                    return;
                  void onSelect(row.original.id);
                }}
              >
                {selectable ? (
                  <label
                    className="selection-cell"
                    onClick={(event) => event.stopPropagation()}
                  >
                    <input
                      type="checkbox"
                      aria-label={`Select ${row.original.title}`}
                      checked={selectedProblemIds.has(row.original.id)}
                      onChange={(event) => {
                        const next = new Set(selectedProblemIds);
                        if (event.target.checked) next.add(row.original.id);
                        else next.delete(row.original.id);
                        onSelectedProblemIds(next);
                      }}
                    />
                  </label>
                ) : null}
                {row.getVisibleCells().map((cell) => (
                  <div
                    key={cell.id}
                    className="table-cell"
                    style={{ width: cell.column.getSize() }}
                  >
                    {flexRender(cell.column.columnDef.cell, cell.getContext())}
                  </div>
                ))}
              </div>
            );
          })}
        </div>
      </div>
    </div>
  );
}

function ProblemCards({
  problems,
  onSelect,
  onReview,
  selectable,
  selectedProblemIds,
  onSelectedProblemIds,
}: {
  problems: ProblemListItem[];
  onSelect: (id: string) => Promise<void>;
  onReview: (problem: ProblemListItem) => void;
  selectable: boolean;
  selectedProblemIds: Set<string>;
  onSelectedProblemIds: (ids: Set<string>) => void;
}) {
  return (
    <div className="problem-cards">
      {problems.map((problem) => (
        <article key={problem.id} onClick={() => void onSelect(problem.id)}>
          {selectable ? (
            <label
              className="mobile-problem-select"
              onClick={(event) => event.stopPropagation()}
            >
              <input
                type="checkbox"
                checked={selectedProblemIds.has(problem.id)}
                aria-label={`Select ${problem.title}`}
                onChange={(event) => {
                  const next = new Set(selectedProblemIds);
                  if (event.target.checked) next.add(problem.id);
                  else next.delete(problem.id);
                  onSelectedProblemIds(next);
                }}
              />
              Mashup
            </label>
          ) : null}
          <div className="card-meta">
            <span className={`platform platform-${problem.platform}`}>
              {platformLabel(problem.platform)}
            </span>
            <span className={`status status-${problem.state ?? "none"}`}>
              {problem.state ? statusLabel(problem.state) : "No state"}
            </span>
            <span className={`status workflow-${problem.status ?? "none"}`}>
              {problem.status
                ? statusLabel(problem.status.replace("_", " "))
                : "No status"}
            </span>
          </div>
          <h2>{problem.title}</h2>
          <Secondary problem={problem} />
          <div className="card-bottom">
            <span>{problem.rating ?? "Unrated"}</span>
            <DifficultyTag difficulty={problem.difficulty} />
            <strong>
              {dateLabel(problem.dueDate ?? problem.nextReviewDate)}
            </strong>
            {(problem.dueDate ?? problem.nextReviewDate) &&
            (problem.dueDate ?? problem.nextReviewDate)! <= todayDhaka() ? (
              <button
                onClick={(event) => {
                  event.stopPropagation();
                  onReview(problem);
                }}
              >
                Start review
              </button>
            ) : null}
          </div>
        </article>
      ))}
    </div>
  );
}

function DetailDrawer({
  detail,
  loading,
  onClose,
  onReview,
  onUpdate,
  width,
  onWidth,
  fullPage,
  onFullPage,
}: {
  detail: ProblemDetail | null;
  loading: boolean;
  onClose: () => void;
  onReview: () => void;
  onUpdate: (
    patch: Partial<{
      rating: number | null;
      difficulty: Difficulty | null;
      state: ProblemState | null;
      status: ProblemStatus | null;
      archived: boolean;
      dueDate: string | null;
      nextReviewDate: string | null;
      officialTags: string[];
    }>,
  ) => Promise<void>;
  width: number;
  onWidth: (width: number) => void;
  fullPage: boolean;
  onFullPage: (value: boolean) => void;
}) {
  const [tab, setTab] = useState("statement");
  const [showTags, setShowTags] = useState(false);
  function startResize(event: React.PointerEvent) {
    event.preventDefault();
    const startX = event.clientX;
    const startWidth = width;
    function move(moveEvent: PointerEvent) {
      onWidth(
        Math.min(
          window.innerWidth - 32,
          Math.max(380, startWidth + startX - moveEvent.clientX),
        ),
      );
    }
    function stop() {
      window.removeEventListener("pointermove", move);
      window.removeEventListener("pointerup", stop);
    }
    window.addEventListener("pointermove", move);
    window.addEventListener("pointerup", stop);
  }
  if (loading && !detail) {
    return (
      <aside className="detail-drawer">
        <div className="drawer-loading">
          <span />
          <span />
          <span />
        </div>
      </aside>
    );
  }
  if (!detail) return null;
  const reflection = detail.reflection;
  return (
    <aside
      className={`detail-drawer ${fullPage ? "full-page" : ""}`}
      style={{ width: fullPage ? "100vw" : width }}
    >
      {!fullPage ? (
        <button
          className="drawer-resizer"
          aria-label="Resize problem panel"
          onPointerDown={startResize}
        />
      ) : null}
      <div className="drawer-top">
        <button className="drawer-close" onClick={onClose} aria-label="Close">
          ×
        </button>
        <div className="drawer-actions">
          <a href={detail.url} target="_blank" rel="noreferrer">
            Open judge ↗
          </a>
          <button onClick={() => onFullPage(!fullPage)}>
            {fullPage ? "Exit full page" : "Full page"}
          </button>
          <button className="primary" onClick={onReview}>
            Start review
          </button>
        </div>
      </div>
      <div className="drawer-title">
        <div className="drawer-badges">
          <span className={`platform platform-${detail.platform}`}>
            {platformLabel(detail.platform)}
          </span>
          <span className={`status status-${detail.state ?? "none"}`}>
            {detail.state ? statusLabel(detail.state) : "No state"}
          </span>
          <span className={`status workflow-${detail.status ?? "none"}`}>
            {detail.status
              ? statusLabel(detail.status.replace("_", " "))
              : "No status"}
          </span>
          <DifficultyTag difficulty={detail.difficulty} />
        </div>
        <h2>{detail.title}</h2>
        <p>
          {detail.contest} · {detail.problemKey}
        </p>
      </div>
      <nav className="drawer-tabs">
        {["overview", "statement", "reflection", "history", "provenance"].map(
          (value) => (
            <button
              key={value}
              className={tab === value ? "active" : ""}
              onClick={() => setTab(value)}
            >
              {statusLabel(value)}
            </button>
          ),
        )}
      </nav>
      <div className="drawer-content">
        {tab === "overview" ? (
          <>
            <section className="insight-card summary-card">
              <span>Summary</span>
              <Markdown>
                {reflection?.summaryMarkdown ??
                  "No plain-language problem summary has been generated yet."}
              </Markdown>
            </section>
            <div className="property-grid">
              <Property
                label="Platform"
                value={platformLabel(detail.platform)}
              />
              <Property label="Canonical key" value={detail.problemKey} mono />
              <Property
                label="Contest"
                value={detail.contest ?? "Not captured"}
              />
              <Property label="Index" value={detail.problemIndex ?? "—"} />
              <label className="editable-property">
                <span>Rating</span>
                <input
                  type="number"
                  value={detail.rating ?? ""}
                  onChange={(event) =>
                    void onUpdate({
                      rating: event.target.value
                        ? Number(event.target.value)
                        : null,
                    })
                  }
                />
              </label>
              <label className="editable-property">
                <span>Difficulty</span>
                <select
                  value={detail.difficulty ?? ""}
                  disabled={detail.rating !== null}
                  title={
                    detail.rating === null
                      ? "Adaptive difficulty"
                      : "Derived from the problem rating"
                  }
                  onChange={(event) =>
                    void onUpdate({
                      difficulty: event.target.value as Difficulty,
                    })
                  }
                >
                  <option value="" disabled>
                    Unclassified
                  </option>
                  {DIFFICULTIES.map((difficulty) => (
                    <option key={difficulty} value={difficulty}>
                      {statusLabel(difficulty)}
                    </option>
                  ))}
                </select>
              </label>
              <label className="editable-property">
                <span>REVIEW STATE</span>
                <select
                  value={detail.state ?? ""}
                  title={
                    detail.state
                      ? STATE_DEFINITIONS[detail.state]
                      : "Choose how this problem should be reviewed"
                  }
                  onChange={(event) =>
                    void onUpdate({
                      state: event.target.value
                        ? (event.target.value as ProblemState)
                        : null,
                    })
                  }
                >
                  <option value="">None</option>
                  <option value="retry">Retry</option>
                  <option value="revise">Revise</option>
                  <option value="resolve">Resolve</option>
                </select>
                <small>
                  {detail.state
                    ? STATE_DEFINITIONS[detail.state]
                    : "Retry is unsolved, Revise is a speed re-solve, and Resolve is uncertain recall."}
                </small>
              </label>
              <label className="editable-property">
                <span>Status</span>
                <select
                  value={detail.status ?? ""}
                  onChange={(event) =>
                    void onUpdate({
                      status: event.target.value
                        ? (event.target.value as ProblemStatus)
                        : null,
                    })
                  }
                >
                  <option value="">Unclassified</option>
                  {PROBLEM_STATUSES.map((status) => (
                    <option key={status} value={status}>
                      {statusLabel(status.replace("_", " "))}
                    </option>
                  ))}
                </select>
              </label>
              <label className="editable-property wide">
                <span>Review Date</span>
                <input
                  type="date"
                  value={detail.dueDate ?? ""}
                  onChange={(event) =>
                    void onUpdate({
                      dueDate: event.target.value || null,
                    })
                  }
                />
              </label>
              <label className="editable-property wide">
                <span>Tags</span>
                <input
                  value={detail.officialTags.join(", ")}
                  onChange={(event) =>
                    void onUpdate({
                      officialTags: event.target.value
                        .split(",")
                        .map((tag) => tag.trim())
                        .filter(Boolean),
                    })
                  }
                />
              </label>
              <Property
                label="Source"
                value={
                  reflection?.sourceStatus === "found"
                    ? (reflection.sourcePath ?? "Found")
                    : "No matching source"
                }
                wide
              />
              <div className="property wide hidden-tags">
                <span>Official tags</span>
                <button onClick={() => setShowTags((value) => !value)}>
                  {showTags
                    ? detail.officialTags.join(", ") || "Not captured"
                    : "Show tags"}
                </button>
              </div>
              <label className="archive-toggle wide">
                <input
                  type="checkbox"
                  checked={detail.archivedAt !== null}
                  onChange={(event) =>
                    void onUpdate({ archived: event.target.checked })
                  }
                />
                Archived (Status and State are preserved)
              </label>
            </div>
          </>
        ) : null}
        {tab === "statement" ? (
          <section className="statement-panel">
            <div className="section-title">
              <div>
                <span>Stored statement</span>
                <p>
                  Captured {detail.statementCapturedAt?.slice(0, 10) ?? "—"} ·{" "}
                  {detail.metadataStatus}
                </p>
              </div>
              <a href={detail.url} target="_blank" rel="noreferrer">
                Source ↗
              </a>
            </div>
            <Markdown statement>{detail.statementMarkdown}</Markdown>
          </section>
        ) : null}
        {tab === "reflection" ? (
          <ReflectionEditor reflection={reflection} />
        ) : null}
        {tab === "history" ? (
          <section>
            <div className="section-title">
              <div>
                <span>Review history</span>
                <p>{detail.reviews.length} completed attempts</p>
              </div>
            </div>
            {detail.reviews.length ? (
              <div className="history-list">
                {detail.reviews.map((review) => (
                  <article key={review.id}>
                    <span className="history-dot" />
                    <div>
                      <strong>
                        {review.outcome
                          ? statusLabel(review.outcome.replace("_", " "))
                          : "Scheduled"}
                      </strong>
                      <p>
                        Deepest reveal:{" "}
                        {review.deepestReveal?.replaceAll("_", " ") ?? "none"}
                      </p>
                      {review.recallNote ? (
                        <blockquote>{review.recallNote}</blockquote>
                      ) : null}
                    </div>
                    <time>
                      {review.reviewedAt?.slice(0, 10) ?? review.dueDate}
                    </time>
                  </article>
                ))}
              </div>
            ) : (
              <EmptyState
                title="No completed reviews yet"
                body="The seeded next date is a demo projection, not a fabricated attempt."
              />
            )}
          </section>
        ) : null}
        {tab === "provenance" ? (
          <>
            <PropertySection title="Metadata & import">
              <Property label="Metadata status" value={detail.metadataStatus} />
              <Property
                label="Import source"
                value={detail.importSource ?? "Native capture"}
              />
              <Property
                label="Statement assets"
                value={`${detail.statementAssets.length} external assets`}
              />
              <Property
                label="Confidence"
                value={
                  reflection?.confidence === null ||
                  reflection?.confidence === undefined
                    ? "Not captured"
                    : `${reflection.confidence}/5`
                }
              />
            </PropertySection>
            <JsonBlock
              title="Field provenance"
              value={detail.metadataProvenance}
            />
            <JsonBlock
              title="Import provenance"
              value={detail.importProvenance}
            />
            <JsonBlock title="Legacy metadata" value={detail.legacyMetadata} />
            <JsonBlock
              title="Raw transcript"
              value={reflection?.transcriptMessages ?? []}
              empty="No interview transcript was invented for imported rows."
            />
          </>
        ) : null}
      </div>
    </aside>
  );
}

function ReflectionView({
  reflection,
}: {
  reflection: ProblemDetail["reflection"];
}) {
  if (!reflection) {
    return (
      <EmptyState
        title="No reflection yet"
        body="This problem can still be reviewed from its statement."
      />
    );
  }
  const summary = reflection.structuredSummary;
  return (
    <section className="reflection-view">
      <Field title="Summary">
        <Markdown>{reflection.summaryMarkdown}</Markdown>
      </Field>
      <Field title="Memory cue" value={reflection.memoryCue} accent />
      <Field title="Key insight" value={summary.key_insight} accent />
      <Field title="Wrong mental model" value={summary.wrong_mental_model} />
      <Field
        title="Why it seemed reasonable"
        value={summary.why_it_seemed_reasonable}
      />
      <Field title="Breakthrough" value={summary.breakthrough_observation} />
      <Field title="Correct trigger" value={summary.correct_trigger} accent />
      <Field title="General pattern" value={summary.general_pattern} />
      <Field
        title="Missing concepts"
        value={
          summary.missing_concepts.length
            ? summary.missing_concepts.join(", ")
            : "Not captured"
        }
      />
      <Field
        title="Cognitive mistakes"
        value={
          summary.cognitive_mistakes.length
            ? summary.cognitive_mistakes.join(", ")
            : "Not captured"
        }
      />
    </section>
  );
}

function ReflectionEditor({
  reflection,
}: {
  reflection: ProblemDetail["reflection"];
}) {
  const [editing, setEditing] = useState(false);
  const [draft, setDraft] = useState(reflection);
  const [saving, setSaving] = useState(false);
  if (!reflection || !draft) {
    return (
      <EmptyState
        title="No reflection yet"
        body="The statement remains reviewable; Codex can create the first reflection."
      />
    );
  }
  if (!editing) {
    return (
      <>
        <button className="edit-reflection" onClick={() => setEditing(true)}>
          Edit reflection
        </button>
        <ReflectionView reflection={draft} />
      </>
    );
  }
  const currentDraft = draft;
  const structured = draft.structuredSummary;
  const textFields = [
    ["key_insight", "Key insight"],
    ["wrong_mental_model", "Wrong mental model"],
    ["why_it_seemed_reasonable", "Why it seemed reasonable"],
    ["breakthrough_observation", "Breakthrough"],
    ["correct_trigger", "Correct trigger"],
    ["general_pattern", "General pattern"],
  ] as const;
  async function save() {
    setSaving(true);
    try {
      const response = await fetch(`/api/reflections/${currentDraft.id}`, {
        method: "PATCH",
        headers: { "content-type": "application/json" },
        body: JSON.stringify({
          summaryMarkdown: currentDraft.summaryMarkdown,
          memoryCue: currentDraft.memoryCue,
          confidence: currentDraft.confidence,
          structuredSummary: structured,
        }),
      });
      if (!response.ok) throw new Error("Reflection save failed");
      setEditing(false);
    } finally {
      setSaving(false);
    }
  }
  return (
    <section className="reflection-editor">
      <label>
        Summary
        <textarea
          value={draft.summaryMarkdown}
          onChange={(event) =>
            setDraft({ ...draft, summaryMarkdown: event.target.value })
          }
        />
      </label>
      <label>
        Memory cue
        <textarea
          value={draft.memoryCue}
          onChange={(event) =>
            setDraft({ ...draft, memoryCue: event.target.value })
          }
        />
      </label>
      {textFields.map(([key, label]) => (
        <label key={key}>
          {label}
          <textarea
            value={structured[key]}
            onChange={(event) =>
              setDraft({
                ...draft,
                structuredSummary: {
                  ...structured,
                  [key]: event.target.value,
                },
              })
            }
          />
        </label>
      ))}
      {(
        [
          ["missing_concepts", "Missing concepts"],
          ["cognitive_mistakes", "Cognitive mistakes"],
        ] as const
      ).map(([key, label]) => (
        <label key={key}>
          {label} (one per line)
          <textarea
            value={structured[key].join("\n")}
            onChange={(event) =>
              setDraft({
                ...draft,
                structuredSummary: {
                  ...structured,
                  [key]: event.target.value
                    .split("\n")
                    .map((value) => value.trim())
                    .filter(Boolean),
                },
              })
            }
          />
        </label>
      ))}
      <label>
        Confidence
        <input
          type="number"
          min="0"
          max="5"
          value={draft.confidence ?? ""}
          onChange={(event) =>
            setDraft({
              ...draft,
              confidence: event.target.value
                ? Number(event.target.value)
                : null,
            })
          }
        />
      </label>
      <p className="immutable-note">
        The raw interview transcript stays immutable as provenance.
      </p>
      <div className="editor-actions">
        <button onClick={() => setEditing(false)}>Cancel</button>
        <button
          className="primary"
          disabled={saving}
          onClick={() => void save()}
        >
          {saving ? "Saving…" : "Save reflection"}
        </button>
      </div>
    </section>
  );
}

function ReviewSurface({
  problem,
  onClose,
  onComplete,
}: {
  problem: ProblemDetail;
  onClose: () => void;
  onComplete: () => Promise<void>;
}) {
  const [deepest, setDeepest] = useState<Reveal>("none");
  const [recallNote, setRecallNote] = useState("");
  const [outcome, setOutcome] = useState<Outcome | null>(null);
  const [nextDate, setNextDate] = useState("");
  const [saving, setSaving] = useState(false);
  const [elapsedSeconds, setElapsedSeconds] = useState(0);
  const reflection = problem.reflection;
  const hasReflection = Boolean(reflection);
  const deepestIndex = REVEALS.indexOf(deepest);
  const canRevealSource = Boolean(reflection?.sourceSnapshot);
  const timerLimitSeconds =
    reviewTimerMinutes(problem.state, problem.difficulty) * 60;
  useEffect(() => {
    const started = Date.now();
    const timer = window.setInterval(
      () => setElapsedSeconds(Math.floor((Date.now() - started) / 1000)),
      1000,
    );
    return () => window.clearInterval(timer);
  }, []);

  function revealNext() {
    const max = hasReflection ? (canRevealSource ? 4 : 3) : 0;
    const nextIndex = Math.min(deepestIndex + 1, max);
    setDeepest(REVEALS[nextIndex]);
  }

  function chooseOutcome(value: Outcome) {
    setOutcome(value);
    setNextDate(addCalendarDays(todayDhaka(), INITIAL_INTERVALS[value]));
  }

  async function complete() {
    if (!outcome || !nextDate) return;
    setSaving(true);
    try {
      const response = await fetch("/api/reviews", {
        method: "POST",
        headers: { "content-type": "application/json" },
        body: JSON.stringify({
          idempotency_key: `web:${problem.id}:${crypto.randomUUID()}`,
          problem_id: problem.id,
          reflection_id: reflection?.id ?? null,
          due_date: problem.dueDate ?? problem.nextReviewDate ?? todayDhaka(),
          outcome,
          deepest_reveal: deepest,
          recall_note: recallNote,
          next_review_date: nextDate,
          timer_limit_seconds: timerLimitSeconds,
          timer_elapsed_seconds: elapsedSeconds,
        }),
      });
      if (!response.ok) throw new Error("Review save failed");
      await onComplete();
    } finally {
      setSaving(false);
    }
  }

  return (
    <div className="review-overlay">
      <section className="review-surface">
        <header>
          <button onClick={onClose}>← Exit review</button>
          <div className="review-progress">
            <span
              className={elapsedSeconds > timerLimitSeconds ? "overtime" : ""}
            >
              {problem.state ? statusLabel(problem.state) : "Resolve"} ·{" "}
              {elapsedSeconds > timerLimitSeconds ? "+" : ""}
              {formatTimer(Math.abs(timerLimitSeconds - elapsedSeconds))}
              {elapsedSeconds > timerLimitSeconds ? " overtime" : " left"}
            </span>
            <i style={{ width: `${20 + deepestIndex * 16}%` }} />
          </div>
          <span className="review-key">{problem.problemKey}</span>
        </header>
        <div className="review-layout">
          <article className="review-statement">
            <div className="review-meta">
              <span className={`platform platform-${problem.platform}`}>
                {platformLabel(problem.platform)}
              </span>
              <span>{problem.rating ?? "Unrated"}</span>
              <DifficultyTag difficulty={problem.difficulty} />
            </div>
            <h1>{problem.title}</h1>
            <p className="review-instruction">
              Reconstruct the approach, critical observation, and recognition
              trigger before revealing anything.
            </p>
            <Markdown statement>{problem.statementMarkdown}</Markdown>
          </article>
          <aside className="recall-panel">
            <label>
              Your recall note <em>optional</em>
              <textarea
                value={recallNote}
                onChange={(event) => setRecallNote(event.target.value)}
                placeholder="What approach would you try? What should trigger it?"
              />
            </label>
            <div className="reveal-stack">
              {deepestIndex >= 1 ? (
                <RevealCard title="Memory cue">
                  {reflection?.memoryCue ?? "Not captured"}
                </RevealCard>
              ) : null}
              {deepestIndex >= 2 ? (
                <RevealCard title="Key insight">
                  {reflection?.structuredSummary.key_insight ?? "Not captured"}
                </RevealCard>
              ) : null}
              {deepestIndex >= 3 ? (
                <RevealCard title="Full reflection">
                  <ReflectionView reflection={reflection} />
                </RevealCard>
              ) : null}
              {deepestIndex >= 4 ? (
                <RevealCard title="Source code">
                  <pre>{reflection?.sourceSnapshot}</pre>
                </RevealCard>
              ) : null}
            </div>
            {!outcome &&
            hasReflection &&
            deepestIndex < (canRevealSource ? 4 : 3) ? (
              <button className="reveal-button" onClick={revealNext}>
                Reveal{" "}
                {
                  [
                    "",
                    "memory cue",
                    "key insight",
                    "full reflection",
                    "source",
                  ][deepestIndex + 1]
                }
                <span>⌄</span>
              </button>
            ) : null}
            {!canRevealSource && deepestIndex >= 3 ? (
              <p className="source-note">
                Source reference:{" "}
                {reflection?.sourcePath ?? "No matching local source"}. No
                snapshot is stored.
              </p>
            ) : null}
            <div className="outcomes">
              <span>How did recall go?</span>
              <div>
                {(
                  [
                    ["recalled", "Recalled", "Unaided"],
                    ["needed_cue", "Needed cue", "Memory cue"],
                    ["forgot", "Forgot", "Insight / reflection"],
                    ["unresolved", "Unresolved", "Still unclear"],
                  ] as Array<[Outcome, string, string]>
                ).map(([value, label, hint]) => (
                  <button
                    key={value}
                    className={outcome === value ? "selected" : ""}
                    onClick={() => chooseOutcome(value)}
                  >
                    <strong>{label}</strong>
                    <span>{hint}</span>
                  </button>
                ))}
              </div>
            </div>
            {outcome ? (
              <div className="review-confirm">
                <label>
                  Next review
                  <input
                    type="date"
                    value={nextDate}
                    onChange={(event) => setNextDate(event.target.value)}
                  />
                </label>
                <button
                  className="primary"
                  disabled={saving}
                  onClick={() => void complete()}
                >
                  {saving ? "Recording…" : "Complete review"}
                </button>
              </div>
            ) : null}
          </aside>
        </div>
      </section>
    </div>
  );
}

function RevealCard({
  title,
  children,
}: {
  title: string;
  children: React.ReactNode;
}) {
  return (
    <section className="reveal-card">
      <span>{title}</span>
      <div>{children}</div>
    </section>
  );
}

function Property({
  label,
  value,
  mono = false,
  wide = false,
}: {
  label: string;
  value: string;
  mono?: boolean;
  wide?: boolean;
}) {
  return (
    <div className={`property ${wide ? "wide" : ""}`}>
      <span>{label}</span>
      <strong className={mono ? "mono" : ""}>{value}</strong>
    </div>
  );
}

function PropertySection({
  title,
  children,
}: {
  title: string;
  children: React.ReactNode;
}) {
  return (
    <section>
      <div className="section-title">
        <span>{title}</span>
      </div>
      <div className="property-grid">{children}</div>
    </section>
  );
}

function Field({
  title,
  value,
  accent,
  children,
}: {
  title: string;
  value?: string;
  accent?: boolean;
  children?: React.ReactNode;
}) {
  return (
    <section className={`reflection-field ${accent ? "accent" : ""}`}>
      <span>{title}</span>
      {children ?? <p>{value}</p>}
    </section>
  );
}

function JsonBlock({
  title,
  value,
  empty,
}: {
  title: string;
  value: unknown;
  empty?: string;
}) {
  const isEmpty =
    (Array.isArray(value) && value.length === 0) ||
    (value &&
      typeof value === "object" &&
      !Array.isArray(value) &&
      Object.keys(value).length === 0);
  return (
    <section className="json-block">
      <span>{title}</span>
      {isEmpty && empty ? (
        <p>{empty}</p>
      ) : (
        <pre>{JSON.stringify(value, null, 2)}</pre>
      )}
    </section>
  );
}

function EmptyState({ title, body }: { title: string; body: string }) {
  return (
    <div className="empty-state">
      <span>○</span>
      <strong>{title}</strong>
      <p>{body}</p>
    </div>
  );
}
