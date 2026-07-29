# Product

## Product vocabulary

- **Capture**: versioned problem data produced by the browser extension.
- **Reflection**: the Codex interview plus structured learning summary for one
  solved problem.
- **Memory cue**: the shortest useful trigger that helps reconstruct the
  approach without exposing the complete answer.
- **Review**: a progressive active-recall attempt recorded as history.
- **Saved view**: a reusable filter and sort definition.

## Capture and reflection

The browser extension performs deterministic extraction. It does not use AI,
hold database credentials, or write directly to ReSolve.

Codex is the reflection interface. It reads the capture, optionally reads the
user's solution, asks adaptive questions, preserves exact user wording,
generates structured knowledge, proposes a first review date, and saves through
MCP only after the user explicitly requests it.

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
