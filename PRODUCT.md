# Product

ReSolve has two independent workflow axes: review **State** and solve
**Status**. Monthly Sprints turn a fixed practice sheet into daily due dates
without inventing missing problems. August 2026 targets the 1600, 1700, 1800,
and 1900 CP31 bands at five problems per day, one seven-day block per band;
September remains to be decided.

## Product vocabulary

- **Capture**: versioned problem data produced by the browser extension.
- **Reflection**: the Codex interview plus structured learning summary for one
  solved problem.
- **Memory cue**: the shortest useful trigger that helps reconstruct the
  approach without exposing the complete answer.
- **Review**: a progressive active-recall attempt recorded as history.
- **Saved view**: a reusable filter and sort definition.
- **Status**: the objective progress of the initial solve and judge submission.
- **State**: the nullable learning action currently queued for the problem.

## Capture and reflection

The browser extension performs deterministic extraction. It does not use AI,
hold database credentials, or write directly to ReSolve.

Codex is the reflection interface. It reads the capture, optionally reads the
user's solution, asks adaptive questions, preserves exact user wording,
generates structured knowledge, assigns unrated problems an adaptive difficulty
after hearing the user's reasoning, proposes a first review date, and saves
through MCP only after the user explicitly requests it.

The generated outputs have a strict separation:

- **Problem summary:** an objective, story-free description of the task: the
  input, required selection or computation, defining condition, and output.
  It contains no user-specific reasoning, failed attempts, solution, or lesson.
- **Metacognitive reflection:** the user's first approach, assumptions, stuck or
  failure point, breakthrough, reusable trigger, mistakes, missing concepts,
  pattern, and confidence. This belongs in the structured reflection and exact
  transcript, not in the problem summary.

The structured reflection should capture:

- Key insight
- Wrong mental model
- Why it seemed reasonable
- Breakthrough observation
- Correct future trigger
- Missing concepts
- General pattern
- Cognitive mistakes
- Next-time cue
- Confidence

## Problem library

The default web experience is a fast database, not a card gallery.

Desktop:

- Saved review and custom views on the left
- Dense virtualized problem table in the center
- Details drawer on the right

Mobile:

- Compact problem cards
- Search and filter chips
- Bottom navigation
- A full-screen problem and review surface when opened

The problem name is the primary visible identifier. Platform and contest
metadata are secondary.

### Status and State

Status tracks objective progress:

- **Backlog**: not started and saved for later.
- **Attempting**: started but not yet solved locally.
- **Pending AC**: solved locally but not yet accepted by the judge.
- **Accepted**: received an accepted judge verdict.

State tracks the next learning action and may be empty:

- **Retry**: return to an unsolved problem and attempt it again.
- **Revise**: re-solve a solved problem to improve speed or fluency.
- **Resolve**: reconstruct a solved problem when confidence or recall is weak.

Backlog may not have a State. Attempting may have Retry or no State. Pending AC
and Accepted may have Revise, Resolve, or no State. A failed submission returns
the problem to Attempting and may set Retry.

No separate Done value is needed; an empty State means that no learning action
is currently queued. Status and State are not topic tags.

Archiving is independent of Status and State. An archived problem retains both
values, is hidden from normal views, and can be restored without losing its
workflow position.

**Pending AC** is a saved view filtered to active problems whose Status is
Pending AC. It is not represented by a `!AC` tag or badge.

Difficulty is a separate single-select property:

- Easy: rating below 1600
- Medium: rating from 1600 through 2399
- Hard: rating from 2400 through 2999
- Extreme: rating from 3000 through 3500

Numeric problem ratings deterministically derive difficulty. Unrated problems
receive adaptive difficulty from Codex during reflection rather than copied
from a generic external list.

Rating filtering uses inclusive start and end fields. Supplying only one field
means an exact-rating query. An unrated problem matches a numeric range when its
difficulty band overlaps that range.

## Statement reader

ReSolve stores normalized Markdown rather than depending on the judge page at
read time. The reader supports:

- Problem statement
- Input and output sections
- Examples
- TeX mathematics
- External diagrams and images
- Link to the original judge page

Raw HTML is not rendered. Captured content must be sanitized and treated as
untrusted data.

## Review

Pressing **Start review** does not reveal the saved answer and does not require
Codex.

It begins a progressive retrieval session:

1. Show the problem name and statement.
2. Hide official tags, memory cue, key insight, full reflection, and source.
3. Ask the user to reconstruct the approach and the recognition trigger.
4. Allow progressive reveal in this order:
   - Memory cue
   - Key insight
   - Full reflection
   - Source code, only when available
5. Let the user record an optional short recall note.
6. Record the deepest reveal required and the user's outcome.
7. Calculate and show the next review date.

The initial outcome vocabulary is:

- **Recalled**: reconstructed unaided
- **Needed cue**: reconstructed after the memory cue
- **Forgot**: needed the key insight or full reflection
- **Unresolved**: still does not understand or cannot reconstruct the solution

The exact interval ladder remains configurable. Manual date override is always
available.

An optional **Discuss in Codex** action may copy a versioned review packet for a
deeper conversation, but it is not required to complete a review.

## Future memory imagery

AI-generated mnemonic images may later help create distinctive memories for
selected problems. They are not part of the MVP and should not add fields or
workflow friction yet.
