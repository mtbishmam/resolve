INSERT INTO problems (
  id, platform, problem_key, url, title, contest, problem_index, rating,
  difficulty, official_tags_json, statement_markdown, statement_assets_json,
  statement_hash, statement_captured_at, metadata_status,
  metadata_provenance_json, legacy_metadata_json, import_source,
  import_provenance_json, review_status, state, status, archived_at, due_date,
  sprint_id, next_review_date, created_at, updated_at
) VALUES (
  'cp31-cf-1305-c', 'codeforces', '1305:C', 'https://codeforces.com/contest/1305/problem/C',
  'Kuroni and Impossible Calculation', '1305', 'C',
  '1600', 'medium', '["brute force","combinatorics","math","number theory"]',
  'To become the king of Codeforces, Kuroni has to solve the following problem.

He is given n numbers a_1, a_2, \dots, a_n. Help Kuroni to calculate \prod_{1\le i \lt j\le n} |a_i - a_j|. As result can be very big, output it modulo m.

If you are not familiar with short notation, \prod_{1\le i \lt j\le n} |a_i - a_j| is equal to |a_1 - a_2|\cdot|a_1 - a_3|\cdot \dots \cdot|a_1 - a_n|\cdot|a_2 - a_3|\cdot|a_2 - a_4|\cdot \dots \cdot|a_2 - a_n| \cdot \dots \cdot |a_{n-1} - a_n|. In other words, this is the product of |a_i - a_j| for all 1\le i  \lt  j \le n.

## Input

The first line contains two integers n, m (2\le n \le 2\cdot 10^5, 1\le m \le 1000) — number of numbers and modulo.

The second line contains n integers a_1, a_2, \dots, a_n (0 \le a_i \le 10^9).

## Output

Output the single number — \prod_{1\le i \lt j\le n} |a_i - a_j| \bmod m.

## Examples

Input

    2 10
    8 5

Output

    3

Input

    3 12
    1 4 5

Output

    0

Input

    3 7
    1 4 9

Output

    1

## Note

In the first sample, |8 - 5| = 3 \equiv 3 \bmod 10.

In the second sample, |1 - 4|\cdot|1 - 5|\cdot|4 - 5| = 3\cdot 4 \cdot 1 = 12 \equiv 0 \bmod 12.

In the third sample, |1 - 4|\cdot|1 - 9|\cdot|4 - 9| = 3 \cdot 8 \cdot 5 = 120 \equiv 1 \bmod 7.', '[]',
  'ec0e78d7ab806d18bcf6a6a312672632f9143f5c4cf0220adf7f352860bd0d95', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":31}',
  'resolve', NULL, 'backlog', NULL, '2026-08-11',
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
  'cp31-cf-2050-f', 'codeforces', '2050:F', 'https://codeforces.com/contest/2050/problem/F',
  'Maximum modulo equality', '2050', 'F',
  '1700', 'medium', '["data structures","divide and conquer","math","number theory"]',
  'You are given an array a of length n and q queries l, r.

For each query, find the maximum possible m, such that all elements a_l, a_{l+1}, ..., a_r are equal modulo m. In other words, a_l \bmod m = a_{l+1} \bmod m = \dots = a_r \bmod m, where a \bmod b — is the remainder of division a by b. In particular, when m can be infinite, print 0.

## Input

The first line contains a single integer t (1 \le t \le 10^4) — the number of test cases.

The first line of each test case contains two integers n, q (1 \le n, q \le 2\cdot 10^5) — the length of the array and the number of queries.

The second line of each test case contains n integers a_i (1 \le a_i \le 10^9) — the elements of the array.

In the following q lines of each test case, two integers l, r are provided (1 \le l \le r \le n) — the range of the query.

It is guaranteed that the sum of n across all test cases does not exceed 2\cdot 10^5, and the sum of q does not exceed 2\cdot 10^5.

## Output

For each query, output the maximum value m described in the statement.

## Example

Input

    3
    5 5
    5 14 2 6 3
    4 5
    1 4
    2 4
    3 5
    1 1
    1 1
    7
    1 1
    3 2
    1 7 8
    2 3
    1 2

Output

    3 1 4 1 0 
    0 
    1 6

## Note

In the first query of the first sample, 6 \bmod 3 = 3 \bmod 3 = 0. It can be shown that for greater m, the required condition will not be fulfilled.

In the third query of the first sample, 14 \bmod 4 = 2 \bmod 4 = 6 \bmod 4 = 2. It can be shown that for greater m, the required condition will not be fulfilled.', '[]',
  '2ef2ef171c85339305ff8fd171a8690ea2b6d0fe52625673e85ddd8eb177c29f', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":1}',
  'resolve', NULL, 'backlog', NULL, '2026-08-12',
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
  'cp31-cf-2041-d', 'codeforces', '2041:D', 'https://codeforces.com/contest/2041/problem/D',
  'Drunken Maze', '2041', 'D',
  '1700', 'medium', '["brute force","dfs and similar","graphs","shortest paths"]',
  'Image generated by ChatGPT 4o. 

You are given a two-dimensional maze with a start and end position. Your task is to find the fastest way to get from the start to the end position. The fastest way is to make the minimum number of steps where one step is going left, right, up, or down. Of course, you cannot walk through walls.

There is, however, a catch: If you make more than three steps in the same direction, you lose balance and fall down. Therefore, it is forbidden to make more than three consecutive steps in the same direction. It is okay to walk three times to the right, then one step to the left, and then again three steps to the right. This has the same effect as taking five steps to the right, but is slower.

## Input

The first line contains two numbers n and m, which are the height and width of the maze. This is followed by an ASCII-representation of the maze where \tt{\#} is a wall, \tt{.} is an empty space, and \tt S and \tt T are the start and end positions.

 - 12 \leq n\times m \leq 200000.
- 3\leq n,m \leq 10000.
- Characters are only \tt{.\#ST} and there is exactly one \tt{S} and one \tt{T}.
- The outer borders are only \tt{\#} (walls).

## Output

The minimum number of steps to reach the end position from the start position or -1 if that is impossible.

## Examples

Input

    7 12
    ############
    #S........T#
    #.########.#
    #..........#
    #..........#
    #..#..#....#
    ############

Output

    15

Input

    5 8
    ########
    #......#
    #.####.#
    #...T#S#
    ########

Output

    14

Input

    5 8
    ########
    #.#S...#
    #.####.#
    #...T#.#
    ########

Output

    -1', '[{"alt":"Problem diagram","url":"https://espresso.codeforces.com/a0a558e320b3ca69dd52fcfb66e51fbd87f4a9a2.png"}]',
  '17c67c3919f21a3605397413ca0a56dcb2e3bd901e06eaa24d0328444367534c', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":2}',
  'resolve', NULL, 'backlog', NULL, '2026-08-12',
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
  'cp31-cf-2018-c', 'codeforces', '2018:C', 'https://codeforces.com/contest/2018/problem/C',
  'Tree Pruning', '2018', 'C',
  '1700', 'medium', '["brute force","dfs and similar","greedy","sortings","trees"]',
  't+pazolite, ginkiha, Hommarju - Paved Garden

⠀

You are given a tree with n nodes, rooted at node 1. In this problem, a leaf is a non-root node with degree 1.

In one operation, you can remove a leaf and the edge adjacent to it (possibly, new leaves appear). What is the minimum number of operations that you have to perform to get a tree, also rooted at node 1, where all the leaves are at the same distance from the root?

## Input

Each test contains multiple test cases. The first line contains the number of test cases t (1 \le t \le 10^4). The description of the test cases follows.

The first line of each test case contains a single integer n (3 \leq n \leq 5 \cdot 10^5) — the number of nodes.

Each of the next n-1 lines contains two integers u, v (1 \leq u, v \leq n, u \neq v), describing an edge that connects u and v. It is guaranteed that the given edges form a tree.

It is guaranteed that the sum of n over all test cases does not exceed 5 \cdot 10^5.

## Output

For each test case, output a single integer: the minimum number of operations needed to achieve your goal.

## Example

Input

    3
    7
    1 2
    1 3
    2 4
    2 5
    4 6
    4 7
    7
    1 2
    1 3
    1 4
    2 5
    3 6
    5 7
    15
    12 9
    1 6
    6 14
    9 11
    8 7
    3 5
    13 5
    6 10
    13 15
    13 6
    14 12
    7 2
    8 1
    1 4

Output

    2
    2
    5

## Note

In the first two examples, the tree is as follows:

  

In the first example, by removing edges (1, 3) and (2, 5), the resulting tree has all leaves (nodes 6 and 7) at the same distance from the root (node 1), which is 3. The answer is 2, as it is the minimum number of edges that need to be removed to achieve the goal.

In the second example, removing edges (1, 4) and (5, 7) results in a tree where all leaves (nodes 4 and 5) are at the same distance from the root (node 1), which is 2.', '[{"alt":"Problem diagram","url":"https://espresso.codeforces.com/a428c7bdf3ba5490a44914a039d11603cfb1c9df.png"}]',
  '7c22be364bc1cef720d12b613d2745c11bd9e827bd96cb6bc6ce971b1c6f5c1d', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":3}',
  'resolve', NULL, 'backlog', NULL, '2026-08-12',
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
  'cp31-cf-2007-d', 'codeforces', '2007:D', 'https://codeforces.com/contest/2007/problem/D',
  'Iris and Game on the Tree', '2007', 'D',
  '1700', 'medium', '["games","graphs","greedy","trees"]',
  'Iris has a tree rooted at vertex 1. Each vertex has a value of \mathtt 0 or \mathtt 1.

Let''s consider a leaf of the tree (the vertex 1 is never considered a leaf) and define its weight. Construct a string formed by the values of the vertices on the path starting at the root and ending in this leaf. Then the weight of the leaf is the difference between the number of occurrences of \mathtt{10} and \mathtt{01} substrings in it.

Take the following tree as an example. Green vertices have a value of \mathtt 1 while white vertices have a value of \mathtt 0.

   - Let''s calculate the weight of the leaf 5: the formed string is \mathtt{10110}. The number of occurrences of substring \mathtt{10} is 2, the number of occurrences of substring \mathtt{01} is 1, so the difference is 2 - 1 = 1.
- Let''s calculate the weight of the leaf 6: the formed string is \mathtt{101}. The number of occurrences of substring \mathtt{10} is 1, the number of occurrences of substring \mathtt{01} is 1, so the difference is 1 - 1 = 0.

The score of a tree is defined as the number of leaves with non-zero weight in the tree.

But the values of some vertices haven''t been decided and will be given to you as \texttt{?}. Filling the blanks would be so boring, so Iris is going to invite Dora to play a game. On each turn, one of the girls chooses any of the remaining vertices with value \texttt{?} and changes its value to \mathtt{0} or \mathtt{1}, with Iris going first. The game continues until there are no vertices with value \mathtt{?} left in the tree. Iris aims to maximize the score of the tree, while Dora aims to minimize that.

Assuming that both girls play optimally, please determine the final score of the tree.

## Input

Each test consists of multiple test cases. The first line contains a single integer t (1 \leq t \leq 5\cdot 10^4) — the number of test cases. The description of the test cases follows.

The first line of each test case contains a single integer n (2 \leq n \leq 10^5) — the number of vertices in the tree.

The following n - 1 lines each contain two integers u and v (1 \leq u, v \leq n) — denoting an edge between vertices u and v.

It''s guaranteed that the given edges form a tree.

The last line contains a string s of length n. The i-th character of s represents the value of vertex i. It''s guaranteed that s only contains characters \mathtt{0}, \mathtt{1} and \mathtt{?}.

It is guaranteed that the sum of n over all test cases doesn''t exceed 2\cdot 10^5.

## Output

For each test case, output a single integer — the final score of the tree.

## Example

Input

    6
    4
    1 2
    1 3
    4 1
    0101
    4
    1 2
    3 2
    2 4
    ???0
    5
    1 2
    1 3
    2 4
    2 5
    ?1?01
    6
    1 2
    2 3
    3 4
    5 3
    3 6
    ?0????
    5
    1 2
    1 3
    1 4
    1 5
    11?1?
    2
    2 1
    ??

Output

    2
    1
    1
    2
    1
    0

## Note

In the first test case, all the values of the vertices have been determined. There are three different paths from the root to a leaf:

 - From vertex 1 to vertex 2. The string formed by the path is \mathtt{01}, so the weight of the leaf is 0-1=-1.
- From vertex 1 to vertex 3. The string formed by the path is \mathtt{00}, so the weight of the leaf is 0-0=0.
- From vertex 1 to vertex 4. The string formed by the path is \mathtt{01}, so the weight of the leaf is 0-1=-1.

Thus, there are two leaves with non-zero weight, so the score of the tree is 2.

In the second test case, one of the sequences of optimal choices for the two players can be:

 - Iris chooses to change the value of the vertex 3 to \mathtt 1.
- Dora chooses to change the value of the vertex 1 to \mathtt 0.
- Iris chooses to change the value of the vertex 2 to \mathtt 0.

The final tree is as follows:

   

The only leaf with non-zero weight is 3, so the score of the tree is 1. Note that this may not be the only sequence of optimal choices for Iris and Dora.', '[{"alt":"Problem diagram","url":"https://espresso.codeforces.com/58c418fecb67125e91955a07cf576ecef59bf44e.png"},{"alt":"Problem diagram","url":"https://espresso.codeforces.com/ce5d3bbe07eadad8323070f0bd37872988d52dfb.png"}]',
  '2e0a9a998dbcbc9fc50fa1ab7a0eef8643e9f61c5d8b6044c7815c99fa6861b5', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":4}',
  'resolve', NULL, 'backlog', NULL, '2026-08-12',
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
  'cp31-cf-1999-g2', 'codeforces', '1999:G2', 'https://codeforces.com/contest/1999/problem/G2',
  'Ruler (hard version)', '1999', 'G2',
  '1700', 'medium', '["binary search","interactive","ternary search"]',
  'This is the hard version of the problem. The only difference between the two versions is that in this version, you can make at most \mathbf{7} queries.

This is an interactive problem. If you are unsure how interactive problems work, then it is recommended to read the guide for participants.

We have a secret ruler that is missing one number x (2 \leq x \leq 999). When you measure an object of length y, the ruler reports the following values:

 - If y  \lt  x, the ruler (correctly) measures the object as having length y.
- If y \geq x, the ruler incorrectly measures the object as having length y+1.
 

The ruler above is missing the number 4, so it correctly measures the first segment as length 3 but incorrectly measures the second segment as length 6 even though it is actually 5.

You need to find the value of x. To do that, you can make queries of the following form:

 - \texttt{?}~a~b — in response, we will measure the side lengths of an a \times b rectangle with our ruler and multiply the results, reporting the measured area of the rectangle back to you. For example, if x=4 and you query a 3 \times 5 rectangle, we will measure its side lengths as 3 \times 6 and report 18 back to you.

Find the value of x. You can ask at most \mathbf{7} queries.

## Input

Each test contains multiple test cases. The first line of input contains a single integer t (1 \leq t \leq 1000) — the number of test cases.

## Interaction

There is no initial input for each test case. You should begin the interaction by asking a query.

To make a query, output a single line of the form \texttt{?}~a~b (1 \leq a, b \leq 1000). In response, you will be told the measured area of the rectangle, according to our secret ruler.

When you are ready to print the answer, output a single line of the form \texttt{!}~x (2 \leq x \leq 999). After that, proceed to process the next test case or terminate the program if it was the last test case. Printing the answer does not count as a query.

The interactor is not adaptive, meaning that the answer is known before the participant asks the queries and doesn''t depend on the queries asked by the participant.

If your program makes more than 7 queries for one set of input data, makes an invalid query, or prints the wrong value of x, then the response to the query will be -1. After receiving such a response, your program should immediately terminate to receive the verdict Wrong Answer. Otherwise, you can get an arbitrary verdict because your solution will continue to read from a closed stream.

After printing a query do not forget to output the end of line and flush the output. Otherwise, you may get Idleness limit exceeded verdict. To do this, use:

 - fflush(stdout) or cout.flush() in C++;
- System.out.flush() in Java;
- flush(output) in Pascal;
- stdout.flush() in Python;
- see the documentation for other languages.

Hacks

To make a hack, use the following format.

The first line should contain a single integer t (1 \leq t \leq 1000) — the number of test cases.

The only line of each test case should contain a single integer x (2 \leq x \leq 999) — the missing number on the ruler.

## Example

Input

    2
    
    18
    
    25
    
    
    9999

Output

    ? 3 5
    
    ? 4 4
    
    ! 4
    ? 99 100
    
    ! 100

## Note

In the first test, the interaction proceeds as follows.

 SolutionJuryExplanation\texttt{2}There are 2 test cases.\texttt{? 3 5}\texttt{18}Secretly, the jury picked x=4. The solution requests the 3 \times 5 rectangle, and the jury responds with 3 \times 6 = 18, as described in the statement.\texttt{? 4 4}\texttt{25}The solution requests the 4 \times 4 rectangle, which the jury measures as 5 \times 5 and responds with 25.\texttt{! 4}The solution has somehow determined that x=4, and outputs it. Since the output is correct, the jury continues to the next test case.\texttt{? 99 100}\texttt{1}Secretly, the jury picked x=100. The solution requests the 99 \times 100 rectangle, which the jury measures as 99 \times 101 and responds with 9999.\texttt{! 100}The solution has somehow determined that x=100, and outputs it. Since the output is correct and there are no more test cases, the jury and the solution exit. 

Note that the line breaks in the example input and output are for the sake of clarity, and do not occur in the real interaction.', '[{"alt":"Problem diagram","url":"https://espresso.codeforces.com/a98908c8e65eba44622cf7a3ee2ee84099990643.png"}]',
  'c927d937e68d38973f20f8ed35f282493146995bd881eb6d7e84892fc275788a', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":5}',
  'resolve', NULL, 'backlog', NULL, '2026-08-12',
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
  'cp31-cf-1983-d', 'codeforces', '1983:D', 'https://codeforces.com/contest/1983/problem/D',
  'Swap Dilemma', '1983', 'D',
  '1700', 'medium', '["constructive algorithms","data structures","divide and conquer","greedy","math","sortings"]',
  'Given two arrays of distinct positive integers a and b of length n, we would like to make both the arrays the same. Two arrays x and y of length k are said to be the same when for all 1 \le i \le k, x_i = y_i.

Now in one move, you can choose some index l and r in a (l \le r) and swap a_l and a_r, then choose some p and q (p \le q) in b such that r-l=q-p and swap b_p and b_q.

Is it possible to make both arrays the same?

## Input

Each test contains multiple test cases. The first line contains the number of test cases t (1 \le t \le 2 \cdot 10^4). The description of the test cases follows.

The first line of each test case contains a single integer n (1 \le n \le 10^5) — the length of the arrays a and b.

The second line of each test case contains n distinct integers a_1,a_2,a_3,\ldots,a_n (1 \le a_i \le 2 \cdot 10^5) — the integers in the array a.

The third line of each test case contains n distinct integers b_1,b_2,b_3,\ldots,b_n (1 \le b_i \le 2 \cdot 10^5) — the integers in the array b.

It is guaranteed that the sum of n over all test cases does not exceed 10^5.

## Output

For each testcase, print "YES" if the arrays a and b can be made the same. Otherwise, print "NO". can output the answer in any case (upper or lower). For example, the strings "yEs", "yes", "Yes", and "YES" will be recognized as positive responses.

## Example

Input

    6
    4
    1 2 3 4
    1 2 3 4
    5
    1 3 4 2 5
    7 1 2 5 4
    4
    1 2 3 4
    4 3 2 1
    3
    1 2 3
    1 3 2
    5
    1 5 7 1000 4
    4 1 7 5 1000
    3
    1 4 2
    1 3 2

Output

    YES
    NO
    YES
    NO
    NO
    NO

## Note

In the first testcase, you don''t need to perform any operations since the arrays are same.

In the second testcase, it can be proven there exists no way to make the arrays same.

In the third testcase, one of the ways to make the arrays same is to first choose l=1, r=3, p=1, q=3 then choose l=1, r=2, p=3, q=4.', '[]',
  '2e45deaa509943f15ec7625ea93296cae8a111f64057bbe26761071c0a4655c4', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":6}',
  'resolve', NULL, 'backlog', NULL, '2026-08-13',
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
  'cp31-cf-1982-d', 'codeforces', '1982:D', 'https://codeforces.com/contest/1982/problem/D',
  'Beauty of the mountains', '1982', 'D',
  '1700', 'medium', '["brute force","data structures","implementation","math","number theory"]',
  'Nikita loves mountains and has finally decided to visit the Berlyand mountain range! The range was so beautiful that Nikita decided to capture it on a map. The map is a table of n rows and m columns, with each cell containing a non-negative integer representing the height of the mountain.

He also noticed that mountains come in two types:

 - With snowy caps.
- Without snowy caps.

Nikita is a very pragmatic person. He wants the sum of the heights of the mountains with snowy caps to be equal to the sum of the heights of the mountains without them. He has arranged with the mayor of Berlyand, Polikarp Polikarpovich, to allow him to transform the landscape.

Nikita can perform transformations on submatrices of size k \times k as follows: he can add an integer constant c to the heights of the mountains within this area, but the type of the mountain remains unchanged. Nikita can choose the constant c independently for each transformation. Note that c can be negative.

Before making the transformations, Nikita asks you to find out if it is possible to achieve equality of the sums, or if it is impossible. It doesn''t matter at what cost, even if the mountains turn into canyons and have negative heights.

If only one type of mountain is represented on the map, then the sum of the heights of the other type of mountain is considered to be zero.

## Input

Each test consists of several test cases. The first line contains an integer t (1 \le t \le 10^{4}) — the number of test cases. This is followed by a description of test cases.

The first line of each test case contains three integers n, m, k (1 \le n, m \le 500, 1 \le k \le min(n, m)).

The next n lines of each test case contain m integers a_{i j} (0 \le a_{i j} \le 10^{9}) — the initial heights of the mountains.

The next n binary strings of length m for each test case determine the type of mountain, ''0'' — with snowy caps, ''1'' — without them.

It is guaranteed that the sum of n \cdot m for all test cases does not exceed 250\,000.

## Output

For each test case, output "YES" without quotes if it is possible to equalize the sums of the mountain heights, otherwise output "NO" without quotes. You can output each letter in any case (for example, the strings "yEs", "yes", "Yes", and "YES" will be recognized as a positive answer).

## Example

Input

    8
    3 3 2
    7 11 3
    4 2 3
    0 1 15
    100
    010
    000
    4 4 3
    123 413 24 233
    123 42 0 216
    22 1 1 53
    427 763 22 6
    0101
    1111
    1010
    0101
    3 3 2
    2 1 1
    1 1 2
    1 5 4
    010
    101
    010
    3 3 2
    2 1 1
    1 1 2
    1 5 3
    010
    101
    010
    3 4 3
    46 49 50 1
    19 30 23 12
    30 25 1 46
    1000
    0100
    0010
    5 4 4
    39 30 0 17
    22 42 30 13
    10 44 46 35
    12 19 9 39
    21 0 45 40
    1000
    1111
    0011
    0111
    1100
    2 2 2
    3 4
    6 7
    00
    00
    2 2 2
    0 0
    2 0
    01
    00

Output

    YES
    NO
    YES
    NO
    YES
    NO
    YES
    YES

## Note

The mountain array from the first test case looks like this:

  

Initially, the sum of the heights of the mountains with snowy caps is 11 + 3 + 4 + 3 + 0 + 1 + 15 = 37, and without them is 7 + 2 = 9.

To equalize these sums, we can perform two transformations:

First transformation:

  

Note that the constant c can be negative.

After the first transformation, the mountain array looks like this:

  

Second transformation:

  

As a result, the mountain array looks like this:

  

The sum of the heights of the mountains with snowy caps is 17 + 9 + 9 - 16 - 20 - 19 + 15 = -5, and without them is 7 - 12 = -5, thus the answer is YES.', '[{"alt":"Problem diagram","url":"https://espresso.codeforces.com/e349846c838c5ede403ad44990902826caf40475.png"},{"alt":"Problem diagram","url":"https://espresso.codeforces.com/f9044376a784d27e1a78bbeb3e3b8f56fb5cdcea.png"},{"alt":"Problem diagram","url":"https://espresso.codeforces.com/dd5439eaa068814b5a2ca277cf97de41164ed2e1.png"},{"alt":"Problem diagram","url":"https://espresso.codeforces.com/5d1b9234864c69e015111f1256a067de0a603f11.png"},{"alt":"Problem diagram","url":"https://espresso.codeforces.com/22fc3469e7a43d2d3cccefa1e1f734234a88a000.png"}]',
  'bba179c1c2ed2f89ac2b13982263d8573f8285207fa740914e35012f2a24923f', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":7}',
  'resolve', NULL, 'backlog', NULL, '2026-08-13',
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
  'cp31-cf-1948-d', 'codeforces', '1948:D', 'https://codeforces.com/contest/1948/problem/D',
  'Tandem Repeats?', '1948', 'D',
  '1700', 'medium', '["brute force","strings","two pointers"]',
  'You are given a string s, consisting of lowercase Latin letters and/or question marks.

A tandem repeat is a string of an even length such that its first half is equal to its second half.

A string a is a substring of a string b if a can be obtained from b by the deletion of several (possibly, zero or all) characters from the beginning and several (possibly, zero or all) characters from the end.

Your goal is to replace each question mark with some lowercase Latin letter in such a way that the length of the longest substring that is a tandem repeat is maximum possible.

## Input

The first line contains a single integer t (1 \le t \le 1000) — the number of testcases.

The only line of each testcase contains a string s (1 \le |s| \le 5000), consisting only of lowercase Latin letters and/or question marks.

The total length of the strings over all testcases doesn''t exceed 5000.

## Output

For each testcase, print a single integer — the maximum length of the longest substring that is a tandem repeat after you replace each question mark in the string with some lowercase Latin letter.

If it''s impossible to make any tandem repeat substrings in the string, print 0.

## Example

Input

    4
    zaabaabz
    ?????
    code?????s
    codeforces

Output

    6
    4
    10
    0', '[]',
  'b88f6aca8095c288ac4f5c2e63a01dc16623f3678fb346233ac327152b053fa5', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":8}',
  'resolve', NULL, 'backlog', NULL, '2026-08-13',
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
  'cp31-cf-1931-f', 'codeforces', '1931:F', 'https://codeforces.com/contest/1931/problem/F',
  'Chat Screenshots', '1931', 'F',
  '1700', 'medium', '["combinatorics","dfs and similar","graphs"]',
  'There are n people in the programming contest chat. Chat participants are ordered by activity, but each person sees himself at the top of the list.

For example, there are 4 participants in the chat, and their order is [2, 3, 1, 4]. Then

 - 1-st user sees the order [1, 2, 3, 4].
- 2-nd user sees the order [2, 3, 1, 4].
- 3-rd user sees the order [3, 2, 1, 4].
- 4-th user sees the order [4, 2, 3, 1].

k people posted screenshots in the chat, which show the order of participants shown to this user. The screenshots were taken within a short period of time, and the order of participants has not changed.

Your task is to determine whether there is a certain order that all screenshots correspond to.

## Input

The first line contains a single integer t (1 \le t \le 10^4) — the number of input test cases. The descriptions of test cases follow.

The first line of the description of each test case contains two integers n and k (1 \le k \le n \le 2 \cdot 10^5, n \cdot k \le 2 \cdot 10^5) — the number of chat participants and the number of participants who posted screenshots.

The following k lines contain descriptions of screenshots posted by the participants.

The i-th row contains n integers a_{ij} each (1 \le a_{ij} \le n, all a_{ij} are different) — the order of participants shown to the participant a_{i0}, where a_{i0} — the author of the screenshot. You can show that in the screenshot description it will always be at the top of the list.

It is guaranteed that the sum of n \cdot k for all test cases does not exceed 2 \cdot 10^5. It is also guaranteed that all the authors of the screenshots are different.

## Output

Output t lines, each of which is the answer to the corresponding test case. As an answer, output "YES" if there exists at least one order of participants, under which all k screenshots could have been obtained. Otherwise, output "NO".

You can output the answer in any case (upper or lower). For example, the strings "yEs", "yes", "Yes", and "YES" will be recognized as positive responses.

## Example

Input

    10
    5 1
    1 2 3 4 5
    4 4
    1 2 3 4
    2 3 1 4
    3 2 1 4
    4 2 3 1
    6 2
    1 3 5 2 4 6
    6 3 5 2 1 4
    3 3
    1 2 3
    2 3 1
    3 2 1
    10 2
    1 2 3 4 5 6 7 8 9 10
    10 9 8 7 6 5 4 3 2 1
    1 1
    1
    5 2
    1 2 3 5 4
    2 1 3 5 4
    3 3
    3 1 2
    2 3 1
    1 3 2
    5 4
    3 5 1 4 2
    2 5 1 4 3
    1 5 4 3 2
    5 1 4 3 2
    3 3
    1 3 2
    2 1 3
    3 2 1

Output

    YES
    YES
    YES
    YES
    NO
    YES
    YES
    YES
    YES
    NO', '[]',
  '4115c177a97fe9975dbb0af300a6c5d2c9b846f3f3b3cd03761548dbd1f93a98', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":9}',
  'resolve', NULL, 'backlog', NULL, '2026-08-13',
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
  'cp31-cf-1894-d', 'codeforces', '1894:D', 'https://codeforces.com/contest/1894/problem/D',
  'Neutral Tonality', '1894', 'D',
  '1700', 'medium', '["constructive algorithms","data structures","sortings","two pointers"]',
  'You are given an array a consisting of n integers, as well as an array b consisting of m integers.

Let \text{LIS}(c) denote the length of the longest increasing subsequence of array c. For example, \text{LIS}([2, \underline{1}, 1, \underline{3}]) = 2, \text{LIS}([\underline{1}, \underline{7}, \underline{9}]) = 3, \text{LIS}([3, \underline{1}, \underline{2}, \underline{4}]) = 3.

You need to insert the numbers b_1, b_2, \ldots, b_m into the array a, at any positions, in any order. Let the resulting array be c_1, c_2, \ldots, c_{n+m}. You need to choose the positions for insertion in order to minimize \text{LIS}(c).

Formally, you need to find an array c_1, c_2, \ldots, c_{n+m} that simultaneously satisfies the following conditions:

- The array a_1, a_2, \ldots, a_n is a subsequence of the array c_1, c_2, \ldots, c_{n+m}.
- The array c_1, c_2, \ldots, c_{n+m} consists of the numbers a_1, a_2, \ldots, a_n, b_1, b_2, \ldots, b_m, possibly rearranged.
- The value of \text{LIS}(c) is the minimum possible among all suitable arrays c.

## Input

Each test contains multiple test cases. The first line contains a single integer t (1 \leq t \leq 10^4) — the number of test cases. The description of the test cases follows.

The first line of each test case contains two integers n, m (1 \leq n \leq 2 \cdot 10^5, 1 \leq m \leq 2 \cdot 10^5) — the length of array a and the length of array b.

The second line of each test case contains n integers a_1, a_2, \ldots, a_n (1 \leq a_i \leq 10^9) — the elements of the array a.

The third line of each test case contains m integers b_1, b_2, \ldots, b_m (1 \leq b_i \leq 10^9) — the elements of the array b.

It is guaranteed that the sum of n over all test cases does not exceed 2\cdot 10^5, and the sum of m over all test cases does not exceed 2\cdot 10^5.

## Output

For each test case, output n + m numbers — the elements of the final array c_1, c_2, \ldots, c_{n+m}, obtained after the insertion, such that the value of \text{LIS}(c) is minimized. If there are several answers, you can output any of them.

## Example

Input

    7
    2 1
    6 4
    5
    5 5
    1 7 2 4 5
    5 4 1 2 7
    1 9
    7
    1 2 3 4 5 6 7 8 9
    3 2
    1 3 5
    2 4
    10 5
    1 9 2 3 8 1 4 7 2 9
    7 8 5 4 6
    2 1
    2 2
    1
    6 1
    1 1 1 1 1 1
    777

Output

    6 5 4
    1 1 7 7 2 2 4 4 5 5
    9 8 7 7 6 5 4 3 2 1
    1 3 5 2 4
    1 9 2 3 8 8 1 4 4 7 7 2 9 6 5
    2 2 1
    777 1 1 1 1 1 1

## Note

In the first test case, \text{LIS}(a) = \text{LIS}([6, 4]) = 1. We can insert the number 5 between 6 and 4, then \text{LIS}(c) = \text{LIS}([6, 5, 4]) = 1.

In the second test case, \text{LIS}([\underline{1}, 7, \underline{2}, \underline{4}, \underline{5}]) = 4. After the insertion, c = [1, 1, 7, 7, 2, 2, 4, 4, 5, 5]. It is easy to see that \text{LIS}(c) = 4. It can be shown that it is impossible to achieve \text{LIS}(c) less than 4.', '[]',
  '22ab3bff23d5de77ce3209c045b604db92c4aac1c3919a62ba02af8a9df92a5d', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":10}',
  'resolve', NULL, 'backlog', NULL, '2026-08-13',
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
  'cp31-cf-1879-d', 'codeforces', '1879:D', 'https://codeforces.com/contest/1879/problem/D',
  'Sum of XOR Functions', '1879', 'D',
  '1700', 'medium', '["bitmasks","combinatorics","divide and conquer","dp","math"]',
  'You are given an array a of length n consisting of non-negative integers.

You have to calculate the value of \sum_{l=1}^{n} \sum_{r=l}^{n} f(l, r) \cdot (r - l + 1), where f(l, r) is a_l \oplus a_{l+1} \oplus \dots \oplus a_{r-1} \oplus a_r (the character \oplus denotes bitwise XOR).

Since the answer can be very large, print it modulo 998244353.

## Input

The first line contains one integer n (1 \le n \le 3 \cdot 10^5) — the length of the array a.

The second line contains n integers a_1, a_2, \dots, a_n (0 \le a_i \le 10^9).

## Output

Print the one integer — the value of \sum_{l=1}^{n} \sum_{r=l}^{n} f(l, r) \cdot (r - l + 1), taken modulo 998244353.

## Examples

Input

    3
    1 3 2

Output

    12

Input

    4
    39 68 31 80

Output

    1337

Input

    7
    313539461 779847196 221612534 488613315 633203958 394620685 761188160

Output

    257421502

## Note

In the first example, the answer is equal to f(1, 1) + 2 \cdot f(1, 2) + 3 \cdot f(1, 3) + f(2, 2) + 2 \cdot f(2, 3) + f(3, 3) =  = 1 + 2 \cdot 2 + 3 \cdot 0 + 3 + 2 \cdot 1 + 2 = 12.', '[]',
  'e7c470dd540020970cfdaf376254a767d8d7d83cf249e9e6dbc8694ea4537152', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":11}',
  'resolve', NULL, 'backlog', NULL, '2026-08-14',
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
  'cp31-cf-1833-f', 'codeforces', '1833:F', 'https://codeforces.com/contest/1833/problem/F',
  'Ira and Flamenco', '1833', 'F',
  '1700', 'medium', '["combinatorics","constructive algorithms","data structures","implementation","math","sortings","two pointers"]',
  'Ira loves Spanish flamenco dance very much. She decided to start her own dance studio and found n students, ith of whom has level a_i.

Ira can choose several of her students and set a dance with them. So she can set a huge number of dances, but she is only interested in magnificent dances. The dance is called magnificent if the following is true:

 - exactly m students participate in the dance;
- levels of all dancers are pairwise distinct;
- levels of every two dancers have an absolute difference strictly less than m.

For example, if m = 3 and a = [4, 2, 2, 3, 6], the following dances are magnificent (students participating in the dance are highlighted in red): [\color{red}{4}, 2, \color{red}{2}, \color{red}{3}, 6], [\color{red}{4}, \color{red}{2}, 2, \color{red}{3}, 6]. At the same time dances [\color{red}{4}, 2, 2, \color{red}{3}, 6], [4, \color{red}{2}, \color{red}{2}, \color{red}{3}, 6], [\color{red}{4}, 2, 2, \color{red}{3}, \color{red}{6}] are not magnificent.

In the dance [\color{red}{4}, 2, 2, \color{red}{3}, 6] only 2 students participate, although m = 3.

The dance [4, \color{red}{2}, \color{red}{2}, \color{red}{3}, 6] involves students with levels 2 and 2, although levels of all dancers must be pairwise distinct.

In the dance [\color{red}{4}, 2, 2, \color{red}{3}, \color{red}{6}] students with levels 3 and 6 participate, but |3 - 6| = 3, although m = 3.

Help Ira count the number of magnificent dances that she can set. Since this number can be very large, count it modulo 10^9 + 7. Two dances are considered different if the sets of students participating in them are different.

## Input

The first line contains a single integer t (1 \le t \le 10^4) — number of testcases.

The first line of each testcase contains integers n and m (1 \le m \le n \le 2 \cdot 10^5) — the number of Ira students and the number of dancers in the magnificent dance.

The second line of each testcase contains n integers a_1, a_2, \ldots, a_n (1 \le a_i \le 10^9) — levels of students.

It is guaranteed that the sum of n over all testcases does not exceed 2 \cdot 10^5.

## Output

For each testcase, print a single integer — the number of magnificent dances. Since this number can be very large, print it modulo 10^9 + 7.

## Example

Input

    9
    7 4
    8 10 10 9 6 11 7
    5 3
    4 2 2 3 6
    8 2
    1 5 2 2 3 1 3 3
    3 3
    3 3 3
    5 1
    3 4 3 10 7
    12 3
    5 2 1 1 4 3 5 5 5 2 7 5
    1 1
    1
    3 2
    1 2 3
    2 2
    1 2

Output

    5
    2
    10
    0
    5
    11
    1
    2
    1

## Note

In the first testcase, Ira can set such magnificent dances: [\color{red}{8}, 10, 10, \color{red}{9}, \color{red}{6}, 11, \color{red}{7}], [\color{red}{8}, \color{red}{10}, 10, \color{red}{9}, 6, 11, \color{red}{7}], [\color{red}{8}, 10, \color{red}{10}, \color{red}{9}, 6, 11, \color{red}{7}], [\color{red}{8}, 10, \color{red}{10}, \color{red}{9}, 6, \color{red}{11}, 7], [\color{red}{8}, \color{red}{10}, 10, \color{red}{9}, 6, \color{red}{11}, 7].

The second testcase is explained in the statements.', '[]',
  '20c77a9a207a415254e523f7269af920d322d5e396c1f13802104312d6549e4d', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":12}',
  'resolve', NULL, 'backlog', NULL, '2026-08-14',
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
  'cp31-cf-1829-h', 'codeforces', '1829:H', 'https://codeforces.com/contest/1829/problem/H',
  'Don''t Blame Me', '1829', 'H',
  '1700', 'medium', '["bitmasks","combinatorics","dp","math"]',
  'Sadly, the problem setter couldn''t think of an interesting story, thus he just asks you to solve the following problem.

Given an array a consisting of n positive integers, count the number of non-empty subsequences for which the bitwise \mathsf{AND} of the elements in the subsequence has exactly k set bits in its binary representation. The answer may be large, so output it modulo 10^9+7.

Recall that the subsequence of an array a is a sequence that can be obtained from a by removing some (possibly, zero) elements. For example, [1, 2, 3], [3], [1, 3] are subsequences of [1, 2, 3], but [3, 2] and [4, 5, 6] are not.

Note that \mathsf{AND} represents the bitwise AND operation.

## Input

Each test contains multiple test cases. The first line contains the number of test cases t (1 \le t \le 10^4). The description of the test cases follows.

The first line of each test case consists of two integers n and k (1 \leq n \leq 2 \cdot 10^5, 0 \le k \le 6) — the length of the array and the number of set bits that the bitwise \mathsf{AND} the counted subsequences should have in their binary representation.

The second line of each test case consists of n integers a_i (0 \leq a_i \leq 63) — the array a.

It is guaranteed that the sum of n over all test cases doesn''t exceed 2 \cdot 10^5.

## Output

For each test case, output a single integer — the number of subsequences that have exactly k set bits in their bitwise \mathsf{AND} value''s binary representation. The answer may be large, so output it modulo 10^9+7.

## Example

Input

    6
    5 1
    1 1 1 1 1
    4 0
    0 1 2 3
    5 1
    5 5 7 4 2
    1 2
    3
    12 0
    0 2 0 2 0 2 0 2 0 2 0 2
    10 6
    63 0 63 5 5 63 63 4 12 13

Output

    31
    10
    10
    1
    4032
    15', '[]',
  '467aac8e715fd68c0606a94fdda5d5e72eb57d6bdf63db2fd2880ff34d30eb77', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":13}',
  'resolve', NULL, 'backlog', NULL, '2026-08-14',
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
  'cp31-cf-1826-d', 'codeforces', '1826:D', 'https://codeforces.com/contest/1826/problem/D',
  'Running Miles', '1826', 'D',
  '1700', 'medium', '["brute force","dp","greedy"]',
  'There is a street with n sights, with sight number i being i miles from the beginning of the street. Sight number i has beauty b_i. You want to start your morning jog l miles and end it r miles from the beginning of the street. By the time you run, you will see sights you run by (including sights at l and r miles from the start). You are interested in the 3 most beautiful sights along your jog, but every mile you run, you get more and more tired.

So choose l and r, such that there are at least 3 sights you run by, and the sum of beauties of the 3 most beautiful sights minus the distance in miles you have to run is maximized. More formally, choose l and r, such that b_{i_1} + b_{i_2} + b_{i_3} - (r - l) is maximum possible, where i_1, i_2, i_3 are the indices of the three maximum elements in range [l, r].

## Input

The first line contains a single integer t (1 \leq t \leq 10^5) — the number of test cases.

The first line of each test case contains a single integer n (3 \leq n \leq 10^5).

The second line of each test case contains n integers b_i (1 \leq b_i \leq 10^8) — beauties of sights i miles from the beginning of the street.

It''s guaranteed that the sum of all n does not exceed 10^5.

## Output

For each test case output a single integer equal to the maximum value b_{i_1} + b_{i_2} + b_{i_3} - (r - l) for some running range [l, r].

## Example

Input

    4
    5
    5 1 4 2 3
    4
    1 1 1 1
    6
    9 8 7 6 5 4
    7
    100000000 1 100000000 1 100000000 1 100000000

Output

    8
    1
    22
    299999996

## Note

In the first example, we can choose l and r to be 1 and 5. So we visit all the sights and the three sights with the maximum beauty are the sights with indices 1, 3, and 5 with beauties 5, 4, and 3, respectively. So the total value is 5 + 4 + 3 - (5 - 1) = 8.

In the second example, the range [l, r] can be [1, 3] or [2, 4], the total value is 1 + 1 + 1 - (3 - 1) = 1.', '[]',
  '52a8b14e116d7db03d9be8edad9866c0ac847499163538bb1212ab1a258d12b9', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":14}',
  'resolve', NULL, 'backlog', NULL, '2026-08-14',
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
