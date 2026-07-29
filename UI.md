# User interface

## Desktop

### Left: saved views

- Due today
- Retry
- Revise
- Resolve
- All problems
- User-created filter and sort combinations

### Center: dense virtualized table

Default columns:

- Problem
- Platform
- Rating or native difficulty
- Review status
- Next review

The primary cell shows only the official problem name. Contest IDs and filenames
are secondary metadata, never part of the title.

The toolbar provides:

- Search
- Filter builder
- Multi-sort
- Visible-column selection
- Save view

### Right: details drawer

The drawer may show:

- Memory cue
- Key insight
- Next review
- Review history
- Statement
- Structured reflection
- Raw transcript
- Source reference when available
- Open original
- Start review

Heavy content loads only when the drawer opens.

## Mobile

- Compact header
- Search
- Wrapping filter chips
- Compact problem cards
- Bottom navigation for Today, Problems, Views, and Settings
- Full-screen statement/details surface
- Full-screen progressive review surface

Do not copy the tall ReSync mobile sidebar. Mobile should reach due problems
immediately.

## Interaction principles

- Cache first, refresh second
- No image-heavy problem cards
- No decorative animation that delays interaction
- Preserve scroll position when opening and closing details
- Make filter and sort changes optimistic and immediate
- Keep the review action reachable with one tap from a due problem
