# Capture contract

Adapter v2 reads MathJax source `<script type="math/tex">` nodes and ignores the
rendered MathJax and assistive MathML copies. This prevents duplicated
Unicode/plain-text/TeX. Sample input/output child lines are joined with explicit
newlines before fenced text blocks. The schema stays `resolve.capture.v1` and
`provenance.adapter_version` is `2`.

## Extension responsibility

The first extension supports Codeforces. It performs user-triggered,
deterministic extraction from the open problem page.

It should:

- Parse canonical identity from accepted Codeforces URL forms
- Extract and normalize the official problem name
- Preserve statement structure
- Recover original TeX where possible
- Convert relative image paths to absolute URLs
- Include metadata provenance and adapter version
- Copy one versioned JSON envelope
- Retain the latest capture locally for recovery
- Show explicit success or failure feedback

It should not:

- Use AI
- Hold database or MCP credentials
- Write directly to the database
- Copy raw page HTML by default
- Embed images as base64 by default

## Envelope

```json
{
  "schema": "resolve.capture.v1",
  "capture_id": "uuid",
  "captured_at": "ISO-8601 timestamp",
  "platform": "codeforces",
  "problem_key": "2179:D",
  "url": "https://codeforces.com/contest/2179/problem/D",
  "problem": {
    "contest_id": 2179,
    "index": "D",
    "title": "Official problem name",
    "rating": 1800,
    "official_tags": []
  },
  "statement": {
    "format": "markdown",
    "text": "Normalized statement",
    "assets": [
      {
        "url": "https://codeforces.com/absolute/image/path",
        "alt": "Problem diagram"
      }
    ]
  },
  "provenance": {
    "adapter": "codeforces",
    "adapter_version": "1",
    "language": "en"
  }
}
```

Official tags may be present in the transport, but Codex must not reveal them
before the user explains their reasoning.

## Failure handling

- If metadata fails, preserve the statement and canonical URL with
  `metadata_status = pending`.
- If statement extraction fails, allow a URL-only capture and ask for the
  statement or retry.
- If the clipboard payload exceeds the safe capture limit, download a JSON
  capture file instead.
- If an external image fails later, show its alt text and an open-at-source
  link.
