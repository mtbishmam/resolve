# Requirements

## Priority

Extreme speed is the number-one requirement.

## MVP acceptance criteria

- A normal capture requires one extension click, one paste, natural answers,
  and one explicit save command.
- The interview normally finishes in roughly five minutes.
- The web app works on desktop and mobile while the user's computers are
  offline.
- Cached problem lists render immediately and refresh in the background.
- Search, filtering, sorting, and saved-view changes feel instantaneous for a
  personal database containing thousands of problems.
- The problem table is virtualized, and statements, transcripts, and source
  snapshots load only when opened.
- Every problem has a canonical `(platform, problem_key)` identity.
- The visible title contains only the official problem name.
- Statements are readable inside ReSolve without visiting the judge page.
- A reflection can be completed without a source file.
- Raw interview messages are preserved verbatim and append-only.
- Reflection saves are atomic and idempotent.
- Reviews preserve history rather than overwriting the previous result.
- The database can be exported in a provider-independent format.
- The future Notion importer can preserve unmapped legacy properties.
- Private data and write operations require authentication.

## Explicitly deferred

- Importing the complete old Notion problem database beyond the approved
  eight-row private showcase
- AI-generated mnemonic images
- Email reminders
- A standalone AI interviewer in the web app
- Pattern analytics, embeddings, and similar-problem recommendations
- Personalized scheduling beyond the first configurable review ladder
- R2 storage unless large source assets make it necessary
