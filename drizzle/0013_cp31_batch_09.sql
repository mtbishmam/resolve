INSERT INTO problems (
  id, platform, problem_key, url, title, contest, problem_index, rating,
  difficulty, official_tags_json, statement_markdown, statement_assets_json,
  statement_hash, statement_captured_at, metadata_status,
  metadata_provenance_json, legacy_metadata_json, import_source,
  import_provenance_json, review_status, state, status, archived_at, due_date,
  sprint_id, next_review_date, created_at, updated_at
) VALUES (
  'cp31-cf-1744-e2', 'codeforces', '1744:E2', 'https://codeforces.com/contest/1744/problem/E2',
  'Divisible Numbers (hard version)', '1744', 'E2',
  '1900', 'medium', '["brute force","math","number theory"]',
  'This is an hard version of the problem. The only difference between an easy and a hard version is the constraints on $$$a$$$, $$$b$$$, $$$c$$$ and $$$d$$$.

You are given $$$4$$$ positive integers $$$a$$$, $$$b$$$, $$$c$$$, $$$d$$$ with $$$a  \lt  c$$$ and $$$b  \lt  d$$$. Find any pair of numbers $$$x$$$ and $$$y$$$ that satisfies the following conditions:

- $$$a  \lt  x \leq c$$$, $$$b  \lt  y \leq d$$$,
- $$$x \cdot y$$$ is divisible by $$$a \cdot b$$$.

Note that required $$$x$$$ and $$$y$$$ may not exist.

## Input

The first line of the input contains a single integer $$$t$$$ $$$(1 \leq t \leq 10$$$), the number of test cases.

The descriptions of the test cases follow.

The only line of each test case contains four integers $$$a$$$, $$$b$$$, $$$c$$$ and $$$d$$$ ($$$1 \leq a  \lt  c \leq 10^9$$$, $$$1 \leq b  \lt  d \leq 10^9$$$).

## Output

For each test case print a pair of numbers $$$a  \lt  x \leq c$$$ and $$$b  \lt  y \leq d$$$ such that $$$x \cdot y$$$ is divisible by $$$a \cdot b$$$. If there are multiple answers, print any of them. If there is no such pair of numbers, then print -1 -1.

## Example

Input

    10
    1 1 2 2
    3 4 5 7
    8 9 15 18
    12 21 14 24
    36 60 48 66
    1024 729 373248 730
    1024 729 373247 730
    5040 40320 40319 1000000000
    999999999 999999999 1000000000 1000000000
    268435456 268435456 1000000000 1000000000

Output

    2 2
    4 6
    12 12
    -1 -1
    -1 -1
    373248 730
    -1 -1
    15120 53760
    -1 -1
    536870912 536870912', '[]',
  'c216ba6fbc8185b06ee9c6963bc888068d64f19c0509d8d74ff6e164ac53e5a7', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":28}',
  'resolve', NULL, 'backlog', NULL, '2026-08-31',
  'sprint-2026-08', NULL, '2026-08-04T00:00:00.000Z',
  '2026-08-04T00:00:00.000Z'
) ON CONFLICT(platform, problem_key) DO UPDATE SET
  url = excluded.url,
  title = CASE WHEN problems.title = '' THEN excluded.title ELSE problems.title END,
  contest = COALESCE(problems.contest, excluded.contest),
  problem_index = COALESCE(problems.problem_index, excluded.problem_index),
  rating = COALESCE(problems.rating, excluded.rating),
  difficulty = COALESCE(problems.difficulty, excluded.difficulty),
  official_tags_json = CASE
    WHEN problems.official_tags_json = '[]' THEN excluded.official_tags_json
    ELSE problems.official_tags_json END,
  statement_markdown = CASE
    WHEN problems.statement_markdown = '' THEN excluded.statement_markdown
    ELSE problems.statement_markdown END,
  statement_assets_json = CASE
    WHEN problems.statement_markdown = '' THEN excluded.statement_assets_json
    ELSE problems.statement_assets_json END,
  statement_hash = COALESCE(problems.statement_hash, excluded.statement_hash),
  statement_captured_at = COALESCE(
    problems.statement_captured_at,
    excluded.statement_captured_at
  ),
  metadata_status = CASE
    WHEN problems.statement_markdown = '' THEN excluded.metadata_status
    ELSE problems.metadata_status END,
  metadata_provenance_json = json_patch(
    excluded.metadata_provenance_json,
    problems.metadata_provenance_json
  ),
  status = COALESCE(problems.status, 'backlog'),
  due_date = excluded.due_date,
  sprint_id = excluded.sprint_id,
  import_provenance_json = json_patch(
    excluded.import_provenance_json,
    problems.import_provenance_json
  ),
  updated_at = excluded.updated_at;

INSERT INTO problems (
  id, platform, problem_key, url, title, contest, problem_index, rating,
  difficulty, official_tags_json, statement_markdown, statement_assets_json,
  statement_hash, statement_captured_at, metadata_status,
  metadata_provenance_json, legacy_metadata_json, import_source,
  import_provenance_json, review_status, state, status, archived_at, due_date,
  sprint_id, next_review_date, created_at, updated_at
) VALUES (
  'cp31-cf-1739-d', 'codeforces', '1739:D', 'https://codeforces.com/contest/1739/problem/D',
  'Reset K Edges', '1739', 'D',
  '1900', 'medium', '["binary search","data structures","dfs and similar","graphs","greedy","trees"]',
  'You are given a rooted tree, consisting of $$$n$$$ vertices. The vertices are numbered from $$$1$$$ to $$$n$$$, the root is the vertex $$$1$$$.

You can perform the following operation at most $$$k$$$ times:

 - choose an edge $$$(v, u)$$$ of the tree such that $$$v$$$ is a parent of $$$u$$$;
- remove the edge $$$(v, u)$$$;
- add an edge $$$(1, u)$$$ (i. e. make $$$u$$$ with its subtree a child of the root).

The height of a tree is the maximum depth of its vertices, and the depth of a vertex is the number of edges on the path from the root to it. For example, the depth of vertex $$$1$$$ is $$$0$$$, since it''s the root, and the depth of all its children is $$$1$$$.

What''s the smallest height of the tree that can be achieved?

## Input

The first line contains a single integer $$$t$$$ ($$$1 \le t \le 10^4$$$) — the number of testcases.

The first line of each testcase contains two integers $$$n$$$ and $$$k$$$ ($$$2 \le n \le 2 \cdot 10^5$$$; $$$0 \le k \le n - 1$$$) — the number of vertices in the tree and the maximum number of operations you can perform.

The second line contains $$$n-1$$$ integers $$$p_2, p_3, \dots, p_n$$$ ($$$1 \le p_i  \lt  i$$$) — the parent of the $$$i$$$-th vertex. Vertex $$$1$$$ is the root.

The sum of $$$n$$$ over all testcases doesn''t exceed $$$2 \cdot 10^5$$$.

## Output

For each testcase, print a single integer — the smallest height of the tree that can achieved by performing at most $$$k$$$ operations.

## Example

Input

    5
    5 1
    1 1 2 2
    5 2
    1 1 2 2
    6 0
    1 2 3 4 5
    6 1
    1 2 3 4 5
    4 3
    1 1 1

Output

    2
    1
    5
    3
    1', '[]',
  '7b6304afdcf958719813ae9c1848aa16413ce475895c9c175e83869bc73be5fe', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":29}',
  'resolve', NULL, 'backlog', NULL, '2026-08-31',
  'sprint-2026-08', NULL, '2026-08-04T00:00:00.000Z',
  '2026-08-04T00:00:00.000Z'
) ON CONFLICT(platform, problem_key) DO UPDATE SET
  url = excluded.url,
  title = CASE WHEN problems.title = '' THEN excluded.title ELSE problems.title END,
  contest = COALESCE(problems.contest, excluded.contest),
  problem_index = COALESCE(problems.problem_index, excluded.problem_index),
  rating = COALESCE(problems.rating, excluded.rating),
  difficulty = COALESCE(problems.difficulty, excluded.difficulty),
  official_tags_json = CASE
    WHEN problems.official_tags_json = '[]' THEN excluded.official_tags_json
    ELSE problems.official_tags_json END,
  statement_markdown = CASE
    WHEN problems.statement_markdown = '' THEN excluded.statement_markdown
    ELSE problems.statement_markdown END,
  statement_assets_json = CASE
    WHEN problems.statement_markdown = '' THEN excluded.statement_assets_json
    ELSE problems.statement_assets_json END,
  statement_hash = COALESCE(problems.statement_hash, excluded.statement_hash),
  statement_captured_at = COALESCE(
    problems.statement_captured_at,
    excluded.statement_captured_at
  ),
  metadata_status = CASE
    WHEN problems.statement_markdown = '' THEN excluded.metadata_status
    ELSE problems.metadata_status END,
  metadata_provenance_json = json_patch(
    excluded.metadata_provenance_json,
    problems.metadata_provenance_json
  ),
  status = COALESCE(problems.status, 'backlog'),
  due_date = excluded.due_date,
  sprint_id = excluded.sprint_id,
  import_provenance_json = json_patch(
    excluded.import_provenance_json,
    problems.import_provenance_json
  ),
  updated_at = excluded.updated_at;

INSERT INTO problems (
  id, platform, problem_key, url, title, contest, problem_index, rating,
  difficulty, official_tags_json, statement_markdown, statement_assets_json,
  statement_hash, statement_captured_at, metadata_status,
  metadata_provenance_json, legacy_metadata_json, import_source,
  import_provenance_json, review_status, state, status, archived_at, due_date,
  sprint_id, next_review_date, created_at, updated_at
) VALUES (
  'cp31-cf-1715-d', 'codeforces', '1715:D', 'https://codeforces.com/contest/1715/problem/D',
  '2+ doors', '1715', 'D',
  '1900', 'medium', '["2-sat","bitmasks","graphs","greedy"]',
  'The Narrator has an integer array $$$a$$$ of length $$$n$$$, but he will only tell you the size $$$n$$$ and $$$q$$$ statements, each of them being three integers $$$i, j, x$$$, which means that $$$a_i \mid a_j = x$$$, where $$$|$$$ denotes the bitwise OR operation.

Find the lexicographically smallest array $$$a$$$ that satisfies all the statements.

An array $$$a$$$ is lexicographically smaller than an array $$$b$$$ of the same length if and only if the following holds:

 - in the first position where $$$a$$$ and $$$b$$$ differ, the array $$$a$$$ has a smaller element than the corresponding element in $$$b$$$.

## Input

In the first line you are given with two integers $$$n$$$ and $$$q$$$ ($$$1 \le n \le 10^5$$$, $$$0 \le q \le 2 \cdot 10^5$$$).

In the next $$$q$$$ lines you are given with three integers $$$i$$$, $$$j$$$, and $$$x$$$ ($$$1 \le i, j \le n$$$, $$$0 \le x  \lt  2^{30}$$$) — the statements.

It is guaranteed that all $$$q$$$ statements hold for at least one array.

## Output

On a single line print $$$n$$$ integers $$$a_1, a_2, \ldots, a_n$$$ ($$$0 \le a_i  \lt  2^{30}$$$) — array $$$a$$$.

## Examples

Input

    4 3
    1 2 3
    1 3 2
    4 1 2

Output

    0 3 2 2

Input

    1 0

Output

    0

Input

    2 1
    1 1 1073741823

Output

    1073741823 0

## Note

In the first sample, these are all the arrays satisfying the statements:

 - $$$[0, 3, 2, 2]$$$,
- $$$[2, 1, 0, 0]$$$,
- $$$[2, 1, 0, 2]$$$,
- $$$[2, 1, 2, 0]$$$,
- $$$[2, 1, 2, 2]$$$,
- $$$[2, 3, 0, 0]$$$,
- $$$[2, 3, 0, 2]$$$,
- $$$[2, 3, 2, 0]$$$,
- $$$[2, 3, 2, 2]$$$.', '[]',
  '76db97b009c1e49fb1673d21edf6c7770a2968e199649894a8814b550e964226', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":30}',
  'resolve', NULL, 'backlog', NULL, '2026-08-31',
  'sprint-2026-08', NULL, '2026-08-04T00:00:00.000Z',
  '2026-08-04T00:00:00.000Z'
) ON CONFLICT(platform, problem_key) DO UPDATE SET
  url = excluded.url,
  title = CASE WHEN problems.title = '' THEN excluded.title ELSE problems.title END,
  contest = COALESCE(problems.contest, excluded.contest),
  problem_index = COALESCE(problems.problem_index, excluded.problem_index),
  rating = COALESCE(problems.rating, excluded.rating),
  difficulty = COALESCE(problems.difficulty, excluded.difficulty),
  official_tags_json = CASE
    WHEN problems.official_tags_json = '[]' THEN excluded.official_tags_json
    ELSE problems.official_tags_json END,
  statement_markdown = CASE
    WHEN problems.statement_markdown = '' THEN excluded.statement_markdown
    ELSE problems.statement_markdown END,
  statement_assets_json = CASE
    WHEN problems.statement_markdown = '' THEN excluded.statement_assets_json
    ELSE problems.statement_assets_json END,
  statement_hash = COALESCE(problems.statement_hash, excluded.statement_hash),
  statement_captured_at = COALESCE(
    problems.statement_captured_at,
    excluded.statement_captured_at
  ),
  metadata_status = CASE
    WHEN problems.statement_markdown = '' THEN excluded.metadata_status
    ELSE problems.metadata_status END,
  metadata_provenance_json = json_patch(
    excluded.metadata_provenance_json,
    problems.metadata_provenance_json
  ),
  status = COALESCE(problems.status, 'backlog'),
  due_date = excluded.due_date,
  sprint_id = excluded.sprint_id,
  import_provenance_json = json_patch(
    excluded.import_provenance_json,
    problems.import_provenance_json
  ),
  updated_at = excluded.updated_at;

INSERT INTO problems (
  id, platform, problem_key, url, title, contest, problem_index, rating,
  difficulty, official_tags_json, statement_markdown, statement_assets_json,
  statement_hash, statement_captured_at, metadata_status,
  metadata_provenance_json, legacy_metadata_json, import_source,
  import_provenance_json, review_status, state, status, archived_at, due_date,
  sprint_id, next_review_date, created_at, updated_at
) VALUES (
  'cp31-cf-1700-d', 'codeforces', '1700:D', 'https://codeforces.com/contest/1700/problem/D',
  'River Locks', '1700', 'D',
  '1900', 'medium', '["binary search","dp","greedy","math"]',
  'Recently in Divanovo, a huge river locks system was built. There are now $$$n$$$ locks, the $$$i$$$-th of them has the volume of $$$v_i$$$ liters, so that it can contain any amount of water between $$$0$$$ and $$$v_i$$$ liters. Each lock has a pipe attached to it. When the pipe is open, $$$1$$$ liter of water enters the lock every second.

The locks system is built in a way to immediately transfer all water exceeding the volume of the lock $$$i$$$ to the lock $$$i + 1$$$. If the lock $$$i + 1$$$ is also full, water will be transferred further. Water exceeding the volume of the last lock pours out to the river.

  The picture illustrates $$$5$$$ locks with two open pipes at locks $$$1$$$ and $$$3$$$. Because locks $$$1$$$, $$$3$$$, and $$$4$$$ are already filled, effectively the water goes to locks $$$2$$$ and $$$5$$$. 

Note that the volume of the $$$i$$$-th lock may be greater than the volume of the $$$i + 1$$$-th lock.

To make all locks work, you need to completely fill each one of them. The mayor of Divanovo is interested in $$$q$$$ independent queries. For each query, suppose that initially all locks are empty and all pipes are closed. Then, some pipes are opened simultaneously. For the $$$j$$$-th query the mayor asks you to calculate the minimum number of pipes to open so that all locks are filled no later than after $$$t_j$$$ seconds.

Please help the mayor to solve this tricky problem and answer his queries.

## Input

The first lines contains one integer $$$n$$$ ($$$1 \le n \le 200\,000$$$) — the number of locks.

The second lines contains $$$n$$$ integers $$$v_1, v_2, \dots, v_n$$$ ($$$1 \le v_i \le 10^9$$$)) — volumes of the locks.

The third line contains one integer $$$q$$$ ($$$1 \le q \le 200\,000$$$) — the number of queries.

Each of the next $$$q$$$ lines contains one integer $$$t_j$$$ ($$$1 \le t_j \le 10^9$$$) — the number of seconds you have to fill all the locks in the query $$$j$$$.

## Output

Print $$$q$$$ integers. The $$$j$$$-th of them should be equal to the minimum number of pipes to turn on so that after $$$t_j$$$ seconds all of the locks are filled. If it is impossible to fill all of the locks in given time, print $$$-1$$$.

## Examples

Input

    5
    4 1 5 4 1
    6
    1
    6
    2
    3
    4
    5

Output

    -1
    3
    -1
    -1
    4
    3

Input

    5
    4 4 4 4 4
    6
    1
    3
    6
    5
    2
    4

Output

    -1
    -1
    4
    4
    -1
    5

## Note

There are $$$6$$$ queries in the first example test.

In the queries $$$1, 3, 4$$$ the answer is $$$-1$$$. We need to wait $$$4$$$ seconds to fill the first lock even if we open all the pipes.

In the sixth query we can open pipes in locks $$$1$$$, $$$3$$$, and $$$4$$$. After $$$4$$$ seconds the locks $$$1$$$ and $$$4$$$ are full. In the following $$$1$$$ second $$$1$$$ liter of water is transferred to the locks $$$2$$$ and $$$5$$$. The lock $$$3$$$ is filled by its own pipe.

Similarly, in the second query one can open pipes in locks $$$1$$$, $$$3$$$, and $$$4$$$.

In the fifth query one can open pipes $$$1, 2, 3, 4$$$.', '[{"alt":"Problem diagram","url":"https://espresso.codeforces.com/41308f5a05a3ba666b4f5fb70d3b4e2348b11f17.png"}]',
  '687ff33cf74cb37b7f2949b2bdcc543183f052b880bccc00ba36d17773d1fd36', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":31}',
  'resolve', NULL, 'backlog', NULL, '2026-09-01',
  'sprint-2026-08', NULL, '2026-08-04T00:00:00.000Z',
  '2026-08-04T00:00:00.000Z'
) ON CONFLICT(platform, problem_key) DO UPDATE SET
  url = excluded.url,
  title = CASE WHEN problems.title = '' THEN excluded.title ELSE problems.title END,
  contest = COALESCE(problems.contest, excluded.contest),
  problem_index = COALESCE(problems.problem_index, excluded.problem_index),
  rating = COALESCE(problems.rating, excluded.rating),
  difficulty = COALESCE(problems.difficulty, excluded.difficulty),
  official_tags_json = CASE
    WHEN problems.official_tags_json = '[]' THEN excluded.official_tags_json
    ELSE problems.official_tags_json END,
  statement_markdown = CASE
    WHEN problems.statement_markdown = '' THEN excluded.statement_markdown
    ELSE problems.statement_markdown END,
  statement_assets_json = CASE
    WHEN problems.statement_markdown = '' THEN excluded.statement_assets_json
    ELSE problems.statement_assets_json END,
  statement_hash = COALESCE(problems.statement_hash, excluded.statement_hash),
  statement_captured_at = COALESCE(
    problems.statement_captured_at,
    excluded.statement_captured_at
  ),
  metadata_status = CASE
    WHEN problems.statement_markdown = '' THEN excluded.metadata_status
    ELSE problems.metadata_status END,
  metadata_provenance_json = json_patch(
    excluded.metadata_provenance_json,
    problems.metadata_provenance_json
  ),
  status = COALESCE(problems.status, 'backlog'),
  due_date = excluded.due_date,
  sprint_id = excluded.sprint_id,
  import_provenance_json = json_patch(
    excluded.import_provenance_json,
    problems.import_provenance_json
  ),
  updated_at = excluded.updated_at;

PRAGMA optimize;
