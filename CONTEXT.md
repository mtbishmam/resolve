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
   structured reflection.
9. When the user says `push_problem`, Codex invokes one atomic, idempotent
   `save_reflection` MCP tool.
10. ReSolve saves the problem, statement, reflection, and first review date.
11. The web app makes the problem available from desktop or mobile.
12. When due, **Start review** begins progressive active recall and records the
    outcome and next review date.

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
- Raw interviews are append-only and must never be replaced by a summary.
- Generated classifications may be regenerated later.

## Success

The system succeeds when reflecting on and reviewing important solved problems
becomes fast enough to happen consistently and recall becomes stronger over
time.
