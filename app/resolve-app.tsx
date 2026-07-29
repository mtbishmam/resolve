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
import {
  lazy,
  Suspense,
  useCallback,
  useEffect,
  useMemo,
  useRef,
  useState,
} from "react";
import type { ProblemDetail, ProblemListItem } from "@/lib/contracts";
import { INITIAL_INTERVALS, addCalendarDays } from "@/lib/schedule";

const MarkdownContent = lazy(() => import("./markdown"));

function Markdown({
  children,
  className,
}: {
  children: string;
  className?: string;
}) {
  return (
    <Suspense fallback={<div className="markdown-loading">Loading text…</div>}>
      <MarkdownContent className={className}>{children}</MarkdownContent>
    </Suspense>
  );
}

type Viewer = { displayName: string; email: string };
type SavedView = {
  id: string;
  name: string;
  filter: {
    due?: "today";
    status?: string[];
    search?: string;
    platform?: string;
  };
  sort: SortingState;
  visibleColumns: string[];
  isDefault: boolean;
};
type Status = "retry" | "revise" | "resolve";
type Reveal =
  | "none"
  | "memory_cue"
  | "key_insight"
  | "full_reflection"
  | "source";
type Outcome = keyof typeof INITIAL_INTERVALS;

const CACHE_KEY = "resolve.problem-index.v1";
const REVEALS: Reveal[] = [
  "none",
  "memory_cue",
  "key_insight",
  "full_reflection",
  "source",
];
const DEFAULT_COLUMNS = [
  "title",
  "platform",
  "rating",
  "reviewStatus",
  "nextReviewDate",
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
  return platform === "codeforces" ? "Codeforces" : "CSES";
}

function Secondary({ problem }: { problem: ProblemListItem }) {
  return (
    <span className="secondary">
      {problem.contest}
      {problem.problemIndex ? ` · ${problem.problemIndex}` : ""}
    </span>
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
  const [activeViewId, setActiveViewId] = useState("view-due-today");
  const [selectedId, setSelectedId] = useState<string | null>(null);
  const [detail, setDetail] = useState<ProblemDetail | null>(null);
  const [detailLoading, setDetailLoading] = useState(false);
  const [search, setSearch] = useState("");
  const [statusFilter, setStatusFilter] = useState<Status[]>([]);
  const [platformFilter, setPlatformFilter] = useState("all");
  const [minRating, setMinRating] = useState("");
  const [sorting, setSorting] = useState<SortingState>([
    { id: "nextReviewDate", desc: false },
  ]);
  const [visibility, setVisibility] = useState<VisibilityState>({});
  const [filtersOpen, setFiltersOpen] = useState(false);
  const [columnsOpen, setColumnsOpen] = useState(false);
  const [reviewOpen, setReviewOpen] = useState(false);
  const [syncing, setSyncing] = useState(true);
  const [mobileSection, setMobileSection] = useState("today");
  const today = todayDhaka();

  const refresh = useCallback(async () => {
    setSyncing(true);
    try {
      const [problemResponse, viewResponse] = await Promise.all([
        fetch("/api/problems"),
        fetch("/api/saved-views"),
      ]);
      if (!problemResponse.ok || !viewResponse.ok) {
        throw new Error("Unable to refresh ReSolve");
      }
      const problemData = (await problemResponse.json()) as {
        problems: ProblemListItem[];
      };
      const viewData = (await viewResponse.json()) as { views: SavedView[] };
      setProblems(problemData.problems);
      setViews(viewData.views);
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

  const loadDetail = useCallback(async (id: string) => {
    setSelectedId(id);
    setDetailLoading(true);
    try {
      const response = await fetch(`/api/problems/${encodeURIComponent(id)}`);
      if (!response.ok) throw new Error("Problem details unavailable");
      const data = (await response.json()) as { problem: ProblemDetail };
      setDetail(data.problem);
    } finally {
      setDetailLoading(false);
    }
  }, []);

  const activeView = views.find((view) => view.id === activeViewId);
  const filteredProblems = useMemo(() => {
    const query = search.trim().toLowerCase();
    return problems.filter((problem) => {
      const dueMatch =
        activeView?.filter.due !== "today" ||
        (problem.nextReviewDate !== null && problem.nextReviewDate <= today);
      const viewStatus = activeView?.filter.status;
      const viewStatusMatch =
        !viewStatus?.length || viewStatus.includes(problem.reviewStatus);
      const statusMatch =
        !statusFilter.length ||
        statusFilter.includes(problem.reviewStatus as Status);
      const platformMatch =
        platformFilter === "all" || problem.platform === platformFilter;
      const ratingMatch =
        !minRating ||
        (problem.rating !== null && problem.rating >= Number(minRating));
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
        viewStatusMatch &&
        statusMatch &&
        platformMatch &&
        ratingMatch &&
        textMatch
      );
    });
  }, [
    activeView,
    minRating,
    platformFilter,
    problems,
    search,
    statusFilter,
    today,
  ]);

  function selectView(view: SavedView) {
    setActiveViewId(view.id);
    setSearch(view.filter.search ?? "");
    setStatusFilter((view.filter.status ?? []) as Status[]);
    setPlatformFilter(view.filter.platform ?? "all");
    if (view.sort.length) setSorting(view.sort);
    setVisibility(
      Object.fromEntries(
        DEFAULT_COLUMNS.map((column) => [
          column,
          view.visibleColumns.includes(column),
        ]),
      ),
    );
    setMobileSection(view.id === "view-due-today" ? "today" : "views");
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
          status: statusFilter,
          platform: platformFilter,
        },
        sort: sorting,
        visibleColumns,
      }),
    });
    if (response.ok) await refresh();
  }

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
      columnHelper.accessor("reviewStatus", {
        header: "State",
        size: 116,
        cell: ({ getValue }) => (
          <span className={`status status-${getValue()}`}>
            {statusLabel(getValue())}
          </span>
        ),
      }),
      columnHelper.accessor("nextReviewDate", {
        header: "Next review",
        size: 132,
        sortingFn: "datetime",
        cell: ({ getValue }) => {
          const value = getValue();
          return (
            <span
              className={
                value && value <= today ? "due-date overdue" : "due-date"
              }
            >
              {dateLabel(value)}
            </span>
          );
        },
      }),
    ],
    [loadDetail, today],
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
  };

  async function updateDetail(
    patch: Partial<{
      rating: number | null;
      reviewStatus: Status;
      nextReviewDate: string | null;
    }>,
  ) {
    if (!detail) return;
    const response = await fetch(`/api/problems/${detail.id}`, {
      method: "PATCH",
      headers: { "content-type": "application/json" },
      body: JSON.stringify(patch),
    });
    if (!response.ok) return;
    const data = (await response.json()) as { problem: ProblemDetail };
    setDetail(data.problem);
    await refresh();
  }

  return (
    <main className="app-shell">
      <aside className="sidebar">
        <div className="brand-row">
          <span className="brand-mark">R</span>
          <div>
            <strong>ReSolve</strong>
            <span>Recall what matters</span>
          </div>
        </div>
        <div className="sidebar-heading">Saved views</div>
        <nav className="view-nav" aria-label="Saved views">
          {views.map((view) => {
            const count = problems.filter((problem) => {
              if (view.filter.due === "today") {
                return (
                  problem.nextReviewDate !== null &&
                  problem.nextReviewDate <= today
                );
              }
              return (
                !view.filter.status?.length ||
                view.filter.status.includes(problem.reviewStatus)
              );
            }).length;
            return (
              <button
                key={view.id}
                className={activeViewId === view.id ? "active" : ""}
                onClick={() => selectView(view)}
              >
                <span className={`view-dot ${view.id.replace("view-", "")}`} />
                <span>{view.name}</span>
                <em>{count}</em>
              </button>
            );
          })}
        </nav>
        <button className="new-view" onClick={() => void saveCurrentView()}>
          <span>＋</span> Save current view
        </button>
        <div className="sidebar-spacer" />
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

      <section className={`workspace ${selectedId ? "drawer-open" : ""}`}>
        <header className="topbar">
          <div>
            <div className="eyebrow">Problem library</div>
            <h1>{activeView?.name ?? "All problems"}</h1>
            <p>
              {filteredProblems.length} problems
              {activeView?.filter.due === "today"
                ? " ready for active recall"
                : " in this view"}
            </p>
          </div>
          <button className="avatar" title={viewer.email}>
            {viewer.displayName.slice(0, 1).toUpperCase()}
          </button>
        </header>

        <div className="toolbar">
          <label className="search">
            <span>⌕</span>
            <input
              value={search}
              onChange={(event) => setSearch(event.target.value)}
              placeholder="Search name, contest, or key…"
            />
            <kbd>⌘ K</kbd>
          </label>
          <div className="toolbar-actions">
            <button
              className={filtersOpen ? "active" : ""}
              onClick={() => setFiltersOpen((value) => !value)}
            >
              Filters
              {statusFilter.length || platformFilter !== "all" || minRating ? (
                <b>
                  {statusFilter.length +
                    Number(platformFilter !== "all") +
                    Number(Boolean(minRating))}
                </b>
              ) : null}
            </button>
            <button
              className={sorting.length ? "active" : ""}
              onClick={() =>
                setSorting((current) =>
                  current[0]?.desc
                    ? [{ id: "nextReviewDate", desc: false }]
                    : [{ id: "nextReviewDate", desc: true }],
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
              {(["retry", "revise", "resolve"] as Status[]).map((status) => (
                <button
                  key={status}
                  className={statusFilter.includes(status) ? "selected" : ""}
                  onClick={() =>
                    setStatusFilter((current) =>
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
              Platform
              <select
                value={platformFilter}
                onChange={(event) => setPlatformFilter(event.target.value)}
              >
                <option value="all">All</option>
                <option value="codeforces">Codeforces</option>
                <option value="cses">CSES</option>
              </select>
            </label>
            <label>
              Minimum rating
              <input
                type="number"
                value={minRating}
                onChange={(event) => setMinRating(event.target.value)}
                placeholder="Any"
              />
            </label>
            <button
              className="clear-filters"
              onClick={() => {
                setStatusFilter([]);
                setPlatformFilter("all");
                setMinRating("");
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
        />
        <ProblemCards
          problems={table.getRowModel().rows.map((row) => row.original)}
          onSelect={loadDetail}
          onReview={(problem) => {
            void loadDetail(problem.id).then(() => setReviewOpen(true));
          }}
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
          detail={detail}
          loading={detailLoading}
          onClose={closeDetail}
          onReview={() => setReviewOpen(true)}
          onUpdate={updateDetail}
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
                if (due) selectView(due);
              } else if (id === "problems") {
                const all = views.find((view) => view.id === "view-all");
                if (all) selectView(all);
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
}: {
  table: ReturnType<typeof useReactTable<ProblemListItem>>;
  selectedId: string | null;
  onSelect: (id: string) => Promise<void>;
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
      <div className="table-head">
        {table.getHeaderGroups().map((headerGroup) =>
          headerGroup.headers.map((header) => (
            <button
              key={header.id}
              style={{ width: header.getSize() }}
              onClick={header.column.getToggleSortingHandler()}
            >
              {flexRender(header.column.columnDef.header, header.getContext())}
              {{
                asc: " ↑",
                desc: " ↓",
              }[header.column.getIsSorted() as string] ?? ""}
            </button>
          )),
        )}
      </div>
      <div className="table-scroll" ref={parentRef}>
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
                onDoubleClick={() => void onSelect(row.original.id)}
              >
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
}: {
  problems: ProblemListItem[];
  onSelect: (id: string) => Promise<void>;
  onReview: (problem: ProblemListItem) => void;
}) {
  return (
    <div className="problem-cards">
      {problems.map((problem) => (
        <article key={problem.id} onClick={() => void onSelect(problem.id)}>
          <div className="card-meta">
            <span className={`platform platform-${problem.platform}`}>
              {platformLabel(problem.platform)}
            </span>
            <span className={`status status-${problem.reviewStatus}`}>
              {statusLabel(problem.reviewStatus)}
            </span>
          </div>
          <h2>{problem.title}</h2>
          <Secondary problem={problem} />
          <div className="card-bottom">
            <span>{problem.rating ?? "Native difficulty"}</span>
            <strong>{dateLabel(problem.nextReviewDate)}</strong>
            {problem.nextReviewDate &&
            problem.nextReviewDate <= todayDhaka() ? (
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
}: {
  detail: ProblemDetail | null;
  loading: boolean;
  onClose: () => void;
  onReview: () => void;
  onUpdate: (
    patch: Partial<{
      rating: number | null;
      reviewStatus: Status;
      nextReviewDate: string | null;
    }>,
  ) => Promise<void>;
}) {
  const [tab, setTab] = useState("overview");
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
    <aside className="detail-drawer">
      <div className="drawer-top">
        <button className="drawer-close" onClick={onClose} aria-label="Close">
          ×
        </button>
        <div className="drawer-actions">
          <a href={detail.url} target="_blank" rel="noreferrer">
            Open judge ↗
          </a>
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
          <span className={`status status-${detail.reviewStatus}`}>
            {statusLabel(detail.reviewStatus)}
          </span>
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
            <section className="recall-card">
              <span>Memory cue</span>
              <p>{reflection?.memoryCue ?? "Not captured"}</p>
            </section>
            <section className="insight-card">
              <span>Key insight</span>
              <p>
                {reflection?.structuredSummary.key_insight ?? "Not captured"}
              </p>
              {reflection?.structuredSummary.provenance.key_insight ===
              "codex_inferred_demo" ? (
                <em>AI-inferred showcase field · needs confirmation</em>
              ) : null}
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
                <span>Review state</span>
                <select
                  value={detail.reviewStatus}
                  onChange={(event) =>
                    void onUpdate({
                      reviewStatus: event.target.value as Status,
                    })
                  }
                >
                  <option value="retry">Retry</option>
                  <option value="revise">Revise</option>
                  <option value="resolve">Resolve</option>
                </select>
              </label>
              <label className="editable-property wide">
                <span>Next review</span>
                <input
                  type="date"
                  value={detail.nextReviewDate ?? ""}
                  onChange={(event) =>
                    void onUpdate({
                      nextReviewDate: event.target.value || null,
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
              <Property
                label="Official tags"
                value={detail.officialTags.join(", ") || "Not captured"}
                wide
              />
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
            <Markdown>{detail.statementMarkdown}</Markdown>
          </section>
        ) : null}
        {tab === "reflection" ? (
          <ReflectionView reflection={reflection} />
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
  const reflection = problem.reflection;
  const deepestIndex = REVEALS.indexOf(deepest);
  const canRevealSource = Boolean(reflection?.sourceSnapshot);

  function revealNext() {
    const max = canRevealSource ? 4 : 3;
    const nextIndex = Math.min(deepestIndex + 1, max);
    setDeepest(REVEALS[nextIndex]);
  }

  function chooseOutcome(value: Outcome) {
    setOutcome(value);
    setNextDate(addCalendarDays(todayDhaka(), INITIAL_INTERVALS[value]));
  }

  async function complete() {
    if (!outcome || !reflection || !nextDate) return;
    setSaving(true);
    try {
      const response = await fetch("/api/reviews", {
        method: "POST",
        headers: { "content-type": "application/json" },
        body: JSON.stringify({
          idempotency_key: `web:${problem.id}:${crypto.randomUUID()}`,
          problem_id: problem.id,
          reflection_id: reflection.id,
          due_date: problem.nextReviewDate ?? todayDhaka(),
          outcome,
          deepest_reveal: deepest,
          recall_note: recallNote,
          next_review_date: nextDate,
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
            <span>Active recall</span>
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
              <span>{problem.rating ?? "Native difficulty"}</span>
            </div>
            <h1>{problem.title}</h1>
            <p className="review-instruction">
              Reconstruct the approach, critical observation, and recognition
              trigger before revealing anything.
            </p>
            <Markdown>{problem.statementMarkdown}</Markdown>
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
            {!outcome && deepestIndex < (canRevealSource ? 4 : 3) ? (
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
