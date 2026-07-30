# Review workflow

## State definitions and timers

- **Revise (Insta Solve):** expected to be solvable again, with a speed goal.
  Easy 10m, Medium 20m, Hard 30m, Extreme 30m. Unaided success archives it;
  failure reschedules it.
- **Retry:** previously unsolved. Easy 10m, Medium 30m, Hard 60m, Extreme 90m.
- **Resolve:** uncertain reconstruction. It uses the Retry timer matrix.

State is nullable and independent from Status. Starting a review marks the
problem Attempting. Finishing records timer limit/elapsed seconds and never
silently rewrites State or Status.

## Purpose

A review should strengthen recognition and reconstruction. Passive rereading is
not considered a completed review.

## Start review

When the user presses **Start review**, ReSolve opens a focused review session
for the selected due problem.

Initially visible:

- Official problem name
- Platform, rating, and difficulty as secondary context
- Status and State as secondary workflow context
- Stored problem statement
- Input, output, examples, TeX, and linked diagrams
- A blank optional recall note

Initially hidden:

- Official tags
- Memory cue
- Key insight
- Wrong mental model
- Structured reflection
- Raw transcript
- Source code

The user first attempts to state:

- The approach
- The critical observation
- The recognition trigger they should notice next time

## Progressive reveal

The user may reveal, in order:

1. Memory cue
2. Key insight
3. Full structured reflection
4. Source code, when available

ReSolve records the deepest reveal reached. Source code absence never blocks a
review.

## Completion

The user selects one outcome:

- Recalled
- Needed cue
- Forgot
- Unresolved

ReSolve appends a review event, calculates the next review date using the active
schedule version, and shows the new date. The user may override the date before
confirming.

A review outcome never changes Status because Status records solve and judge
progress. Any State change after review is explicit rather than inferred from
the outcome.

The initial `initial-v1` interval ladder is Recalled 14 days, Needed cue 7 days,
Forgot 2 days, and Unresolved 1 day. It is stored as versioned configuration;
historical rows retain their schedule version. Manual date override remains
available.

## Optional Codex discussion

If the user wants a deeper review, **Discuss in Codex** may copy a
`resolve.review.v1` packet containing the problem identity, statement, prior
reflection, and current recall note. This is optional and does not replace the
fast non-AI review path.
