INSERT INTO problems (
  id, platform, problem_key, url, title, contest, problem_index, rating,
  official_tags_json, statement_markdown, statement_assets_json, statement_hash,
  statement_captured_at, metadata_status, metadata_provenance_json,
  legacy_metadata_json, import_source, import_provenance_json, review_status,
  next_review_date, created_at, updated_at
) VALUES (
  'cf-1554-b', 'codeforces', '1554:B', 'https://codeforces.com/contest/1554/problem/B',
  'Cobb', 'Codeforces 1554', 'B', '1700',
  '["bitmasks","brute force","greedy","math"]', 'You are given $$$n$$$ integers $$$a_1, a_2, \ldots, a_n$$$ and an integer $$$k$$$. Find the maximum value of $$$i \cdot j - k \cdot (a_i | a_j)$$$ over all pairs $$$(i, j)$$$ of integers with $$$1 \le i < j \le n$$$. Here, $$$|$$$ is the bitwise OR operator.

## Input

The first line contains a single integer $$$t$$$ ($$$1 \le t \le 10\,000$$$)  — the number of test cases.

The first line of each test case contains two integers $$$n$$$ ($$$2 \le n \le 10^5$$$) and $$$k$$$ ($$$1 \le k \le \min(n, 100)$$$).

The second line of each test case contains $$$n$$$ integers $$$a_1, a_2, \ldots, a_n$$$ ($$$0 \le a_i \le n$$$).

It is guaranteed that the sum of $$$n$$$ over all test cases doesn''t exceed $$$3 \cdot 10^5$$$.

## Output

For each test case, print a single integer  — the maximum possible value of $$$i \cdot j - k \cdot (a_i | a_j)$$$.

## Examples

Input:

```text
4
3 3
1 1 3
2 2
1 2
4 3
0 1 2 3
6 6
3 2 0 0 5 6
```

Output:

```text
-1
-4
3
12
```

## Note

Let $$$f(i, j) = i \cdot j - k \cdot (a_i | a_j)$$$.

In the first test case,

- $$$f(1, 2) = 1 \cdot 2 - k \cdot (a_1 | a_2) = 2 - 3 \cdot (1 | 1) = -1$$$.
- $$$f(1, 3) = 1 \cdot 3 - k \cdot (a_1 | a_3) = 3 - 3 \cdot (1 | 3) = -6$$$.
- $$$f(2, 3) = 2 \cdot 3 - k \cdot (a_2 | a_3) = 6 - 3 \cdot (1 | 3) = -3$$$.

So the maximum is $$$f(1, 2) = -1$$$.

In the fourth test case, the maximum is $$$f(3, 4) = 12$$$.', '[]',
  '61157741a0fc17c83e943ceb357df98a8409dd3837dae2deb312e48c8e95adb2', '2026-07-30T00:00:00.000Z', 'complete',
  '{"title":"codeforces_api","rating":"codeforces_api","official_tags":"codeforces_api","statement":"huggingface_snapshot_of_codeforces"}', '{"notion_properties":{"Summary":null,"Gains":"a[i] <= n, means that the maximum value of any (a[i] | a[j]) can be atmost 2 * n\ni * j / a[i] | a[j] for all pairs cannot be calculated fast enough anyhow\nThe fact that a[i] <= n && k <= 100 both combined the critical factor","Metacognition":"// why is k so small?\n// a[i] <= n?\n\n/* Lemmas\n    1. We''ll have to do an exhaustive search\n*/\n\n/* Solutions\n    1. per bit by bit operation?\n    2. brute force to deduce pattern\n    3. binary search?\n*/\n\n/* Problems\n    I don''t know how to do i * j fast for all pairs yet\n    I don''t know how to do (ai | aj) for all pairs yet\n    I can''t figure out what small k implies yet\n    Does a[i] <= n imply something?\n*/","Tags":["Retry","Bitwise","All Pairs"],"Difficulty":"1700"}}', 'notion_showcase_v1',
  '{"notion_row_url":"https://app.notion.com/2a4f02b8a3264c268248b292b7aac3b2","selected_because":"Strong Retry example with detailed constraint-driven metacognition and a reusable brute-force bound.","imported_at":"2026-07-30T00:00:00.000Z","seeded_demo_schedule":true,"learning_field_warning":"Codex-inferred demo fields need user confirmation and are not original wording."}', 'retry', '2026-07-30',
  '2026-07-30T00:00:00.000Z', '2026-07-30T00:00:00.000Z'
) ON CONFLICT(platform, problem_key) DO UPDATE SET
  url = excluded.url,
  title = excluded.title,
  contest = excluded.contest,
  problem_index = excluded.problem_index,
  rating = excluded.rating,
  official_tags_json = excluded.official_tags_json,
  statement_markdown = excluded.statement_markdown,
  statement_assets_json = excluded.statement_assets_json,
  statement_hash = excluded.statement_hash,
  statement_captured_at = excluded.statement_captured_at,
  metadata_status = excluded.metadata_status,
  metadata_provenance_json = excluded.metadata_provenance_json,
  legacy_metadata_json = excluded.legacy_metadata_json,
  import_source = excluded.import_source,
  import_provenance_json = excluded.import_provenance_json,
  updated_at = excluded.updated_at;

INSERT INTO reflections (
  id, idempotency_key, problem_id, source_path, source_snapshot, source_status,
  transcript_messages_json, transcript_hash, summary_markdown,
  structured_summary_json, memory_cue, confidence, first_review_date, created_at
) VALUES (
  'cf-1554-b-reflection-1', 'showcase:cf-1554-b:reflection:1', 'cf-1554-b',
  '/Users/mtbishmam/code/competitive-programming/practice/1554B.cpp', NULL, 'found',
  '[]', '4f53cda18c2baa0c0354bb5f9a3ecbe5ed12ab4d8e11ba873c2f11161202b945',
  'a[i] <= n, means that the maximum value of any (a[i] | a[j]) can be atmost 2 * n
i * j / a[i] | a[j] for all pairs cannot be calculated fast enough anyhow
The fact that a[i] <= n && k <= 100 both combined the critical factor', '{"key_insight":"The combined bounds a[i] <= n and k <= 100 make only a short suffix of indices worth checking.","wrong_mental_model":"I don''t know how to do i * j fast for all pairs yet; I don''t know how to do (ai | aj) for all pairs yet.","why_it_seemed_reasonable":"Not captured","breakthrough_observation":"a[i] <= n bounds every bitwise OR by less than 2n, while the i*j term grows with large indices.","correct_trigger":"Ask: why is k so small, and why is a[i] <= n?","missing_concepts":["Bounding competing terms"],"general_pattern":"When one term is globally bounded, restrict exhaustive search to where the unbounded term is largest.","cognitive_mistakes":[],"provenance":{"key_insight":"codex_inferred_demo","wrong_mental_model":"source_derived","correct_trigger":"codex_inferred_demo","general_pattern":"codex_inferred_demo"}}',
  'Bound the OR penalty; scan the high-index suffix.', NULL, '2026-07-30',
  '2026-07-30T00:00:00.000Z'
) ON CONFLICT(idempotency_key) DO NOTHING;

INSERT INTO problems (
  id, platform, problem_key, url, title, contest, problem_index, rating,
  official_tags_json, statement_markdown, statement_assets_json, statement_hash,
  statement_captured_at, metadata_status, metadata_provenance_json,
  legacy_metadata_json, import_source, import_provenance_json, review_status,
  next_review_date, created_at, updated_at
) VALUES (
  'cf-1486-b', 'codeforces', '1486:B', 'https://codeforces.com/contest/1486/problem/B',
  'Eastern Exhibition', 'Codeforces 1486', 'B', '1500',
  '["binary search","geometry","shortest paths","sortings"]', 'You and your friends live in $$$n$$$ houses. Each house is located on a 2D plane, in a point with integer coordinates. There might be different houses located in the same point. The mayor of the city is asking you for places for the building of the Eastern exhibition. You have to find the number of places (points with integer coordinates), so that the summary distance from all the houses to the exhibition is minimal. The exhibition can be built in the same point as some house. The distance between two points $$$(x_1, y_1)$$$ and $$$(x_2, y_2)$$$ is $$$|x_1 - x_2| + |y_1 - y_2|$$$, where $$$|x|$$$ is the absolute value of $$$x$$$.

## Input

First line contains a single integer $$$t$$$ $$$(1 \leq t \leq 1000)$$$ — the number of test cases.

The first line of each test case contains a single integer $$$n$$$ $$$(1 \leq n \leq 1000)$$$. Next $$$n$$$ lines describe the positions of the houses $$$(x_i, y_i)$$$ $$$(0 \leq x_i, y_i \leq 10^9)$$$.

It''s guaranteed that the sum of all $$$n$$$ does not exceed $$$1000$$$.

## Output

For each test case output a single integer - the number of different positions for the exhibition. The exhibition can be built in the same point as some house.

## Examples

Input:

```text
6
3
0 0
2 0
1 2
4
1 0
0 2
2 3
3 1
4
0 0
0 1
1 0
1 1
2
0 0
1 1
2
0 0
2 0
2
0 0
0 0
```

Output:

```text
1
4
4
4
3
1
```

## Note

Here are the images for the example test cases. Blue dots stand for the houses, green — possible positions for the exhibition.

First test case.

Second test case.

Third test case.

Fourth test case.

Fifth test case.

Sixth test case. Here both houses are located at $$$(0, 0)$$$.', '[]',
  '7cd50292cf0bde7c1b7a840dca7ac840a308f4c3c3e551167f307ccc744c8ca1', '2026-07-30T00:00:00.000Z', 'complete',
  '{"title":"codeforces_api","rating":"codeforces_api","official_tags":"codeforces_api","statement":"huggingface_snapshot_of_codeforces"}', '{"notion_properties":{"Summary":"A good problem about manhattan distance","Gains":"Should''ve thought about medians and such, need to implement a method that atleast makes me consider those options. Another important lesson: for geometry problems if we can solve it for one dimension, then we can maybe extend it to two dimensions","Metacognition":"/* Analysis\n    The minimum distance between any two points is the min di\n    after getting the min_dis, we''ll just check how many pairs have that min_dis?\n\n*/\n\n/* Sols\n    1. get min distance between any pair of nodes\n    then, get the node with the maxmum number of\n\n    2. Compress all coordinates, then get the lower and upper bounds on both x & y and do a n^2 solution?\n*/","Tags":["Retry","Lesson","Geometry"],"Difficulty":"1500"}}', 'notion_showcase_v1',
  '{"notion_row_url":"https://app.notion.com/31325e4e074344fe9ce199d31f3fd468","selected_because":"Detailed Retry geometry row showing an incorrect distance model and a clear median trigger.","imported_at":"2026-07-30T00:00:00.000Z","seeded_demo_schedule":true,"learning_field_warning":"Codex-inferred demo fields need user confirmation and are not original wording."}', 'retry', '2026-07-29',
  '2026-07-30T00:00:00.000Z', '2026-07-30T00:00:00.000Z'
) ON CONFLICT(platform, problem_key) DO UPDATE SET
  url = excluded.url,
  title = excluded.title,
  contest = excluded.contest,
  problem_index = excluded.problem_index,
  rating = excluded.rating,
  official_tags_json = excluded.official_tags_json,
  statement_markdown = excluded.statement_markdown,
  statement_assets_json = excluded.statement_assets_json,
  statement_hash = excluded.statement_hash,
  statement_captured_at = excluded.statement_captured_at,
  metadata_status = excluded.metadata_status,
  metadata_provenance_json = excluded.metadata_provenance_json,
  legacy_metadata_json = excluded.legacy_metadata_json,
  import_source = excluded.import_source,
  import_provenance_json = excluded.import_provenance_json,
  updated_at = excluded.updated_at;

INSERT INTO reflections (
  id, idempotency_key, problem_id, source_path, source_snapshot, source_status,
  transcript_messages_json, transcript_hash, summary_markdown,
  structured_summary_json, memory_cue, confidence, first_review_date, created_at
) VALUES (
  'cf-1486-b-reflection-1', 'showcase:cf-1486-b:reflection:1', 'cf-1486-b',
  '/Users/mtbishmam/code/competitive-programming/practice/1486B.cpp', NULL, 'found',
  '[]', '4f53cda18c2baa0c0354bb5f9a3ecbe5ed12ab4d8e11ba873c2f11161202b945',
  'A good problem about manhattan distance', '{"key_insight":"Manhattan distance separates by dimension; each coordinate is minimized by the median interval.","wrong_mental_model":"Find the minimum distance between pairs of given points, then count pairs at that distance.","why_it_seemed_reasonable":"The objective mentions distance, so pairwise distances looked like the direct quantity to minimize.","breakthrough_observation":"Solve the one-dimensional absolute-distance problem, then multiply the valid x and y choices.","correct_trigger":"For Manhattan geometry, solve one dimension first and consider medians.","missing_concepts":["Median minimizes absolute deviations"],"general_pattern":"Separable objectives can be optimized independently per coordinate.","cognitive_mistakes":["Focused on pairwise distances instead of the chosen meeting point"],"provenance":{"key_insight":"codex_inferred_demo","wrong_mental_model":"source_derived","correct_trigger":"codex_inferred_demo","general_pattern":"codex_inferred_demo"}}',
  'Manhattan -> split axes -> median intervals.', NULL, '2026-07-29',
  '2026-07-30T00:00:00.000Z'
) ON CONFLICT(idempotency_key) DO NOTHING;

INSERT INTO problems (
  id, platform, problem_key, url, title, contest, problem_index, rating,
  official_tags_json, statement_markdown, statement_assets_json, statement_hash,
  statement_captured_at, metadata_status, metadata_provenance_json,
  legacy_metadata_json, import_source, import_provenance_json, review_status,
  next_review_date, created_at, updated_at
) VALUES (
  'cf-1702-e', 'codeforces', '1702:E', 'https://codeforces.com/contest/1702/problem/E',
  'Split Into Two Sets', 'Codeforces 1702', 'E', '1600',
  '["dfs and similar","dsu","graphs"]', 'Polycarp was recently given a set of $$$n$$$ (number $$$n$$$ — even) dominoes. Each domino contains two integers from $$$1$$$ to $$$n$$$.

Can he divide all the dominoes into two sets so that all the numbers on the dominoes of each set are different? Each domino must go into exactly one of the two sets.

For example, if he has $$$4$$$ dominoes: $$$\{1, 4\}$$$, $$$\{1, 3\}$$$, $$$\{3, 2\}$$$ and $$$\{4, 2\}$$$, then Polycarp will be able to divide them into two sets in the required way. The first set can include the first and third dominoes ($$$\{1, 4\}$$$ and $$$\{3, 2\}$$$), and the second set — the second and fourth ones ($$$\{1, 3\}$$$ and $$$\{4, 2\}$$$).

## Input

The first line contains a single integer $$$t$$$ ($$$1 \le t \le 10^4$$$) — the number of test cases.

The descriptions of the test cases follow.

The first line of each test case contains a single even integer $$$n$$$ ($$$2 \le n \le 2 \cdot 10^5$$$) — the number of dominoes.

The next $$$n$$$ lines contain pairs of numbers $$$a_i$$$ and $$$b_i$$$ ($$$1 \le a_i, b_i \le n$$$) describing the numbers on the $$$i$$$-th domino.

It is guaranteed that the sum of $$$n$$$ over all test cases does not exceed $$$2 \cdot 10^5$$$.

## Output

For each test case print:

- YES, if it is possible to divide $$$n$$$ dominoes into two sets so that the numbers on the dominoes of each set are different;
- NO if this is not possible.

You can print YES and NO in any case (for example, the strings yEs, yes, Yes and YES will be recognized as a positive answer).

## Examples

Input:

```text
6
4
1 2
4 3
2 1
3 4
6
1 2
4 5
1 3
4 6
2 3
5 6
2
1 1
2 2
2
1 2
2 1
8
2 1
1 2
4 3
4 3
5 6
5 7
8 6
7 8
8
1 2
2 1
4 3
5 3
5 4
6 7
8 6
7 8
```

Output:

```text
YES
NO
NO
YES
YES
NO
```

## Note

In the first test case, the dominoes can be divided as follows:

- First set of dominoes: $$$[\{1, 2\}, \{4, 3\}]$$$
- Second set of dominoes: $$$[\{2, 1\}, \{3, 4\}]$$$

In the second test case, there''s no way to divide dominoes into $$$2$$$ sets, at least one of them will contain repeated number.', '[]',
  '845d31e08b0e955aa51fe016c843deabfc047773c44e18d5813952960edd74b8', '2026-07-30T00:00:00.000Z', 'complete',
  '{"title":"codeforces_api","rating":"codeforces_api","official_tags":"codeforces_api","statement":"huggingface_snapshot_of_codeforces"}', '{"notion_properties":{"Summary":null,"Gains":"If the question asks you to divide between two  sets or similar think about bipartite check. Here, the division is between the edges rather than the nodes, and we’re checking if a bipartition is possible or not.\nBipartite Check = even-length cycles, which means no odd-length cycles can be present. So, we can use a bipartite check to find out even-length cycles as well","Metacognition":null,"Tags":["Resolve","Bipartite Check","Lesson"],"Difficulty":"1600"}}', 'notion_showcase_v1',
  '{"notion_row_url":"https://app.notion.com/3f42663170344d0ea7ebe9c58afc7d51","selected_because":"Resolve example with a strong recognition trigger connecting two-set division to bipartiteness.","imported_at":"2026-07-30T00:00:00.000Z","seeded_demo_schedule":true,"learning_field_warning":"Codex-inferred demo fields need user confirmation and are not original wording."}', 'resolve', '2026-07-30',
  '2026-07-30T00:00:00.000Z', '2026-07-30T00:00:00.000Z'
) ON CONFLICT(platform, problem_key) DO UPDATE SET
  url = excluded.url,
  title = excluded.title,
  contest = excluded.contest,
  problem_index = excluded.problem_index,
  rating = excluded.rating,
  official_tags_json = excluded.official_tags_json,
  statement_markdown = excluded.statement_markdown,
  statement_assets_json = excluded.statement_assets_json,
  statement_hash = excluded.statement_hash,
  statement_captured_at = excluded.statement_captured_at,
  metadata_status = excluded.metadata_status,
  metadata_provenance_json = excluded.metadata_provenance_json,
  legacy_metadata_json = excluded.legacy_metadata_json,
  import_source = excluded.import_source,
  import_provenance_json = excluded.import_provenance_json,
  updated_at = excluded.updated_at;

INSERT INTO reflections (
  id, idempotency_key, problem_id, source_path, source_snapshot, source_status,
  transcript_messages_json, transcript_hash, summary_markdown,
  structured_summary_json, memory_cue, confidence, first_review_date, created_at
) VALUES (
  'cf-1702-e-reflection-1', 'showcase:cf-1702-e:reflection:1', 'cf-1702-e',
  '/Users/mtbishmam/code/competitive-programming/practice/1702E.cpp', NULL, 'found',
  '[]', '4f53cda18c2baa0c0354bb5f9a3ecbe5ed12ab4d8e11ba873c2f11161202b945',
  'If the question asks you to divide between two  sets or similar think about bipartite check. Here, the division is between the edges rather than the nodes, and we’re checking if a bipartition is possible or not.
Bipartite Check = even-length cycles, which means no odd-length cycles can be present. So, we can use a bipartite check to find out even-length cycles as well', '{"key_insight":"Model every pair as an edge; degree must be at most two and every component must be bipartite.","wrong_mental_model":"Not captured","why_it_seemed_reasonable":"Not captured","breakthrough_observation":"The requested split into two sets is a bipartite-coloring condition.","correct_trigger":"When a problem asks to divide objects between two sets, test a bipartite model.","missing_concepts":[],"general_pattern":"Two-way compatibility constraints often become graph 2-coloring.","cognitive_mistakes":[],"provenance":{"key_insight":"codex_inferred_demo","wrong_mental_model":"not_captured","correct_trigger":"codex_inferred_demo","general_pattern":"codex_inferred_demo"}}',
  'Two sets -> build the graph -> degree 2 + bipartite.', NULL, '2026-07-30',
  '2026-07-30T00:00:00.000Z'
) ON CONFLICT(idempotency_key) DO NOTHING;

INSERT INTO problems (
  id, platform, problem_key, url, title, contest, problem_index, rating,
  official_tags_json, statement_markdown, statement_assets_json, statement_hash,
  statement_captured_at, metadata_status, metadata_provenance_json,
  legacy_metadata_json, import_source, import_provenance_json, review_status,
  next_review_date, created_at, updated_at
) VALUES (
  'cf-1305-c', 'codeforces', '1305:C', 'https://codeforces.com/contest/1305/problem/C',
  'Kuroni and Impossible Calculation', 'Codeforces 1305', 'C', '1600',
  '["brute force","combinatorics","math","number theory"]', 'To become the king of Codeforces, Kuroni has to solve the following problem.

He is given $$$n$$$ numbers $$$a_1, a_2, \dots, a_n$$$. Help Kuroni to calculate $$$\prod_{1\le i<j\le n} |a_i - a_j|$$$. As result can be very big, output it modulo $$$m$$$.

If you are not familiar with short notation, $$$\prod_{1\le i<j\le n} |a_i - a_j|$$$ is equal to $$$|a_1 - a_2|\cdot|a_1 - a_3|\cdot$$$ $$$\dots$$$ $$$\cdot|a_1 - a_n|\cdot|a_2 - a_3|\cdot|a_2 - a_4|\cdot$$$ $$$\dots$$$ $$$\cdot|a_2 - a_n| \cdot$$$ $$$\dots$$$ $$$\cdot |a_{n-1} - a_n|$$$. In other words, this is the product of $$$|a_i - a_j|$$$ for all $$$1\le i < j \le n$$$.

## Input

The first line contains two integers $$$n$$$, $$$m$$$ ($$$2\le n \le 2\cdot 10^5$$$, $$$1\le m \le 1000$$$) — number of numbers and modulo.

The second line contains $$$n$$$ integers $$$a_1, a_2, \dots, a_n$$$ ($$$0 \le a_i \le 10^9$$$).

## Output

Output the single number — $$$\prod_{1\le i<j\le n} |a_i - a_j| \bmod m$$$.

## Examples

Input:

```text
2 10
8 5
```

Output:

```text
3
```

Input:

```text
3 12
1 4 5
```

Output:

```text
0
```

Input:

```text
3 7
1 4 9
```

Output:

```text
1
```

## Note

In the first sample, $$$|8 - 5| = 3 \equiv 3 \bmod 10$$$.

In the second sample, $$$|1 - 4|\cdot|1 - 5|\cdot|4 - 5| = 3\cdot 4 \cdot 1 = 12 \equiv 0 \bmod 12$$$.

In the third sample, $$$|1 - 4|\cdot|1 - 9|\cdot|4 - 9| = 3 \cdot 8 \cdot 5 = 120 \equiv 1 \bmod 7$$$.', '[]',
  '24277afe40d88666baaf2c0a2502824a602854929079aa2eaa6561424a844612', '2026-07-30T00:00:00.000Z', 'complete',
  '{"title":"codeforces_api","rating":"codeforces_api","official_tags":"codeforces_api","statement":"huggingface_snapshot_of_codeforces"}', '{"notion_properties":{"Summary":null,"Gains":"Should''ve thought about piegonhole principle. Modular Arithmetic and pigeonhole principle go hand to hand","Metacognition":null,"Tags":["Resolve","All Pairs","Modular Arithmetic","Pigeonhole Principle"],"Difficulty":"1600"}}', 'notion_showcase_v1',
  '{"notion_row_url":"https://app.notion.com/4346a2a85c264acda409b34652c6c8e2","selected_because":"Resolve number-theory example where pigeonhole reasoning collapses an apparent all-pairs product.","imported_at":"2026-07-30T00:00:00.000Z","seeded_demo_schedule":true,"learning_field_warning":"Codex-inferred demo fields need user confirmation and are not original wording."}', 'resolve', '2026-08-02',
  '2026-07-30T00:00:00.000Z', '2026-07-30T00:00:00.000Z'
) ON CONFLICT(platform, problem_key) DO UPDATE SET
  url = excluded.url,
  title = excluded.title,
  contest = excluded.contest,
  problem_index = excluded.problem_index,
  rating = excluded.rating,
  official_tags_json = excluded.official_tags_json,
  statement_markdown = excluded.statement_markdown,
  statement_assets_json = excluded.statement_assets_json,
  statement_hash = excluded.statement_hash,
  statement_captured_at = excluded.statement_captured_at,
  metadata_status = excluded.metadata_status,
  metadata_provenance_json = excluded.metadata_provenance_json,
  legacy_metadata_json = excluded.legacy_metadata_json,
  import_source = excluded.import_source,
  import_provenance_json = excluded.import_provenance_json,
  updated_at = excluded.updated_at;

INSERT INTO reflections (
  id, idempotency_key, problem_id, source_path, source_snapshot, source_status,
  transcript_messages_json, transcript_hash, summary_markdown,
  structured_summary_json, memory_cue, confidence, first_review_date, created_at
) VALUES (
  'cf-1305-c-reflection-1', 'showcase:cf-1305-c:reflection:1', 'cf-1305-c',
  '/Users/mtbishmam/code/competitive-programming/practice/1305C.cpp', NULL, 'found',
  '[]', '4f53cda18c2baa0c0354bb5f9a3ecbe5ed12ab4d8e11ba873c2f11161202b945',
  'Should''ve thought about piegonhole principle. Modular Arithmetic and pigeonhole principle go hand to hand', '{"key_insight":"If n > m, two values share a residue modulo m, so one pair difference is divisible by m and the whole product is zero.","wrong_mental_model":"Not captured","why_it_seemed_reasonable":"Not captured","breakthrough_observation":"There are only m residues, but more than m array values.","correct_trigger":"When values are reduced modulo m and n > m, check pigeonhole immediately.","missing_concepts":[],"general_pattern":"A zero factor can collapse a product; search for forced collisions before optimizing multiplication.","cognitive_mistakes":[],"provenance":{"key_insight":"codex_inferred_demo","wrong_mental_model":"not_captured","correct_trigger":"codex_inferred_demo","general_pattern":"codex_inferred_demo"}}',
  'n > m -> repeated residue -> zero product.', NULL, '2026-08-02',
  '2026-07-30T00:00:00.000Z'
) ON CONFLICT(idempotency_key) DO NOTHING;

INSERT INTO problems (
  id, platform, problem_key, url, title, contest, problem_index, rating,
  official_tags_json, statement_markdown, statement_assets_json, statement_hash,
  statement_captured_at, metadata_status, metadata_provenance_json,
  legacy_metadata_json, import_source, import_provenance_json, review_status,
  next_review_date, created_at, updated_at
) VALUES (
  'cf-377-a', 'codeforces', '377:A', 'https://codeforces.com/contest/377/problem/A',
  'Maze', 'Codeforces 377', 'A', '1600',
  '["dfs and similar"]', 'Pavel loves grid mazes. A grid maze is an n × m rectangle maze where each cell is either empty, or is a wall. You can go from one cell to another only if both cells are empty and have a common side.

Pavel drew a grid maze with all empty cells forming a connected area. That is, you can go from any empty cell to any other one. Pavel doesn''t like it when his maze has too little walls. He wants to turn exactly k empty cells into walls so that all the remaining cells still formed a connected area. Help him.

## Input

The first line contains three integers n, m, k (1 ≤ n, m ≤ 500, 0 ≤ k < s), where n and m are the maze''s height and width, correspondingly, k is the number of walls Pavel wants to add and letter s represents the number of empty cells in the original maze.

Each of the next n lines contains m characters. They describe the original maze. If a character on a line equals ".", then the corresponding cell is empty and if the character equals "#", then the cell is a wall.

## Output

Print n lines containing m characters each: the new maze that fits Pavel''s requirements. Mark the empty cells that you transformed into walls as "X", the other cells must be left without changes (that is, "." and "#").

It is guaranteed that a solution exists. If there are multiple solutions you can output any of them.

## Examples

Input:

```text
3 4 2
#..#
..#.
#...
```

Output:

```text
#.X#
X.#.
#...
```

Input:

```text
5 4 5
#...
#.#.
.#..
...#
.#.#
```

Output:

```text
#XXX
#X#.
X#..
...#
.#.#
```', '[]',
  '464c16283d2488fe937b530e2c8513ec0be6c86dbe0f5749371d927d85b2e83d', '2026-07-30T00:00:00.000Z', 'complete',
  '{"title":"codeforces_api","rating":"codeforces_api","official_tags":"codeforces_api","statement":"huggingface_snapshot_of_codeforces"}', '{"notion_properties":{"Summary":null,"Gains":"The maximum length path can be n * m in a grid of n * m. And from now on let''s try to put all the conditions like !vis[x][y] && a[x][y] =! ''#'' in the isvalid function","Metacognition":null,"Tags":["Revise","BFS"],"Difficulty":"1600"}}', 'notion_showcase_v1',
  '{"notion_row_url":"https://app.notion.com/134cb296d7c74853ac4f7d754058a1d2","selected_because":"Revise grid-search example with a concrete implementation lesson about traversal depth and validity checks.","imported_at":"2026-07-30T00:00:00.000Z","seeded_demo_schedule":true,"learning_field_warning":"Codex-inferred demo fields need user confirmation and are not original wording."}', 'revise', '2026-07-31',
  '2026-07-30T00:00:00.000Z', '2026-07-30T00:00:00.000Z'
) ON CONFLICT(platform, problem_key) DO UPDATE SET
  url = excluded.url,
  title = excluded.title,
  contest = excluded.contest,
  problem_index = excluded.problem_index,
  rating = excluded.rating,
  official_tags_json = excluded.official_tags_json,
  statement_markdown = excluded.statement_markdown,
  statement_assets_json = excluded.statement_assets_json,
  statement_hash = excluded.statement_hash,
  statement_captured_at = excluded.statement_captured_at,
  metadata_status = excluded.metadata_status,
  metadata_provenance_json = excluded.metadata_provenance_json,
  legacy_metadata_json = excluded.legacy_metadata_json,
  import_source = excluded.import_source,
  import_provenance_json = excluded.import_provenance_json,
  updated_at = excluded.updated_at;

INSERT INTO reflections (
  id, idempotency_key, problem_id, source_path, source_snapshot, source_status,
  transcript_messages_json, transcript_hash, summary_markdown,
  structured_summary_json, memory_cue, confidence, first_review_date, created_at
) VALUES (
  'cf-377-a-reflection-1', 'showcase:cf-377-a:reflection:1', 'cf-377-a',
  '/Users/mtbishmam/code/competitive-programming/practice/377A.cpp', NULL, 'found',
  '[]', '4f53cda18c2baa0c0354bb5f9a3ecbe5ed12ab4d8e11ba873c2f11161202b945',
  'The maximum length path can be n * m in a grid of n * m. And from now on let''s try to put all the conditions like !vis[x][y] && a[x][y] =! ''#'' in the isvalid function', '{"key_insight":"Traverse one connected component of empty cells and mark exactly k cells from the traversal tail.","wrong_mental_model":"Not captured","why_it_seemed_reasonable":"Not captured","breakthrough_observation":"Keeping a connected prefix of a DFS/BFS order leaves the unmarked cells connected.","correct_trigger":"Need to remove cells while preserving connectivity -> keep a traversal prefix.","missing_concepts":["Grid traversal depth can reach n*m"],"general_pattern":"A traversal order can provide a connectivity-preserving keep/remove boundary.","cognitive_mistakes":[],"provenance":{"key_insight":"codex_inferred_demo","wrong_mental_model":"not_captured","correct_trigger":"codex_inferred_demo","general_pattern":"codex_inferred_demo"}}',
  'Traverse all dots; turn the last k into X.', NULL, '2026-07-31',
  '2026-07-30T00:00:00.000Z'
) ON CONFLICT(idempotency_key) DO NOTHING;

INSERT INTO problems (
  id, platform, problem_key, url, title, contest, problem_index, rating,
  official_tags_json, statement_markdown, statement_assets_json, statement_hash,
  statement_captured_at, metadata_status, metadata_provenance_json,
  legacy_metadata_json, import_source, import_provenance_json, review_status,
  next_review_date, created_at, updated_at
) VALUES (
  'cf-2108-a', 'codeforces', '2108:A', 'https://codeforces.com/contest/2108/problem/A',
  'Permutation Warm-Up', 'Codeforces 2108', 'A', '800',
  '["combinatorics","greedy","math"]', 'For a permutation (p) of length (n)(^{\text{∗}}), we define the function: () f(p) = \sum_{i=1}^{n} \lvert p_i - i \rvert () You are given a number (n). You need to compute how many distinct values the function (f(p)) can take when considering all possible permutations of the numbers from (1) to (n). (^{\text{∗}})A permutation of length (n) is an array consisting of (n) distinct integers from (1) to (n) in arbitrary order. For example, (2,3,1,5,4) is a permutation, but (1,2,2) is not a permutation ((2) appears twice in the array), and (1,3,4) is also not a permutation ((n=3) but there is (4) in the array). Each test contains multiple test cases. The first line contains the number of test cases (t) ((1 \le t \le 100)). The description of the test cases follows. The first line of each test case contains an integer (n) ((1 \leq n \leq 500)) — the number of numbers in the permutations. For each test case, output a single integer — the number of distinct values of the function (f(p)) for the given length of permutations. Consider the first two examples of the input. For (n = 2), there are only (2) permutations — (1, 2) and (2, 1). (f(1, 2) = \lvert 1 - 1 \rvert + \lvert 2 - 2 \rvert = 0), (f(2, 1) = \lvert 2 - 1 \rvert + \lvert 1 - 2 \rvert = 1 + 1 = 2). Thus, the function takes (2) distinct values. For (n=3), there are already (6) permutations: (1, 2, 3), (1, 3, 2), (2, 1, 3), (2, 3, 1), (3, 1, 2), (3, 2, 1), the function values of which will be (0, 2, 2, 4, 4), and (4) respectively, meaning there are a total of (3) values.', '[]',
  '3994c499be9fc59f8f5154cc25629654939af856abee486ef1cbcd18728c837e', '2026-07-30T00:00:00.000Z', 'complete',
  '{"title":"codeforces_api","rating":"codeforces_api","official_tags":"codeforces_api","statement":"cf_problemset_mirror_snapshot"}', '{"notion_properties":{"Summary":null,"Gains":"If they''re talking about permutations, do the following - \n1. Think about the first permutation and the last permutation & get answers for both. Those are usually the lower and upper bounds\n2. Given the first permutation, we can reach  any other permutation by doing adjacent swaps where a[i] < a[j] for i < j\n3. Now, calculate the rate of change for any permutation with respect to the initial permutation","Metacognition":null,"Tags":["Resolve","Inversions"],"Difficulty":"800"}}', 'notion_showcase_v1',
  '{"notion_row_url":"https://app.notion.com/289067fc316a4068ab2c7892e43acce1","selected_because":"Newer easy Resolve example with a useful permutation invariant and an intentionally missing local source.","imported_at":"2026-07-30T00:00:00.000Z","seeded_demo_schedule":true,"learning_field_warning":"Codex-inferred demo fields need user confirmation and are not original wording."}', 'resolve', '2026-08-01',
  '2026-07-30T00:00:00.000Z', '2026-07-30T00:00:00.000Z'
) ON CONFLICT(platform, problem_key) DO UPDATE SET
  url = excluded.url,
  title = excluded.title,
  contest = excluded.contest,
  problem_index = excluded.problem_index,
  rating = excluded.rating,
  official_tags_json = excluded.official_tags_json,
  statement_markdown = excluded.statement_markdown,
  statement_assets_json = excluded.statement_assets_json,
  statement_hash = excluded.statement_hash,
  statement_captured_at = excluded.statement_captured_at,
  metadata_status = excluded.metadata_status,
  metadata_provenance_json = excluded.metadata_provenance_json,
  legacy_metadata_json = excluded.legacy_metadata_json,
  import_source = excluded.import_source,
  import_provenance_json = excluded.import_provenance_json,
  updated_at = excluded.updated_at;

INSERT INTO reflections (
  id, idempotency_key, problem_id, source_path, source_snapshot, source_status,
  transcript_messages_json, transcript_hash, summary_markdown,
  structured_summary_json, memory_cue, confidence, first_review_date, created_at
) VALUES (
  'cf-2108-a-reflection-1', 'showcase:cf-2108-a:reflection:1', 'cf-2108-a',
  NULL, NULL, 'missing',
  '[]', '4f53cda18c2baa0c0354bb5f9a3ecbe5ed12ab4d8e11ba873c2f11161202b945',
  'If they''re talking about permutations, do the following -
1. Think about the first permutation and the last permutation & get answers for both. Those are usually the lower and upper bounds
2. Given the first permutation, we can reach  any other permutation by doing adjacent swaps where a[i] < a[j] for i < j
3. Now, calculate the rate of change for any permutation with respect to the initial permutation', '{"key_insight":"Track how the target expression changes under an adjacent inversion swap, starting from the identity permutation.","wrong_mental_model":"Not captured","why_it_seemed_reasonable":"Not captured","breakthrough_observation":"Every permutation is reachable from the identity by adjacent swaps, exposing a stable change rule.","correct_trigger":"For a permutation statistic, compare identity and reverse order, then inspect one adjacent swap.","missing_concepts":[],"general_pattern":"Analyze a permutation statistic through generators such as adjacent swaps.","cognitive_mistakes":[],"provenance":{"key_insight":"codex_inferred_demo","wrong_mental_model":"not_captured","correct_trigger":"codex_inferred_demo","general_pattern":"codex_inferred_demo"}}',
  'Identity -> adjacent swaps -> invariant change.', NULL, '2026-08-01',
  '2026-07-30T00:00:00.000Z'
) ON CONFLICT(idempotency_key) DO NOTHING;

INSERT INTO problems (
  id, platform, problem_key, url, title, contest, problem_index, rating,
  official_tags_json, statement_markdown, statement_assets_json, statement_hash,
  statement_captured_at, metadata_status, metadata_provenance_json,
  legacy_metadata_json, import_source, import_provenance_json, review_status,
  next_review_date, created_at, updated_at
) VALUES (
  'cses-1668', 'cses', '1668', 'https://cses.fi/problemset/task/1668/',
  'Building Teams', 'CSES Problem Set', '1668', NULL,
  '["Bipartite Check","Graph Theory"]', 'There are $n$ pupils in Uolevi''s class, and $m$ friendships between them. Your task is to divide the pupils into two teams in such a way that no two pupils in a team are friends. You can freely choose the sizes of the teams.

## Input

The first input line has two integers $n$ and $m$: the number of pupils and friendships. The pupils are numbered $1,2,\dots,n$.

Then, there are $m$ lines describing the friendships. Each line has two integers $a$ and $b$: pupils $a$ and $b$ are friends.

Every friendship is between two different pupils. You can assume that there is at most one friendship between any two pupils.

## Output

Print an example of how to build the teams. For each pupil, print "1" or "2" depending on to which team the pupil will be assigned. You can print any valid team.

If there are no solutions, print "IMPOSSIBLE".

## Constraints

- $1 \le n \le 10^5$

- $1 \le m \le 2 \cdot 10^5$

- $1 \le a,b \le n$

## Example

Input:

```text
5 3
1 2
1 3
4 5
```

Output:

```text
1 2 2 1 2
```', '[]',
  '2977d27228f0f64bca6d18648af7a7c66863712e9326e939981b65ec86249b60', '2026-07-30T00:00:00.000Z', 'complete',
  '{"title":"cses_official","rating":"not_captured","official_tags":"notion_original","statement":"cses_official"}', '{"notion_properties":{"Summary":"Bipartition (UG) + Print → DFS\nOnly col array and c params added\nFor Cycle Detection + Print → DFS\nOnly par array and p params added","Gains":"Using a global flag rather than recursive functional values is better\nBipartite Check and Cycle Detection aren''t the same","Metacognition":null,"Tags":["Bipartite Check","Lesson","Graph Theory"],"Difficulty":"Easy"}}', 'notion_showcase_v1',
  '{"notion_row_url":"https://app.notion.com/0d3cbbaaa41f46c1884a9ac22aff6455","selected_because":"CSES platform example with concise implementation notes distinguishing bipartite checking from cycle detection.","imported_at":"2026-07-30T00:00:00.000Z","seeded_demo_schedule":true,"learning_field_warning":"Codex-inferred demo fields need user confirmation and are not original wording."}', 'revise', '2026-08-03',
  '2026-07-30T00:00:00.000Z', '2026-07-30T00:00:00.000Z'
) ON CONFLICT(platform, problem_key) DO UPDATE SET
  url = excluded.url,
  title = excluded.title,
  contest = excluded.contest,
  problem_index = excluded.problem_index,
  rating = excluded.rating,
  official_tags_json = excluded.official_tags_json,
  statement_markdown = excluded.statement_markdown,
  statement_assets_json = excluded.statement_assets_json,
  statement_hash = excluded.statement_hash,
  statement_captured_at = excluded.statement_captured_at,
  metadata_status = excluded.metadata_status,
  metadata_provenance_json = excluded.metadata_provenance_json,
  legacy_metadata_json = excluded.legacy_metadata_json,
  import_source = excluded.import_source,
  import_provenance_json = excluded.import_provenance_json,
  updated_at = excluded.updated_at;

INSERT INTO reflections (
  id, idempotency_key, problem_id, source_path, source_snapshot, source_status,
  transcript_messages_json, transcript_hash, summary_markdown,
  structured_summary_json, memory_cue, confidence, first_review_date, created_at
) VALUES (
  'cses-1668-reflection-1', 'showcase:cses-1668:reflection:1', 'cses-1668',
  '/Users/mtbishmam/code/competitive-programming/practice/Building_Teams.cpp', NULL, 'found',
  '[]', '4f53cda18c2baa0c0354bb5f9a3ecbe5ed12ab4d8e11ba873c2f11161202b945',
  'Bipartition (UG) + Print → DFS
Only col array and c params added
For Cycle Detection + Print → DFS
Only par array and p params added', '{"key_insight":"DFS-color every connected component with two colors and reject any same-color edge.","wrong_mental_model":"Bipartite check and cycle detection are the same.","why_it_seemed_reasonable":"Both workflows traverse an undirected graph and inspect already visited neighbors.","breakthrough_observation":"Cycle detection tracks parents; bipartite checking tracks color parity.","correct_trigger":"Two teams with no internal friendship is exactly a graph 2-coloring request.","missing_concepts":[],"general_pattern":"Name the invariant stored by DFS rather than reusing traversal code mechanically.","cognitive_mistakes":["Conflated two DFS invariants"],"provenance":{"key_insight":"codex_inferred_demo","wrong_mental_model":"source_derived","correct_trigger":"codex_inferred_demo","general_pattern":"codex_inferred_demo"}}',
  'Two teams = two colors, all components.', NULL, '2026-08-03',
  '2026-07-30T00:00:00.000Z'
) ON CONFLICT(idempotency_key) DO NOTHING;

INSERT INTO problems (
  id, platform, problem_key, url, title, contest, problem_index, rating,
  official_tags_json, statement_markdown, statement_assets_json, statement_hash,
  statement_captured_at, metadata_status, metadata_provenance_json,
  legacy_metadata_json, import_source, import_provenance_json, review_status,
  next_review_date, created_at, updated_at
) VALUES (
  'cses-1193', 'cses', '1193', 'https://cses.fi/problemset/task/1193/',
  'Labyrinth', 'CSES Problem Set', '1193', NULL,
  '["BFS","Graph Theory"]', 'You are given a map of a labyrinth, and your task is to find a path from start to end. You can walk left, right, up and down.

## Input

The first input line has two integers $n$ and $m$: the height and width of the map.

Then there are $n$ lines of $m$ characters describing the labyrinth. Each character is . (floor), # (wall), A (start), or B (end). There is exactly one A and one B in the input.

## Output

First print "YES", if there is a path, and "NO" otherwise.

If there is a path, print the length of the shortest such path and its description as a string consisting of characters L (left), R (right), U (up), and D (down). You can print any valid solution.

## Constraints

- $1 \le n,m \le 1000$

## Example

Input:

```text
5 8
########
#.A#...#
#.##.#B#
#......#
########
```

Output:

```text
YES
9
LDDRRRRRU
```', '[]',
  'f7bcdac7b1b72842cf94eb6e76ab32ef6070ffc0266ae7e077dce66b76174107', '2026-07-30T00:00:00.000Z', 'complete',
  '{"title":"cses_official","rating":"not_captured","official_tags":"notion_original","statement":"cses_official"}', '{"notion_properties":{"Summary":"SSSP (Grid) + Print → BFS","Gains":"Mark vis[nx][ny] before exploring (nx, ny), otherwise you might get TLE","Metacognition":null,"Tags":["BFS","Graph Theory"],"Difficulty":"Easy"}}', 'notion_showcase_v1',
  '{"notion_row_url":"https://app.notion.com/2a6dd19d238e43a7ab9107f4815fcb47","selected_because":"CSES BFS example with a compact path-reconstruction summary and a concrete TLE prevention lesson.","imported_at":"2026-07-30T00:00:00.000Z","seeded_demo_schedule":true,"learning_field_warning":"Codex-inferred demo fields need user confirmation and are not original wording."}', 'resolve', '2026-08-04',
  '2026-07-30T00:00:00.000Z', '2026-07-30T00:00:00.000Z'
) ON CONFLICT(platform, problem_key) DO UPDATE SET
  url = excluded.url,
  title = excluded.title,
  contest = excluded.contest,
  problem_index = excluded.problem_index,
  rating = excluded.rating,
  official_tags_json = excluded.official_tags_json,
  statement_markdown = excluded.statement_markdown,
  statement_assets_json = excluded.statement_assets_json,
  statement_hash = excluded.statement_hash,
  statement_captured_at = excluded.statement_captured_at,
  metadata_status = excluded.metadata_status,
  metadata_provenance_json = excluded.metadata_provenance_json,
  legacy_metadata_json = excluded.legacy_metadata_json,
  import_source = excluded.import_source,
  import_provenance_json = excluded.import_provenance_json,
  updated_at = excluded.updated_at;

INSERT INTO reflections (
  id, idempotency_key, problem_id, source_path, source_snapshot, source_status,
  transcript_messages_json, transcript_hash, summary_markdown,
  structured_summary_json, memory_cue, confidence, first_review_date, created_at
) VALUES (
  'cses-1193-reflection-1', 'showcase:cses-1193:reflection:1', 'cses-1193',
  '/Users/mtbishmam/code/competitive-programming/practice/Labyrinth.cpp', NULL, 'found',
  '[]', '4f53cda18c2baa0c0354bb5f9a3ecbe5ed12ab4d8e11ba873c2f11161202b945',
  'SSSP (Grid) + Print → BFS', '{"key_insight":"BFS from A while storing each cell''s incoming move, then backtrack from B.","wrong_mental_model":"Not captured","why_it_seemed_reasonable":"Not captured","breakthrough_observation":"Mark a neighbor visited when enqueuing it, not when dequeuing it.","correct_trigger":"Unweighted shortest path with reconstruction -> BFS plus parent direction.","missing_concepts":[],"general_pattern":"Claim BFS nodes at enqueue time to prevent duplicate work.","cognitive_mistakes":[],"provenance":{"key_insight":"codex_inferred_demo","wrong_mental_model":"not_captured","correct_trigger":"codex_inferred_demo","general_pattern":"codex_inferred_demo"}}',
  'BFS, mark on push, backtrack directions.', NULL, '2026-08-04',
  '2026-07-30T00:00:00.000Z'
) ON CONFLICT(idempotency_key) DO NOTHING;

INSERT INTO saved_views (
  id, name, filter_json, sort_json, visible_columns_json, is_default,
  created_at, updated_at
) VALUES (
  'view-due-today', 'Due today', '{"schema":"resolve.filter.v1","due":"today"}', '[{"id":"nextReviewDate","desc":false}]', '["title","platform","rating","reviewStatus","nextReviewDate"]', 1,
  '2026-07-30T00:00:00.000Z', '2026-07-30T00:00:00.000Z'
) ON CONFLICT(id) DO UPDATE SET
  name = excluded.name,
  filter_json = excluded.filter_json,
  sort_json = excluded.sort_json,
  visible_columns_json = excluded.visible_columns_json,
  is_default = excluded.is_default,
  updated_at = excluded.updated_at;

INSERT INTO saved_views (
  id, name, filter_json, sort_json, visible_columns_json, is_default,
  created_at, updated_at
) VALUES (
  'view-retry', 'Retry', '{"schema":"resolve.filter.v1","status":["retry"]}', '[{"id":"nextReviewDate","desc":false}]', '["title","platform","rating","reviewStatus","nextReviewDate"]', 0,
  '2026-07-30T00:00:00.000Z', '2026-07-30T00:00:00.000Z'
) ON CONFLICT(id) DO UPDATE SET
  name = excluded.name,
  filter_json = excluded.filter_json,
  sort_json = excluded.sort_json,
  visible_columns_json = excluded.visible_columns_json,
  is_default = excluded.is_default,
  updated_at = excluded.updated_at;

INSERT INTO saved_views (
  id, name, filter_json, sort_json, visible_columns_json, is_default,
  created_at, updated_at
) VALUES (
  'view-revise', 'Revise', '{"schema":"resolve.filter.v1","status":["revise"]}', '[{"id":"nextReviewDate","desc":false}]', '["title","platform","rating","reviewStatus","nextReviewDate"]', 0,
  '2026-07-30T00:00:00.000Z', '2026-07-30T00:00:00.000Z'
) ON CONFLICT(id) DO UPDATE SET
  name = excluded.name,
  filter_json = excluded.filter_json,
  sort_json = excluded.sort_json,
  visible_columns_json = excluded.visible_columns_json,
  is_default = excluded.is_default,
  updated_at = excluded.updated_at;

INSERT INTO saved_views (
  id, name, filter_json, sort_json, visible_columns_json, is_default,
  created_at, updated_at
) VALUES (
  'view-resolve', 'Resolve', '{"schema":"resolve.filter.v1","status":["resolve"]}', '[{"id":"nextReviewDate","desc":false}]', '["title","platform","rating","reviewStatus","nextReviewDate"]', 0,
  '2026-07-30T00:00:00.000Z', '2026-07-30T00:00:00.000Z'
) ON CONFLICT(id) DO UPDATE SET
  name = excluded.name,
  filter_json = excluded.filter_json,
  sort_json = excluded.sort_json,
  visible_columns_json = excluded.visible_columns_json,
  is_default = excluded.is_default,
  updated_at = excluded.updated_at;

INSERT INTO saved_views (
  id, name, filter_json, sort_json, visible_columns_json, is_default,
  created_at, updated_at
) VALUES (
  'view-all', 'All problems', '{"schema":"resolve.filter.v1"}', '[{"id":"nextReviewDate","desc":false}]', '["title","platform","rating","reviewStatus","nextReviewDate"]', 0,
  '2026-07-30T00:00:00.000Z', '2026-07-30T00:00:00.000Z'
) ON CONFLICT(id) DO UPDATE SET
  name = excluded.name,
  filter_json = excluded.filter_json,
  sort_json = excluded.sort_json,
  visible_columns_json = excluded.visible_columns_json,
  is_default = excluded.is_default,
  updated_at = excluded.updated_at;
