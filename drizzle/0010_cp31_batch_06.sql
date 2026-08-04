INSERT INTO problems (
  id, platform, problem_key, url, title, contest, problem_index, rating,
  difficulty, official_tags_json, statement_markdown, statement_assets_json,
  statement_hash, statement_captured_at, metadata_status,
  metadata_provenance_json, legacy_metadata_json, import_source,
  import_provenance_json, review_status, state, status, archived_at, due_date,
  sprint_id, next_review_date, created_at, updated_at
) VALUES (
  'cp31-cf-1691-d', 'codeforces', '1691:D', 'https://codeforces.com/contest/1691/problem/D',
  'Max GEQ Sum', '1691', 'D',
  '1800', 'medium', '["binary search","constructive algorithms","data structures","divide and conquer","implementation","two pointers"]',
  'You are given an array a of n integers. You are asked to find out if the inequality \max(a_i, a_{i + 1}, \ldots, a_{j - 1}, a_{j}) \geq a_i + a_{i + 1} + \dots + a_{j - 1} + a_{j} holds for all pairs of indices (i, j), where 1 \leq i \leq j \leq n.

## Input

Each test contains multiple test cases. The first line contains the number of test cases t (1 \le t \le 10^5). Description of the test cases follows.

The first line of each test case contains a single integer n (1 \leq n \leq 2 \cdot 10^5)  — the size of the array.

The next line of each test case contains n integers a_1, a_2, \ldots, a_n (-10^9 \le a_i \le 10^9).

It is guaranteed that the sum of n over all test cases does not exceed 2 \cdot 10^5.

## Output

For each test case, on a new line output "YES" if the condition is satisfied for the given array, and "NO" otherwise. You can print each letter in any case (upper or lower).

## Example

Input

    3
    4
    -1 1 -1 2
    5
    -1 2 -3 2 -1
    3
    2 3 -1

Output

    YES
    YES
    NO

## Note

In test cases 1 and 2, the given condition is satisfied for all (i, j) pairs.

In test case 3, the condition isn''t satisfied for the pair (1, 2) as \max(2, 3)  \lt  2 + 3.', '[]',
  '9ef902a4b5756c350e31fc9b9b138372bd677061fb24748750d6e5d59aad9c9e', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":14}',
  'resolve', NULL, 'backlog', NULL, '2026-08-21',
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
  'cp31-cf-1517-d', 'codeforces', '1517:D', 'https://codeforces.com/contest/1517/problem/D',
  'Explorer Space', '1517', 'D',
  '1800', 'medium', '["dp","graphs","shortest paths"]',
  'You are wandering in the explorer space of the 2050 Conference.

The explorer space can be viewed as an undirected weighted grid graph with size n\times m. The set of vertices is \{(i, j)|1\le i\le n, 1\le j\le m\}. Two vertices (i_1,j_1) and (i_2, j_2) are connected by an edge if and only if |i_1-i_2|+|j_1-j_2|=1.

At each step, you can walk to any vertex connected by an edge with your current vertex. On each edge, there are some number of exhibits. Since you already know all the exhibits, whenever you go through an edge containing x exhibits, your boredness increases by x.

For each starting vertex (i, j), please answer the following question: What is the minimum possible boredness if you walk from (i, j) and go back to it after exactly k steps?

You can use any edge for multiple times but the boredness on those edges are also counted for multiple times. At each step, you cannot stay on your current vertex. You also cannot change direction while going through an edge. Before going back to your starting vertex (i, j) after k steps, you can visit (i, j) (or not) freely.

## Input

The first line contains three integers n, m and k (2\leq n, m\leq 500, 1\leq k\leq 20).

The j-th number (1\le j \le m - 1) in the i-th line of the following n lines is the number of exibits on the edge between vertex (i, j) and vertex (i, j+1).

The j-th number (1\le j\le m) in the i-th line of the following n-1 lines is the number of exibits on the edge between vertex (i, j) and vertex (i+1, j).

The number of exhibits on each edge is an integer between 1 and 10^6.

## Output

Output n lines with m numbers each. The j-th number in the i-th line, answer_{ij}, should be the minimum possible boredness if you walk from (i, j) and go back to it after exactly k steps.

If you cannot go back to vertex (i, j) after exactly k steps, answer_{ij} should be -1.

## Examples

Input

    3 3 10
    1 1
    1 1
    1 1
    1 1 1
    1 1 1

Output

    10 10 10
    10 10 10
    10 10 10

Input

    2 2 4
    1
    3
    4 2

Output

    4 4
    10 6

Input

    2 2 3
    1
    2
    3 4

Output

    -1 -1
    -1 -1

## Note

In the first example, the answer is always 10 no matter how you walk.

In the second example, answer_{21} = 10, the path is (2,1) \to (1,1) \to (1,2) \to (2,2) \to (2,1), the boredness is 4 + 1 + 2 + 3 = 10.', '[]',
  'c7cfa8ed3d12fd70e0a91bcafc99d90245e8e82a091325b4693d2b4bbfa80cfa', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":15}',
  'resolve', NULL, 'backlog', NULL, '2026-08-21',
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
  'cp31-cf-1509-c', 'codeforces', '1509:C', 'https://codeforces.com/contest/1509/problem/C',
  'The Sports Festival', '1509', 'C',
  '1800', 'medium', '["dp","greedy"]',
  'The student council is preparing for the relay race at the sports festival.

The council consists of n members. They will run one after the other in the race, the speed of member i is s_i. The discrepancy d_i of the i-th stage is the difference between the maximum and the minimum running speed among the first i members who ran. Formally, if a_i denotes the speed of the i-th member who participated in the race, then d_i = \max(a_1, a_2, \dots, a_i) - \min(a_1, a_2, \dots, a_i).

You want to minimize the sum of the discrepancies d_1 + d_2 + \dots + d_n. To do this, you are allowed to change the order in which the members run. What is the minimum possible sum that can be achieved?

## Input

The first line contains a single integer n (1 \le n \le 2000)  — the number of members of the student council.

The second line contains n integers s_1, s_2, \dots, s_n (1 \le s_i \le 10^9)  – the running speeds of the members.

## Output

Print a single integer  — the minimum possible value of d_1 + d_2 + \dots + d_n after choosing the order of the members.

## Examples

Input

    3
    3 1 2

Output

    3

Input

    1
    5

Output

    0

Input

    6
    1 6 3 3 6 3

Output

    11

Input

    6
    104 943872923 6589 889921234 1000000000 69

Output

    2833800505

## Note

In the first test case, we may choose to make the third member run first, followed by the first member, and finally the second. Thus a_1 = 2, a_2 = 3, and a_3 = 1. We have:

 - d_1 = \max(2) - \min(2) = 2 - 2 = 0.
- d_2 = \max(2, 3) - \min(2, 3) = 3 - 2 = 1.
- d_3 = \max(2, 3, 1) - \min(2, 3, 1) = 3 - 1 = 2.

The resulting sum is d_1 + d_2 + d_3 = 0 + 1 + 2 = 3. It can be shown that it is impossible to achieve a smaller value.

In the second test case, the only possible rearrangement gives d_1 = 0, so the minimum possible result is 0.', '[]',
  '0e6e5a4743eb9fc7c8d35a18484da8ee94ed718c9705da82404b4bcb00283543', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":16}',
  'resolve', NULL, 'backlog', NULL, '2026-08-22',
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
  'cp31-cf-1491-d', 'codeforces', '1491:D', 'https://codeforces.com/contest/1491/problem/D',
  'Zookeeper and The Infinite Zoo', '1491', 'D',
  '1800', 'medium', '["bitmasks","constructive algorithms","dp","greedy","math"]',
  'There is a new attraction in Singapore Zoo: The Infinite Zoo.

The Infinite Zoo can be represented by a graph with an infinite number of vertices labeled 1,2,3,\ldots. There is a directed edge from vertex u to vertex u+v if and only if u\&v=v, where \& denotes the bitwise AND operation. There are no other edges in the graph.

Zookeeper has q queries. In the i-th query she will ask you if she can travel from vertex u_i to vertex v_i by going through directed edges.

## Input

The first line contains an integer q (1 \leq q \leq 10^5) — the number of queries.

The i-th of the next q lines will contain two integers u_i, v_i (1 \leq u_i, v_i  \lt  2^{30}) — a query made by Zookeeper.

## Output

For the i-th of the q queries, output "YES" in a single line if Zookeeper can travel from vertex u_i to vertex v_i. Otherwise, output "NO".

You can print your answer in any case. For example, if the answer is "YES", then the output "Yes" or "yeS" will also be considered as correct answer.

## Example

Input

    5
    1 4
    3 6
    1 6
    6 2
    5 5

Output

    YES
    YES
    NO
    NO
    YES

## Note

The subgraph on vertices 1,2,3,4,5,6 is shown below.', '[{"alt":"Problem diagram","url":"https://espresso.codeforces.com/fe4cd2be4273d0e0fd69d5727e31f963a9b56597.png"}]',
  '5d010e350611bafd00cf2ca8b0721dce73d580569eb42662cf49348e6d6dca4d', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":17}',
  'resolve', NULL, 'backlog', NULL, '2026-08-22',
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
  'cp31-cf-1468-j', 'codeforces', '1468:J', 'https://codeforces.com/contest/1468/problem/J',
  'Road Reform', '1468', 'J',
  '1800', 'medium', '["dsu","graphs","greedy"]',
  'There are n cities and m bidirectional roads in Berland. The i-th road connects the cities x_i and y_i, and has the speed limit s_i. The road network allows everyone to get from any city to any other city.

The Berland Transport Ministry is planning a road reform.

First of all, maintaining all m roads is too costly, so m - (n - 1) roads will be demolished in such a way that the remaining (n - 1) roads still allow to get to any city from any other city. Formally, the remaining roads should represent an undirected tree.

Secondly, the speed limits on the remaining roads might be changed. The changes will be done sequentially, each change is either increasing the speed limit on some road by 1, or decreasing it by 1. Since changing the speed limit requires a lot of work, the Ministry wants to minimize the number of changes.

The goal of the Ministry is to have a road network of (n - 1) roads with the maximum speed limit over all roads equal to exactly k. They assigned you the task of calculating the minimum number of speed limit changes they have to perform so the road network meets their requirements.

For example, suppose the initial map of Berland looks like that, and k = 7:

  

Then one of the optimal courses of action is to demolish the roads 1–4 and 3–4, and then decrease the speed limit on the road 2–3 by 1, so the resulting road network looks like that:

## Input

The first line contains one integer t (1 \le t \le 1000) — the number of test cases.

The first line of each test case contains three integers n, m and k (2 \le n \le 2 \cdot 10^5; n - 1 \le m \le \min(2 \cdot 10^5, \frac{n(n-1)}{2}); 1 \le k \le 10^9) — the number of cities, the number of roads and the required maximum speed limit, respectively.

Then m lines follow. The i-th line contains three integers x_i, y_i and s_i (1 \le x_i, y_i \le n; x_i \ne y_i; 1 \le s_i \le 10^9) — the cities connected by the i-th road and the speed limit on it, respectively. All roads are bidirectional.

The road network in each test case is connected (that is, it is possible to reach any city from any other city by traveling along the road), and each pair of cities is connected by at most one road.

The sum of n over all test cases does not exceed 2 \cdot 10^5. Similarly, the sum of m over all test cases does not exceed 2 \cdot 10^5.

## Output

For each test case, print one integer — the minimum number of changes the Ministry has to perform so that the maximum speed limit among the remaining (n - 1) roads is exactly k.

## Example

Input

    4
    4 5 7
    4 1 3
    1 2 5
    2 3 8
    2 4 1
    3 4 4
    4 6 5
    1 2 1
    1 3 1
    1 4 2
    2 4 1
    4 3 1
    3 2 1
    3 2 10
    1 2 8
    1 3 10
    5 5 15
    1 2 17
    3 1 15
    2 3 10
    1 4 14
    2 5 8

Output

    1
    3
    0
    0

## Note

The explanation for the example test:

The first test case is described in the problem statement.

In the second test case, the road network initially looks like that:

  

The Ministry can demolish the roads 1–2, 3–2 and 3–4, and then increase the speed limit on the road 1–4 three times.

In the third test case, the road network already meets all the requirements.

In the fourth test case, it is enough to demolish the road 1–2 so the resulting road network meets the requirements.', '[{"alt":"Problem diagram","url":"https://espresso.codeforces.com/733cb599cc7e9bd751cb590866cace5a207dec6f.png"},{"alt":"Problem diagram","url":"https://espresso.codeforces.com/aafdedd23e3077335800387927eedf7dbdf99a6c.png"},{"alt":"Problem diagram","url":"https://espresso.codeforces.com/af2714f5b8e774568184a3fbec53af2f54476fef.png"}]',
  '027c5bcf66982dbdb06827ab2b3e692930ff4e9eeff47b3615aeff9dff32f6bf', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":18}',
  'resolve', NULL, 'backlog', NULL, '2026-08-22',
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
  'cp31-cf-1466-e', 'codeforces', '1466:E', 'https://codeforces.com/contest/1466/problem/E',
  'Apollo versus Pan', '1466', 'E',
  '1800', 'medium', '["bitmasks","brute force","math"]',
  'Only a few know that Pan and Apollo weren''t only battling for the title of the GOAT musician. A few millenniums later, they also challenged each other in math (or rather in fast calculations). The task they got to solve is the following:

Let x_1, x_2, \ldots, x_n be the sequence of n non-negative integers. Find this value: \sum_{i=1}^n \sum_{j=1}^n \sum_{k=1}^n (x_i \, \& \, x_j) \cdot (x_j \, | \, x_k)

Here \& denotes the bitwise and, and | denotes the bitwise or.

Pan and Apollo could solve this in a few seconds. Can you do it too? For convenience, find the answer modulo 10^9 + 7.

## Input

The first line of the input contains a single integer t (1 \leq t \leq 1\,000) denoting the number of test cases, then t test cases follow.

The first line of each test case consists of a single integer n (1 \leq n \leq 5 \cdot 10^5), the length of the sequence. The second one contains n non-negative integers x_1, x_2, \ldots, x_n (0 \leq x_i  \lt  2^{60}), elements of the sequence.

The sum of n over all test cases will not exceed 5 \cdot 10^5.

## Output

Print t lines. The i-th line should contain the answer to the i-th text case.

## Example

Input

    8
    2
    1 7
    3
    1 2 4
    4
    5 5 5 5
    5
    6 2 2 1 0
    1
    0
    1
    1
    6
    1 12 123 1234 12345 123456
    5
    536870912 536870911 1152921504606846975 1152921504606846974 1152921504606846973

Output

    128
    91
    1600
    505
    0
    1
    502811676
    264880351', '[]',
  'ca5ee88bc4faad4dda9365c3f4e46251a59305a2ad772ad52f634041e2f35927', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":19}',
  'resolve', NULL, 'backlog', NULL, '2026-08-22',
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
  'cp31-cf-1462-f', 'codeforces', '1462:F', 'https://codeforces.com/contest/1462/problem/F',
  'The Treasure of The Segments', '1462', 'F',
  '1800', 'medium', '["binary search","data structures","greedy"]',
  'Polycarp found n segments on the street. A segment with the index i is described by two integers l_i and r_i — coordinates of the beginning and end of the segment, respectively. Polycarp realized that he didn''t need all the segments, so he wanted to delete some of them.

Polycarp believes that a set of k segments is good if there is a segment [l_i, r_i] (1 \leq i \leq k) from the set, such that it intersects every segment from the set (the intersection must be a point or segment). For example, a set of 3 segments [[1, 4], [2, 3], [3, 6]] is good, since the segment [2, 3] intersects each segment from the set. Set of 4 segments [[1, 2], [2, 3], [3, 5], [4, 5]] is not good.

Polycarp wonders, what is the minimum number of segments he has to delete so that the remaining segments form a good set?

## Input

The first line contains a single integer t (1 \leq t \leq 2 \cdot 10^5) — number of test cases. Then t test cases follow.

The first line of each test case contains a single integer n (1 \leq n \leq 2 \cdot 10^5) — the number of segments. This is followed by n lines describing the segments.

Each segment is described by two integers l and r (1 \leq l \leq r \leq 10^9) — coordinates of the beginning and end of the segment, respectively.

It is guaranteed that the sum of n for all test cases does not exceed 2 \cdot 10^5.

## Output

For each test case, output a single integer — the minimum number of segments that need to be deleted in order for the set of remaining segments to become good.

## Example

Input

    4
    3
    1 4
    2 3
    3 6
    4
    1 2
    2 3
    3 5
    4 5
    5
    1 2
    3 8
    4 5
    6 7
    9 10
    5
    1 5
    2 4
    3 5
    3 8
    4 8

Output

    0
    1
    2
    0', '[]',
  '618c12bab859692d62da7ad98e3679eaa50c2ab079d602725b991f9c428a7f67', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":20}',
  'resolve', NULL, 'backlog', NULL, '2026-08-22',
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
  'cp31-cf-1447-d', 'codeforces', '1447:D', 'https://codeforces.com/contest/1447/problem/D',
  'Catching Cheaters', '1447', 'D',
  '1800', 'medium', '["dp","greedy","strings"]',
  'You are given two strings A and B representing essays of two students who are suspected cheaters. For any two strings C, D we define their similarity score S(C,D) as 4\cdot LCS(C,D) - |C| - |D|, where LCS(C,D) denotes the length of the Longest Common Subsequence of strings C and D.

You believe that only some part of the essays could have been copied, therefore you''re interested in their substrings.

Calculate the maximal similarity score over all pairs of substrings. More formally, output maximal S(C, D) over all pairs (C, D), where C is some substring of A, and D is some substring of B.

If X is a string, |X| denotes its length.

A string a is a substring of a string b if a can be obtained from b by deletion of several (possibly, zero or all) characters from the beginning and several (possibly, zero or all) characters from the end.

A string a is a subsequence of a string b if a can be obtained from b by deletion of several (possibly, zero or all) characters.

Pay attention to the difference between the substring and subsequence, as they both appear in the problem statement.

You may wish to read the Wikipedia page about the Longest Common Subsequence problem.

## Input

The first line contains two positive integers n and m (1 \leq n, m \leq 5000) — lengths of the two strings A and B.

The second line contains a string consisting of n lowercase Latin letters — string A.

The third line contains a string consisting of m lowercase Latin letters — string B.

## Output

Output maximal S(C, D) over all pairs (C, D), where C is some substring of A, and D is some substring of B.

## Examples

Input

    4 5
    abba
    babab

Output

    5

Input

    8 10
    bbbbabab
    bbbabaaaaa

Output

    12

Input

    7 7
    uiibwws
    qhtkxcn

Output

    0

## Note

For the first case:

abb from the first string and abab from the second string have LCS equal to abb.

The result is S(abb, abab) = (4 \cdot |abb|) - |abb| - |abab| = 4 \cdot 3 - 3 - 4 = 5.', '[]',
  '1440fa5a2091f9c9b66130229dbf8b8d7b67a355ca59478d299af67928995178', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":21}',
  'resolve', NULL, 'backlog', NULL, '2026-08-23',
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
  'cp31-cf-1442-b', 'codeforces', '1442:B', 'https://codeforces.com/contest/1442/problem/B',
  'Identify the Operations', '1442', 'B',
  '1800', 'medium', '["combinatorics","data structures","dsu","greedy","implementation"]',
  'We start with a permutation a_1, a_2, \ldots, a_n and with an empty array b. We apply the following operation k times.

On the i-th iteration, we select an index t_i (1 \le t_i \le n-i+1), remove a_{t_i} from the array, and append one of the numbers a_{t_i-1} or a_{t_i+1} (if t_i-1 or t_i+1 are within the array bounds) to the right end of the array b. Then we move elements a_{t_i+1}, \ldots, a_n to the left in order to fill in the empty space.

You are given the initial permutation a_1, a_2, \ldots, a_n and the resulting array b_1, b_2, \ldots, b_k. All elements of an array b are distinct. Calculate the number of possible sequences of indices t_1, t_2, \ldots, t_k modulo 998\,244\,353.

## Input

Each test contains multiple test cases. The first line contains an integer t (1 \le t \le 100\,000), denoting the number of test cases, followed by a description of the test cases.

The first line of each test case contains two integers n, k (1 \le k  \lt  n \le 200\,000): sizes of arrays a and b.

The second line of each test case contains n integers a_1, a_2, \ldots, a_n (1 \le a_i \le n): elements of a. All elements of a are distinct.

The third line of each test case contains k integers b_1, b_2, \ldots, b_k (1 \le b_i \le n): elements of b. All elements of b are distinct.

The sum of all n among all test cases is guaranteed to not exceed 200\,000.

## Output

For each test case print one integer: the number of possible sequences modulo 998\,244\,353.

## Example

Input

    3
    5 3
    1 2 3 4 5
    3 2 5
    4 3
    4 3 2 1
    4 3 1
    7 4
    1 4 7 3 6 2 5
    3 2 4 5

Output

    2
    0
    4

## Note

\require{cancel}

Let''s denote as a_1 a_2 \ldots \cancel{a_i} \underline{a_{i+1}} \ldots a_n \rightarrow a_1 a_2 \ldots a_{i-1} a_{i+1} \ldots a_{n-1} an operation over an element with index i: removal of element a_i from array a and appending element a_{i+1} to array b.

In the first example test, the following two options can be used to produce the given array b:

 - 1 2 \underline{3} \cancel{4} 5 \rightarrow 1 \underline{2} \cancel{3} 5 \rightarrow 1 \cancel{2} \underline{5} \rightarrow 1 2; (t_1, t_2, t_3) = (4, 3, 2);
- 1 2 \underline{3} \cancel{4} 5 \rightarrow \cancel{1} \underline{2} 3 5 \rightarrow 2 \cancel{3} \underline{5} \rightarrow 1 5; (t_1, t_2, t_3) = (4, 1, 2).

In the second example test, it is impossible to achieve the given array no matter the operations used. That''s because, on the first application, we removed the element next to 4, namely number 3, which means that it couldn''t be added to array b on the second step.

In the third example test, there are four options to achieve the given array b:

 - 1 4 \cancel{7} \underline{3} 6 2 5 \rightarrow 1 4 3 \cancel{6} \underline{2} 5 \rightarrow \cancel{1} \underline{4} 3 2 5 \rightarrow 4 3 \cancel{2} \underline{5} \rightarrow 4 3 5;
- 1 4 \cancel{7} \underline{3} 6 2 5 \rightarrow 1 4 3 \cancel{6} \underline{2} 5 \rightarrow 1 \underline{4} \cancel{3} 2 5 \rightarrow 1 4 \cancel{2} \underline{5} \rightarrow 1 4 5;
- 1 4 7 \underline{3} \cancel{6} 2 5 \rightarrow 1 4 7 \cancel{3} \underline{2} 5 \rightarrow \cancel{1} \underline{4} 7 2 5 \rightarrow 4 7 \cancel{2} \underline{5} \rightarrow 4 7 5;
- 1 4 7 \underline{3} \cancel{6} 2 5 \rightarrow 1 4 7 \cancel{3} \underline{2} 5 \rightarrow 1 \underline{4} \cancel{7} 2 5 \rightarrow 1 4 \cancel{2} \underline{5} \rightarrow 1 4 5;', '[]',
  'a95c047aeaf97f32cbcff4792eea2a1612ab072950db480dc617259effdf4895', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":22}',
  'resolve', NULL, 'backlog', NULL, '2026-08-23',
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
  'cp31-cf-1437-c', 'codeforces', '1437:C', 'https://codeforces.com/contest/1437/problem/C',
  'Chef Monocarp', '1437', 'C',
  '1800', 'medium', '["dp","flows","graph matchings","greedy","math","sortings"]',
  'Chef Monocarp has just put n dishes into an oven. He knows that the i-th dish has its optimal cooking time equal to t_i minutes.

At any positive integer minute T Monocarp can put no more than one dish out of the oven. If the i-th dish is put out at some minute T, then its unpleasant value is |T - t_i| — the absolute difference between T and t_i. Once the dish is out of the oven, it can''t go back in.

Monocarp should put all the dishes out of the oven. What is the minimum total unpleasant value Monocarp can obtain?

## Input

The first line contains a single integer q (1 \le q \le 200) — the number of testcases.

Then q testcases follow.

The first line of the testcase contains a single integer n (1 \le n \le 200) — the number of dishes in the oven.

The second line of the testcase contains n integers t_1, t_2, \dots, t_n (1 \le t_i \le n) — the optimal cooking time for each dish.

The sum of n over all q testcases doesn''t exceed 200.

## Output

Print a single integer for each testcase — the minimum total unpleasant value Monocarp can obtain when he puts out all the dishes out of the oven. Remember that Monocarp can only put the dishes out at positive integer minutes and no more than one dish at any minute.

## Example

Input

    6
    6
    4 2 4 4 5 2
    7
    7 7 7 7 7 7 7
    1
    1
    5
    5 1 2 4 3
    4
    1 4 4 4
    21
    21 8 1 4 1 5 21 1 8 21 11 21 11 3 12 8 19 15 9 11 13

Output

    4
    12
    0
    0
    2
    21

## Note

In the first example Monocarp can put out the dishes at minutes 3, 1, 5, 4, 6, 2. That way the total unpleasant value will be |4 - 3| + |2 - 1| + |4 - 5| + |4 - 4| + |6 - 5| + |2 - 2| = 4.

In the second example Monocarp can put out the dishes at minutes 4, 5, 6, 7, 8, 9, 10.

In the third example Monocarp can put out the dish at minute 1.

In the fourth example Monocarp can put out the dishes at minutes 5, 1, 2, 4, 3.

In the fifth example Monocarp can put out the dishes at minutes 1, 3, 4, 5.', '[]',
  '5ba456464e92a29b76b920b5d21e952ec728edfd99f238c702ef482412f713ba', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":23}',
  'resolve', NULL, 'backlog', NULL, '2026-08-23',
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
  'cp31-cf-1401-d', 'codeforces', '1401:D', 'https://codeforces.com/contest/1401/problem/D',
  'Maximum Distributed Tree', '1401', 'D',
  '1800', 'medium', '["dfs and similar","dp","greedy","implementation","math","number theory","sortings","trees"]',
  'You are given a tree that consists of n nodes. You should label each of its n-1 edges with an integer in such way that satisfies the following conditions:

 - each integer must be greater than 0;
- the product of all n-1 numbers should be equal to k;
- the number of 1-s among all n-1 integers must be minimum possible.

Let''s define f(u,v) as the sum of the numbers on the simple path from node u to node v. Also, let \sum\limits_{i=1}^{n-1} \sum\limits_{j=i+1}^n f(i,j) be a distribution index of the tree.

Find the maximum possible distribution index you can get. Since answer can be too large, print it modulo 10^9 + 7.

In this problem, since the number k can be large, the result of the prime factorization of k is given instead.

## Input

The first line contains one integer t (1 \le t \le 100) — the number of test cases.

The first line of each test case contains a single integer n (2 \le n \le 10^5) — the number of nodes in the tree.

Each of the next n-1 lines describes an edge: the i-th line contains two integers u_i and v_i (1 \le u_i, v_i \le n; u_i \ne v_i) — indices of vertices connected by the i-th edge.

Next line contains a single integer m (1 \le m \le 6 \cdot 10^4) — the number of prime factors of k.

Next line contains m prime numbers p_1, p_2, \ldots, p_m (2 \le p_i  \lt  6 \cdot 10^4) such that k = p_1 \cdot p_2 \cdot \ldots \cdot p_m.

It is guaranteed that the sum of n over all test cases doesn''t exceed 10^5, the sum of m over all test cases doesn''t exceed 6 \cdot 10^4, and the given edges for each test cases form a tree.

## Output

Print the maximum distribution index you can get. Since answer can be too large, print it modulo 10^9+7.

## Example

Input

    3
    4
    1 2
    2 3
    3 4
    2
    2 2
    4
    3 4
    1 3
    3 2
    2
    3 2
    7
    6 1
    2 3
    4 6
    7 3
    5 1
    3 6
    4
    7 5 13 3

Output

    17
    18
    286

## Note

In the first test case, one of the optimal ways is on the following image:

  

In this case, f(1,2)=1, f(1,3)=3, f(1,4)=5, f(2,3)=2, f(2,4)=4, f(3,4)=2, so the sum of these 6 numbers is 17.

In the second test case, one of the optimal ways is on the following image:

  

In this case, f(1,2)=3, f(1,3)=1, f(1,4)=4, f(2,3)=2, f(2,4)=5, f(3,4)=3, so the sum of these 6 numbers is 18.', '[{"alt":"Problem diagram","url":"https://espresso.codeforces.com/47c01cca95f2052b2f4fbc60f42f584214acee21.png"},{"alt":"Problem diagram","url":"https://espresso.codeforces.com/be6fdc6dfcc7940440a13671212239673cd9fdd5.png"}]',
  '8401033649d5dd929994c4eb956cb5095a12a27173ac61da6cc4fe72648bbe2b', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":24}',
  'resolve', NULL, 'backlog', NULL, '2026-08-23',
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
  'cp31-cf-1396-b', 'codeforces', '1396:B', 'https://codeforces.com/contest/1396/problem/B',
  'Stoned Game', '1396', 'B',
  '1800', 'medium', '["brute force","constructive algorithms","games","greedy"]',
  'T is playing a game with his friend, HL.

There are n piles of stones, the i-th pile initially has a_i stones.

T and HL will take alternating turns, with T going first. In each turn, a player chooses a non-empty pile and then removes a single stone from it. However, one cannot choose a pile that has been chosen in the previous turn (the pile that was chosen by the other player, or if the current turn is the first turn then the player can choose any non-empty pile). The player who cannot choose a pile in his turn loses, and the game ends.

Assuming both players play optimally, given the starting configuration of t games, determine the winner of each game.

## Input

The first line of the input contains a single integer t (1 \le t \le 100) — the number of games. The description of the games follows. Each description contains two lines:

The first line contains a single integer n (1 \le n \le 100) — the number of piles.

The second line contains n integers a_1, a_2, \dots, a_n (1 \le a_i \le 100).

## Output

For each game, print on a single line the name of the winner, "T" or "HL" (without quotes)

## Example

Input

    2
    1
    2
    2
    1 1

Output

    T
    HL

## Note

In the first game, T removes a single stone from the only pile in his first turn. After that, although the pile still contains 1 stone, HL cannot choose from this pile because it has been chosen by T in the previous turn. Therefore, T is the winner.', '[]',
  'b812c67fb6c6b1bcbb6308978f3cde1f3fc3ed7d35a1086eb9c28810c6a81bac', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":25}',
  'resolve', NULL, 'backlog', NULL, '2026-08-23',
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
  'cp31-cf-1355-c', 'codeforces', '1355:C', 'https://codeforces.com/contest/1355/problem/C',
  'Count Triangles', '1355', 'C',
  '1800', 'medium', '["binary search","implementation","math","two pointers"]',
  'Like any unknown mathematician, Yuri has favourite numbers: A, B, C, and D, where A \leq B \leq C \leq D. Yuri also likes triangles and once he thought: how many non-degenerate triangles with integer sides x, y, and z exist, such that A \leq x \leq B \leq y \leq C \leq z \leq D holds?

Yuri is preparing problems for a new contest now, so he is very busy. That''s why he asked you to calculate the number of triangles with described property.

The triangle is called non-degenerate if and only if its vertices are not collinear.

## Input

The first line contains four integers: A, B, C and D (1 \leq A \leq B \leq C \leq D \leq 5 \cdot 10^5) — Yuri''s favourite numbers.

## Output

Print the number of non-degenerate triangles with integer sides x, y, and z such that the inequality A \leq x \leq B \leq y \leq C \leq z \leq D holds.

## Examples

Input

    1 2 3 4

Output

    4

Input

    1 2 2 5

Output

    3

Input

    500000 500000 500000 500000

Output

    1

## Note

In the first example Yuri can make up triangles with sides (1, 3, 3), (2, 2, 3), (2, 3, 3) and (2, 3, 4).

In the second example Yuri can make up triangles with sides (1, 2, 2), (2, 2, 2) and (2, 2, 3).

In the third example Yuri can make up only one equilateral triangle with sides equal to 5 \cdot 10^5.', '[]',
  '8b09402deae96e8bb55c9e833b59e1b9e69bba8790e5a89ca0bc6c91a781e58f', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":26}',
  'resolve', NULL, 'backlog', NULL, '2026-08-24',
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
  'cp31-cf-1338-b', 'codeforces', '1338:B', 'https://codeforces.com/contest/1338/problem/B',
  'Edge Weight Assignment', '1338', 'B',
  '1800', 'medium', '["bitmasks","constructive algorithms","dfs and similar","greedy","math","trees"]',
  'You have unweighted tree of n vertices. You have to assign a positive weight to each edge so that the following condition would hold:

 - For every two different leaves v_{1} and v_{2} of this tree, bitwise XOR of weights of all edges on the simple path between v_{1} and v_{2} has to be equal to 0.

Note that you can put very large positive integers (like 10^{(10^{10})}).

It''s guaranteed that such assignment always exists under given constraints. Now let''s define f as the number of distinct weights in assignment.

  In this example, assignment is valid, because bitwise XOR of all edge weights between every pair of leaves is 0. f value is 2 here, because there are 2 distinct edge weights(4 and 5).

In this example, assignment is invalid, because bitwise XOR of all edge weights between vertex 1 and vertex 6 (3, 4, 5, 4) is not 0.

What are the minimum and the maximum possible values of f for the given tree? Find and print both.

## Input

The first line contains integer n (3 \le n \le 10^{5}) — the number of vertices in given tree.

The i-th of the next n-1 lines contains two integers a_{i} and b_{i} (1 \le a_{i} \lt b_{i} \le n) — it means there is an edge between a_{i} and b_{i}. It is guaranteed that given graph forms tree of n vertices.

## Output

Print two integers — the minimum and maximum possible value of f can be made from valid assignment of given tree. Note that it''s always possible to make an assignment under given constraints.

## Examples

Input

    6
    1 3
    2 3
    3 4
    4 5
    5 6

Output

    1 4

Input

    6
    1 3
    2 3
    3 4
    4 5
    4 6

Output

    3 3

Input

    7
    1 2
    2 7
    3 4
    4 7
    5 6
    6 7

Output

    1 6

## Note

In the first example, possible assignments for each minimum and maximum are described in picture below. Of course, there are multiple possible assignments for each minimum and maximum.

  

In the second example, possible assignments for each minimum and maximum are described in picture below. The f value of valid assignment of this tree is always 3.

  

In the third example, possible assignments for each minimum and maximum are described in picture below. Of course, there are multiple possible assignments for each minimum and maximum.', '[{"alt":"Problem diagram","url":"https://espresso.codeforces.com/5b0101e1310bed98e055bbf14738361d76eac0d7.png"},{"alt":"Problem diagram","url":"https://espresso.codeforces.com/0069cd7e09cedad856e36260655c8bbd4f42062f.png"},{"alt":"Problem diagram","url":"https://espresso.codeforces.com/8c3ca6ef35ed8818b24c63d36c4f1fe419bb545c.png"},{"alt":"Problem diagram","url":"https://espresso.codeforces.com/97d4c3d0db0f70bfbf3cc4fa8ba0a2691a95320e.png"},{"alt":"Problem diagram","url":"https://espresso.codeforces.com/2cd034f9908e3131bc593c352126e15712c58763.png"}]',
  '9ef550fbfa931693d993d81cef4676bfb4dd6e12d8020e70be17e884b0368eb6', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":27}',
  'resolve', NULL, 'backlog', NULL, '2026-08-24',
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
  'cp31-cf-1335-e2', 'codeforces', '1335:E2', 'https://codeforces.com/contest/1335/problem/E2',
  'Three Blocks Palindrome (hard version)', '1335', 'E2',
  '1800', 'medium', '["brute force","data structures","dp","two pointers"]',
  'The only difference between easy and hard versions is constraints.

You are given a sequence a consisting of n positive integers.

Let''s define a three blocks palindrome as the sequence, consisting of at most two distinct elements (let these elements are a and b, a can be equal b) and is as follows: [\underbrace{a, a, \dots, a}_{x}, \underbrace{b, b, \dots, b}_{y}, \underbrace{a, a, \dots, a}_{x}]. There x, y are integers greater than or equal to 0. For example, sequences [], [2], [1, 1], [1, 2, 1], [1, 2, 2, 1] and [1, 1, 2, 1, 1] are three block palindromes but [1, 2, 3, 2, 1], [1, 2, 1, 2, 1] and [1, 2] are not.

Your task is to choose the maximum by length subsequence of a that is a three blocks palindrome.

You have to answer t independent test cases.

Recall that the sequence t is a a subsequence of the sequence s if t can be derived from s by removing zero or more elements without changing the order of the remaining elements. For example, if s=[1, 2, 1, 3, 1, 2, 1], then possible subsequences are: [1, 1, 1, 1], [3] and [1, 2, 1, 3, 1, 2, 1], but not [3, 2, 3] and [1, 1, 1, 1, 2].

## Input

The first line of the input contains one integer t (1 \le t \le 10^4) — the number of test cases. Then t test cases follow.

The first line of the test case contains one integer n (1 \le n \le 2 \cdot 10^5) — the length of a. The second line of the test case contains n integers a_1, a_2, \dots, a_n (1 \le a_i \le 200), where a_i is the i-th element of a. Note that the maximum value of a_i can be up to 200.

It is guaranteed that the sum of n over all test cases does not exceed 2 \cdot 10^5 (\sum n \le 2 \cdot 10^5).

## Output

For each test case, print the answer — the maximum possible length of some subsequence of a that is a three blocks palindrome.

## Example

Input

    6
    8
    1 1 2 2 3 2 1 1
    3
    1 3 3
    4
    1 10 10 1
    1
    26
    2
    2 1
    3
    1 1 1

Output

    7
    2
    4
    1
    1
    3', '[]',
  'fd34241e9d45325d33591fbc4baeafd3a7e6f63dc4497abb43f1a99ff90845fb', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":28}',
  'resolve', NULL, 'backlog', NULL, '2026-08-24',
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
