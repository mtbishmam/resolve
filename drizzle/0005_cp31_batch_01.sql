INSERT INTO problems (
  id, platform, problem_key, url, title, contest, problem_index, rating,
  difficulty, official_tags_json, statement_markdown, statement_assets_json,
  statement_hash, statement_captured_at, metadata_status,
  metadata_provenance_json, legacy_metadata_json, import_source,
  import_provenance_json, review_status, state, status, archived_at, due_date,
  sprint_id, next_review_date, created_at, updated_at
) VALUES (
  'cp31-cf-1920-c', 'codeforces', '1920:C', 'https://codeforces.com/contest/1920/problem/C',
  'Partitioning the Array', '1920', 'C',
  '1600', 'medium', '["brute force","math","number theory"]',
  'Allen has an array a_1, a_2,\ldots,a_n. For every positive integer k that is a divisor of n, Allen does the following:

 - He partitions the array into \frac{n}{k} disjoint subarrays of length k. In other words, he partitions the array into the following subarrays: [a_1,a_2,\ldots,a_k],[a_{k+1}, a_{k+2},\ldots,a_{2k}],\ldots,[a_{n-k+1},a_{n-k+2},\ldots,a_{n}]
- Allen earns one point if there exists some positive integer m (m \geq 2) such that if he replaces every element in the array with its remainder when divided by m, then all subarrays will be identical.

Help Allen find the number of points he will earn.

## Input

Each test consists of multiple test cases. The first line contains a single integer t (1 \leq t \leq 10^4) — the number of test cases. The description of the test cases follows.

The first line of each test case contains a single integer n (1 \leq n \leq 2\cdot10^5) — the length of the array a.

The second line of each test case contains n integers a_1, a_2,\ldots, a_n (1 \leq a_i \leq n) — the elements of the array a.

It is guaranteed that the sum of n over all test cases does not exceed 2 \cdot 10^5.

## Output

For each test case, output a single integer — the number of points Allen will earn.

## Example

Input

    8
    4
    1 2 1 4
    3
    1 2 3
    5
    1 1 1 1 1
    6
    1 3 1 1 3 1
    6
    6 2 6 2 2 2
    6
    2 6 3 6 6 6
    10
    1 7 5 1 4 3 1 3 1 4
    1
    1

Output

    2
    1
    2
    4
    4
    1
    2
    1

## Note

In the first test case, k=2 earns a point since Allen can pick m = 2 and both subarrays will be equal to [1, 0]. k=4 also earns a point, since no matter what m Allen chooses, there will be only one subarray and thus all subarrays are equal.

In the second test case, Allen earns 1 point for k=3, where his choice for m does not matter.', '[]',
  '2f49f58c71f59d4aacff8cc7276e2f5624cc252a5bf2ea323e5c67adf23e4fb7', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":1}',
  'resolve', NULL, 'backlog', NULL, '2026-08-05',
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
  'cp31-cf-1907-e', 'codeforces', '1907:E', 'https://codeforces.com/contest/1907/problem/E',
  'Good Triples', '1907', 'E',
  '1600', 'medium', '["brute force","combinatorics","number theory"]',
  'Given a non-negative integer number n (n \ge 0). Let''s say a triple of non-negative integers (a, b, c) is good if a + b + c = n, and digsum(a) + digsum(b) + digsum(c) = digsum(n), where digsum(x) is the sum of digits of number x.

For example, if n = 26, then the pair (4, 12, 10) is good, because 4 + 12 + 10 = 26, and (4) + (1 + 2) + (1 + 0) = (2 + 6).

Your task is to find the number of good triples for the given number n. The order of the numbers in a triple matters. For example, the triples (4, 12, 10) and (10, 12, 4) are two different triples.

## Input

The first line of input contains a single integer t (1 \le t \le 10^4) — the number of test cases. Descriptions of test cases follow.

The first and only line of the test case contains one integer n (0 \le n \le 10^7).

## Output

For each test case output one integer, the number of good triples for the given integer n. Order of integers in a triple matters.

## Example

Input

    12
    11
    0
    1
    2
    3
    4
    5
    3141
    999
    2718
    9999999
    10000000

Output

    9
    1
    3
    6
    10
    15
    21
    1350
    166375
    29160
    1522435234375
    3

## Note

In the first example, the good triples are (0, 0, 11), (0, 1, 10), (0, 10, 1), (0, 11, 0), (1, 0, 10), (1, 10, 0), (10, 0, 1), (10, 1, 0), (11, 0, 0).

In the second example, there is only one good triple (0, 0, 0).', '[]',
  '7f314f132da333048f0feba56b3aefc9135ed3ff1c384edf944f47c9514fca30', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":2}',
  'resolve', NULL, 'backlog', NULL, '2026-08-05',
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
  'cp31-cf-1886-c', 'codeforces', '1886:C', 'https://codeforces.com/contest/1886/problem/C',
  'Decreasing String', '1886', 'C',
  '1600', 'medium', '["implementation","strings"]',
  'Recall that string a is lexicographically smaller than string b if a is a prefix of b (and a \ne b), or there exists an index i (1 \le i \le \min(|a|, |b|)) such that a_i  \lt  b_i, and for any index j (1 \le j  \lt  i) a_j = b_j.

Consider a sequence of strings s_1, s_2, \dots, s_n, each consisting of lowercase Latin letters. String s_1 is given explicitly, and all other strings are generated according to the following rule: to obtain the string s_i, a character is removed from string s_{i-1} in such a way that string s_i is lexicographically minimal.

For example, if s_1 = \mathrm{dacb}, then string s_2 = \mathrm{acb}, string s_3 = \mathrm{ab}, string s_4 = \mathrm{a}.

After that, we obtain the string S = s_1 + s_2 + \dots + s_n (S is the concatenation of all strings s_1, s_2, \dots, s_n).

You need to output the character in position pos of the string S (i. e. the character S_{pos}).

## Input

The first line contains one integer t — the number of test cases (1 \le t \le 10^4).

Each test case consists of two lines. The first line contains the string s_1 (1 \le |s_1| \le 10^6), consisting of lowercase Latin letters. The second line contains the integer pos (1 \le pos \le \frac{|s_1| \cdot (|s_1| +1)}{2}). You may assume that n is equal to the length of the given string (n = |s_1|).

Additional constraint on the input: the sum of |s_1| over all test cases does not exceed 10^6.

## Output

For each test case, print the answer — the character that is at position pos in string S. Note that the answers between different test cases are not separated by spaces or line breaks.

## Example

Input

    3
    cab
    6
    abcd
    9
    x
    1

Output

    abx', '[]',
  '1403367ea9541aca1708237ae50ed23eb6eb2ce196c94e87e4070a3bb9ebcd48', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":3}',
  'resolve', NULL, 'backlog', NULL, '2026-08-05',
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
  'cp31-cf-1856-c', 'codeforces', '1856:C', 'https://codeforces.com/contest/1856/problem/C',
  'To Become Max', '1856', 'C',
  '1600', 'medium', '["binary search","brute force","data structures","dp"]',
  'You are given an array of integers a of length n.

In one operation you:

 - Choose an index i such that 1 \le i \le n - 1 and a_i \le a_{i + 1}.
- Increase a_i by 1.

Find the maximum possible value of \max(a_1, a_2, \ldots a_n) that you can get after performing this operation at most k times.

## Input

Each test contains multiple test cases. The first line of input contains a single integer t (1 \le t \le 100) — the number of test cases. The description of the test cases follows.

The first line of each test case contains two integers n and k (2 \le n \le 1000, 1 \le k \le 10^{8}) — the length of the array a and the maximum number of operations that can be performed.

The second line of each test case contains n integers a_1,a_2,\ldots,a_n (1 \le a_i \le 10^{8}) — the elements of the array a.

It is guaranteed that the sum of n over all test cases does not exceed 1000.

## Output

For each test case output a single integer — the maximum possible maximum of the array after performing at most k operations.

## Example

Input

    6
    3 4
    1 3 3
    5 6
    1 3 4 5 1
    4 13
    1 1 3 179
    5 3
    4 3 2 2 2
    5 6
    6 5 4 1 5
    2 17
    3 5

Output

    4
    7
    179
    5
    7
    6

## Note

In the first test case, one possible optimal sequence of operations is: [\color{red}{1}, 3, 3] \rightarrow [2, \color{red}{3}, 3] \rightarrow [\color{red}{2}, 4, 3] \rightarrow [\color{red}{3}, 4, 3] \rightarrow [4, 4, 3].

In the second test case, one possible optimal sequence of operations is: [1, \color{red}{3}, 4, 5, 1] \rightarrow [1, \color{red}{4}, 4, 5, 1] \rightarrow [1, 5, \color{red}{4}, 5, 1] \rightarrow [1, 5, \color{red}{5}, 5, 1] \rightarrow [1, \color{red}{5}, 6, 5, 1] \rightarrow [1, \color{red}{6}, 6, 5, 1] \rightarrow [1, 7, 6, 5, 1].', '[]',
  '61f8b0385e2d57697f6044c9dd1b5d6dc9c288664b13e2b035076363b7aed705', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":4}',
  'resolve', NULL, 'backlog', NULL, '2026-08-05',
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
  'cp31-cf-1843-e', 'codeforces', '1843:E', 'https://codeforces.com/contest/1843/problem/E',
  'Tracking Segments', '1843', 'E',
  '1600', 'medium', '["binary search","brute force","data structures","two pointers"]',
  'You are given an array a consisting of n zeros. You are also given a set of m not necessarily different segments. Each segment is defined by two numbers l_i and r_i (1 \le l_i \le r_i \le n) and represents a subarray a_{l_i}, a_{l_i+1}, \dots, a_{r_i} of the array a.

Let''s call the segment l_i, r_i beautiful if the number of ones on this segment is strictly greater than the number of zeros. For example, if a = [1, 0, 1, 0, 1], then the segment [1, 5] is beautiful (the number of ones is 3, the number of zeros is 2), but the segment [3, 4] is not is beautiful (the number of ones is 1, the number of zeros is 1).

You also have q changes. For each change you are given the number 1 \le x \le n, which means that you must assign an element a_x the value 1.

You have to find the first change after which at least one of m given segments becomes beautiful, or report that none of them is beautiful after processing all q changes.

## Input

The first line contains a single integer t (1 \le t \le 10^4) — the number of test cases.

The first line of each test case contains two integers n and m (1 \le m \le n \le 10^5) — the size of the array a and the number of segments, respectively.

Then there are m lines consisting of two numbers l_i and r_i (1 \le l_i \le r_i \le n) —the boundaries of the segments.

The next line contains an integer q (1 \le q \le n) — the number of changes.

The following q lines each contain a single integer x (1 \le x \le n) — the index of the array element that needs to be set to 1. It is guaranteed that indexes in queries are distinct.

It is guaranteed that the sum of n for all test cases does not exceed 10^5.

## Output

For each test case, output one integer  — the minimum change number after which at least one of the segments will be beautiful, or -1 if none of the segments will be beautiful.

## Example

Input

    6
    5 5
    1 2
    4 5
    1 5
    1 3
    2 4
    5
    5
    3
    1
    2
    4
    4 2
    1 1
    4 4
    2
    2
    3
    5 2
    1 5
    1 5
    4
    2
    1
    3
    4
    5 2
    1 5
    1 3
    5
    4
    1
    2
    3
    5
    5 5
    1 5
    1 5
    1 5
    1 5
    1 4
    3
    1
    4
    3
    3 2
    2 2
    1 3
    3
    2
    3
    1

Output

    3
    -1
    3
    3
    3
    1

## Note

In the first case, after first 2 changes we won''t have any beautiful segments, but after the third one on a segment [1; 5] there will be 3 ones and only 2 zeros, so the answer is 3.

In the second case, there won''t be any beautiful segments.', '[]',
  '3d925c80e961bf57835b2063b78be5ee76fb1c25fdefee6ff0bfeb5f5d1b49b8', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":5}',
  'resolve', NULL, 'backlog', NULL, '2026-08-05',
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
  'cp31-cf-1833-e', 'codeforces', '1833:E', 'https://codeforces.com/contest/1833/problem/E',
  'Round Dance', '1833', 'E',
  '1600', 'medium', '["dfs and similar","dsu","graphs","shortest paths"]',
  'n people came to the festival and decided to dance a few round dances. There are at least 2 people in the round dance and each person has exactly two neighbors. If there are 2 people in the round dance then they have the same neighbor on each side.

You decided to find out exactly how many dances there were. But each participant of the holiday remembered exactly one neighbor. Your task is to determine what the minimum and maximum number of round dances could be.

For example, if there were 6 people at the holiday, and the numbers of the neighbors they remembered are equal [2, 1, 4, 3, 6, 5], then the minimum number of round dances is1:

 - 1 - 2 - 3 - 4 - 5 - 6 - 1
 and the maximum is 3:  - 1 - 2 - 1
- 3 - 4 - 3
- 5 - 6 - 5

## Input

The first line contains a positive number t (1 \le t \le 10^4) — the number of test cases. The following is a description of the test cases.

The first line of the description of each test case contains a positive number n (2 \le n \le 2 \cdot 10^5) — the number of people at the holiday.

The second line of the description of each test case contains n integers a_i (1 \le a_i \le n, a_i \neq i) — the number of the neighbor that the ith person remembered.

It is guaranteed that the test cases are correct and corresponds to at least one division of people into round dances.

It is guaranteed that the sum of n for all test cases does not exceed 2 \cdot 10^5.

## Output

For each test case, output two integers — the minimum and maximum number of round dances that could be.

## Example

Input

    10
    6
    2 1 4 3 6 5
    6
    2 3 1 5 6 4
    9
    2 3 2 5 6 5 8 9 8
    2
    2 1
    4
    4 3 2 1
    5
    2 3 4 5 1
    6
    5 3 4 1 1 2
    5
    3 5 4 1 2
    6
    6 3 2 5 4 3
    6
    5 1 4 3 4 2

Output

    1 3
    2 2
    1 3
    1 1
    1 2
    1 1
    1 1
    2 2
    1 2
    1 1', '[]',
  'dfd64624c6b0c2b1b88f3f79090674775b63acad97fedbaab0c1409ce91808b1', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":6}',
  'resolve', NULL, 'backlog', NULL, '2026-08-06',
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
  'cp31-cf-1829-g', 'codeforces', '1829:G', 'https://codeforces.com/contest/1829/problem/G',
  'Hits Different', '1829', 'G',
  '1600', 'medium', '["data structures","dp","implementation","math"]',
  'In a carnival game, there is a huge pyramid of cans with 2023 rows, numbered in a regular pattern as shown.

 

If can 9^2 is hit initially, then all cans colored red in the picture above would fall.

You throw a ball at the pyramid, and it hits a single can with number n^2. This causes all cans that are stacked on top of this can to fall (that is, can n^2 falls, then the cans directly above n^2 fall, then the cans directly above those cans, and so on). For example, the picture above shows the cans that would fall if can 9^2 is hit.

What is the sum of the numbers on all cans that fall? Recall that n^2 = n \times n.

## Input

The first line contains an integer t (1 \leq t \leq 1000) — the number of test cases.

The only line of each test case contains a single integer n (1 \leq n \leq 10^6) — it means that the can you hit has label n^2.

## Output

For each test case, output a single integer — the sum of the numbers on all cans that fall.

Please note, that the answer for some test cases won''t fit into 32-bit integer type, so you should use at least 64-bit integer type in your programming language (like long long for C++). For all valid inputs, the answer will always fit into 64-bit integer type.

## Example

Input

    10
    9
    1
    2
    3
    4
    5
    6
    10
    1434
    1000000

Output

    156
    1
    5
    10
    21
    39
    46
    146
    63145186
    58116199242129511

## Note

The first test case is pictured in the statement. The sum of the numbers that fall is 1^2 + 2^2 + 3^2 + 5^2 + 6^2 + 9^2 = 1 + 4 + 9 + 25 + 36 + 81 = 156.

In the second test case, only the can labeled 1^2 falls, so the answer is 1^2=1.

In the third test case, the cans labeled 1^2 and 2^2 fall, so the answer is 1^2+2^2=1+4=5.

In the fourth test case, the cans labeled 1^2 and 3^2 fall, so the answer is 1^2+3^2=1+9=10.

In the fifth test case, the cans labeled 1^2, 2^2, and 4^2 fall, so the answer is 1^2+2^2+4^2=1+4+16=21.', '[{"alt":"Problem diagram","url":"https://espresso.codeforces.com/944109fd35d631f1a6949221008cfab20655ee75.png"}]',
  'b54e9ebd12a7d8349c2d56405fb149953eda3253032b226181fbcac4975192d2', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":7}',
  'resolve', NULL, 'backlog', NULL, '2026-08-06',
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
  'cp31-cf-1798-d', 'codeforces', '1798:D', 'https://codeforces.com/contest/1798/problem/D',
  'Shocking Arrangement', '1798', 'D',
  '1600', 'medium', '["constructive algorithms","greedy","math"]',
  'You are given an array a_1, a_2, \ldots, a_n consisting of integers such that a_1 + a_2 + \ldots + a_n = 0.

You have to rearrange the elements of the array a so that the following condition is satisfied:

\max\limits_{1 \le l \le r \le n} \lvert a_l + a_{l+1} + \ldots + a_r \rvert  \lt  \max(a_1, a_2, \ldots, a_n) - \min(a_1, a_2, \ldots, a_n), where |x| denotes the absolute value of x.

More formally, determine if there exists a permutation p_1, p_2, \ldots, p_n that for the array a_{p_1}, a_{p_2}, \ldots, a_{p_n}, the condition above is satisfied, and find the corresponding array.

Recall that the array p_1, p_2, \ldots, p_n is called a permutation if for each integer x from 1 to n there is exactly one i from 1 to n such that p_i = x.

## Input

Each test contains multiple test cases. The first line contains the number of test cases t (1 \le t \le 50\,000). The description of the test cases follows.

The first line of each test case contains a single integer n (1 \le n \le 300\,000) — the length of the array a.

The second line of each test case contains n integers a_1, a_2, \ldots, a_n (-10^9 \le a_i \le 10^9) — elements of the array a. It is guaranteed that the sum of the array a is zero, in other words: a_1 + a_2 + \ldots + a_n = 0.

It is guaranteed that the sum of n over all test cases does not exceed 300\,000.

## Output

For each test case, if it is impossible to rearrange the elements of the array a in the required way, print "No" in a single line.

If possible, print "Yes" in the first line, and then in a separate line n numbers — elements a_1, a_2, \ldots, a_n rearranged in a valid order (a_{p_1}, a_{p_2}, \ldots, a_{p_n}).

If there are several possible answers, you can output any of them.

## Example

Input

    7
    4
    3 4 -2 -5
    5
    2 2 2 -3 -3
    8
    -3 -3 1 1 1 1 1 1
    3
    0 1 -1
    7
    -3 4 3 4 -4 -4 0
    1
    0
    7
    -18 13 -18 -17 12 15 13

Output

    Yes
    -5 -2 3 4
    Yes
    -3 2 -3 2 2
    Yes
    1 1 1 -3 1 1 1 -3
    Yes
    -1 0 1
    Yes
    4 -4 4 -4 0 3 -3
    No
    Yes
    13 12 -18 15 -18 13 -17

## Note

In the first test case \max(a_1, \ldots, a_n) - \min(a_1, \ldots, a_n) = 9. Therefore, the elements can be rearranged as [-5, -2, 3, 4]. It is easy to see that for such an arrangement \lvert a_l + \ldots + a_r \rvert is always not greater than 7, and therefore less than 9.

In the second test case you can rearrange the elements of the array as [-3, 2, -3, 2, 2]. Then the maximum modulus of the sum will be reached on the subarray [-3, 2, -3], and will be equal to \lvert -3 + 2 + -3 \rvert = \lvert -4 \rvert = 4, which is less than 5.

In the fourth test example, any rearrangement of the array a will be suitable as an answer, including [-1, 0, 1].', '[]',
  '6454ae6fe3f123be0cbf0c2ab4989be20e55e641053b5240ab0ac141f059d5e6', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":8}',
  'resolve', NULL, 'backlog', NULL, '2026-08-06',
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
  'cp31-cf-1795-d', 'codeforces', '1795:D', 'https://codeforces.com/contest/1795/problem/D',
  'Triangle Coloring', '1795', 'D',
  '1600', 'medium', '["combinatorics","math"]',
  'You are given an undirected graph consisting of n vertices and n edges, where n is divisible by 6. Each edge has a weight, which is a positive (greater than zero) integer.

The graph has the following structure: it is split into \frac{n}{3} triples of vertices, the first triple consisting of vertices 1, 2, 3, the second triple consisting of vertices 4, 5, 6, and so on. Every pair of vertices from the same triple is connected by an edge. There are no edges between vertices from different triples.

You have to paint the vertices of this graph into two colors, red and blue. Each vertex should have exactly one color, there should be exactly \frac{n}{2} red vertices and \frac{n}{2} blue vertices. The coloring is called valid if it meets these constraints.

The weight of the coloring is the sum of weights of edges connecting two vertices with different colors.

Let W be the maximum possible weight of a valid coloring. Calculate the number of valid colorings with weight W, and print it modulo 998244353.

## Input

The first line contains one integer n (6 \le n \le 3 \cdot 10^5, n is divisible by 6).

The second line contains n integers w_1, w_2, \dots, w_n (1 \le w_i \le 1000) — the weights of the edges. Edge 1 connects vertices 1 and 2, edge 2 connects vertices 1 and 3, edge 3 connects vertices 2 and 3, edge 4 connects vertices 4 and 5, edge 5 connects vertices 4 and 6, edge 6 connects vertices 5 and 6, and so on.

## Output

Print one integer — the number of valid colorings with maximum possible weight, taken modulo 998244353.

## Examples

Input

    12
    1 3 3 7 8 5 2 2 2 2 4 2

Output

    36

Input

    6
    4 2 6 6 6 4

Output

    2

## Note

The following picture describes the graph from the first example test.

  

The maximum possible weight of a valid coloring of this graph is 31.', '[{"alt":"Problem diagram","url":"https://espresso.codeforces.com/e6e4005b0df87f33b3aafa20244614c906413b24.png"}]',
  'a6810bbc7a29df8d3306241650f8be72cf22eeb12dfc5b2f29c6db8458d1d2d3', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":9}',
  'resolve', NULL, 'backlog', NULL, '2026-08-06',
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
  'cp31-cf-1782-c', 'codeforces', '1782:C', 'https://codeforces.com/contest/1782/problem/C',
  'Equal Frequencies', '1782', 'C',
  '1600', 'medium', '["brute force","constructive algorithms","greedy","implementation","sortings","strings"]',
  'Let''s call a string balanced if all characters that are present in it appear the same number of times. For example, "coder", "appall", and "ttttttt" are balanced, while "wowwow" and "codeforces" are not.

You are given a string s of length n consisting of lowercase English letters. Find a balanced string t of the same length n consisting of lowercase English letters that is different from the string s in as few positions as possible. In other words, the number of indices i such that s_i \ne t_i should be as small as possible.

## Input

Each test contains multiple test cases. The first line contains the number of test cases t (1 \le t \le 10^4). The description of the test cases follows.

Each test case consists of two lines. The first line contains a single integer n (1 \le n \le 10^5) — the length of the string s.

The second line contains the string s of length n consisting of lowercase English letters.

It is guaranteed that the sum of n over all test cases does not exceed 10^5.

## Output

For each test case, print the smallest number of positions where string s and a balanced string t can differ, followed by such a string t.

If there are multiple solutions, print any. It can be shown that at least one balanced string always exists.

## Example

Input

    4
    5
    hello
    10
    codeforces
    5
    eevee
    6
    appall

Output

    1
    helno
    2
    codefofced
    1
    eeeee
    0
    appall

## Note

In the first test case, the given string "hello" is not balanced: letters ''h'', ''e'', and ''o'' appear in it once, while letter ''l'' appears twice. On the other hand, string "helno" is balanced: five distinct letters are present in it, and each of them appears exactly once. Strings "hello" and "helno" differ in just one position: the fourth character. Other solutions are possible too.

In the second test case, string "codefofced" is balanced since only letters ''c'', ''o'', ''d'', ''e'', and ''f'' are present in it, and each of them appears exactly twice.

In the third test case, string "eeeee" is balanced since only letter ''e'' is present in it.

In the fourth test case, the given string "appall" is already balanced.', '[]',
  'a3265b6a58339a825bdcf7c10822f2d93d21e5396235973d4821514aac2a71f7', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":10}',
  'resolve', NULL, 'backlog', NULL, '2026-08-06',
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
  'cp31-cf-1778-c', 'codeforces', '1778:C', 'https://codeforces.com/contest/1778/problem/C',
  'Flexible String', '1778', 'C',
  '1600', 'medium', '["bitmasks","brute force","strings"]',
  'You have a string a and a string b. Both of the strings have length n. There are at most 10 different characters in the string a. You also have a set Q. Initially, the set Q is empty. You can apply the following operation on the string a any number of times:

 - Choose an index i (1\leq i \leq n) and a lowercase English letter c. Add a_i to the set Q and then replace a_i with c.

For example, Let the string a be "\tt{abecca}". We can do the following operations:

 - In the first operation, if you choose i = 3 and c = \tt{x}, the character a_3 = \tt{e} will be added to the set Q. So, the set Q will be \{\tt{e}\}, and the string a will be "\tt{ab\underline{x}cca}".
- In the second operation, if you choose i = 6 and c = \tt{s}, the character a_6 = \tt{a} will be added to the set Q. So, the set Q will be \{\tt{e}, \tt{a}\}, and the string a will be "\tt{abxcc\underline{s}}".

You can apply any number of operations on a, but in the end, the set Q should contain at most k different characters. Under this constraint, you have to maximize the number of integer pairs (l, r) (1\leq l\leq r \leq n) such that a[l,r] = b[l,r]. Here, s[l,r] means the substring of string s starting at index l (inclusively) and ending at index r (inclusively).

## Input

Each test contains multiple test cases. The first line contains the number of test cases t (1 \le t \le 10^4). The description of the test cases follows.

The first line contains two integers n and k (1\leq n \leq 10^5, 0\leq k\leq 10) — the length of the two strings and the limit on different characters in the set Q.

The second line contains the string a of length n. There is at most 10 different characters in the string a.

The last line contains the string b of length n.

Both of the strings a and b contain only lowercase English letters. The sum of n over all test cases doesn''t exceed 10^5.

## Output

For each test case, print a single integer in a line, the maximum number of pairs (l, r) satisfying the constraints.

## Example

Input

    6
    3 1
    abc
    abd
    3 0
    abc
    abd
    3 1
    xbb
    xcd
    4 1
    abcd
    axcb
    3 10
    abc
    abd
    10 3
    lkwhbahuqa
    qoiujoncjb

Output

    6
    3
    6
    6
    6
    11

## Note

In the first case, we can select index i = 3 and replace it with character c = \tt{d}. All possible pairs (l,r) will be valid.

In the second case, we can''t perform any operation. The 3 valid pairs (l,r) are:

 - a[1,1] = b[1,1] = "\tt{a}",
- a[1,2] = b[1,2] = "\tt{ab}",
- a[2,2] = b[2,2] = "\tt{b}".

In the third case, we can choose index 2 and index 3 and replace them with the characters \tt{c} and \tt{d} respectively. The final set Q will be \{\tt{b}\} having size 1 that satisfies the value of k. All possible pairs (l,r) will be valid.', '[]',
  '4a93cc076a5fd55405365548ce99415fd13e395b07df5ddc4af0c58e9ea77787', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":11}',
  'resolve', NULL, 'backlog', NULL, '2026-08-07',
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
  'cp31-cf-1775-c', 'codeforces', '1775:C', 'https://codeforces.com/contest/1775/problem/C',
  'Interesting Sequence', '1775', 'C',
  '1600', 'medium', '["bitmasks","math"]',
  'Petya and his friend, robot Petya++, like to solve exciting math problems.

One day Petya++ came up with the numbers n and x and wrote the following equality on the board: n\ \&\ (n+1)\ \&\ \dots\ \&\ m = x, where \& denotes the bitwise AND operation. Then he suggested his friend Petya find such a minimal m (m \ge n) that the equality on the board holds.

Unfortunately, Petya couldn''t solve this problem in his head and decided to ask for computer help. He quickly wrote a program and found the answer.

Can you solve this difficult problem?

## Input

Each test contains multiple test cases. The first line contains the number of test cases t (1 \le t \le 2000). The description of the test cases follows.

The only line of each test case contains two integers n, x (0\le n, x \le 10^{18}).

## Output

For every test case, output the smallest possible value of m such that equality holds.

If the equality does not hold for any m, print -1 instead.

We can show that if the required m exists, it does not exceed 5 \cdot 10^{18}.

## Example

Input

    5
    10 8
    10 10
    10 42
    20 16
    1000000000000000000 0

Output

    12
    10
    -1
    24
    1152921504606846976

## Note

In the first example, 10\ \&\ 11 = 10, but 10\ \&\ 11\ \&\ 12 = 8, so the answer is 12.

In the second example, 10 = 10, so the answer is 10.

In the third example, we can see that the required m does not exist, so we have to print -1.', '[{"alt":"Problem diagram","url":"https://espresso.codeforces.com/4a5e1ab1c08f0400bd260e438330e662751bdc07.png"}]',
  '5dd2814af24da96d1822264614e12f39636c008f76ff6b9b55c84998485691e0', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":12}',
  'resolve', NULL, 'backlog', NULL, '2026-08-07',
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
  'cp31-cf-1741-e', 'codeforces', '1741:E', 'https://codeforces.com/contest/1741/problem/E',
  'Sending a Sequence Over the Network', '1741', 'E',
  '1600', 'medium', '["dp"]',
  'The sequence a is sent over the network as follows:

 - sequence a is split into segments (each element of the sequence belongs to exactly one segment, each segment is a group of consecutive elements of sequence);
- for each segment, its length is written next to it, either to the left of it or to the right of it;
- the resulting sequence b is sent over the network.

For example, we needed to send the sequence a = [1, 2, 3, 1, 2, 3]. Suppose it was split into segments as follows: [\color{red}{1}] + [\color{blue}{2, 3, 1}] + [\color{green}{2, 3}]. Then we could have the following sequences:

 - b = [1, \color{red}{1}, 3, \color{blue}{2, 3, 1}, \color{green}{2, 3}, 2],
- b = [\color{red}{1}, 1, 3, \color{blue}{2, 3, 1}, 2, \color{green}{2, 3}],
- b = [\color{red}{1}, 1, \color{blue}{2, 3, 1}, 3, 2, \color{green}{2, 3}],
- b = [\color{red}{1}, 1,\color{blue}{2, 3, 1}, 3, \color{green}{2, 3}, 2].

If a different segmentation had been used, the sent sequence might have been different.

The sequence b is given. Could the sequence b be sent over the network? In other words, is there such a sequence a that converting a to send it over the network could result in a sequence b?

## Input

The first line of input data contains a single integer t (1 \le t \le 10^4) — the number of test cases.

Each test case consists of two lines.

The first line of the test case contains an integer n (1 \le n \le 2 \cdot 10^5) — the size of the sequence b.

The second line of test case contains n integers b_1, b_2, \dots, b_n (1 \le b_i \le 10^9) — the sequence b itself.

It is guaranteed that the sum of n over all test cases does not exceed 2 \cdot 10^5.

## Output

For each test case print on a separate line:

 - YES if sequence b could be sent over the network, that is, if sequence b could be obtained from some sequence a to send a over the network.
- NO otherwise.

You can output YES and NO in any case (for example, strings yEs, yes, Yes and YES will be recognized as positive response).

## Example

Input

    7
    9
    1 1 2 3 1 3 2 2 3
    5
    12 1 2 7 5
    6
    5 7 8 9 10 3
    4
    4 8 6 2
    2
    3 1
    10
    4 6 2 1 9 4 9 3 4 2
    1
    1

Output

    YES
    YES
    YES
    NO
    YES
    YES
    NO

## Note

In the first case, the sequence b could be obtained from the sequence a = [1, 2, 3, 1, 2, 3] with the following partition: [\color{red}{1}] + [\color{blue}{2, 3, 1}] + [\color{green}{2, 3}]. The sequence b: [\color{red}{1}, 1, \color{blue}{2, 3, 1}, 3, 2, \color{green}{2, 3}].

In the second case, the sequence b could be obtained from the sequence a = [12, 7, 5] with the following partition: [\color{red}{12}] + [\color{green}{7, 5}]. The sequence b: [\color{red}{12}, 1, 2, \color{green}{7, 5}].

In the third case, the sequence b could be obtained from the sequence a = [7, 8, 9, 10, 3] with the following partition: [\color{red}{7, 8, 9, 10, 3}]. The sequence b: [5, \color{red}{7, 8, 9, 10, 3}].

In the fourth case, there is no sequence a such that changing a for transmission over the network could produce a sequence b.', '[]',
  'ed4e48d7eb56354d88936a42af6e2805ebc91d13772396202e8d6e66cd7cc667', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":13}',
  'resolve', NULL, 'backlog', NULL, '2026-08-07',
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
  'cp31-cf-1730-b', 'codeforces', '1730:B', 'https://codeforces.com/contest/1730/problem/B',
  'Meeting on the Line', '1730', 'B',
  '1600', 'medium', '["binary search","geometry","greedy","implementation","math","ternary search"]',
  'n people live on the coordinate line, the i-th one lives at the point x_i (1 \le i \le n). They want to choose a position x_0 to meet. The i-th person will spend |x_i - x_0| minutes to get to the meeting place. Also, the i-th person needs t_i minutes to get dressed, so in total he or she needs t_i + |x_i - x_0| minutes.

Here |y| denotes the absolute value of y.

These people ask you to find a position x_0 that minimizes the time in which all n people can gather at the meeting place.

## Input

The first line contains a single integer t (1 \le t \le 10^3) — the number of test cases. Then the test cases follow.

Each test case consists of three lines.

The first line contains a single integer n (1 \le n \le 10^5) — the number of people.

The second line contains n integers x_1, x_2, \dots, x_n (0 \le x_i \le 10^{8}) — the positions of the people.

The third line contains n integers t_1, t_2, \dots, t_n (0 \le t_i \le 10^{8}), where t_i is the time i-th person needs to get dressed.

It is guaranteed that the sum of n over all test cases does not exceed 2 \cdot 10^5.

## Output

For each test case, print a single real number — the optimum position x_0. It can be shown that the optimal position x_0 is unique.

Your answer will be considered correct if its absolute or relative error does not exceed 10^{−6}. Formally, let your answer be a, the jury''s answer be b. Your answer will be considered correct if \frac{|a−b|}{max(1,|b|)} \le 10^{−6}.

## Example

Input

    7
    1
    0
    3
    2
    3 1
    0 0
    2
    1 4
    0 0
    3
    1 2 3
    0 0 0
    3
    1 2 3
    4 1 2
    3
    3 3 3
    5 3 3
    6
    5 4 7 2 10 4
    3 2 5 1 4 6

Output

    0
    2
    2.5
    2
    1
    3
    6

## Note

 - In the 1-st test case there is one person, so it is efficient to choose his or her position for the meeting place. Then he or she will get to it in 3 minutes, that he or she need to get dressed.
- In the 2-nd test case there are 2 people who don''t need time to get dressed. Each of them needs one minute to get to position 2.
- In the 5-th test case the 1-st person needs 4 minutes to get to position 1 (4 minutes to get dressed and 0 minutes on the way); the 2-nd person needs 2 minutes to get to position 1 (1 minute to get dressed and 1 minute on the way); the 3-rd person needs 4 minutes to get to position 1 (2 minutes to get dressed and 2 minutes on the way).', '[]',
  'f857d0f9f3ede0ab4a2e0fd0b2e2590c1cbf101814ff95634b22bd16ab0152c0', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":14}',
  'resolve', NULL, 'backlog', NULL, '2026-08-07',
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
  'cp31-cf-1702-e', 'codeforces', '1702:E', 'https://codeforces.com/contest/1702/problem/E',
  'Split Into Two Sets', '1702', 'E',
  '1600', 'medium', '["dfs and similar","dsu","graphs"]',
  'Polycarp was recently given a set of n (number n — even) dominoes. Each domino contains two integers from 1 to n.

Can he divide all the dominoes into two sets so that all the numbers on the dominoes of each set are different? Each domino must go into exactly one of the two sets.

For example, if he has 4 dominoes: \{1, 4\}, \{1, 3\}, \{3, 2\} and \{4, 2\}, then Polycarp will be able to divide them into two sets in the required way. The first set can include the first and third dominoes (\{1, 4\} and \{3, 2\}), and the second set — the second and fourth ones (\{1, 3\} and \{4, 2\}).

## Input

The first line contains a single integer t (1 \le t \le 10^4) — the number of test cases.

The descriptions of the test cases follow.

The first line of each test case contains a single even integer n (2 \le n \le 2 \cdot 10^5) — the number of dominoes.

The next n lines contain pairs of numbers a_i and b_i (1 \le a_i, b_i \le n) describing the numbers on the i-th domino.

It is guaranteed that the sum of n over all test cases does not exceed 2 \cdot 10^5.

## Output

For each test case print:

 - YES, if it is possible to divide n dominoes into two sets so that the numbers on the dominoes of each set are different;
- NO if this is not possible.

You can print YES and NO in any case (for example, the strings yEs, yes, Yes and YES will be recognized as a positive answer).

## Example

Input

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

Output

    YES
    NO
    NO
    YES
    YES
    NO

## Note

In the first test case, the dominoes can be divided as follows:

 - First set of dominoes: [\{1, 2\}, \{4, 3\}]
- Second set of dominoes: [\{2, 1\}, \{3, 4\}]
 In other words, in the first set we take dominoes with numbers 1 and 2, and in the second set we take dominoes with numbers 3 and 4.

In the second test case, there''s no way to divide dominoes into 2 sets, at least one of them will contain repeated number.', '[]',
  '054d2ec77f3a0e609a5d35c31c8c68be6c075a7e8e72815667fd8c2c05f1f4d4', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":15}',
  'resolve', NULL, 'backlog', NULL, '2026-08-07',
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
