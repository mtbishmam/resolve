INSERT INTO problems (
  id, platform, problem_key, url, title, contest, problem_index, rating,
  difficulty, official_tags_json, statement_markdown, statement_assets_json,
  statement_hash, statement_captured_at, metadata_status,
  metadata_provenance_json, legacy_metadata_json, import_source,
  import_provenance_json, review_status, state, status, archived_at, due_date,
  sprint_id, next_review_date, created_at, updated_at
) VALUES (
  'cp31-cf-1290-b', 'codeforces', '1290:B', 'https://codeforces.com/contest/1290/problem/B',
  'Irreducible Anagrams', '1290', 'B',
  '1800', 'medium', '["binary search","constructive algorithms","data structures","strings","two pointers"]',
  'Let''s call two strings s and t anagrams of each other if it is possible to rearrange symbols in the string s to get a string, equal to t.

Let''s consider two strings s and t which are anagrams of each other. We say that t is a reducible anagram of s if there exists an integer k \ge 2 and 2k non-empty strings s_1, t_1, s_2, t_2, \dots, s_k, t_k that satisfy the following conditions:

 - If we write the strings s_1, s_2, \dots, s_k in order, the resulting string will be equal to s;
- If we write the strings t_1, t_2, \dots, t_k in order, the resulting string will be equal to t;
- For all integers i between 1 and k inclusive, s_i and t_i are anagrams of each other.

If such strings don''t exist, then t is said to be an irreducible anagram of s. Note that these notions are only defined when s and t are anagrams of each other.

For example, consider the string s =  "gamegame". Then the string t =  "megamage" is a reducible anagram of s, we may choose for example s_1 =  "game", s_2 =  "gam", s_3 =  "e" and t_1 =  "mega", t_2 =  "mag", t_3 =  "e":

  

On the other hand, we can prove that t =  "memegaga" is an irreducible anagram of s.

You will be given a string s and q queries, represented by two integers 1 \le l \le r \le |s| (where |s| is equal to the length of the string s). For each query, you should find if the substring of s formed by characters from the l-th to the r-th has at least one irreducible anagram.

## Input

The first line contains a string s, consisting of lowercase English characters (1 \le |s| \le 2 \cdot 10^5).

The second line contains a single integer q (1 \le q \le 10^5)  — the number of queries.

Each of the following q lines contain two integers l and r (1 \le l \le r \le |s|), representing a query for the substring of s formed by characters from the l-th to the r-th.

## Output

For each query, print a single line containing "Yes" (without quotes) if the corresponding substring has at least one irreducible anagram, and a single line containing "No" (without quotes) otherwise.

## Examples

Input

    aaaaa
    3
    1 1
    2 4
    5 5

Output

    Yes
    No
    Yes

Input

    aabbbbbbc
    6
    1 2
    2 4
    2 2
    1 9
    5 7
    3 5

Output

    No
    Yes
    Yes
    Yes
    No
    No

## Note

In the first sample, in the first and third queries, the substring is "a", which has itself as an irreducible anagram since two or more non-empty strings cannot be put together to obtain "a". On the other hand, in the second query, the substring is "aaa", which has no irreducible anagrams: its only anagram is itself, and we may choose s_1 =  "a", s_2 =  "aa", t_1 =  "a", t_2 =  "aa" to show that it is a reducible anagram.

In the second query of the second sample, the substring is "abb", which has, for example, "bba" as an irreducible anagram.', '[{"alt":"Problem diagram","url":"https://espresso.codeforces.com/6a53aacfb1d36ae5a64a4cadf6a9c3b488e883be.png"}]',
  'd4acf5dc5335042d60606065072dac2b5a378917550cdfc681050557f442adcc', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":29}',
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
  'cp31-cf-1286-b', 'codeforces', '1286:B', 'https://codeforces.com/contest/1286/problem/B',
  'Numbers on Tree', '1286', 'B',
  '1800', 'medium', '["constructive algorithms","data structures","dfs and similar","graphs","greedy","trees"]',
  'Evlampiy was gifted a rooted tree. The vertices of the tree are numbered from 1 to n. Each of its vertices also has an integer a_i written on it. For each vertex i, Evlampiy calculated c_i — the number of vertices j in the subtree of vertex i, such that a_j  \lt  a_i.

Illustration for the second example, the first integer is a_i and the integer in parentheses is c_i

After the new year, Evlampiy could not remember what his gift was! He remembers the tree and the values of c_i, but he completely forgot which integers a_i were written on the vertices.

Help him to restore initial integers!

## Input

The first line contains an integer n (1 \leq n \leq 2000) — the number of vertices in the tree.

The next n lines contain descriptions of vertices: the i-th line contains two integers p_i and c_i (0 \leq p_i \leq n; 0 \leq c_i \leq n-1), where p_i is the parent of vertex i or 0 if vertex i is root, and c_i is the number of vertices j in the subtree of vertex i, such that a_j  \lt  a_i.

It is guaranteed that the values of p_i describe a rooted tree with n vertices.

## Output

If a solution exists, in the first line print "YES", and in the second line output n integers a_i (1 \leq a_i \leq {10}^{9}). If there are several solutions, output any of them. One can prove that if there is a solution, then there is also a solution in which all a_i are between 1 and 10^9.

If there are no solutions, print "NO".

## Examples

Input

    3
    2 0
    0 2
    2 0

Output

    YES
    1 2 1

Input

    5
    0 1
    1 3
    2 1
    3 0
    2 0

Output

    YES
    2 3 2 1 2', '[{"alt":"Problem diagram","url":"https://espresso.codeforces.com/f5dda49bc62f72dcd05825f4d2b40d4d7a64a2fb.png"}]',
  '39d7c651281df6e2c39fd4bc2588012a892e6a66fe7c73b65138021bd3894a7a', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":30}',
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
  'cp31-cf-1283-d', 'codeforces', '1283:D', 'https://codeforces.com/contest/1283/problem/D',
  'Christmas Trees', '1283', 'D',
  '1800', 'medium', '["graphs","greedy","shortest paths"]',
  'There are n Christmas trees on an infinite number line. The i-th tree grows at the position x_i. All x_i are guaranteed to be distinct.

Each integer point can be either occupied by the Christmas tree, by the human or not occupied at all. Non-integer points cannot be occupied by anything.

There are m people who want to celebrate Christmas. Let y_1, y_2, \dots, y_m be the positions of people (note that all values x_1, x_2, \dots, x_n, y_1, y_2, \dots, y_m should be distinct and all y_j should be integer). You want to find such an arrangement of people that the value \sum\limits_{j=1}^{m}\min\limits_{i=1}^{n}|x_i - y_j| is the minimum possible (in other words, the sum of distances to the nearest Christmas tree for all people should be minimized).

In other words, let d_j be the distance from the j-th human to the nearest Christmas tree (d_j = \min\limits_{i=1}^{n} |y_j - x_i|). Then you need to choose such positions y_1, y_2, \dots, y_m that \sum\limits_{j=1}^{m} d_j is the minimum possible.

## Input

The first line of the input contains two integers n and m (1 \le n, m \le 2 \cdot 10^5) — the number of Christmas trees and the number of people.

The second line of the input contains n integers x_1, x_2, \dots, x_n (-10^9 \le x_i \le 10^9), where x_i is the position of the i-th Christmas tree. It is guaranteed that all x_i are distinct.

## Output

In the first line print one integer res — the minimum possible value of \sum\limits_{j=1}^{m}\min\limits_{i=1}^{n}|x_i - y_j| (in other words, the sum of distances to the nearest Christmas tree for all people).

In the second line print m integers y_1, y_2, \dots, y_m (-2 \cdot 10^9 \le y_j \le 2 \cdot 10^9), where y_j is the position of the j-th human. All y_j should be distinct and all values x_1, x_2, \dots, x_n, y_1, y_2, \dots, y_m should be distinct.

If there are multiple answers, print any of them.

## Examples

Input

    2 6
    1 5

Output

    8
    -1 2 6 4 0 3

Input

    3 5
    0 3 1

Output

    7
    5 -2 4 -1 2', '[]',
  '8f8d1432fb1577e10ef3eb51ad2d53b2e04b1fbc6b46cf4496f05c384438a162', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":31}',
  'resolve', NULL, 'backlog', NULL, '2026-08-25',
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
  'cp31-cf-2044-f', 'codeforces', '2044:F', 'https://codeforces.com/contest/2044/problem/F',
  'Easy Demon Problem', '2044', 'F',
  '1900', 'medium', '["binary search","brute force","data structures","math","number theory"]',
  'For an arbitrary grid, Robot defines its beauty to be the sum of elements in the grid.

Robot gives you an array a of length n and an array b of length m. You construct a n by m grid M such that M_{i,j}=a_i\cdot b_j for all 1 \leq i \leq n and 1 \leq j \leq m.

Then, Robot gives you q queries, each consisting of a single integer x. For each query, determine whether or not it is possible to perform the following operation exactly once so that M has a beauty of x:

 - Choose integers r and c such that 1 \leq r \leq n and 1 \leq c \leq m
- Set M_{i,j} to be 0 for all ordered pairs (i,j) such that i=r, j=c, or both.

Note that queries are not persistent, meaning that you do not actually set any elements to 0 in the process — you are only required to output if it is possible to find r and c such that if the above operation is performed, the beauty of the grid will be x. Also, note that you must perform the operation for each query, even if the beauty of the original grid is already x.

## Input

The first line contains three integers n, m, and q (1 \leq n,m \leq 2\cdot 10^5, 1 \leq q \leq 5\cdot 10^4) — the length of a, the length of b, and the number of queries respectively.

The second line contains n integers a_1, a_2, \ldots, a_n (0 \leq |a_i| \leq n).

The third line contains m integers b_1, b_2, \ldots, b_m (0 \leq |b_i| \leq m).

The following q lines each contain a single integer x (1 \leq |x| \leq 2\cdot 10^5), the beauty of the grid you wish to achieve by setting all elements in a row and a column to 0.

## Output

For each testcase, output "YES" (without quotes) if there is a way to perform the aforementioned operation such that the beauty is x, and "NO" (without quotes) otherwise.

You can output "YES" and "NO" in any case (for example, strings "yES", "yes" and "Yes" will be recognized as a positive response).

## Examples

Input

    3 3 6
    -2 3 -3
    -2 2 -1
    -1
    1
    -2
    2
    -3
    3

Output

    NO
    YES
    NO
    NO
    YES
    NO

Input

    5 5 6
    1 -2 3 0 0
    0 -2 5 0 -3
    4
    -3
    5
    2
    -1
    2

Output

    YES
    YES
    YES
    YES
    NO
    YES

## Note

In the second example, the grid is

0 -2 5 0 -3

0 4 -10 0 6

0 -6 15 0 -9

0 0 0 0 0

0 0 0 0 0

By performing the operation with r=4 and c=2, we create the following grid:

0 0 5 0 -3

0 0 -10 0 6

0 0 15 0 -9

0 0 0 0 0

0 0 0 0 0

which has beauty 4. Thus, we output YES.

In the second query, selecting r=3 and c=5 creates a grid with beauty -3.

In the third query, selecting r=3 and c=3 creates a grid with beauty 5.', '[]',
  '590e4b0694aedd0619682471711ae5b0c15811406e59bfa58b78c84ae26afb51', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":1}',
  'resolve', NULL, 'backlog', NULL, '2026-08-26',
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
  'cp31-cf-2042-d', 'codeforces', '2042:D', 'https://codeforces.com/contest/2042/problem/D',
  'Recommendations', '2042', 'D',
  '1900', 'medium', '["data structures","implementation","sortings","two pointers"]',
  'Suppose you are working in some audio streaming service. The service has $$$n$$$ active users and $$$10^9$$$ tracks users can listen to. Users can like tracks and, based on likes, the service should recommend them new tracks.

Tracks are numbered from $$$1$$$ to $$$10^9$$$. It turned out that tracks the $$$i$$$-th user likes form a segment $$$[l_i, r_i]$$$.

Let''s say that the user $$$j$$$ is a predictor for user $$$i$$$ ($$$j \neq i$$$) if user $$$j$$$ likes all tracks the $$$i$$$-th user likes (and, possibly, some other tracks too).

Also, let''s say that a track is strongly recommended for user $$$i$$$ if the track is not liked by the $$$i$$$-th user yet, but it is liked by every predictor for the $$$i$$$-th user.

Calculate the number of strongly recommended tracks for each user $$$i$$$. If a user doesn''t have any predictors, then print $$$0$$$ for that user.

## Input

The first line contains one integer $$$t$$$ ($$$1 \le t \le 10^4$$$) — the number of test cases. Next, $$$t$$$ cases follow.

The first line of each test case contains one integer $$$n$$$ ($$$1 \le n \le 2 \cdot 10^5$$$) — the number of users.

The next $$$n$$$ lines contain two integers $$$l_i$$$ and $$$r_i$$$ per line ($$$1 \le l_i \le r_i \le 10^9$$$) — the segment of tracks the $$$i$$$-th user likes.

Additional constraint on the input: the sum of $$$n$$$ over all test cases doesn''t exceed $$$2 \cdot 10^5$$$.

## Output

For each test case, print $$$n$$$ integers, where the $$$i$$$-th integer is the number of strongly recommended tracks for the $$$i$$$-th user (or $$$0$$$, if that user doesn''t have any predictors).

## Example

Input

    4
    3
    3 8
    2 5
    4 5
    2
    42 42
    1 1000000000
    3
    42 42
    1 1000000000
    42 42
    6
    1 10
    3 10
    3 7
    5 7
    4 4
    1 2

Output

    0
    0
    1
    999999999
    0
    0
    0
    0
    0
    2
    3
    2
    4
    8

## Note

In the first test case:

 - the first user has no predictors;
- the second user has no predictors;
- the third user has two predictors: users $$$1$$$ and $$$2$$$; only track $$$3$$$ is liked by both of them and not liked by the third user.

In the second test case, the second user is a predictor for the first user. Therefore, all tracks, except $$$42$$$, are strongly recommended for the first user.

In the third test case, the first user has two predictors: users $$$2$$$ and $$$3$$$, but there is no track that is liked by them and not liked by the first user himself.', '[]',
  '93b538203a3835681bc593b9cc02985b9266d649f56d05984c5ceed28e440ce6', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":2}',
  'resolve', NULL, 'backlog', NULL, '2026-08-26',
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
  'cp31-cf-2036-f', 'codeforces', '2036:F', 'https://codeforces.com/contest/2036/problem/F',
  'XORificator 3000', '2036', 'F',
  '1900', 'medium', '["bitmasks","dp","number theory","two pointers"]',
  'Alice has been giving gifts to Bob for many years, and she knows that what he enjoys the most is performing bitwise XOR of interesting integers. Bob considers a positive integer $$$x$$$ to be interesting if it satisfies $$$x \not\equiv k (\bmod 2^i)$$$. Therefore, this year for his birthday, she gifted him a super-powerful "XORificator 3000", the latest model.

Bob was very pleased with the gift, as it allowed him to instantly compute the XOR of all interesting integers in any range from $$$l$$$ to $$$r$$$, inclusive. After all, what else does a person need for happiness? Unfortunately, the device was so powerful that at one point it performed XOR with itself and disappeared. Bob was very upset, and to cheer him up, Alice asked you to write your version of the "XORificator".

## Input

The first line of input contains a single integer $$$t$$$ $$$(1 \leq t \leq 10^4)$$$ — the number of XOR queries on the segment. The following $$$t$$$ lines contain the queries, each consisting of the integers $$$l$$$, $$$r$$$, $$$i$$$, $$$k$$$ $$$(1 \leq l \leq r \leq 10^{18}$$$, $$$0 \leq i \leq 30$$$, $$$0 \leq k  \lt  2^i)$$$.

## Output

For each query, output a single integer — the XOR of all integers $$$x$$$ in the range $$$[l, r]$$$ such that $$$x \not\equiv k \mod 2^i$$$.

## Example

Input

    6
    1 3 1 0
    2 28 3 7
    15 43 1 0
    57 2007 1 0
    1010 1993 2 2
    1 1000000000 30 1543

Output

    2
    2
    13
    0
    4
    1000000519

## Note

In the first query, the interesting integers in the range $$$[1, 3]$$$ are $$$1$$$ and $$$3$$$, so the answer will be $$$1 \oplus 3 = 2$$$.', '[]',
  '6be3805e541abb159ee244742e0c94a10e09c2d526ed07779d6ef71c3a5b7ac3', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":3}',
  'resolve', NULL, 'backlog', NULL, '2026-08-26',
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
  'cp31-cf-2014-h', 'codeforces', '2014:H', 'https://codeforces.com/contest/2014/problem/H',
  'Robin Hood Archery', '2014', 'H',
  '1900', 'medium', '["data structures","divide and conquer","greedy","hashing"]',
  'At such times archery was always the main sport of the day, for the Nottinghamshire yeomen were the best hand at the longbow in all merry England, but this year the Sheriff hesitated...

Sheriff of Nottingham has organized a tournament in archery. It''s the final round and Robin Hood is playing against Sheriff!

There are $$$n$$$ targets in a row numbered from $$$1$$$ to $$$n$$$. When a player shoots target $$$i$$$, their score increases by $$$a_i$$$ and the target $$$i$$$ is destroyed. The game consists of turns and players alternate between whose turn it is. Robin Hood always starts the game, then Sheriff and so on. The game continues until all targets are destroyed. Both players start with score $$$0$$$.

At the end of the game, the player with most score wins and the other player loses. If both players have the same score, it''s a tie and no one wins or loses. In each turn, the player can shoot any target that wasn''t shot before. Both play optimally to get the most score possible.

Sheriff of Nottingham has a suspicion that he might lose the game! This cannot happen, you must help Sheriff. Sheriff will pose $$$q$$$ queries, each specifying $$$l$$$ and $$$r$$$. This means that the game would be played only with targets $$$l, l+1, \dots, r$$$, as others would be removed by Sheriff before the game starts.

For each query $$$l$$$, $$$r$$$, determine whether the Sheriff can not lose the game when only considering the targets $$$l, l+1, \dots, r$$$.

## Input

The first line of input contains one integer $$$t$$$ ($$$1 \le t \le 10^4$$$) — the number of test cases.

The first line of each test case contains two integers $$$n$$$, $$$q$$$ ($$$1 \le n,q \le 2\cdot10^5$$$) — the number of targets and the queries Sheriff will pose.

The second line of each test case contains $$$n$$$ integers $$$a_1, a_2, \ldots, a_n$$$ ($$$1 \le a_i \le 10^6$$$) — the points for hitting each target.

Then follow $$$q$$$ lines, each with two integers $$$l$$$ and $$$r$$$ ($$$1 \le l \le r \le n$$$) — the range of the targets that is considered for each query.

It is guaranteed that the sum of both $$$n$$$ and $$$q$$$ across all test cases does not exceed $$$2 \cdot 10^5$$$.

## Output

For each query, output "YES", if the Sheriff does not lose the game when only considering the targets $$$l, l+1, \dots, r$$$, and "NO" otherwise.

You can output the answer in any case (upper or lower). For example, the strings "yEs", "yes", "Yes", and "YES" will be recognized as positive responses.

## Example

Input

    2
    3 3
    1 2 2
    1 2
    1 3
    2 3
    5 3
    2 1 2 1 1
    1 2
    1 3
    4 5

Output

    NO
    NO
    YES
    NO
    NO
    YES', '[]',
  '6d711e17842ade7eb3e57a5f6f7c9f7ef1ab1e62c57ac3457a33424964a89e9b', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":4}',
  'resolve', NULL, 'backlog', NULL, '2026-08-26',
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
  'cp31-cf-2009-g1', 'codeforces', '2009:G1', 'https://codeforces.com/contest/2009/problem/G1',
  'Yunli''s Subarray Queries (easy version)', '2009', 'G1',
  '1900', 'medium', '["binary search","data structures","two pointers"]',
  'This is the easy version of the problem. In this version, it is guaranteed that $$$r=l+k-1$$$ for all queries.

For an arbitrary array $$$b$$$, Yunli can perform the following operation any number of times:

 - Select an index $$$i$$$. Set $$$b_i = x$$$ where $$$x$$$ is any integer she desires ($$$x$$$ is not limited to the interval $$$[1,n]$$$).

Denote $$$f(b)$$$ as the minimum number of operations she needs to perform until there exists a consecutive subarray$$$^{\text{∗}}$$$ of length at least $$$k$$$ in $$$b$$$.

Yunli is given an array $$$a$$$ of size $$$n$$$ and asks you $$$q$$$ queries. In each query, you must output $$$\sum_{j=l+k-1}^{r} f([a_l, a_{l+1}, \ldots, a_j])$$$. Note that in this version, you are only required to output $$$f([a_l, a_{l+1}, \ldots, a_{l+k-1}])$$$.

$$$^{\text{∗}}$$$If there exists a consecutive subarray of length $$$k$$$ that starts at index $$$i$$$ ($$$1 \leq i \leq |b|-k+1$$$), then $$$b_j = b_{j-1} + 1$$$ for all $$$i  \lt  j \leq i+k-1$$$.

## Input

The first line contains $$$t$$$ ($$$1 \leq t \leq 10^4$$$) — the number of test cases.

The first line of each test case contains three integers $$$n$$$, $$$k$$$, and $$$q$$$ ($$$1 \leq k \leq n \leq 2 \cdot 10^5$$$, $$$1 \leq q \leq 2 \cdot 10^5$$$) — the length of the array, the length of the consecutive subarray, and the number of queries.

The following line contains $$$n$$$ integers $$$a_1, a_2, \dots, a_n$$$ ($$$1 \leq a_i \leq n$$$).

The following $$$q$$$ lines contain two integers $$$l$$$ and $$$r$$$ ($$$1 \leq l \leq r \leq n$$$, $$$r=l+k-1$$$) — the bounds of the query.

It is guaranteed that the sum of $$$n$$$ over all test cases does not exceed $$$2 \cdot 10^5$$$ and the sum of $$$q$$$ over all test cases does not exceed $$$2 \cdot 10^5$$$.

## Output

Output $$$\sum_{j=l+k-1}^{r} f([a_l, a_{l+1}, \ldots, a_j])$$$ for each query on a new line.

## Example

Input

    3
    7 5 3
    1 2 3 2 1 2 3
    1 5
    2 6
    3 7
    8 4 2
    4 3 1 1 2 4 3 2
    3 6
    2 5
    5 4 2
    4 5 1 2 3
    1 4
    2 5

Output

    2
    3
    2
    2
    2
    2
    1

## Note

In the first query of the first testcase, $$$b=[1,2,3,2,1]$$$. Yunli can make a consecutive subarray of length $$$5$$$ in $$$2$$$ moves:

 - Set $$$b_4=4$$$
- Set $$$b_5=5$$$
 After operations $$$b=[1, 2, 3, 4, 5]$$$.

In the second query of the first testcase, $$$b=[2,3,2,1,2]$$$. Yunli can make a consecutive subarray of length $$$5$$$ in $$$3$$$ moves:

 - Set $$$b_3=0$$$
- Set $$$b_2=-1$$$
- Set $$$b_1=-2$$$
 After operations $$$b=[-2, -1, 0, 1, 2]$$$.', '[]',
  '821e40472c95bea7a96c1bb7ca02e53707382500da98b846b57154d3b40faedf', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":5}',
  'resolve', NULL, 'backlog', NULL, '2026-08-26',
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
  'cp31-cf-2001-d', 'codeforces', '2001:D', 'https://codeforces.com/contest/2001/problem/D',
  'Longest Max Min Subsequence', '2001', 'D',
  '1900', 'medium', '["brute force","constructive algorithms","data structures","greedy","implementation"]',
  'You are given an integer sequence $$$a_1, a_2, \ldots, a_n$$$. Let $$$S$$$ be the set of all possible non-empty subsequences of $$$a$$$ without duplicate elements. Your goal is to find the longest sequence in $$$S$$$. If there are multiple of them, find the one that minimizes lexicographical order after multiplying terms at odd positions by $$$-1$$$.

For example, given $$$a = [3, 2, 3, 1]$$$, $$$S = \{[1], [2], [3], [2, 1], [2, 3], [3, 1], [3, 2], [2, 3, 1], [3, 2, 1]\}$$$. Then $$$[2, 3, 1]$$$ and $$$[3, 2, 1]$$$ would be the longest, and $$$[3, 2, 1]$$$ would be the answer since $$$[-3, 2, -1]$$$ is lexicographically smaller than $$$[-2, 3, -1]$$$.

A sequence $$$c$$$ is a subsequence of a sequence $$$d$$$ if $$$c$$$ can be obtained from $$$d$$$ by the deletion of several (possibly, zero or all) elements.

A sequence $$$c$$$ is lexicographically smaller than a sequence $$$d$$$ if and only if one of the following holds:

- $$$c$$$ is a prefix of $$$d$$$, but $$$c \ne d$$$;
- in the first position where $$$c$$$ and $$$d$$$ differ, the sequence $$$c$$$ has a smaller element than the corresponding element in $$$d$$$.

## Input

Each test contains multiple test cases. The first line contains the number of test cases $$$t$$$ ($$$1 \le t \le 5 \cdot 10^4$$$). The description of the test cases follows.

The first line of each test case contains an integer $$$n$$$ ($$$1 \le n \le 3 \cdot 10^5$$$) — the length of $$$a$$$.

The second line of each test case contains $$$n$$$ integers $$$a_1, a_2, \ldots, a_n$$$ ($$$1 \le a_i \le n$$$) — the sequence $$$a$$$.

It is guaranteed that the sum of $$$n$$$ over all test cases does not exceed $$$3 \cdot 10^5$$$.

## Output

For each test case, output the answer in the following format:

Output an integer $$$m$$$ in the first line — the length of $$$b$$$.

Then output $$$m$$$ integers $$$b_1, b_2, \ldots, b_m$$$ in the second line — the sequence $$$b$$$.

## Examples

Input

    4
    4
    3 2 1 3
    4
    1 1 1 1
    9
    3 2 1 3 2 1 3 2 1
    1
    1

Output

    3
    3 2 1
    1
    1
    3
    3 1 2
    1
    1

Input

    10
    2
    1 2
    10
    5 2 1 7 9 7 2 5 5 2
    2
    1 2
    10
    2 2 8 7 7 9 8 1 9 6
    9
    9 1 7 5 8 5 6 4 1
    3
    3 3 3
    6
    1 6 4 4 6 5
    6
    3 4 4 5 3 3
    10
    4 1 4 5 4 5 10 1 5 1
    7
    1 2 1 3 2 4 6

Output

    2
    1 2
    5
    5 1 9 7 2
    2
    1 2
    6
    2 7 9 8 1 6
    7
    9 1 7 5 8 6 4
    1
    3
    4
    1 4 6 5
    3
    4 5 3
    4
    5 4 10 1
    5
    2 1 3 4 6

## Note

In the first example, $$$S = \{[1], [2], [3], [1, 3], [2, 1], [2, 3], [3, 1], [3, 2], [2, 1, 3], [3, 2, 1]\}$$$. Among them, $$$[2, 1, 3]$$$ and $$$[3, 2, 1]$$$ are the longest and $$$[-3, 2, -1]$$$ is lexicographical smaller than $$$[-2, 1, -3]$$$, so $$$[3, 2, 1]$$$ is the answer.

In the second example, $$$S = \{[1]\}$$$, so $$$[1]$$$ is the answer.', '[]',
  '061d82f6b1da37c9578beed02d1e48f394c44a86ef5aa0c56a110537cb5483b4', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":6}',
  'resolve', NULL, 'backlog', NULL, '2026-08-27',
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
  'cp31-cf-1994-d', 'codeforces', '1994:D', 'https://codeforces.com/contest/1994/problem/D',
  'Funny Game', '1994', 'D',
  '1900', 'medium', '["constructive algorithms","dsu","graphs","greedy","math","number theory","trees"]',
  'Vanya has a graph with $$$n$$$ vertices (numbered from $$$1$$$ to $$$n$$$) and an array $$$a$$$ of $$$n$$$ integers; initially, there are no edges in the graph. Vanya got bored, and to have fun, he decided to perform $$$n - 1$$$ operations.

Operation number $$$x$$$ (operations are numbered in order starting from $$$1$$$) is as follows:

 - Choose $$$2$$$ different numbers $$$1 \leq u,v \leq n$$$, such that $$$|a_u - a_v|$$$ is divisible by $$$x$$$.
- Add an undirected edge between vertices $$$u$$$ and $$$v$$$ to the graph.

Help Vanya get a connected$$$^{\text{∗}}$$$ graph using the $$$n - 1$$$ operations, or determine that it is impossible.

$$$^{\text{∗}}$$$A graph is called connected if it is possible to reach any vertex from any other by moving along the edges.

## Input

Each test consists of multiple test cases. The first line contains an integer $$$t$$$ ($$$1 \le t \le 10^{3}$$$) — the number of test cases. Then follows the description of the test cases.

The first line of each test case contains the number $$$n$$$ ($$$1 \leq n \leq 2000$$$) — the number of vertices in the graph.

The second line of each test case contains $$$n$$$ numbers $$$a_1, a_2, \cdots a_n$$$ ($$$1 \leq a_i \leq 10^9$$$).

It is guaranteed that the sum of $$$n$$$ over all test cases does not exceed $$$2000$$$.

## Output

For each test case, if there is no solution, then output "No" (without quotes).

Otherwise, output "Yes" (without quotes), and then output $$$n - 1$$$ lines, where in the $$$i$$$-th line, output the numbers $$$u$$$ and $$$v$$$ that need to be chosen for operation $$$i$$$.

You can output each letter in any case (for example, the strings "yEs", "yes", "Yes", and "YES" will be recognized as a positive answer).

## Example

Input

    8
    2
    1 4
    4
    99 7 1 13
    5
    10 2 31 44 73
    5
    87 6 81 44 32
    5
    62 35 33 79 16
    5
    6 51 31 69 42
    5
    52 63 25 21 5
    12
    33 40 3 11 31 43 37 8 50 5 12 22

Output

    YES
    2 1
    YES
    4 1
    2 1
    3 2
    YES
    5 1
    4 1
    3 1
    2 1
    YES
    4 1
    3 1
    2 1
    5 4
    YES
    3 1
    5 1
    2 1
    4 2
    YES
    4 1
    5 1
    2 1
    3 2
    YES
    2 1
    5 2
    3 1
    4 3
    YES
    9 1
    12 9
    11 1
    10 1
    6 1
    7 6
    2 1
    8 2
    5 2
    3 1
    4 1

## Note

Let''s consider the second test case.

 - First operation $$$(x = 1)$$$: we can connect vertices $$$4$$$ and $$$1$$$, since $$$|a_4 - a_1| = |13 - 99| = |-86| = 86$$$, and $$$86$$$ is divisible by $$$1$$$.
   - Second operation $$$(x = 2)$$$: we can connect vertices $$$2$$$ and $$$1$$$, since $$$|a_2 - a_1| = |7 - 99| = |-92| = 92$$$, and $$$92$$$ is divisible by $$$2$$$.
   - Third operation $$$(x = 3)$$$: we can connect vertices $$$3$$$ and $$$2$$$, since $$$|a_3 - a_2| = |1 - 7| = |-6| = 6$$$, and $$$6$$$ is divisible by $$$3$$$.
  From the picture, it can be seen that a connected graph is obtained.', '[{"alt":"Problem diagram","url":"https://espresso.codeforces.com/24b0967a906dec08457b4ca26b1b9f94e4ae11d0.png"},{"alt":"Problem diagram","url":"https://espresso.codeforces.com/fdb54e80cd5428b2a0b745bfed10e1b4409a4a07.png"},{"alt":"Problem diagram","url":"https://espresso.codeforces.com/449331c248284a198b0c59042745856fef47c643.png"}]',
  'e2a7bb60f7dd9b2eeefce42eaa9f9911db6ce21d30d4135f5ebf99b008d02426', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":7}',
  'resolve', NULL, 'backlog', NULL, '2026-08-27',
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
  'cp31-cf-1992-f', 'codeforces', '1992:F', 'https://codeforces.com/contest/1992/problem/F',
  'Valuable Cards', '1992', 'F',
  '1900', 'medium', '["brute force","dp","greedy","number theory","two pointers"]',
  'In his favorite cafe Kmes once again wanted to try the herring under a fur coat. Previously, it would not have been difficult for him to do this, but the cafe recently introduced a new purchasing policy.

Now, in order to make a purchase, Kmes needs to solve the following problem: $$$n$$$ cards with prices for different positions are laid out in front of him, on the $$$i$$$-th card there is an integer $$$a_i$$$, among these prices there is no whole positive integer $$$x$$$.

Kmes is asked to divide these cards into the minimum number of bad segments (so that each card belongs to exactly one segment). A segment is considered bad if it is impossible to select a subset of cards with a product equal to $$$x$$$. All segments, in which Kmes will divide the cards, must be bad.

Formally, the segment $$$(l, r)$$$ is bad if there are no indices $$$i_1  \lt  i_2  \lt  \ldots  \lt  i_k$$$ such that $$$l \le i_1, i_k \le r$$$, and $$$a_{i_1} \cdot a_{i_2} \ldots \cdot a_{i_k} = x$$$.

Help Kmes determine the minimum number of bad segments in order to enjoy his favorite dish.

## Input

The first line contains a single integer $$$t$$$ ($$$1 \le t \le 10^3$$$) — the number of test cases.

The first line of each set of input data gives you $$$2$$$ integers $$$n$$$ and $$$x$$$ ($$$1 \le n \le 10^5, 2 \le x \le 10^5$$$) — the number of cards and the integer, respectively.

The second line of each set of input data contains $$$n$$$ integers $$$a_i$$$ ($$$1 \le a_i \le 2 \cdot 10^5, a_i \neq x$$$) — the prices on the cards.

It is guaranteed that the sum of $$$n$$$ over all sets of test data does not exceed $$$10^5$$$.

## Output

For each set of input data, output the minimum number of bad segments.

## Example

Input

    8
    6 4
    2 3 6 2 1 2
    9 100000
    50000 25000 12500 6250 3125 2 4 8 16
    5 2
    1 1 1 1 1
    8 6
    4 3 4 3 4 3 4 3
    7 12
    6 11 1 3 11 10 2
    10 5
    2 4 4 2 4 4 4 3 1 1
    7 8
    4 6 5 1 2 4 1
    8 27
    3 9 17 26 2 20 9 3

Output

    3
    2
    1
    1
    2
    1
    3
    3', '[]',
  '2cd9faedaf9cdb8ce5d71e485c43b8aad37ee003d191fedb70e46301b379ce73', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":8}',
  'resolve', NULL, 'backlog', NULL, '2026-08-27',
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
  'cp31-cf-1986-f', 'codeforces', '1986:F', 'https://codeforces.com/contest/1986/problem/F',
  'Non-academic Problem', '1986', 'F',
  '1900', 'medium', '["dfs and similar","graphs","trees"]',
  'You are given a connected undirected graph, the vertices of which are numbered with integers from $$$1$$$ to $$$n$$$. Your task is to minimize the number of pairs of vertices $$$1 \leq u  \lt  v \leq n$$$ between which there exists a path in this graph. To achieve this, you can remove exactly one edge from the graph.

Find the smallest number of pairs of vertices!

## Input

Each test consists of several sets of input data. The first line contains a single integer $$$t$$$ ($$$1 \leq t \leq 10^4$$$) — the number of sets of input data. Then follows their description.

The first line of each set of input data contains two integers $$$n$$$ and $$$m$$$ ($$$2 \leq n \leq 10^5$$$, $$$n - 1 \leq m \leq \min(10^5, \frac{n \cdot (n - 1)}{2})$$$) — the number of vertices in the graph and the number of edges.

Each of the next $$$m$$$ lines contains two integers $$$u$$$ and $$$v$$$ ($$$1 \leq u, v \leq n, u \neq v$$$), indicating that there is an undirected edge in the graph between vertices $$$u$$$ and $$$v$$$.

It is guaranteed that the given graph is connected and without multiple edges.

It is guaranteed that the sum of $$$n$$$ and the sum of $$$m$$$ over all sets of input data does not exceed $$$2 \cdot 10^5$$$.

## Output

For each set of input data, output the smallest number of pairs of reachable vertices, if exactly one edge can be removed.

## Example

Input

    6
    2 1
    1 2
    3 3
    1 2
    2 3
    1 3
    5 5
    1 2
    1 3
    3 4
    4 5
    5 3
    6 7
    1 2
    1 3
    2 3
    3 4
    4 5
    4 6
    5 6
    5 5
    1 2
    1 3
    2 3
    2 4
    3 5
    10 12
    1 2
    1 3
    2 3
    2 4
    4 5
    5 6
    6 7
    7 4
    3 8
    8 9
    9 10
    10 8

Output

    0
    3
    4
    6
    6
    21

## Note

In the first set of input data, we will remove the single edge $$$(1, 2)$$$ and the only pair of vertices $$$(1, 2)$$$ will become unreachable from each other.

In the second set of input data, no matter which edge we remove, all vertices will be reachable from each other.

In the fourth set of input data, the graph looks like this initially.

  

We will remove the edge $$$(3, 4)$$$ and then the only reachable pairs of vertices will be $$$(1, 2)$$$, $$$(1, 3)$$$, $$$(2, 3)$$$, $$$(4, 5)$$$, $$$(4, 6)$$$, $$$(5, 6)$$$.

  

In the sixth set of input data, the graph looks like this initially.

  

After removing the edge $$$(2, 4)$$$, the graph will look like this. Thus, there will be $$$21$$$ pairs of reachable vertices.', '[{"alt":"Problem diagram","url":"https://espresso.codeforces.com/374872f585ce28149acd3b381875efadf03e3f9f.png"},{"alt":"Problem diagram","url":"https://espresso.codeforces.com/adb68230f3dce64b691c34d8c62b1aae1d001832.png"},{"alt":"Problem diagram","url":"https://espresso.codeforces.com/af198d53b65fc93300eea0a58cf54fbbf3f62159.png"},{"alt":"Problem diagram","url":"https://espresso.codeforces.com/c6412c8719740b67fbeec45ec0428b1bf6adc5c4.png"}]',
  'a183a96563984419a49b9a92d622de986b2c02f451f0c693fd3a811f8f87267f', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":9}',
  'resolve', NULL, 'backlog', NULL, '2026-08-27',
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
  'cp31-cf-1957-d', 'codeforces', '1957:D', 'https://codeforces.com/contest/1957/problem/D',
  'A BIT of an Inequality', '1957', 'D',
  '1900', 'medium', '["bitmasks","brute force","dp","math"]',
  'You are given an array $$$a_1, a_2, \ldots, a_n$$$. Find the number of tuples ($$$x, y, z$$$) such that:

 - $$$1 \leq x \leq y \leq z \leq n$$$, and
- $$$f(x, y) \oplus f(y, z)  \gt  f(x, z)$$$.

We define $$$f(l, r) = a_l \oplus a_{l + 1} \oplus \ldots \oplus a_{r}$$$, where $$$\oplus$$$ denotes the bitwise XOR operation.

## Input

The first line contains a single integer $$$t$$$ ($$$1 \leq t \leq 10^4$$$) — the number of test cases.

The first line of each test case contains a single integer $$$n$$$ ($$$1 \leq n \leq 10^5$$$).

The second line of each test case contains $$$n$$$ integers $$$a_1, a_2, \ldots, a_n$$$ ($$$1 \leq a_i \leq 10^9$$$).

It is guaranteed that the sum of $$$n$$$ over all test cases does not exceed $$$10^5$$$.

## Output

For each test case, output a single integer on a new line — the number of described tuples.

## Example

Input

    3
    3
    6 2 4
    1
    3
    5
    7 3 7 2 1

Output

    4
    0
    16

## Note

In the first case, there are 4 such tuples in the array $$$[6, 2, 4]$$$:

 - ($$$1$$$, $$$2$$$, $$$2$$$): $$$(a_1 \oplus a_2) \oplus (a_2) = 4 \oplus 2  \gt  (a_1 \oplus a_2) = 4$$$
- ($$$1$$$, $$$1$$$, $$$3$$$): $$$(a_1) \oplus (a_1 \oplus a_2 \oplus a_3) = 6 \oplus 0  \gt  (a_1 \oplus a_2 \oplus a_3) = 0$$$
- ($$$1$$$, $$$2$$$, $$$3$$$): $$$(a_1 \oplus a_2) \oplus (a_2 \oplus a_3) = 4 \oplus 6  \gt  (a_1 \oplus a_2 \oplus a_3) = 0$$$
- ($$$1$$$, $$$3$$$, $$$3$$$): $$$(a_1 \oplus a_2 \oplus a_3) \oplus (a_3) = 0 \oplus 4  \gt  (a_1 \oplus a_2 \oplus a_3) = 0$$$

In the second test case, there are no such tuples.', '[]',
  '526d5c56c11a9205ec52d348eb5937509f3d3b3b84061952bf6657b0ae64e879', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":10}',
  'resolve', NULL, 'backlog', NULL, '2026-08-27',
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
  'cp31-cf-1950-g', 'codeforces', '1950:G', 'https://codeforces.com/contest/1950/problem/G',
  'Shuffling Songs', '1950', 'G',
  '1900', 'medium', '["bitmasks","dfs and similar","dp","graphs","hashing","implementation","strings"]',
  'Vladislav has a playlist consisting of $$$n$$$ songs, numbered from $$$1$$$ to $$$n$$$. Song $$$i$$$ has genre $$$g_i$$$ and writer $$$w_i$$$. He wants to make a playlist in such a way that every pair of adjacent songs either have the same writer or are from the same genre (or both). He calls such a playlist exciting. Both $$$g_i$$$ and $$$w_i$$$ are strings of length no more than $$$10^4$$$.

It might not always be possible to make an exciting playlist using all the songs, so the shuffling process occurs in two steps. First, some amount (possibly zero) of the songs are removed, and then the remaining songs in the playlist are rearranged to make it exciting.

Since Vladislav doesn''t like when songs get removed from his playlist, he wants the making playlist to perform as few removals as possible. Help him find the minimum number of removals that need to be performed in order to be able to rearrange the rest of the songs to make the playlist exciting.

## Input

The first line of the input contains a single integer $$$t$$$ ($$$1 \le t \le 1000$$$) — the number of test cases. The description of test cases follows.

The first line of each test case contains a single integer $$$n$$$ ($$$1 \le n \le 16$$$) — the number of songs in the original playlist.

Then $$$n$$$ lines follow, the $$$i$$$-th of which contains two strings of lowercase letters $$$g_i$$$ and $$$w_i$$$ ($$$1 \leq |g_i|, |w_i| \leq 10^4$$$) — the genre and the writer of the $$$i$$$-th song. Where $$$|g_i|$$$ and $$$|w_i|$$$ are lengths of the strings.

The sum of $$$2^n$$$ over all test cases does not exceed $$$2^{16}$$$.

The sum of $$$|g_i| + |w_i|$$$ over all test cases does not exceed $$$4 \cdot 10^5$$$.

## Output

For each test case, output a single integer — the minimum number of removals necessary so that the resulting playlist can be made exciting.

## Example

Input

    4
    1
    pop taylorswift
    4
    electronic themotans
    electronic carlasdreams
    pop themotans
    pop irinarimes
    7
    rap eminem
    rap drdre
    rap kanyewest
    pop taylorswift
    indierock arcticmonkeys
    indierock arcticmonkeys
    punkrock theoffspring
    4
    a b
    c d
    e f
    g h

Output

    0
    0
    4
    3

## Note

In the first test case, the playlist is already exciting.

In the second test case, if you have the songs in the order $$$4, 3, 1, 2$$$, it is exciting, so you don''t need to remove any songs.

In the third test case, you can remove songs $$$4, 5, 6, 7$$$. Then the playlist with songs in the order $$$1, 2, 3$$$ is exciting.', '[]',
  '83d681223b1455d93d923796fba43bd95a9f2ebabbf7ff38d7931bfac744fdc8', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":11}',
  'resolve', NULL, 'backlog', NULL, '2026-08-28',
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
  'cp31-cf-1932-f', 'codeforces', '1932:F', 'https://codeforces.com/contest/1932/problem/F',
  'Feed Cats', '1932', 'F',
  '1900', 'medium', '["data structures","dp","sortings"]',
  'There is a fun game where you need to feed cats that come and go. The level of the game consists of $$$n$$$ steps. There are $$$m$$$ cats; the cat $$$i$$$ is present in steps from $$$l_i$$$ to $$$r_i$$$, inclusive. In each step, you can feed all the cats that are currently present or do nothing.

If you feed the same cat more than once, it will overeat, and you will immediately lose the game. Your goal is to feed as many cats as possible without causing any cat to overeat.

Find the maximum number of cats you can feed.

Formally, you need to select several integer points from the segment from $$$1$$$ to $$$n$$$ in such a way that among given segments, none covers two or more of the selected points, and as many segments as possible cover one of the selected points.

## Input

The first line of input contains a single integer $$$t$$$ ($$$1 \le t \le 10^4$$$) — the number of test cases. Then the descriptions of the test cases follow.

The first line of each test case contains two integers $$$n$$$ and $$$m$$$ ($$$1 \le n \le 10^6$$$, $$$1 \le m\le 2\cdot 10^5$$$).

The $$$i$$$-th of the next $$$m$$$ lines contains a pair of integers $$$l_i$$$ and $$$r_i$$$ ($$$1 \le l_i \le r_i \le n$$$).

The sum of $$$n$$$ for all tests does not exceed $$$10^6$$$, the sum of $$$m$$$ for all tests does not exceed $$$2\cdot 10^5$$$.

## Output

For each test case, print a single integer, the maximum number of cats you can feed.

## Example

Input

    3
    15 6
    2 10
    3 5
    2 4
    7 7
    8 12
    11 11
    1000 1
    1 1000
    5 10
    1 2
    3 4
    3 4
    3 4
    3 4
    1 1
    1 2
    3 3
    3 4
    3 4

Output

    5
    1
    10

## Note

In the first example, one of the ways to feed five cats is to feed at steps $$$4$$$ and $$$11$$$.

- At step $$$4$$$, cats $$$1$$$, $$$2$$$, and $$$3$$$ will be fed.
- At step $$$11$$$, cats $$$5$$$ and $$$6$$$ will be fed.', '[]',
  '469a38c6540d0b20072e6a4a6e111e94cf85a833c07ee27677ede6f56f3b18cc', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":12}',
  'resolve', NULL, 'backlog', NULL, '2026-08-28',
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
