INSERT INTO problems (
  id, platform, problem_key, url, title, contest, problem_index, rating,
  difficulty, official_tags_json, statement_markdown, statement_assets_json,
  statement_hash, statement_captured_at, metadata_status,
  metadata_provenance_json, legacy_metadata_json, import_source,
  import_provenance_json, review_status, state, status, archived_at, due_date,
  sprint_id, next_review_date, created_at, updated_at
) VALUES (
  'cp31-cf-1698-d', 'codeforces', '1698:D', 'https://codeforces.com/contest/1698/problem/D',
  'Fixed Point Guessing', '1698', 'D',
  '1600', 'medium', '["binary search","constructive algorithms","interactive"]',
  'This is an interactive problem.

Initially, there is an array a = [1, 2, \ldots, n], where n is an odd positive integer. The jury has selected \frac{n-1}{2} disjoint pairs of elements, and then the elements in those pairs are swapped. For example, if a=[1,2,3,4,5], and the pairs 1 \leftrightarrow 4 and 3 \leftrightarrow 5 are swapped, then the resulting array is [4, 2, 5, 1, 3].

As a result of these swaps, exactly one element will not change position. You need to find this element.

To do this, you can ask several queries. In each query, you can pick two integers l and r (1 \leq l \leq r \leq n). In return, you will be given the elements of the subarray [a_l, a_{l + 1}, \dots, a_r] sorted in increasing order.

Find the element which did not change position. You can make at most \mathbf{15} queries.

The array a is fixed before the interaction and does not change after your queries.

Recall that an array b is a subarray of the array a if b can be obtained from a by deletion of several (possibly, zero or all) elements from the beginning and several (possibly, zero or all) elements from the end.

## Input

Each test contains multiple test cases. The first line contains an integer t (1 \leq t \leq 500) — the number of test cases. The description of the test cases follows.

The first line of each test case contains an integer n (3 \leq n  \lt  10^4; n is odd) — the length of the array a.

After reading the first line of each test case, you should begin the interaction.

It is guaranteed that the sum of n over all test cases does not exceed 10^4.

## Interaction

For each test case, begin the interaction by reading the integer n.

To make a query, output "\texttt{?}\;l\;r" (1 \leq l \leq r \leq n) without quotes. Afterwards, you should read in r-l+1 integers — the integers a_l, a_{l + 1}, \dots, a_r, in increasing order. You can make at most 15 such queries in a single test case.

If you receive the integer -1 instead of an answer or the integer n, it means your program has made an invalid query, has exceed the limit of queries, or has given incorrect answer on the previous test case. Your program must terminate immediately to receive a Wrong Answer verdict. Otherwise you can get an arbitrary verdict because your solution will continue to read from a closed stream.

When you are ready to give the final answer, output "\texttt{!}\;x" (1 \leq x \leq n) without quotes — the element that did not change position. Giving this answer does not count towards the limit of 15 queries. Afterwards, your program must continue to solve the remaining test cases, or exit if all test cases have been solved.

After printing a query do not forget to output end of line and flush the output. Otherwise, you will get Idleness limit exceeded. To do this, use:

 - fflush(stdout) or cout.flush() in C++;
- System.out.flush() in Java;
- flush(output) in Pascal;
- stdout.flush() in Python;
- see documentation for other languages.

Hacks

To make a hack, use the following format. The first line must contain an integer t (1 \leq t \leq 500) — the number of test cases. The description of the test cases follows.

The first line of each test case must contain an integer n (3 \leq n  \lt  10^4; n is odd) — the length of the array a.

The second line of each test case must contain n space-separated integers a_1, a_2, \ldots, a_n (1 \le a_i \le n) — the elements of a. The array a should be the result of \frac{n-1}{2} disjoint swaps on the array [1,2,\dots,n].

## Example

Input

    2
    5
    
    1 2 4 5
    
    1 3 5
    
    3
    
    1

Output

    
    
    ? 1 4
    
    ? 3 5
    
    ! 2
    
    ? 1 1
    
    ! 1

## Note

In the first test, the interaction proceeds as follows.

 SolutionJuryExplanation\texttt{2}There are 2 test cases.\texttt{5}In the first test case, the hidden array is [4,2,5,1,3], with length 5.\texttt{? 1 4}\texttt{1 2 4 5}The solution requests the subarray [4,2,5,1] in increasing order, and the jury responds with [1,2,4,5].\texttt{? 3 5}\texttt{1 3 5}The solution requests the subarray [5,1,3] in increasing order, and the jury responds with [1,3,5].\texttt{! 2}The solution has somehow determined that a_2=2, and outputs it. Since the output is correct, the jury continues to the next test case.\texttt{3}In the second test case, the hidden array is [1,3,2], with length 3.\texttt{? 1 1}\texttt{1}The solution requests the number [1] only, and the jury responds with [1].\texttt{! 1}The solution has determined that a_1=1, and outputs it. Since the output is correct and there are no more test cases, the jury and the solution exit. 

Note that the line breaks in the example input and output are for the sake of clarity, and do not occur in the real interaction.', '[]',
  '4ec910ba9f15a644baed32e17d55d894739cd99765a1bce1deabde77528dad00', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":16}',
  'resolve', NULL, 'backlog', NULL, '2026-08-08',
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
  'cp31-cf-1660-d', 'codeforces', '1660:D', 'https://codeforces.com/contest/1660/problem/D',
  'Maximum Product Strikes Back', '1660', 'D',
  '1600', 'medium', '["brute force","implementation","math","two pointers"]',
  'You are given an array a consisting of n integers. For each i (1 \le i \le n) the following inequality is true: -2 \le a_i \le 2.

You can remove any number (possibly 0) of elements from the beginning of the array and any number (possibly 0) of elements from the end of the array. You are allowed to delete the whole array.

You need to answer the question: how many elements should be removed from the beginning of the array, and how many elements should be removed from the end of the array, so that the result will be an array whose product (multiplication) of elements is maximal. If there is more than one way to get an array with the maximum product of elements on it, you are allowed to output any of them.

The product of elements of an empty array (array of length 0) should be assumed to be 1.

## Input

The first line of input data contains an integer t (1 \le t \le 10^4) —the number of test cases in the test.

Then the descriptions of the input test cases follow.

The first line of each test case description contains an integer n (1 \le n \le 2 \cdot 10^5) —the length of array a.

The next line contains n integers a_1, a_2, \dots, a_n (|a_i| \le 2) — elements of array a.

It is guaranteed that the sum of n over all test cases does not exceed 2 \cdot 10^5.

## Output

For each test case, output two non-negative numbers x and y (0 \le x + y \le n) — such that the product (multiplication) of the array numbers, after removing x elements from the beginning and y elements from the end, is maximal.

If there is more than one way to get the maximal product, it is allowed to output any of them. Consider the product of numbers on empty array to be 1.

## Example

Input

    5
    4
    1 2 -1 2
    3
    1 1 -2
    5
    2 0 -2 2 -1
    3
    -2 -1 -1
    3
    -1 -2 -2

Output

    0 2
    3 0
    2 0
    0 1
    1 0

## Note

In the first case, the maximal value of the product is 2. Thus, we can either delete the first three elements (obtain array [2]), or the last two and one first element (also obtain array [2]), or the last two elements (obtain array [1, 2]). Thus, in the first case, the answers fit: "3 0", or "1 2", or "0 2".

In the second case, the maximum value of the product is 1. Then we can remove all elements from the array because the value of the product on the empty array will be 1. So the answer is "3 0", but there are other possible answers.

In the third case, we can remove the first two elements of the array. Then we get the array: [-2, 2, -1]. The product of the elements of the resulting array is (-2) \cdot 2 \cdot (-1) = 4. This value is the maximum possible value that can be obtained. Thus, for this case the answer is: "2 0".', '[]',
  '2be93f00cd17ceebde8d2bafd623561ba542583c40fcf452ca67a815d5eab4da', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":17}',
  'resolve', NULL, 'backlog', NULL, '2026-08-08',
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
  'cp31-cf-1633-d', 'codeforces', '1633:D', 'https://codeforces.com/contest/1633/problem/D',
  'Make Them Equal', '1633', 'D',
  '1600', 'medium', '["dp","greedy"]',
  'You have an array of integers a of size n. Initially, all elements of the array are equal to 1. You can perform the following operation: choose two integers i (1 \le i \le n) and x (x  \gt  0), and then increase the value of a_i by \left\lfloor\frac{a_i}{x}\right\rfloor (i.e. make a_i = a_i + \left\lfloor\frac{a_i}{x}\right\rfloor).

After performing all operations, you will receive c_i coins for all such i that a_i = b_i.

Your task is to determine the maximum number of coins that you can receive by performing no more than k operations.

## Input

The first line contains a single integer t (1 \le t \le 100) — the number of test cases.

The first line of each test case contains two integers n and k (1 \le n \le 10^3; 0 \le k \le 10^6) — the size of the array and the maximum number of operations, respectively.

The second line contains n integers b_1, b_2, \dots, b_n (1 \le b_i \le 10^3).

The third line contains n integers c_1, c_2, \dots, c_n (1 \le c_i \le 10^6).

The sum of n over all test cases does not exceed 10^3.

## Output

For each test case, print one integer — the maximum number of coins that you can get by performing no more than k operations.

## Example

Input

    4
    4 4
    1 7 5 2
    2 6 5 2
    3 0
    3 5 2
    5 4 7
    5 9
    5 2 5 6 3
    5 9 1 9 7
    6 14
    11 4 6 2 8 16
    43 45 9 41 15 38

Output

    9
    0
    30
    167', '[]',
  'fa5160624032885122c303ab9c8d2ae386d2fa76fb631c841392e4e52b674d6a', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":18}',
  'resolve', NULL, 'backlog', NULL, '2026-08-08',
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
  'cp31-cf-1610-c', 'codeforces', '1610:C', 'https://codeforces.com/contest/1610/problem/C',
  'Keshi Is Throwing a Party', '1610', 'C',
  '1600', 'medium', '["binary search","greedy"]',
  'Keshi is throwing a party and he wants everybody in the party to be happy.

He has n friends. His i-th friend has i dollars.

If you invite the i-th friend to the party, he will be happy only if at most a_i people in the party are strictly richer than him and at most b_i people are strictly poorer than him.

Keshi wants to invite as many people as possible. Find the maximum number of people he can invite to the party so that every invited person would be happy.

## Input

The first line contains a single integer t (1\le t\le 10^4) — the number of test cases. The description of the test cases follows.

The first line of each test case contains a single integer n (1\le n\le 2 \cdot 10^5) — the number of Keshi''s friends.

The i-th of the following n lines contains two integers a_i and b_i (0 \le a_i, b_i  \lt  n).

It is guaranteed that the sum of n over all test cases doesn''t exceed 2 \cdot 10^5.

## Output

For each test case print the maximum number of people Keshi can invite.

## Example

Input

    3
    3
    1 2
    2 1
    1 1
    2
    0 0
    0 1
    2
    1 0
    0 1

Output

    2
    1
    2

## Note

In the first test case, he invites the first and the second person. If he invites all of them, the third person won''t be happy because there will be more than 1 person poorer than him.', '[]',
  'a8032cd09f193bcada4c82e38e702fe6aff69b30bcde9f695fe534f5dc64b84a', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":19}',
  'resolve', NULL, 'backlog', NULL, '2026-08-08',
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
  'cp31-cf-1555-d', 'codeforces', '1555:D', 'https://codeforces.com/contest/1555/problem/D',
  'Say No to Palindromes', '1555', 'D',
  '1600', 'medium', '["brute force","constructive algorithms","dp","strings"]',
  'Let''s call the string beautiful if it does not contain a substring of length at least 2, which is a palindrome. Recall that a palindrome is a string that reads the same way from the first character to the last and from the last character to the first. For example, the strings a, bab, acca, bcabcbacb are palindromes, but the strings ab, abbbaa, cccb are not.

Let''s define cost of a string as the minimum number of operations so that the string becomes beautiful, if in one operation it is allowed to change any character of the string to one of the first 3 letters of the Latin alphabet (in lowercase).

You are given a string s of length n, each character of the string is one of the first 3 letters of the Latin alphabet (in lowercase).

You have to answer m queries — calculate the cost of the substring of the string s from l_i-th to r_i-th position, inclusive.

## Input

The first line contains two integers n and m (1 \le n, m \le 2 \cdot 10^5) — the length of the string s and the number of queries.

The second line contains the string s, it consists of n characters, each character one of the first 3 Latin letters.

The following m lines contain two integers l_i and r_i (1 \le l_i \le r_i \le n) — parameters of the i-th query.

## Output

For each query, print a single integer — the cost of the substring of the string s from l_i-th to r_i-th position, inclusive.

## Example

Input

    5 4
    baacb
    1 3
    1 5
    4 5
    2 3

Output

    1
    2
    0
    1

## Note

Consider the queries of the example test.

 - in the first query, the substring is baa, which can be changed to bac in one operation;
- in the second query, the substring is baacb, which can be changed to cbacb in two operations;
- in the third query, the substring is cb, which can be left unchanged;
- in the fourth query, the substring is aa, which can be changed to ba in one operation.', '[]',
  '5e415ed0e8aa91c6a6992d3084a9ac647578f0595d32902b097161c3d4a0924f', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":20}',
  'resolve', NULL, 'backlog', NULL, '2026-08-08',
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
  'cp31-cf-1537-e1', 'codeforces', '1537:E1', 'https://codeforces.com/contest/1537/problem/E1',
  'Erase and Extend (Easy Version)', '1537', 'E1',
  '1600', 'medium', '["binary search","brute force","dp","greedy","hashing","implementation","string suffix structures","strings","two pointers"]',
  'This is the easy version of the problem. The only difference is the constraints on n and k. You can make hacks only if all versions of the problem are solved.

You have a string s, and you can do two types of operations on it:

 - Delete the last character of the string.
- Duplicate the string: s:=s+s, where + denotes concatenation.

You can use each operation any number of times (possibly none).

Your task is to find the lexicographically smallest string of length exactly k that can be obtained by doing these operations on string s.

A string a is lexicographically smaller than a string b if and only if one of the following holds:

 - a is a prefix of b, but a\ne b;
- In the first position where a and b differ, the string a has a letter that appears earlier in the alphabet than the corresponding letter in b.

## Input

The first line contains two integers n, k (1 \leq n, k \leq 5000) — the length of the original string s and the length of the desired string.

The second line contains the string s, consisting of n lowercase English letters.

## Output

Print the lexicographically smallest string of length k that can be obtained by doing the operations on string s.

## Examples

Input

    8 16
    dbcadabc

Output

    dbcadabcdbcadabc

Input

    4 5
    abcd

Output

    aaaaa

## Note

In the first test, it is optimal to make one duplication: "dbcadabc" \to "dbcadabcdbcadabc".

In the second test it is optimal to delete the last 3 characters, then duplicate the string 3 times, then delete the last 3 characters to make the string have length k.

"abcd" \to "abc" \to "ab" \to "a" \to "aa" \to "aaaa" \to "aaaaaaaa" \to "aaaaaaa" \to "aaaaaa" \to "aaaaa".', '[]',
  '4e45187b2036e3d6792d707880b1601da80a06ce0ea7bb6269b628af6d630452', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":21}',
  'resolve', NULL, 'backlog', NULL, '2026-08-09',
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
  'cp31-cf-1528-a', 'codeforces', '1528:A', 'https://codeforces.com/contest/1528/problem/A',
  'Parsa''s Humongous Tree', '1528', 'A',
  '1600', 'medium', '["dfs and similar","divide and conquer","dp","greedy","trees"]',
  'Parsa has a humongous tree on n vertices.

On each vertex v he has written two integers l_v and r_v.

To make Parsa''s tree look even more majestic, Nima wants to assign a number a_v (l_v \le a_v \le r_v) to each vertex v such that the beauty of Parsa''s tree is maximized.

Nima''s sense of the beauty is rather bizarre. He defines the beauty of the tree as the sum of |a_u - a_v| over all edges (u, v) of the tree.

Since Parsa''s tree is too large, Nima can''t maximize its beauty on his own. Your task is to find the maximum possible beauty for Parsa''s tree.

## Input

The first line contains an integer t (1\le t\le 250) — the number of test cases. The description of the test cases follows.

The first line of each test case contains a single integer n (2\le n\le 10^5) — the number of vertices in Parsa''s tree.

The i-th of the following n lines contains two integers l_i and r_i (1 \le l_i \le r_i \le 10^9).

Each of the next n-1 lines contains two integers u and v (1 \le u , v \le n, u\neq v) meaning that there is an edge between the vertices u and v in Parsa''s tree.

It is guaranteed that the given graph is a tree.

It is guaranteed that the sum of n over all test cases doesn''t exceed 2 \cdot 10^5.

## Output

For each test case print the maximum possible beauty for Parsa''s tree.

## Example

Input

    3
    2
    1 6
    3 8
    1 2
    3
    1 3
    4 6
    7 9
    1 2
    2 3
    6
    3 14
    12 20
    12 19
    2 12
    10 17
    3 17
    3 2
    6 5
    1 5
    2 6
    4 6

Output

    7
    8
    62

## Note

The trees in the example:

  

In the first test case, one possible assignment is a = \{1, 8\} which results in |1 - 8| = 7.

In the second test case, one of the possible assignments is a = \{1, 5, 9\} which results in a beauty of |1 - 5| + |5 - 9| = 8', '[{"alt":"Problem diagram","url":"https://espresso.codeforces.com/3b031338d47b70d058f72ff35ca2c141822732f0.png"}]',
  'caa141846f3f77c17a87019e6193dca4143cf735ac6503ad410e9f0c0d7c89df', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":22}',
  'resolve', NULL, 'backlog', NULL, '2026-08-09',
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
  'cp31-cf-1498-c', 'codeforces', '1498:C', 'https://codeforces.com/contest/1498/problem/C',
  'Planar Reflections', '1498', 'C',
  '1600', 'medium', '["brute force","data structures","dp"]',
  'Gaurang has grown up in a mystical universe. He is faced by n consecutive 2D planes. He shoots a particle of decay age k at the planes.

A particle can pass through a plane directly, however, every plane produces an identical copy of the particle going in the opposite direction with a decay age k-1. If a particle has decay age equal to 1, it will NOT produce a copy.

For example, if there are two planes and a particle is shot with decay age 3 (towards the right), the process is as follows: (here, D(x) refers to a single particle with decay age x)

- the first plane produces a D(2) to the left and lets D(3) continue on to the right;
- the second plane produces a D(2) to the left and lets D(3) continue on to the right;
- the first plane lets D(2) continue on to the left and produces a D(1) to the right;
- the second plane lets D(1) continue on to the right (D(1) cannot produce any copies).

In total, the final multiset S of particles is \{D(3), D(2), D(2), D(1)\}. (See notes for visual explanation of this test case.)

Gaurang is unable to cope up with the complexity of this situation when the number of planes is too large. Help Gaurang find the size of the multiset S, given n and k.

Since the size of the multiset can be very large, you have to output it modulo 10^9+7.

Note: Particles can go back and forth between the planes without colliding with each other.

## Input

The first line of the input contains the number of test cases t (1 \le t \le 100). Then, t lines follow, each containing two integers n and k (1 \le n, k \le 1000).

Additionally, the sum of n over all test cases will not exceed 1000, and the sum of k over all test cases will not exceed 1000. All test cases in one test are different.

## Output

Output t integers. The i-th of them should be equal to the answer to the i-th test case.

## Examples

Input

    4
    2 3
    2 2
    3 1
    1 3

Output

    4
    3
    1
    2

Input

    3
    1 1
    1 500
    500 250

Output

    1
    2
    257950823

## Note

Let us explain the first example with four test cases.

Test case 1: (n = 2, k = 3) is already explained in the problem statement.

See the below figure of this simulation. Each straight line with a different color represents the path of a different particle. As you can see, there are four distinct particles in the multiset. Note that the vertical spacing between reflected particles is for visual clarity only (as mentioned before, no two distinct particles collide with each other)

  

Test case 2: (n = 2, k = 2) is explained as follows:

- the first plane produces a D(1) to the left and lets D(2) continue on to the right;
- the second plane produces a D(1) to the left and lets D(2) continue on to the right;
- the first plane lets D(1) continue on to the left (D(1) cannot produce any copies).

Total size of multiset obtained \{D(1), D(1), D(2)\} is equal to three.

Test case 3: (n = 3, k = 1), there are three planes, but decay age is only one. So no new copies are produced while the one particle passes through the planes. Hence, the answer is one.

Test case 4: (n = 1, k = 3) there is only one plane. The particle produces a new copy to the left. The multiset \{D(2), D(3)\} is of size two.', '[{"alt":"Problem diagram","url":"https://espresso.codeforces.com/91b8b91bc97b8e5dbdaf5b5beafb5787dd887133.png"}]',
  '75d9f5f5efcb742c686b67b8e82c11393a55ea67d1ba5678bd44c8e57bbb7028', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":23}',
  'resolve', NULL, 'backlog', NULL, '2026-08-09',
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
  'cp31-cf-1475-e', 'codeforces', '1475:E', 'https://codeforces.com/contest/1475/problem/E',
  'Advertising Agency', '1475', 'E',
  '1600', 'medium', '["combinatorics","math","sortings"]',
  'Masha works in an advertising agency. In order to promote the new brand, she wants to conclude contracts with some bloggers. In total, Masha has connections of n different bloggers. Blogger numbered i has a_i followers.

Since Masha has a limited budget, she can only sign a contract with k different bloggers. Of course, Masha wants her ad to be seen by as many people as possible. Therefore, she must hire bloggers with the maximum total number of followers.

Help her, find the number of ways to select k bloggers so that the total number of their followers is maximum possible. Two ways are considered different if there is at least one blogger in the first way, which is not in the second way. Masha believes that all bloggers have different followers (that is, there is no follower who would follow two different bloggers).

For example, if n=4, k=3, a=[1, 3, 1, 2], then Masha has two ways to select 3 bloggers with the maximum total number of followers:

 - conclude contracts with bloggers with numbers 1, 2 and 4. In this case, the number of followers will be equal to a_1 + a_2 + a_4 = 6.
- conclude contracts with bloggers with numbers 2, 3 and 4. In this case, the number of followers will be equal to a_2 + a_3 + a_4 = 6.

Since the answer can be quite large, output it modulo 10^9+7.

## Input

The first line contains one integer t (1 \le t \le 1000) — the number of test cases. Then t test cases follow.

The first line of each test case contains two integers n and k (1 \le k \le n \le 1000) — the number of bloggers and how many of them you can sign a contract with.

The second line of each test case contains n integers a_1, a_2, \ldots a_n (1 \le a_i \le n) — the number of followers of each blogger.

It is guaranteed that the sum of n over all test cases does not exceed 1000.

## Output

For each test case, on a separate line output one integer — the number of ways to select k bloggers so that the total number of their followers is maximum possible.

## Example

Input

    3
    4 3
    1 3 1 2
    4 2
    1 1 1 1
    2 1
    1 2

Output

    2
    6
    1

## Note

The test case is explained in the statements.

In the second test case, the following ways are valid:

 - conclude contracts with bloggers with numbers 1 and 2. In this case, the number of followers will be equal to a_1 + a_2 = 2;
- conclude contracts with bloggers with numbers 1 and 3. In this case, the number of followers will be equal to a_1 + a_3 = 2;
- conclude contracts with bloggers with numbers 1 and 4. In this case, the number of followers will be equal to a_1 + a_4 = 2;
- conclude contracts with bloggers with numbers 2 and 3. In this case, the number of followers will be equal to a_2 + a_3 = 2;
- conclude contracts with bloggers with numbers 2 and 4. In this case, the number of followers will be equal to a_2 + a_4 = 2;
- conclude contracts with bloggers with numbers 3 and 4. In this case, the number of followers will be equal to a_3 + a_4 = 2.

In the third test case, the following ways are valid:

 - concludes a contract with a blogger with the number 2. In this case, the number of followers will be equal to a_2 = 2.', '[]',
  'c6a9cf5bc8e335c54396c2b96e4abb124d38dd3a4458017c5226232f693d3d60', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":24}',
  'resolve', NULL, 'backlog', NULL, '2026-08-09',
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
  'cp31-cf-1458-a', 'codeforces', '1458:A', 'https://codeforces.com/contest/1458/problem/A',
  'Row GCD', '1458', 'A',
  '1600', 'medium', '["math","number theory"]',
  'You are given two positive integer sequences a_1, \ldots, a_n and b_1, \ldots, b_m. For each j = 1, \ldots, m find the greatest common divisor of a_1 + b_j, \ldots, a_n + b_j.

## Input

The first line contains two integers n and m (1 \leq n, m \leq 2 \cdot 10^5).

The second line contains n integers a_1, \ldots, a_n (1 \leq a_i \leq 10^{18}).

The third line contains m integers b_1, \ldots, b_m (1 \leq b_j \leq 10^{18}).

## Output

Print m integers. The j-th of them should be equal to GCD(a_1 + b_j, \ldots, a_n + b_j).

## Example

Input

    4 4
    1 25 121 169
    1 2 7 23

Output

    2 3 8 24', '[]',
  'd868205862afea8a00f4d2fd9064261a355c2e539b097aa1ca9b17fa8fe8d8db', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":25}',
  'resolve', NULL, 'backlog', NULL, '2026-08-09',
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
  'cp31-cf-1407-c', 'codeforces', '1407:C', 'https://codeforces.com/contest/1407/problem/C',
  'Chocolate Bunny', '1407', 'C',
  '1600', 'medium', '["constructive algorithms","interactive","math","two pointers"]',
  'This is an interactive problem.

We hid from you a permutation p of length n, consisting of the elements from 1 to n. You want to guess it. To do that, you can give us 2 different indices i and j, and we will reply with p_{i} \bmod p_{j} (remainder of division p_{i} by p_{j}).

We have enough patience to answer at most 2 \cdot n queries, so you should fit in this constraint. Can you do it?

As a reminder, a permutation of length n is an array consisting of n distinct integers from 1 to n in arbitrary order. For example, [2,3,1,5,4] is a permutation, but [1,2,2] is not a permutation (2 appears twice in the array) and [1,3,4] is also not a permutation (n=3 but there is 4 in the array).

## Input

The only line of the input contains a single integer n (1 \le n \le 10^4) — length of the permutation.

## Interaction

The interaction starts with reading n.

Then you are allowed to make at most 2 \cdot n queries in the following way:

 - "? x y" (1 \le x, y \le n, x \ne y).

After each one, you should read an integer k, that equals p_x \bmod p_y.

When you have guessed the permutation, print a single line "! " (without quotes), followed by array p and quit.

After printing a query do not forget to output end of line and flush the output. Otherwise, you will get Idleness limit exceeded. To do this, use:

- fflush(stdout) or cout.flush() in C++;
- System.out.flush() in Java;
- flush(output) in Pascal;
- stdout.flush() in Python;
- see documentation for other languages.

Exit immediately after receiving "-1" and you will see Wrong answer verdict. Otherwise you can get an arbitrary verdict because your solution will continue to read from a closed stream.

Hack format

In the first line output n (1 \le n \le 10^4). In the second line print the permutation of n integers p_1, p_2, \ldots, p_n.

## Example

Input

    3
    
    1
    
    2
    
    1
    
    0

Output

    ? 1 2
    
    ? 3 2
    
    ? 1 3
    
    ? 2 1
    
    ! 1 3 2', '[]',
  '29ed72636f46b27926ec910dcca5dfa3c2988ded99ed93d0c3b163eab45d2508', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":26}',
  'resolve', NULL, 'backlog', NULL, '2026-08-10',
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
  'cp31-cf-1398-c', 'codeforces', '1398:C', 'https://codeforces.com/contest/1398/problem/C',
  'Good Subarrays', '1398', 'C',
  '1600', 'medium', '["data structures","dp","math"]',
  'You are given an array a_1, a_2, \dots , a_n consisting of integers from 0 to 9. A subarray a_l, a_{l+1}, a_{l+2}, \dots , a_{r-1}, a_r is good if the sum of elements of this subarray is equal to the length of this subarray (\sum\limits_{i=l}^{r} a_i = r - l + 1).

For example, if a = [1, 2, 0], then there are 3 good subarrays: a_{1 \dots 1} = [1], a_{2 \dots 3} = [2, 0] and a_{1 \dots 3} = [1, 2, 0].

Calculate the number of good subarrays of the array a.

## Input

The first line contains one integer t (1 \le t \le 1000) — the number of test cases.

The first line of each test case contains one integer n (1 \le n \le 10^5) — the length of the array a.

The second line of each test case contains a string consisting of n decimal digits, where the i-th digit is equal to the value of a_i.

It is guaranteed that the sum of n over all test cases does not exceed 10^5.

## Output

For each test case print one integer — the number of good subarrays of the array a.

## Example

Input

    3
    3
    120
    5
    11011
    6
    600005

Output

    3
    6
    1

## Note

The first test case is considered in the statement.

In the second test case, there are 6 good subarrays: a_{1 \dots 1}, a_{2 \dots 2}, a_{1 \dots 2}, a_{4 \dots 4}, a_{5 \dots 5} and a_{4 \dots 5}.

In the third test case there is only one good subarray: a_{2 \dots 6}.', '[]',
  'bf8ecece3cc79d7187c422cca848eaaca9a3402c024d88d787470e49519cc589', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":27}',
  'resolve', NULL, 'backlog', NULL, '2026-08-10',
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
  'cp31-cf-1389-b', 'codeforces', '1389:B', 'https://codeforces.com/contest/1389/problem/B',
  'Array Walk', '1389', 'B',
  '1600', 'medium', '["brute force","dp","greedy"]',
  'You are given an array a_1, a_2, \dots, a_n, consisting of n positive integers.

Initially you are standing at index 1 and have a score equal to a_1. You can perform two kinds of moves:

 - move right — go from your current index x to x+1 and add a_{x+1} to your score. This move can only be performed if x \lt n.
- move left — go from your current index x to x-1 and add a_{x-1} to your score. This move can only be performed if x \gt 1. Also, you can''t perform two or more moves to the left in a row.

You want to perform exactly k moves. Also, there should be no more than z moves to the left among them.

What is the maximum score you can achieve?

## Input

The first line contains a single integer t (1 \le t \le 10^4) — the number of testcases.

The first line of each testcase contains three integers n, k and z (2 \le n \le 10^5, 1 \le k \le n - 1, 0 \le z \le min(5, k)) — the number of elements in the array, the total number of moves you should perform and the maximum number of moves to the left you can perform.

The second line of each testcase contains n integers a_1, a_2, \dots, a_n (1 \le a_i \le 10^4) — the given array.

The sum of n over all testcases does not exceed 3 \cdot 10^5.

## Output

Print t integers — for each testcase output the maximum score you can achieve if you make exactly k moves in total, no more than z of them are to the left and there are no two or more moves to the left in a row.

## Example

Input

    4
    5 4 0
    1 5 4 3 2
    5 4 1
    1 5 4 3 2
    5 4 4
    10 20 30 40 50
    10 7 3
    4 6 8 2 9 9 7 4 10 9

Output

    15
    19
    150
    56

## Note

In the first testcase you are not allowed to move left at all. So you make four moves to the right and obtain the score a_1 + a_2 + a_3 + a_4 + a_5.

In the second example you can move one time to the left. So we can follow these moves: right, right, left, right. The score will be a_1 + a_2 + a_3 + a_2 + a_3.

In the third example you can move four times to the left but it''s not optimal anyway, you can just move four times to the right and obtain the score a_1 + a_2 + a_3 + a_4 + a_5.', '[]',
  '9a94c5e51d0887229788567135b28c69378c592f0b41f87efc15240e7de7e3cf', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":28}',
  'resolve', NULL, 'backlog', NULL, '2026-08-10',
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
  'cp31-cf-1349-a', 'codeforces', '1349:A', 'https://codeforces.com/contest/1349/problem/A',
  'Orac and LCM', '1349', 'A',
  '1600', 'medium', '["data structures","math","number theory"]',
  'For the multiset of positive integers s=\{s_1,s_2,\dots,s_k\}, define the Greatest Common Divisor (GCD) and Least Common Multiple (LCM) of s as follow:

- \gcd(s) is the maximum positive integer x, such that all integers in s are divisible on x.
- \textrm{lcm}(s) is the minimum positive integer x, that divisible on all integers from s.

For example, \gcd(\{8,12\})=4,\gcd(\{12,18,6\})=6 and \textrm{lcm}(\{4,6\})=12. Note that for any positive integer x, \gcd(\{x\})=\textrm{lcm}(\{x\})=x.

Orac has a sequence a with length n. He come up with the multiset t=\{\textrm{lcm}(\{a_i,a_j\})\ |\ i \lt j\}, and asked you to find the value of \gcd(t) for him. In other words, you need to calculate the GCD of LCMs of all pairs of elements in the given sequence.

## Input

The first line contains one integer n\ (2\le n\le 100\,000).

The second line contains n integers, a_1, a_2, \ldots, a_n (1 \leq a_i \leq 200\,000).

## Output

Print one integer: \gcd(\{\textrm{lcm}(\{a_i,a_j\})\ |\ i \lt j\}).

## Examples

Input

    2
    1 1

Output

    1

Input

    4
    10 24 40 80

Output

    40

Input

    10
    540 648 810 648 720 540 594 864 972 648

Output

    54

## Note

For the first example, t=\{\textrm{lcm}(\{1,1\})\}=\{1\}, so \gcd(t)=1.

For the second example, t=\{120,40,80,120,240,80\}, and it''s not hard to see that \gcd(t)=40.', '[]',
  '79bf084103d4ab754eadbc236d092c510050c8c51fb5987bb0cf2781a841ca8f', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":29}',
  'resolve', NULL, 'backlog', NULL, '2026-08-10',
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
  'cp31-cf-1337-c', 'codeforces', '1337:C', 'https://codeforces.com/contest/1337/problem/C',
  'Linova and Kingdom', '1337', 'C',
  '1600', 'medium', '["dfs and similar","dp","greedy","sortings","trees"]',
  'Writing light novels is the most important thing in Linova''s life. Last night, Linova dreamed about a fantastic kingdom. She began to write a light novel for the kingdom as soon as she woke up, and of course, she is the queen of it.

 

There are n cities and n-1 two-way roads connecting pairs of cities in the kingdom. From any city, you can reach any other city by walking through some roads. The cities are numbered from 1 to n, and the city 1 is the capital of the kingdom. So, the kingdom has a tree structure.

As the queen, Linova plans to choose exactly k cities developing industry, while the other cities will develop tourism. The capital also can be either industrial or tourism city.

A meeting is held in the capital once a year. To attend the meeting, each industry city sends an envoy. All envoys will follow the shortest path from the departure city to the capital (which is unique).

Traveling in tourism cities is pleasant. For each envoy, his happiness is equal to the number of tourism cities on his path.

In order to be a queen loved by people, Linova wants to choose k cities which can maximize the sum of happinesses of all envoys. Can you calculate the maximum sum for her?

## Input

The first line contains two integers n and k (2\le n\le 2 \cdot 10^5, 1\le k \lt  n)  — the number of cities and industry cities respectively.

Each of the next n-1 lines contains two integers u and v (1\le u,v\le n), denoting there is a road connecting city u and city v.

It is guaranteed that from any city, you can reach any other city by the roads.

## Output

Print the only line containing a single integer  — the maximum possible sum of happinesses of all envoys.

## Examples

Input

    7 4
    1 2
    1 3
    1 4
    3 5
    3 6
    4 7

Output

    7

Input

    4 1
    1 2
    1 3
    2 4

Output

    2

Input

    8 5
    7 5
    1 7
    6 1
    3 7
    8 3
    2 1
    4 5

Output

    9

## Note

In the first example, Linova can choose cities 2, 5, 6, 7 to develop industry, then the happiness of the envoy from city 2 is 1, the happiness of envoys from cities 5, 6, 7 is 2. The sum of happinesses is 7, and it can be proved to be the maximum one.

In the second example, choosing cities 3, 4 developing industry can reach a sum of 3, but remember that Linova plans to choose exactly k cities developing industry, then the maximum sum is 2.', '[{"alt":"Problem diagram","url":"https://espresso.codeforces.com/3c9feee64419eafec6d59e848358a3d2728c4ad0.png"},{"alt":"Problem diagram","url":"https://espresso.codeforces.com/7a08924d2561b29fde378ce67d0f080fb15b1427.png"},{"alt":"Problem diagram","url":"https://espresso.codeforces.com/3ee4308d6548160ed97deb712bdca868e244d1ae.png"}]',
  '48739c57923a178ed324723919095967b9e0095ea6ed4508193e843ddc54e68e', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":30}',
  'resolve', NULL, 'backlog', NULL, '2026-08-10',
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
