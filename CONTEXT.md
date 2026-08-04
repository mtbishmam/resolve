# ReSolve context

## Purpose

ReSolve is a personal AI learning system designed to maximize competitive
programming improvement while minimizing the friction of reflecting on and
reviewing solved problems.

It is not a startup, social platform, general note-taking app, or Notion clone.
Its objective is faster learning and stronger memory per solved problem.

Every feature must pass one test:

> Does this reduce friction or increase learning from the next solved problem?

Extreme speed is the number-one product requirement.

## Approved workflow

1. Solve a problem.
2. Click the ReSolve extension on the problem page.
3. The extension copies a versioned JSON capture containing the canonical URL,
   problem identity, normalized statement, metadata, TeX, and external image
   links.
4. Paste the capture into Codex running from the ReSolve project.
5. Codex derives the expected solution filename and looks in
   `/Users/mtbishmam/code/competitive-programming/practice`.
6. If a solution exists, Codex may read it as supporting context. If it does
   not exist, Codex asks the user to explain their approach and continues.
7. Codex conducts an adaptive reflection without revealing official tags until
   the user has explained their reasoning.
8. Codex preserves the exact interview messages and generates a compact,
   structured reflection. It derives Codeforces difficulty from rating or
   adaptively assigns difficulty to an unrated CSES problem after hearing the
   user's reasoning.
9. When the user says `push_problem`, Codex invokes one atomic, idempotent
   `save_reflection` MCP tool.
10. ReSolve saves the problem, statement, reflection, and first review date.
11. The web app makes the problem available from desktop or mobile.
12. When due, **Start review** begins progressive active recall and records the
    outcome and next review date.

### Sprint problem flow

1. Open **August Sprint** from the sidebar.
2. Work through CP31 in rating order: 1600 on August 5–11, 1700 on August
   12–18, 1800 on August 19–25, and 1900 on August 26–September 1.
3. Select any problems across any views and create a focused mashup. Choose a
   five-hour duration and, when needed, a start time earlier than now.
4. Solve from the stored statement tabs. ReSolve keeps the global and active-tab
   timers plus Approaches, Lemmas, and Analysis, and saves them in the
   background.
5. When a Sprint problem is later captured and reflected through Codex,
   `save_reflection` recognizes its canonical identity, keeps its Sprint due
   date, adds the reflection, and applies the explicitly supplied State and
   Status.
6. If only workflow properties need changing, use `get_problem` and then
   `update_problem`; no duplicate problem is created.
7. Open Profile → Mashups for dated results. A copied result packet is written
   back through `record_mashup_result`, which requires the existing mashup and
   problem IDs and never creates a new problem.

## Firm decisions

- The product name is **ReSolve**.
- The problem title is only the official problem name. Platform, problem key,
  contest, index, URL, and filename are separate properties.
- Codex is the MVP AI interface. There is no redundant OpenAI or Gemini API
  call for interviewing or summarizing.
- The backend, frontend, MCP server, and application data reside in this
  project.
- Raw solution code remains in the competitive-programming repository.
- A source file is useful but optional.
- The normalized problem statement is stored and rendered directly in ReSolve.
- TeX is preserved and rendered in the frontend.
- Problem images remain external links initially; ReSolve embeds them inline
  and provides an open-at-source fallback.
- AI-generated mnemonic images are deferred.
- Only the approved eight-row private Notion showcase is imported for the MVP;
  the full database remains deferred.
- In-app due and overdue views come before email reminders.
- Status tracks `Backlog`, `Attempting`, `Pending AC`, or `Accepted`.
- Nullable State tracks `Retry`, `Revise`, or `Resolve`:
  - Retry means returning to an unsolved problem.
  - Revise means re-solving for speed or fluency.
  - Resolve means re-solving because recall or confidence is weak.
- Archiving preserves Status and State instead of acting as another Status.
- Pending AC is a saved view, not a special tag.
- Raw interviews are append-only and must never be replaced by a summary.
- Generated classifications may be regenerated later.

## Success

The system succeeds when reflecting on and reviewing important solved problems
becomes fast enough to happen consistently and recall becomes stronger over
time.
