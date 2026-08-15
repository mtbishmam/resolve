UPDATE problems
SET statement_markdown = replace(
      statement_markdown,
      '```text
N
A_1 A_2 ... A_N
```',
      '$$
\begin{gathered}
N \\
A_1 \quad A_2 \quad \ldots \quad A_N
\end{gathered}
$$'
    ),
    statement_hash = '51b01a5f35ce5bf3f15af0835dda97f2549145de950de69522cc618be64d09f3',
    statement_captured_at = '2026-08-15T17:55:00.000Z',
    metadata_provenance_json = json_set(
      COALESCE(metadata_provenance_json, '{}'),
      '$.input_format', 'semantic_math_v1'
    ),
    updated_at = '2026-08-15T17:55:00.000Z'
WHERE platform = 'atcoder'
  AND problem_key = 'abc446_d'
  AND statement_markdown LIKE '%A_1 A_2 ... A_N%';
