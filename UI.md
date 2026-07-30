# User interface

The app opens on Due Today. Core views are ordered Due Today, Revise, Retry,
Resolve, All problems, then Pending AC and Archived; they cannot be deleted.
User saved views are separate and deletable.

`Cmd+K`/`Ctrl+K` focuses search. Filters include State, Status, tags, platform,
difficulty, and rating. Overview shows the plain-language Summary, while Memory
Cue and Key Insight live in Reflection. Official tags are hidden until
requested. Difficulty, REVIEW STATE, Status, Review Date, tags, archive state,
and all generated reflection fields are editable; the raw transcript stays
immutable. The side peek is drag-resizable, overlays above 700px, and supports
full-page problems.

## Desktop

### Left: saved views

- Due today
- Retry
- Revise
- Resolve
- Pending AC
- All problems
- Archived
- User-created filter and sort combinations

Retry, Revise, and Resolve filter the State property. Pending AC filters
`Status = Pending AC` and excludes archived problems. Normal views exclude
archived problems; the Archived view is the restore path.

### Center: dense virtualized table

Default columns:

- Problem
- Platform
- Rating
- Difficulty
- Status
- State
- Next review

The primary cell shows only the official problem name. Contest IDs and filenames
are secondary metadata, never part of the title.

The toolbar provides:

- Search
- Filter builder with Status, State, archive visibility, difficulty, and
  inclusive start/end rating
- Multi-sort
- Visible-column selection
- Save view

If only one rating endpoint is filled, the interface mirrors it as an exact
rating. For unrated problems, the numeric range matches any difficulty band it
overlaps.

### Right: details drawer

The drawer may show:

- Memory cue
- Key insight
- Status and State
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
- Status and State controls
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
- Keep Status and State independently editable
- Preserve Status and State when archiving or restoring a problem
- Keep the review action reachable with one tap from a due problem
