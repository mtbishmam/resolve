INSERT INTO problems (
  id, platform, problem_key, url, title, contest, problem_index, rating,
  difficulty, official_tags_json, statement_markdown, statement_assets_json,
  statement_hash, statement_captured_at, metadata_status,
  metadata_provenance_json, legacy_metadata_json, import_source,
  import_provenance_json, review_status, state, status, archived_at, due_date,
  sprint_id, next_review_date, created_at, updated_at
) VALUES (
  'cp31-cf-1822-g1', 'codeforces', '1822:G1', 'https://codeforces.com/contest/1822/problem/G1',
  'Magic Triples (Easy Version)', '1822', 'G1',
  '1700', 'medium', '["brute force","data structures","math","number theory"]',
  'This is the easy version of the problem. The only difference is that in this version, a_i \le 10^6.

For a given sequence of n integers a, a triple (i, j, k) is called magic if:

 - 1 \le i, j, k \le n.
- i, j, k are pairwise distinct.
- there exists a positive integer b such that a_i \cdot b = a_j and a_j \cdot b = a_k.

Kolya received a sequence of integers a as a gift and now wants to count the number of magic triples for it. Help him with this task!

Note that there are no constraints on the order of integers i, j and k.

## Input

The first line contains a single integer t (1 \le t \le 10^4) — the number of test cases. The description of the test cases follows.

The first line of the test case contains a single integer n (3 \le n \le 2 \cdot 10^5) — the length of the sequence.

The second line of the test contains n integers a_1, a_2, a_3, \dots, a_n (1 \le a_i \le 10^6) — the elements of the sequence a.

The sum of n over all test cases does not exceed 2 \cdot 10^5.

## Output

For each test case, output a single integer — the number of magic triples for the sequence a.

## Example

Input

    7
    5
    1 7 7 2 7
    3
    6 2 18
    9
    1 2 3 4 5 6 7 8 9
    4
    1000 993 986 179
    7
    1 10 100 1000 10000 100000 1000000
    8
    1 1 2 2 4 4 8 8
    9
    1 1 1 2 2 2 4 4 4

Output

    6
    1
    3
    0
    9
    16
    45

## Note

In the first example, there are 6 magic triples for the sequence a — (2, 3, 5), (2, 5, 3), (3, 2, 5), (3, 5, 2), (5, 2, 3), (5, 3, 2).

In the second example, there is a single magic triple for the sequence a — (2, 1, 3).', '[]',
  '2149ba7155f9695a8d5cad98488a9ad68e2da0edf3ea268e1cbbcbe05d1c9a6c', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":15}',
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
  'cp31-cf-1792-d', 'codeforces', '1792:D', 'https://codeforces.com/contest/1792/problem/D',
  'Fixed Prefix Permutations', '1792', 'D',
  '1700', 'medium', '["binary search","bitmasks","data structures","hashing","math","sortings"]',
  'You are given n permutations a_1, a_2, \dots, a_n, each of length m. Recall that a permutation of length m is a sequence of m distinct integers from 1 to m.

Let the beauty of a permutation p_1, p_2, \dots, p_m be the largest k such that p_1 = 1, p_2 = 2, \dots, p_k = k. If p_1 \neq 1, then the beauty is 0.

The product of two permutations p \cdot q is a permutation r such that r_j = q_{p_j}.

For each i from 1 to n, print the largest beauty of a permutation a_i \cdot a_j over all j from 1 to n (possibly, i = j).

## Input

The first line contains a single integer t (1 \le t \le 10^4) — the number of testcases.

The first line of each testcase contains two integers n and m (1 \le n \le 5 \cdot 10^4; 1 \le m \le 10) — the number of permutations and the length of each permutation.

The i-th of the next n lines contains a permutation a_i — m distinct integers from 1 to m.

The sum of n doesn''t exceed 5 \cdot 10^4 over all testcases.

## Output

For each testcase, print n integers. The i-th value should be equal to the largest beauty of a permutation a_i \cdot a_j over all j (1 \le j \le n).

## Example

Input

    3
    3 4
    2 4 1 3
    1 2 4 3
    2 1 3 4
    2 2
    1 2
    2 1
    8 10
    3 4 9 6 10 2 7 8 1 5
    3 9 1 8 5 7 4 10 2 6
    3 10 1 7 5 9 6 4 2 8
    1 2 3 4 8 6 10 7 9 5
    1 2 3 4 10 6 8 5 7 9
    9 6 1 2 10 4 7 8 3 5
    7 9 3 2 5 6 4 8 1 10
    9 4 3 7 5 6 1 10 8 2

Output

    1 4 4 
    2 2 
    10 8 1 6 8 10 1 7', '[]',
  'f0e77c487794c0442cef2bb454c281ba3b073046355c77c54cee9f75f88629a1', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":16}',
  'resolve', NULL, 'backlog', NULL, '2026-08-15',
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
  'cp31-cf-1777-c', 'codeforces', '1777:C', 'https://codeforces.com/contest/1777/problem/C',
  'Quiz Master', '1777', 'C',
  '1700', 'medium', '["binary search","math","number theory","sortings","two pointers"]',
  'A school has to decide on its team for an international quiz. There are n students in the school. We can describe the students using an array a where a_i is the smartness of the i-th (1 \le i \le n) student.

There are m topics 1, 2, 3, \ldots, m from which the quiz questions will be formed. The i-th student is considered proficient in a topic T if (a_i \bmod T) = 0. Otherwise, he is a rookie in that topic.

We say that a team of students is collectively proficient in all the topics if for every topic there is a member of the team proficient in this topic.

Find a team that is collectively proficient in all the topics such that the maximum difference between the smartness of any two students in that team is minimized. Output this difference.

## Input

Each test contains multiple test cases. The first line contains the number of test cases t (1 \le t \le 10^4). The description of the test cases follows.

The first line of each test case contains n and m (1 \le n,m \le 10^5).

The second line of each test case contains n integers a_1, a_2, \ldots, a_n (1 \le a_i \le 10^5).

It is guaranteed that the sum of n over all test cases does not exceed 10^5.

It is guaranteed that the sum of m over all test cases does not exceed 10^5.

## Output

For each test case, print the answer on a new line. If there is no solution, output -1.

## Example

Input

    3
    2 4
    3 7
    4 2
    3 7 2 9
    5 7
    6 4 3 5 7

Output

    -1
    0
    3

## Note

In the first test case, we have participants with smartnesses 3 and 7, and m = 4. Thus, there is no student with smartness divisible by 2. Since 2 \leq m, there is no way to choose a team.

In the second test case, we can select the participant with smartness 2 to be the only one on the team. This way the team will be collectively proficient in both topics 1 and 2.

In the third test case, consider the team with participants of smartnesses 4, 5, 6, 7. This way the team will be collectively proficient in all topics 1, 2, \ldots, 7.', '[]',
  '882b2a2def07068a24c8391958f698471a79878e8438e5538a3c7810051d47fc', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":17}',
  'resolve', NULL, 'backlog', NULL, '2026-08-15',
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
  'cp31-cf-1760-g', 'codeforces', '1760:G', 'https://codeforces.com/contest/1760/problem/G',
  'SlavicG''s Favorite Problem', '1760', 'G',
  '1700', 'medium', '["bitmasks","dfs and similar","graphs"]',
  'You are given a weighted tree with n vertices. Recall that a tree is a connected graph without any cycles. A weighted tree is a tree in which each edge has a certain weight. The tree is undirected, it doesn''t have a root.

Since trees bore you, you decided to challenge yourself and play a game on the given tree.

In a move, you can travel from a node to one of its neighbors (another node it has a direct edge with).

You start with a variable x which is initially equal to 0. When you pass through edge i, x changes its value to x ~\mathsf{XOR}~ w_i (where w_i is the weight of the i-th edge).

Your task is to go from vertex a to vertex b, but you are allowed to enter node b if and only if after traveling to it, the value of x will become 0. In other words, you can travel to node b only by using an edge i such that x ~\mathsf{XOR}~ w_i = 0. Once you enter node b the game ends and you win.

Additionally, you can teleport at most once at any point in time to any vertex except vertex b. You can teleport from any vertex, even from a.

Answer with "YES" if you can reach vertex b from a, and "NO" otherwise.

Note that \mathsf{XOR} represents the bitwise XOR operation.

## Input

The first line contains a single integer t (1 \leq t \leq 1000) — the number of test cases.

The first line of each test case contains three integers n, a, and b (2 \leq n \leq 10^5), (1 \leq a, b \leq n; a \ne b) — the number of vertices, and the starting and desired ending node respectively.

Each of the next n-1 lines denotes an edge of the tree. Edge i is denoted by three integers u_i, v_i and w_i  — the labels of vertices it connects (1 \leq u_i, v_i \leq n; u_i \ne v_i; 1 \leq w_i \leq 10^9) and the weight of the respective edge.

It is guaranteed that the sum of n over all test cases does not exceed 10^5.

## Output

For each test case output "YES" if you can reach vertex b, and "NO" otherwise.

## Example

Input

    3
    5 1 4
    1 3 1
    2 3 2
    4 3 3
    3 5 1
    2 1 2
    1 2 2
    6 2 3
    1 2 1
    2 3 1
    3 4 1
    4 5 3
    5 6 5

Output

    YES
    NO
    YES

## Note

For the first test case, we can travel from node 1 to node 3, x changing from 0 to 1, then we travel from node 3 to node 2, x becoming equal to 3. Now, we can teleport to node 3 and travel from node 3 to node 4, reaching node b, since x became equal to 0 in the end, so we should answer "YES".

For the second test case, we have no moves, since we can''t teleport to node b and the only move we have is to travel to node 2 which is impossible since x wouldn''t be equal to 0 when reaching it, so we should answer "NO".', '[]',
  '83b08587fbbbbc9bf485de0fd6636af0b2aee0d2ba3e6a4ee7fe5d3bcee9d72e', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":18}',
  'resolve', NULL, 'backlog', NULL, '2026-08-15',
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
  'cp31-cf-1735-d', 'codeforces', '1735:D', 'https://codeforces.com/contest/1735/problem/D',
  'Meta-set', '1735', 'D',
  '1700', 'medium', '["brute force","combinatorics","data structures","hashing","math"]',
  'You like the card board game "Set". Each card contains k features, each of which is equal to a value from the set \{0, 1, 2\}. The deck contains all possible variants of cards, that is, there are 3^k different cards in total.

A feature for three cards is called good if it is the same for these cards or pairwise distinct. Three cards are called a set if all k features are good for them.

For example, the cards (0, 0, 0), (0, 2, 1), and (0, 1, 2) form a set, but the cards (0, 2, 2), (2, 1, 2), and (1, 2, 0) do not, as, for example, the last feature is not good.

A group of five cards is called a meta-set, if there is strictly more than one set among them. How many meta-sets there are among given n distinct cards?

## Input

The first line of the input contains two integers n and k (1 \le n \le 10^3, 1 \le k \le 20) — the number of cards on a table and the number of card features. The description of the cards follows in the next n lines.

Each line describing a card contains k integers c_{i, 1}, c_{i, 2}, \ldots, c_{i, k} (0 \le c_{i, j} \le 2) — card features. It is guaranteed that all cards are distinct.

## Output

Output one integer — the number of meta-sets.

## Examples

Input

    8 4
    0 0 0 0
    0 0 0 1
    0 0 0 2
    0 0 1 0
    0 0 2 0
    0 1 0 0
    1 0 0 0
    2 2 0 0

Output

    1

Input

    7 4
    0 0 0 0
    0 0 0 1
    0 0 0 2
    0 0 1 0
    0 0 2 0
    0 1 0 0
    0 2 0 0

Output

    3

Input

    9 2
    0 0
    0 1
    0 2
    1 0
    1 1
    1 2
    2 0
    2 1
    2 2

Output

    54

Input

    20 4
    0 2 0 0
    0 2 2 2
    0 2 2 1
    0 2 0 1
    1 2 2 0
    1 2 1 0
    1 2 2 1
    1 2 0 1
    1 1 2 2
    1 1 0 2
    1 1 2 1
    1 1 1 1
    2 1 2 0
    2 1 1 2
    2 1 2 1
    2 1 1 1
    0 1 1 2
    0 0 1 0
    2 2 0 0
    2 0 0 2

Output

    0

## Note

Let''s draw the cards indicating the first four features. The first feature will indicate the number of objects on a card: 1, 2, 3. The second one is the color: red, green, purple. The third is the shape: oval, diamond, squiggle. The fourth is filling: open, striped, solid.

You can see the first three tests below. For the first two tests, the meta-sets are highlighted.

In the first test, the only meta-set is the five cards (0000,\ 0001,\ 0002,\ 0010,\ 0020). The sets in it are the triples (0000,\ 0001,\ 0002) and (0000,\ 0010,\ 0020). Also, a set is the triple (0100,\ 1000,\ 2200) which does not belong to any meta-set.

  

In the second test, the following groups of five cards are meta-sets: (0000,\ 0001,\ 0002,\ 0010,\ 0020), (0000,\ 0001,\ 0002,\ 0100,\ 0200), (0000,\ 0010,\ 0020,\ 0100,\ 0200).

  

In there third test, there are 54 meta-sets.', '[{"alt":"Problem diagram","url":"https://espresso.codeforces.com/294b433719e5c7d42bd7eaa11a549d189bd488de.png"},{"alt":"Problem diagram","url":"https://espresso.codeforces.com/37ff40acf802ba24393cecf877ecbea33f89397b.png"},{"alt":"Problem diagram","url":"https://espresso.codeforces.com/880c85c827f3a1b11ccab331703ef4ea25a39db6.png"}]',
  'fe11af8787c4ecc0c2c84f46f49fecd01c9d97c35090aada1dac39068e870c46', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":19}',
  'resolve', NULL, 'backlog', NULL, '2026-08-15',
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
  'cp31-cf-1731-c', 'codeforces', '1731:C', 'https://codeforces.com/contest/1731/problem/C',
  'Even Subarrays', '1731', 'C',
  '1700', 'medium', '["bitmasks","brute force","hashing","math","number theory"]',
  'You are given an integer array a_1, a_2, \dots, a_n (1 \le a_i \le n).

Find the number of subarrays of a whose \operatorname{XOR} has an even number of divisors. In other words, find all pairs of indices (i, j) (i \le j) such that a_i \oplus a_{i + 1} \oplus \dots \oplus a_j has an even number of divisors.

For example, numbers 2, 3, 5 or 6 have an even number of divisors, while 1 and 4 — odd. Consider that 0 has an odd number of divisors in this task.

Here \operatorname{XOR} (or \oplus) denotes the bitwise XOR operation.

Print the number of subarrays but multiplied by 2022... Okay, let''s stop. Just print the actual answer.

## Input

Each test contains multiple test cases. The first line contains the number of test cases t (1 \leq t \leq 10^4). Description of the test cases follows.

The first line of each test case contains a single integer n (2 \leq n \leq 2 \cdot 10^5) — the length of the array a.

The second line contains n integers a_1, a_2, \dots, a_n (1 \leq a_i \leq n).

It is guaranteed that the sum of n over all test cases does not exceed 2 \cdot 10^5.

## Output

For each test case, print the number of subarrays, whose \operatorname{XOR} has an even number of divisors.

## Example

Input

    4
    3
    3 1 2
    5
    4 2 1 5 3
    4
    4 4 4 4
    7
    5 7 3 7 1 7 3

Output

    4
    11
    0
    20

## Note

In the first test case, there are 4 subarrays whose \operatorname{XOR} has an even number of divisors: [3], [3,1], [1,2], [2].

In the second test case, there are 11 subarrays whose \operatorname{XOR} has an even number of divisors: [4,2], [4,2,1], [4,2,1,5], [2], [2,1], [2,1,5], [2,1,5,3], [1,5,3], [5], [5,3], [3].

In the third test case, there is no subarray whose \operatorname{XOR} has an even number of divisors since \operatorname{XOR} of any subarray is either 4 or 0.', '[]',
  'e8228cb50e690a25fe61cd71044cc7a9f92fa76fdf4288b7c1b385f32979eda6', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":20}',
  'resolve', NULL, 'backlog', NULL, '2026-08-15',
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
  'cp31-cf-1715-c', 'codeforces', '1715:C', 'https://codeforces.com/contest/1715/problem/C',
  'Monoblock', '1715', 'C',
  '1700', 'medium', '["combinatorics","data structures","implementation","math"]',
  'Stanley has decided to buy a new desktop PC made by the company "Monoblock", and to solve captcha on their website, he needs to solve the following task.

The awesomeness of an array is the minimum number of blocks of consecutive identical numbers in which the array could be split. For example, the awesomeness of an array

 - [1, 1, 1] is 1;
- [5, 7] is 2, as it could be split into blocks [5] and [7];
- [1, 7, 7, 7, 7, 7, 7, 7, 9, 9, 9, 9, 9, 9, 9, 9, 9] is 3, as it could be split into blocks [1], [7, 7, 7, 7, 7, 7, 7], and [9, 9, 9, 9, 9, 9, 9, 9, 9].

You are given an array a of length n. There are m queries of two integers i, x. A query i, x means that from now on the i-th element of the array a is equal to x.

After each query print the sum of awesomeness values among all subsegments of array a. In other words, after each query you need to calculate \sum\limits_{l = 1}^n \sum\limits_{r = l}^n g(l, r), where g(l, r) is the awesomeness of the array b = [a_l, a_{l + 1}, \ldots, a_r].

## Input

In the first line you are given with two integers n and m (1 \leq n, m \leq 10^5).

The second line contains n integers a_1, a_2, \ldots, a_n (1 \le a_i \le 10^9) — the array a.

In the next m lines you are given the descriptions of queries. Each line contains two integers i and x (1 \leq i \leq n, 1 \leq x \leq 10^9).

## Output

Print the answer to each query on a new line.

## Example

Input

    5 5
    1 2 3 4 5
    3 2
    4 2
    3 1
    2 1
    2 2

Output

    29
    23
    35
    25
    35

## Note

After the first query a is equal to [1, 2, 2, 4, 5], and the answer is 29 because we can split each of the subsegments the following way:

 - [1; 1]: [1], 1 block;
- [1; 2]: [1] + [2], 2 blocks;
- [1; 3]: [1] + [2, 2], 2 blocks;
- [1; 4]: [1] + [2, 2] + [4], 3 blocks;
- [1; 5]: [1] + [2, 2] + [4] + [5], 4 blocks;
- [2; 2]: [2], 1 block;
- [2; 3]: [2, 2], 1 block;
- [2; 4]: [2, 2] + [4], 2 blocks;
- [2; 5]: [2, 2] + [4] + [5], 3 blocks;
- [3; 3]: [2], 1 block;
- [3; 4]: [2] + [4], 2 blocks;
- [3; 5]: [2] + [4] + [5], 3 blocks;
- [4; 4]: [4], 1 block;
- [4; 5]: [4] + [5], 2 blocks;
- [5; 5]: [5], 1 block;
 which is 1 + 2 + 2 + 3 + 4 + 1 + 1 + 2 + 3 + 1 + 2 + 3 + 1 + 2 + 1 = 29 in total.', '[]',
  'a2685cd4ef7b280852d4cb8310377bccca24cbe625a0b25322ac8cabdde7bdf5', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":21}',
  'resolve', NULL, 'backlog', NULL, '2026-08-16',
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
  'cp31-cf-1709-d', 'codeforces', '1709:D', 'https://codeforces.com/contest/1709/problem/D',
  'Rorororobot', '1709', 'D',
  '1700', 'medium', '["binary search","data structures","greedy","math"]',
  'There is a grid, consisting of n rows and m columns. The rows are numbered from 1 to n from bottom to top. The columns are numbered from 1 to m from left to right. The i-th column has the bottom a_i cells blocked (the cells in rows 1, 2, \dots, a_i), the remaining n - a_i cells are unblocked.

A robot is travelling across this grid. You can send it commands — move up, right, down or left. If a robot attempts to move into a blocked cell or outside the grid, it explodes.

However, the robot is broken — it executes each received command k times. So if you tell it to move up, for example, it will move up k times (k cells). You can''t send it commands while the robot executes the current one.

You are asked q queries about the robot. Each query has a start cell, a finish cell and a value k. Can you send the robot an arbitrary number of commands (possibly, zero) so that it reaches the finish cell from the start cell, given that it executes each command k times?

The robot must stop in the finish cell. If it visits the finish cell while still executing commands, it doesn''t count.

## Input

The first line contains two integers n and m (1 \le n \le 10^9; 1 \le m \le 2 \cdot 10^5) — the number of rows and columns of the grid.

The second line contains m integers a_1, a_2, \dots, a_m (0 \le a_i \le n) — the number of blocked cells on the bottom of the i-th column.

The third line contains a single integer q (1 \le q \le 2 \cdot 10^5) — the number of queries.

Each of the next q lines contain five integers x_s, y_s, x_f, y_f and k (a[y_s]  \lt  x_s \le n; 1 \le y_s \le m; a[y_f]  \lt  x_f \le n; 1 \le y_f \le m; 1 \le k \le 10^9) — the row and the column of the start cell, the row and the column of the finish cell and the number of times each your command is executed. The start and the finish cell of each query are unblocked.

## Output

For each query, print "YES" if you can send the robot an arbitrary number of commands (possibly, zero) so that it reaches the finish cell from the start cell, given that it executes each command k times. Otherwise, print "NO".

## Example

Input

    11 10
    9 0 0 10 3 4 8 11 10 8
    6
    1 2 1 3 1
    1 2 1 3 2
    4 3 4 5 2
    5 3 11 5 3
    5 3 11 5 2
    11 9 9 10 1

Output

    YES
    NO
    NO
    NO
    YES
    YES', '[]',
  'a575001b3fa7fd19a467335a01b436e53f0d88408deab26ea1dbe1e60edb3c75', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":22}',
  'resolve', NULL, 'backlog', NULL, '2026-08-16',
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
  'cp31-cf-1695-c', 'codeforces', '1695:C', 'https://codeforces.com/contest/1695/problem/C',
  'Zero Path', '1695', 'C',
  '1700', 'medium', '["brute force","data structures","dp","graphs","greedy","shortest paths"]',
  'You are given a grid with n rows and m columns. We denote the square on the i-th (1\le i\le n) row and j-th (1\le j\le m) column by (i, j) and the number there by a_{ij}. All numbers are equal to 1 or to -1.

You start from the square (1, 1) and can move one square down or one square to the right at a time. In the end, you want to end up at the square (n, m).

Is it possible to move in such a way so that the sum of the values written in all the visited cells (including a_{11} and a_{nm}) is 0?

## Input

Each test contains multiple test cases. The first line contains the number of test cases t (1 \leq t \leq 10^4). Description of the test cases follows.

The first line of each test case contains two integers n and m (1 \le n, m \le 1000)  — the size of the grid.

Each of the following n lines contains m integers. The j-th integer on the i-th line is a_{ij} (a_{ij} = 1 or -1)  — the element in the cell (i, j).

It is guaranteed that the sum of n\cdot m over all test cases does not exceed 10^6.

## Output

For each test case, print "YES" if there exists a path from the top left to the bottom right that adds up to 0, and "NO" otherwise. You can output each letter in any case.

## Example

Input

    5
    1 1
    1
    1 2
    1 -1
    1 4
    1 -1 1 -1
    3 4
    1 -1 -1 -1
    -1 1 1 -1
    1 1 1 -1
    3 4
    1 -1 1 1
    -1 1 -1 1
    1 -1 1 1

Output

    NO
    YES
    YES
    YES
    NO

## Note

One possible path for the fourth test case is given in the picture in the statement.', '[{"alt":"Problem diagram","url":"https://espresso.codeforces.com/560459f1359d2f414325a61f7bdd72246cafae93.png"}]',
  '50c6adc6be02e2d40b9f6064dc0aaf084b6200550b50aa07ada2e69edb4b7e6f', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":23}',
  'resolve', NULL, 'backlog', NULL, '2026-08-16',
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
  'cp31-cf-1692-h', 'codeforces', '1692:H', 'https://codeforces.com/contest/1692/problem/H',
  'Gambling', '1692', 'H',
  '1700', 'medium', '["data structures","dp","greedy","math"]',
  'Marian is at a casino. The game at the casino works like this.

Before each round, the player selects a number between 1 and 10^9. After that, a dice with 10^9 faces is rolled so that a random number between 1 and 10^9 appears. If the player guesses the number correctly their total money is doubled, else their total money is halved.

Marian predicted the future and knows all the numbers x_1, x_2, \dots, x_n that the dice will show in the next n rounds.

He will pick three integers a, l and r (l \leq r). He will play r-l+1 rounds (rounds between l and r inclusive). In each of these rounds, he will guess the same number a. At the start (before the round l) he has 1 dollar.

Marian asks you to determine the integers a, l and r (1 \leq a \leq 10^9, 1 \leq l \leq r \leq n) such that he makes the most money at the end.

Note that during halving and multiplying there is no rounding and there are no precision errors. So, for example during a game, Marian could have money equal to \dfrac{1}{1024}, \dfrac{1}{128}, \dfrac{1}{2}, 1, 2, 4, etc. (any value of 2^t, where t is an integer of any sign).

## Input

The first line contains a single integer t (1 \leq t \leq 100) — the number of test cases.

The first line of each test case contains a single integer n (1 \leq n \leq 2\cdot 10^5) — the number of rounds.

The second line of each test case contains n integers x_1, x_2, \dots, x_n (1 \leq x_i \leq 10^9), where x_i is the number that will fall on the dice in the i-th round.

It is guaranteed that the sum of n over all test cases does not exceed 2\cdot10^5.

## Output

For each test case, output three integers a, l, and r such that Marian makes the most amount of money gambling with his strategy. If there are multiple answers, you may output any of them.

## Example

Input

    4
    5
    4 4 3 4 4
    5
    11 1 11 1 11
    1
    1000000000
    10
    8 8 8 9 9 6 6 9 6 6

Output

    4 1 5
    1 2 2
    1000000000 1 1
    6 6 10

## Note

For the first test case, the best choice is a=4, l=1, r=5, and the game would go as follows.

 - Marian starts with one dollar.
- After the first round, he ends up with 2 dollars because the numbers coincide with the chosen one.
- After the second round, he ends up with 4 dollars because the numbers coincide again.
- After the third round, he ends up with 2 dollars because he guesses 4 even though 3 is the correct choice.
- After the fourth round, he ends up with 4 dollars again.
- In the final round, he ends up 8 dollars because he again guessed correctly.

There are many possible answers for the second test case, but it can be proven that Marian will not end up with more than 2 dollars, so any choice with l = r with the appropriate a is acceptable.', '[]',
  'd9199cb00ad22ea5a5c27ed06ee46f642e0561caa5625cf014e1eca6b5b8af1a', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":24}',
  'resolve', NULL, 'backlog', NULL, '2026-08-16',
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
  'cp31-cf-1690-f', 'codeforces', '1690:F', 'https://codeforces.com/contest/1690/problem/F',
  'Shifting String', '1690', 'F',
  '1700', 'medium', '["graphs","math","number theory","strings"]',
  'Polycarp found the string s and the permutation p. Their lengths turned out to be the same and equal to n.

A permutation of n elements — is an array of length n, in which every integer from 1 to n occurs exactly once. For example, [1, 2, 3] and [4, 3, 5, 1, 2] are permutations, but [1, 2, 4], [4, 3, 2, 1, 2] and [0, 1, 2] are not.

In one operation he can multiply s by p, so he replaces s with string new, in which for any i from 1 to n it is true that new_i = s_{p_i}. For example, with s=wmbe and p = [3, 1, 4, 2], after operation the string will turn to s=s_3 s_1 s_4 s_2=bwem.

Polycarp wondered after how many operations the string would become equal to its initial value for the first time. Since it may take too long, he asks for your help in this matter.

It can be proved that the required number of operations always exists. It can be very large, so use a 64-bit integer type.

## Input

The first line of input contains one integer t (1 \le t \le 5000) — the number of test cases in input.

The first line of each case contains single integer n (1 \le n \le 200) — the length of string and permutation.

The second line of each case contains a string s of length n, containing lowercase Latin letters.

The third line of each case contains n integers — permutation p (1 \le p_i \le n), all p_i are different.

## Output

Output t lines, each of which contains the answer to the corresponding test case of input. As an answer output single integer — the minimum number of operations, after which the string s will become the same as it was before operations.

## Example

Input

    3
    5
    ababa
    3 4 5 2 1
    5
    ababa
    2 1 4 5 3
    10
    codeforces
    8 6 1 7 5 2 9 3 10 4

Output

    1
    6
    12

## Note

In the first sample operation doesn''t change the string, so it will become the same as it was after 1 operations.

In the second sample the string will change as follows:

- s = babaa
- s = abaab
- s = baaba
- s = abbaa
- s = baaab
- s = ababa', '[]',
  '0cf8e052f3f28bf0523496b5e8511469a58263b2341e94da829168a08fcaca94', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":25}',
  'resolve', NULL, 'backlog', NULL, '2026-08-16',
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
  'cp31-cf-1625-c', 'codeforces', '1625:C', 'https://codeforces.com/contest/1625/problem/C',
  'Road Optimization', '1625', 'C',
  '1700', 'medium', '["dp"]',
  'The Government of Mars is not only interested in optimizing space flights, but also wants to improve the road system of the planet.

One of the most important highways of Mars connects Olymp City and Kstolop, the capital of Cydonia. In this problem, we only consider the way from Kstolop to Olymp City, but not the reverse path (i. e. the path from Olymp City to Kstolop).

The road from Kstolop to Olymp City is \ell kilometers long. Each point of the road has a coordinate x (0 \le x \le \ell), which is equal to the distance from Kstolop in kilometers. So, Kstolop is located in the point with coordinate 0, and Olymp City is located in the point with coordinate \ell.

There are n signs along the road, i-th of which sets a speed limit a_i. This limit means that the next kilometer must be passed in a_i minutes and is active until you encounter the next along the road. There is a road sign at the start of the road (i. e. in the point with coordinate 0), which sets the initial speed limit.

If you know the location of all the signs, it''s not hard to calculate how much time it takes to drive from Kstolop to Olymp City. Consider an example:

  

Here, you need to drive the first three kilometers in five minutes each, then one kilometer in eight minutes, then four kilometers in three minutes each, and finally the last two kilometers must be passed in six minutes each. Total time is 3\cdot 5 + 1\cdot 8 + 4\cdot 3 + 2\cdot 6 = 47 minutes.

To optimize the road traffic, the Government of Mars decided to remove no more than k road signs. It cannot remove the sign at the start of the road, otherwise, there will be no limit at the start. By removing these signs, the Government also wants to make the time needed to drive from Kstolop to Olymp City as small as possible.

The largest industrial enterprises are located in Cydonia, so it''s the priority task to optimize the road traffic from Olymp City. So, the Government of Mars wants you to remove the signs in the way described above.

## Input

The first line contains three integers n, \ell, k (1 \le n \le 500, 1 \le \ell \le 10^5, 0 \le k \le n-1), the amount of signs on the road, the distance between the cities and the maximal number of signs you may remove.

The second line contains n integers d_i (d_1 = 0, d_i  \lt  d_{i+1}, 0 \le d_i \le \ell - 1) — coordinates of all signs.

The third line contains n integers a_i (1 \le a_i \le 10^4) — speed limits.

## Output

Print a single integer — minimal possible time to drive from Kstolop to Olymp City in minutes, if you remove no more than k road signs.

## Examples

Input

    4 10 0
    0 3 4 8
    5 8 3 6

Output

    47

Input

    4 10 2
    0 3 4 8
    5 8 3 6

Output

    38

## Note

In the first example, you cannot remove the signs. So the answer is 47, as it''s said in the statements above.

In the second example, you may remove the second and the fourth sign. In this case, you need to drive four kilometers in 4\cdot5 = 20 minutes, and then six kilometers in 6\cdot3 = 18, so the total time is 4\cdot5 + 6\cdot3 = 38 minutes.', '[{"alt":"Problem diagram","url":"https://espresso.codeforces.com/41a5e5b0a30f71fb54feb75410b62f72718c031c.png"}]',
  '7d83434296981787e015fd7870152fe5ec3bf0f8cff557bca98d32e975c8996c', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":26}',
  'resolve', NULL, 'backlog', NULL, '2026-08-17',
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
  'cp31-cf-1598-d', 'codeforces', '1598:D', 'https://codeforces.com/contest/1598/problem/D',
  'Training Session', '1598', 'D',
  '1700', 'medium', '["combinatorics","data structures","geometry","implementation","math"]',
  'Monocarp is the coach of the Berland State University programming teams. He decided to compose a problemset for a training session for his teams.

Monocarp has n problems that none of his students have seen yet. The i-th problem has a topic a_i (an integer from 1 to n) and a difficulty b_i (an integer from 1 to n). All problems are different, that is, there are no two tasks that have the same topic and difficulty at the same time.

Monocarp decided to select exactly 3 problems from n problems for the problemset. The problems should satisfy at least one of two conditions (possibly, both):

 - the topics of all three selected problems are different;
- the difficulties of all three selected problems are different.

Your task is to determine the number of ways to select three problems for the problemset.

## Input

The first line contains a single integer t (1 \le t \le 50000) — the number of testcases.

The first line of each testcase contains an integer n (3 \le n \le 2 \cdot 10^5) — the number of problems that Monocarp have.

In the i-th of the following n lines, there are two integers a_i and b_i (1 \le a_i, b_i \le n) — the topic and the difficulty of the i-th problem.

It is guaranteed that there are no two problems that have the same topic and difficulty at the same time.

The sum of n over all testcases doesn''t exceed 2 \cdot 10^5.

## Output

Print the number of ways to select three training problems that meet either of the requirements described in the statement.

## Example

Input

    2
    4
    2 4
    3 4
    2 1
    1 3
    5
    1 5
    2 4
    3 3
    4 2
    5 1

Output

    3
    10

## Note

In the first example, you can take the following sets of three problems:

 - problems 1, 2, 4;
- problems 1, 3, 4;
- problems 2, 3, 4.

Thus, the number of ways is equal to three.', '[]',
  'd0669ef1d22de81acf829076777db71301e20d4a2da328eb011312c9283d976e', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":27}',
  'resolve', NULL, 'backlog', NULL, '2026-08-17',
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
  'cp31-cf-1594-d', 'codeforces', '1594:D', 'https://codeforces.com/contest/1594/problem/D',
  'The Number of Imposters', '1594', 'D',
  '1700', 'medium', '["constructive algorithms","dfs and similar","dp","dsu","graphs"]',
  'Theofanis started playing the new online game called "Among them". However, he always plays with Cypriot players, and they all have the same name: "Andreas" (the most common name in Cyprus).

In each game, Theofanis plays with n other players. Since they all have the same name, they are numbered from 1 to n.

The players write m comments in the chat. A comment has the structure of "i j c" where i and j are two distinct integers and c is a string (1 \le i, j \le n; i \neq j; c is either imposter or crewmate). The comment means that player i said that player j has the role c.

An imposter always lies, and a crewmate always tells the truth.

Help Theofanis find the maximum possible number of imposters among all the other Cypriot players, or determine that the comments contradict each other (see the notes for further explanation).

Note that each player has exactly one role: either imposter or crewmate.

## Input

The first line contains a single integer t (1 \le t \le 10^4) — the number of test cases. Description of each test case follows.

The first line of each test case contains two integers n and m (1 \le n \le 2 \cdot 10^5; 0 \le m \le 5 \cdot 10^5) — the number of players except Theofanis and the number of comments.

Each of the next m lines contains a comment made by the players of the structure "i j c" where i and j are two distinct integers and c is a string (1 \le i, j \le n; i \neq j; c is either imposter or crewmate).

There can be multiple comments for the same pair of (i, j).

It is guaranteed that the sum of all n does not exceed 2 \cdot 10^5 and the sum of all m does not exceed 5 \cdot 10^5.

## Output

For each test case, print one integer — the maximum possible number of imposters. If the comments contradict each other, print -1.

## Example

Input

    5
    3 2
    1 2 imposter
    2 3 crewmate
    5 4
    1 3 crewmate
    2 5 crewmate
    2 4 imposter
    3 4 imposter
    2 2
    1 2 imposter
    2 1 crewmate
    3 5
    1 2 imposter
    1 2 imposter
    3 2 crewmate
    3 2 crewmate
    1 3 imposter
    5 0

Output

    2
    4
    -1
    2
    5

## Note

In the first test case, imposters can be Andreas 2 and 3.

In the second test case, imposters can be Andreas 1, 2, 3 and 5.

In the third test case, comments contradict each other. This is because player 1 says that player 2 is an imposter, and player 2 says that player 1 is a crewmate. If player 1 is a crewmate, then he must be telling the truth, so player 2 must be an imposter. But if player 2 is an imposter then he must be lying, so player 1 can''t be a crewmate. Contradiction.', '[]',
  'f7ee376dcc78dbab064c704e120abc37730983b5cbe79c330890749ee15fe466', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":28}',
  'resolve', NULL, 'backlog', NULL, '2026-08-17',
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
  'cp31-cf-1557-c', 'codeforces', '1557:C', 'https://codeforces.com/contest/1557/problem/C',
  'Moamen and XOR', '1557', 'C',
  '1700', 'medium', '["bitmasks","combinatorics","dp","math","matrices"]',
  'Moamen and Ezzat are playing a game. They create an array a of n non-negative integers where every element is less than 2^k.

Moamen wins if a_1 \,\&\, a_2 \,\&\, a_3 \,\&\, \ldots \,\&\, a_n \ge a_1 \oplus a_2 \oplus a_3 \oplus \ldots \oplus a_n.

Here \& denotes the bitwise AND operation, and \oplus denotes the bitwise XOR operation.

Please calculate the number of winning for Moamen arrays a.

As the result may be very large, print the value modulo 1\,000\,000\,007 (10^9 + 7).

## Input

The first line contains a single integer t (1 \le t \le 5)— the number of test cases.

Each test case consists of one line containing two integers n and k (1 \le n\le 2\cdot 10^5, 0 \le k \le 2\cdot 10^5).

## Output

For each test case, print a single value — the number of different arrays that Moamen wins with.

Print the result modulo 1\,000\,000\,007 (10^9 + 7).

## Example

Input

    3
    3 1
    2 1
    4 0

Output

    5
    2
    1

## Note

In the first example, n = 3, k = 1. As a result, all the possible arrays are [0,0,0], [0,0,1], [0,1,0], [1,0,0], [1,1,0], [0,1,1], [1,0,1], and [1,1,1].

Moamen wins in only 5 of them: [0,0,0], [1,1,0], [0,1,1], [1,0,1], and [1,1,1].', '[]',
  'c9b0fcb7b2f37287d060c1837ebf87bafc6124eedfaea266f4c406ead93d7f78', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":29}',
  'resolve', NULL, 'backlog', NULL, '2026-08-17',
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
