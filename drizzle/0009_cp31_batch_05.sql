INSERT INTO problems (
  id, platform, problem_key, url, title, contest, problem_index, rating,
  difficulty, official_tags_json, statement_markdown, statement_assets_json,
  statement_hash, statement_captured_at, metadata_status,
  metadata_provenance_json, legacy_metadata_json, import_source,
  import_provenance_json, review_status, state, status, archived_at, due_date,
  sprint_id, next_review_date, created_at, updated_at
) VALUES (
  'cp31-cf-1528-b', 'codeforces', '1528:B', 'https://codeforces.com/contest/1528/problem/B',
  'Kavi on Pairing Duty', '1528', 'B',
  '1700', 'medium', '["combinatorics","dp","math"]',
  'Kavi has 2n points lying on the OX axis, i-th of which is located at x = i.

Kavi considers all ways to split these 2n points into n pairs. Among those, he is interested in good pairings, which are defined as follows:

Consider n segments with ends at the points in correspondent pairs. The pairing is called good, if for every 2 different segments A and B among those, at least one of the following holds:

 - One of the segments A and B lies completely inside the other.
- A and B have the same length.

Consider the following example:

  

A is a good pairing since the red segment lies completely inside the blue segment.

B is a good pairing since the red and the blue segment have the same length.

C is not a good pairing since none of the red or blue segments lies inside the other, neither do they have the same size.

Kavi is interested in the number of good pairings, so he wants you to find it for him. As the result can be large, find this number modulo 998244353.

Two pairings are called different, if some two points are in one pair in some pairing and in different pairs in another.

## Input

The single line of the input contains a single integer n (1\le n \le 10^6).

## Output

Print the number of good pairings modulo 998244353.

## Examples

Input

    1

Output

    1

Input

    2

Output

    3

Input

    3

Output

    6

Input

    100

Output

    688750769

## Note

The good pairings for the second example are:

  

In the third example, the good pairings are:', '[{"alt":"Problem diagram","url":"https://espresso.codeforces.com/304e402bd9dd7ae582af7438150cff90ff28b317.png"},{"alt":"Problem diagram","url":"https://espresso.codeforces.com/0c345b16ff051eade409b0d573d36f7a818d6714.png"},{"alt":"Problem diagram","url":"https://espresso.codeforces.com/3fc6d4a86ba217fe99b35319fb8cbcd1d88e271b.png"}]',
  '9c4240bf6c86f48ce5a95238f8981da74afb9c0a0bbb42802d0b407039ce1814', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":30}',
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
  'cp31-cf-1516-c', 'codeforces', '1516:C', 'https://codeforces.com/contest/1516/problem/C',
  'Baby Ehab Partitions Again', '1516', 'C',
  '1700', 'medium', '["bitmasks","constructive algorithms","dp","math"]',
  'Baby Ehab was toying around with arrays. He has an array a of length n. He defines an array to be good if there''s no way to partition it into 2 subsequences such that the sum of the elements in the first is equal to the sum of the elements in the second. Now he wants to remove the minimum number of elements in a so that it becomes a good array. Can you help him?

A sequence b is a subsequence of an array a if b can be obtained from a by deleting some (possibly zero or all) elements. A partitioning of an array is a way to divide it into 2 subsequences such that every element belongs to exactly one subsequence, so you must use all the elements, and you can''t share any elements.

## Input

The first line contains an integer n (2 \le n \le 100) — the length of the array a.

The second line contains n integers a_1, a_2, \ldots, a_{n} (1 \le a_i \le 2000) — the elements of the array a.

## Output

The first line should contain the minimum number of elements you need to remove.

The second line should contain the indices of the elements you''re removing, separated by spaces.

We can show that an answer always exists. If there are multiple solutions, you can print any.

## Examples

Input

    4
    6 3 9 12

Output

    1
    2

Input

    2
    1 2

Output

    0

## Note

In the first example, you can partition the array into [6,9] and [3,12], so you must remove at least 1 element. Removing 3 is sufficient.

In the second example, the array is already good, so you don''t need to remove any elements.', '[]',
  '20eccb8c832a2fc5a1fe8e6281f5789cf9554e15f8810288f3132537ed1a2ba1', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":31}',
  'resolve', NULL, 'backlog', NULL, '2026-08-18',
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
  'cp31-cf-2022-c', 'codeforces', '2022:C', 'https://codeforces.com/contest/2022/problem/C',
  'Gerrymandering', '2022', 'C',
  '1800', 'medium', '["dp","implementation"]',
  'We all steal a little bit. But I have only one hand, while my adversaries have two.

Álvaro Obregón

Álvaro and José are the only candidates running for the presidency of Tepito, a rectangular grid of $$$2$$$ rows and $$$n$$$ columns, where each cell represents a house. It is guaranteed that $$$n$$$ is a multiple of $$$3$$$.

Under the voting system of Tepito, the grid will be split into districts, which consist of any $$$3$$$ houses that are connected$$$^{\text{∗}}$$$. Each house will belong to exactly one district.

Each district will cast a single vote. The district will vote for Álvaro or José respectively if at least $$$2$$$ houses in that district select them. Therefore, a total of $$$\frac{2n}{3}$$$ votes will be cast.

As Álvaro is the current president, he knows exactly which candidate each house will select. If Álvaro divides the houses into districts optimally, determine the maximum number of votes he can get.

$$$^{\text{∗}}$$$A set of cells is connected if there is a path between any $$$2$$$ cells that requires moving only up, down, left and right through cells in the set.

## Input

Each test contains multiple test cases. The first line contains the number of test cases $$$t$$$ ($$$1 \le t \le 10^4$$$). The description of the test cases follows.

The first line of each test case contains one integer $$$n$$$ ($$$3 \le n \le 10^5$$$; $$$n$$$ is a multiple of $$$3$$$) — the number of columns of Tepito.

The following two lines each contain a string of length $$$n$$$. The $$$i$$$-th line contains the string $$$s_i$$$, consisting of the characters $$$\texttt{A}$$$ and $$$\texttt{J}$$$. If $$$s_{i,j}=\texttt{A}$$$, the house in the $$$i$$$-th row and $$$j$$$-th column will select Álvaro. Otherwise if $$$s_{i,j}=\texttt{J}$$$, the house will select José.

It is guaranteed that the sum of $$$n$$$ over all test cases does not exceed $$$10^5$$$.

## Output

For each test case, output a single integer — the maximum number of districts Álvaro can win by optimally dividing the houses into districts.

## Example

Input

    4
    3
    AAA
    AJJ
    6
    JAJAJJ
    JJAJAJ
    6
    AJJJAJ
    AJJAAA
    9
    AJJJJAJAJ
    JAAJJJJJA

Output

    2
    2
    3
    2

## Note

The image below showcases the optimal arrangement of districts Álvaro can use for each test case in the example.', '[{"alt":"Problem diagram","url":"https://espresso.codeforces.com/201cafe7ad173f25765de51cfc513d2eb124be57.png"}]',
  'ffa23a0fc4c21e8f742b58a6e836cb545965b35d25ef966bff038c97d43efc71', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":1}',
  'resolve', NULL, 'backlog', NULL, '2026-08-19',
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
  'cp31-cf-2014-e', 'codeforces', '2014:E', 'https://codeforces.com/contest/2014/problem/E',
  'Rendez-vous de Marian et Robin', '2014', 'E',
  '1800', 'medium', '["dfs and similar","graphs","shortest paths"]',
  'In the humble act of meeting, joy doth unfold like a flower in bloom.

Absence makes the heart grow fonder. Marian sold her last ware at the Market at the same time Robin finished training at the Major Oak. They couldn''t wait to meet, so they both start without delay.

The travel network is represented as $$$n$$$ vertices numbered from $$$1$$$ to $$$n$$$ and $$$m$$$ edges. The $$$i$$$-th edge connects vertices $$$u_i$$$ and $$$v_i$$$, and takes $$$w_i$$$ seconds to travel (all $$$w_i$$$ are even). Marian starts at vertex $$$1$$$ (Market) and Robin starts at vertex $$$n$$$ (Major Oak).

In addition, $$$h$$$ of the $$$n$$$ vertices each has a single horse available. Both Marian and Robin are capable riders, and could mount horses in no time (i.e. in $$$0$$$ seconds). Travel times are halved when riding. Once mounted, a horse lasts the remainder of the travel. Meeting must take place on a vertex (i.e. not on an edge). Either could choose to wait on any vertex.

Output the earliest time Robin and Marian can meet. If vertices $$$1$$$ and $$$n$$$ are disconnected, output $$$-1$$$ as the meeting is cancelled.

## Input

The first line of the input contains a single integer $$$t$$$ ($$$1\leq t \leq 10^4$$$) — the number of test cases.

The first line of each test case consists of three integers $$$n$$$, $$$m$$$, $$$h$$$ ($$$2 \le n \le 2 \cdot 10^5, \;1 \le m \le 2 \cdot 10^5, \; 1 \le h \le n$$$) — the number of vertices, the number of edges and the number of vertices that have a single horse.

The second line of each test case contains $$$h$$$ distinct integers $$$a_1, a_2, \ldots, a_h$$$ ($$$1 \le a_i \le n$$$) — the vertices that have a single horse available.

Then follow $$$m$$$ lines of each test case, each with three integers $$$u_i$$$, $$$v_i$$$, $$$w_i$$$ ($$$1\le u_i,v_i \le n, \; 2\le w_i \le 10^6$$$) — meaning that there is an edge between vertices $$$u_i$$$ and $$$v_i$$$ with travel cost $$$w_i$$$ seconds without a horse.

There are no self loops or multiple edges. By good fortune, all $$$w_i$$$ are even integers.

It is guaranteed that the sums of both $$$n$$$ and $$$m$$$ over all test cases do not exceed $$$2 \cdot 10^5$$$.

## Output

For each test case, output a single integer, the earliest time Robin and Marian can meet. If it is impossible for them to meet, output $$$-1$$$.

## Example

Input

    6
    2 1 1
    1
    1 2 10
    3 1 2
    2 3
    1 2 10
    3 3 1
    2
    1 2 4
    1 3 10
    2 3 6
    4 3 2
    2 3
    1 2 10
    2 3 18
    3 4 16
    3 2 1
    2
    1 2 4
    1 3 16
    7 7 1
    3
    1 5 2
    2 6 12
    1 2 12
    6 4 8
    7 3 4
    6 3 4
    7 6 4

Output

    5
    -1
    6
    19
    14
    12

## Note

In the first test case, Marian rides from vertex $$$1$$$ to vertex $$$2$$$, Robin waits.

In the second test case, vertices $$$1$$$ and $$$3$$$ are not connected.

In the third test case, both Marian and Robin travel to vertex $$$2$$$ to meet.

In the fourth test case, Marian travels to vertex $$$2$$$ without a horse, mounts the horse at vertex $$$2$$$ and rides to vertex $$$3$$$ to meet Robin.

In the fifth test case, Marian travels to vertex $$$2$$$ without a horse, mounts the horse at vertex $$$2$$$ and rides back to vertex $$$1$$$ and then to vertex $$$3$$$. Robin waits.', '[]',
  '0ad4ed8acd73dbb2f8f5da5c6827eb256033ddb741bace23f646596c37bf2933', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":2}',
  'resolve', NULL, 'backlog', NULL, '2026-08-19',
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
  'cp31-cf-1974-e', 'codeforces', '1974:E', 'https://codeforces.com/contest/1974/problem/E',
  'Money Buys Happiness', '1974', 'E',
  '1800', 'medium', '["dp"]',
  'Being a physicist, Charlie likes to plan his life in simple and precise terms.

For the next $$$m$$$ months, starting with no money, Charlie will work hard and earn $$$x$$$ pounds per month. For the $$$i$$$-th month $$$(1 \le i \le m)$$$, there''ll be a single opportunity of paying cost $$$c_i$$$ pounds to obtain happiness $$$h_i$$$.

Borrowing is not allowed. Money earned in the $$$i$$$-th month can only be spent in a later $$$j$$$-th month ($$$j \gt i$$$).

Since physicists don''t code, help Charlie find the maximum obtainable sum of happiness.

## Input

The first line of input contains a single integer $$$t$$$ ($$$1 \le t \le 1000$$$) — the number of test cases.

The first line of each test case contains two integers, $$$m$$$ and $$$x$$$ ($$$1 \le m \le 50$$$, $$$1 \le x \le 10^8$$$) — the total number of months and the monthly salary.

The $$$i$$$-th of the following $$$m$$$ lines contains two integers, $$$c_i$$$ and $$$h_i$$$ ($$$0 \le c_i \le 10^8$$$, $$$1 \le h_i \le 10^3$$$) — the cost and happiness on offer for the $$$i$$$-th month. Note that some happiness may be free ($$$c_i=0$$$ for some $$$i$$$''s).

It is guaranteed that the sum of $$$\sum_i h_i$$$ over all test cases does not exceed $$$10^5$$$.

## Output

For each test case, print a single integer, the maximum sum of happiness Charlie could obtain.

## Example

Input

    7
    1 10
    1 5
    2 80
    0 10
    200 100
    3 100
    70 100
    100 200
    150 150
    5 8
    3 1
    5 3
    3 4
    1 5
    5 3
    2 5
    1 5
    2 1
    5 3
    2 5
    2 4
    4 1
    5 1
    3 4
    5 2
    2 1
    1 2
    3 5
    3 2
    3 2

Output

    0
    10
    200
    15
    1
    9
    9

## Note

In the first test case, Charlie only gets paid at the end of the month, so is unable to afford anything.

In the second test case, Charlie obtains the free happiness in the first month.

In the third test case, it''s optimal for Charlie to buy happiness in the second month. Even with money left at the end, Charlie could not go back in time to obtain the happiness on offer in the first month.', '[]',
  '6c4bd2d547e685f4c19fd970bcbadbf9d3058cb85ce9ea074ec3973639b05f82', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":3}',
  'resolve', NULL, 'backlog', NULL, '2026-08-19',
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
  'cp31-cf-1935-d', 'codeforces', '1935:D', 'https://codeforces.com/contest/1935/problem/D',
  'Exam in MAC', '1935', 'D',
  '1800', 'medium', '["binary search","combinatorics","implementation","math"]',
  'The Master''s Assistance Center has announced an entrance exam, which consists of the following.

The candidate is given a set $$$s$$$ of size $$$n$$$ and some strange integer $$$c$$$. For this set, it is needed to calculate the number of pairs of integers $$$(x, y)$$$ such that $$$0 \leq x \leq y \leq c$$$, $$$x + y$$$ is not contained in the set $$$s$$$, and also $$$y - x$$$ is not contained in the set $$$s$$$.

Your friend wants to enter the Center. Help him pass the exam!

## Input

Each test consists of multiple test cases. The first line contains a single integer $$$t$$$ ($$$1 \leq t \leq 2 \cdot 10^4$$$) — the number of test cases. The description of the test cases follows.

The first line of each test case contains two integers $$$n$$$ and $$$c$$$ ($$$1 \leq n \leq 3 \cdot 10^5$$$, $$$1 \leq c \leq 10^9$$$) — the size of the set and the strange integer.

The second line of each test case contains $$$n$$$ integers $$$s_1, s_2, \ldots, s_{n}$$$ ($$$0 \leq s_1  \lt  s_2  \lt  \ldots  \lt  s_{n} \leq c$$$) — the elements of the set $$$s$$$.

It is guaranteed that the sum of $$$n$$$ over all test cases does not exceed $$$3 \cdot 10^5$$$.

## Output

For each test case, output a single integer — the number of suitable pairs of integers.

## Example

Input

    8
    3 3
    1 2 3
    1 179
    57
    4 6
    0 3 5 6
    1 1
    1
    5 10
    0 2 4 8 10
    5 10
    1 3 5 7 9
    4 10
    2 4 6 7
    3 1000000000
    228 1337 998244353

Output

    3
    16139
    10
    2
    33
    36
    35
    499999998999122959

## Note

In the first test case, the following pairs are suitable: $$$(0, 0)$$$, $$$(2, 2)$$$, $$$(3, 3)$$$.

In the third test case, the following pairs are suitable: $$$(0, 1)$$$, $$$(0, 2)$$$, $$$(0, 4)$$$, $$$(1, 3)$$$, $$$(2, 6)$$$, $$$(3, 4)$$$, $$$(3, 5)$$$, $$$(4, 5)$$$, $$$(4, 6)$$$, $$$(5, 6)$$$.', '[]',
  'c9d2bb493ba644f6ba9073fa01579d185316b0d21f9a0bfdf79998059a7e8b14', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":4}',
  'resolve', NULL, 'backlog', NULL, '2026-08-19',
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
  'cp31-cf-1915-g', 'codeforces', '1915:G', 'https://codeforces.com/contest/1915/problem/G',
  'Bicycles', '1915', 'G',
  '1800', 'medium', '["graphs","greedy","implementation","shortest paths","sortings"]',
  'All of Slavic''s friends are planning to travel from the place where they live to a party using their bikes. And they all have a bike except Slavic. There are $$$n$$$ cities through which they can travel. They all live in the city $$$1$$$ and want to go to the party located in the city $$$n$$$. The map of cities can be seen as an undirected graph with $$$n$$$ nodes and $$$m$$$ edges. Edge $$$i$$$ connects cities $$$u_i$$$ and $$$v_i$$$ and has a length of $$$w_i$$$.

Slavic doesn''t have a bike, but what he has is money. Every city has exactly one bike for sale. The bike in the $$$i$$$-th city has a slowness factor of $$$s_{i}$$$. Once Slavic buys a bike, he can use it whenever to travel from the city he is currently in to any neighboring city, by taking $$$w_i \cdot s_j$$$ time, considering he is traversing edge $$$i$$$ using a bike $$$j$$$ he owns.

Slavic can buy as many bikes as he wants as money isn''t a problem for him. Since Slavic hates traveling by bike, he wants to get from his place to the party in the shortest amount of time possible. And, since his informatics skills are quite rusty, he asks you for help.

What''s the shortest amount of time required for Slavic to travel from city $$$1$$$ to city $$$n$$$? Slavic can''t travel without a bike. It is guaranteed that it is possible for Slavic to travel from city $$$1$$$ to any other city.

## Input

The first line contains a single integer $$$t$$$ ($$$1 \leq t \leq 100$$$) — the number of test cases. The description of the test cases follows.

The first line of each test case contains two space-separated integers $$$n$$$ and $$$m$$$ ($$$2 \leq n \leq 1000$$$; $$$n - 1 \leq m \leq 1000$$$) — the number of cities and the number of roads, respectively.

The $$$i$$$-th of the following $$$m$$$ lines each contain three integers $$$u_i$$$, $$$v_i$$$, $$$w_i$$$ ($$$1 \le u_i, v_i \le n$$$, $$$u_i \neq v_i$$$; $$$1 \leq w_i \leq 10^5$$$), denoting that there is a road between cities $$$u_i$$$ and $$$v_i$$$ of length $$$w_i$$$. The same pair of cities can be connected by more than one road.

The next line contains $$$n$$$ integers $$$s_1, \ldots, s_n$$$ ($$$1 \leq s_i \leq 1000$$$) — the slowness factor of each bike.

The sum of $$$n$$$ over all test cases does not exceed $$$1000$$$, and the sum of $$$m$$$ over all test cases does not exceed $$$1000$$$.

Additional constraint on the input: it is possible to travel from city $$$1$$$ to any other city.

## Output

For each test case, output a single integer denoting the shortest amount of time Slavic can reach city $$$n$$$ starting from city $$$1$$$.

## Example

Input

    3
    5 5
    1 2 2
    3 2 1
    2 4 5
    2 5 7
    4 5 1
    5 2 1 3 3
    5 10
    1 2 5
    1 3 5
    1 4 4
    1 5 8
    2 3 6
    2 4 3
    2 5 2
    3 4 1
    3 5 8
    4 5 2
    7 2 8 4 1
    7 10
    3 2 8
    2 1 4
    2 5 7
    2 6 4
    7 1 2
    4 3 5
    6 4 2
    6 7 1
    6 7 4
    4 5 9
    7 6 5 4 3 2 1

Output

    19
    36
    14', '[]',
  'e323d12733e5ecae09670c27360e39d000e9124b22a833ed01614c58c2169caf', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":5}',
  'resolve', NULL, 'backlog', NULL, '2026-08-19',
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
  'cp31-cf-1912-k', 'codeforces', '1912:K', 'https://codeforces.com/contest/1912/problem/K',
  'Kim''s Quest', '1912', 'K',
  '1800', 'medium', '["bitmasks","combinatorics","dp"]',
  'In the long-forgotten halls of Kombinatoria''s ancient academy, a gifted mathematician named Kim is faced with an unusual challenge. They found an old sequence of integers, which is believed to be a cryptic message from the legendary Kombinatoria''s Oracle, and Kim wants to decipher its hidden meaning.

Kim''s mission is to find specific patterns within the sequence, known as Harmonious Subsequences. These are extraordinary subsequences where the sum of every three consecutive numbers is even, and each subsequence must be at least three numbers in length.

Given a sequence $$$a_i$$$ ($$$1 \le i \le n$$$) of length $$$n$$$, its subsequence of length $$$m$$$ is equal to $$$a_{b_1}, a_{b_2}, \ldots, a_{b_m}$$$ and is uniquely defined by a set of $$$m$$$ indices $$$b_j$$$, such that $$$1 \le b_1  \lt  b_2  \lt  \ldots  \lt  b_m \le n$$$. Subsequences given by different sets of indices $$$b_j$$$ are considered different.

There''s a twist in Kim''s quest: the number of these Harmonious Subsequences could be overwhelming. To report the findings effectively, Kim must calculate the total number of these subsequences, presenting the answer as a remainder after dividing by the number $$$998\,244\,353$$$.

## Input

The first line contains a single integer $$$n$$$ — the length of the sequence ($$$3 \le n \le 2 \cdot 10^5$$$).

The second line contains $$$n$$$ space-separated integers $$$a_i$$$ — the elements of the sequence ($$$1 \le a_i \le 2 \cdot 10^5$$$).

## Output

Output one number — the number of Harmonious Subsequences, modulo $$$998\,244\,353$$$.

## Examples

Input

    3
    1 2 3

Output

    1

Input

    5
    2 8 2 6 4

Output

    16

Input

    5
    5 7 1 3 5

Output

    0

Input

    11
    3 1 4 1 5 9 2 6 5 3 6

Output

    386

Input

    54
    2 1 1 1 1 2 1 2 2 2 2 1 1 1 2 1 1 2
    2 1 2 2 2 2 2 2 2 1 1 1 2 2 1 1 1 1
    2 2 1 1 2 2 2 2 2 1 1 1 2 2 1 2 1 1

Output

    0

## Note

In the provided input data for the fifth sample, the sequence of numbers is split into three separate lines for clarity, but it should be understood that in the actual test data, the sequence is given in one line. The actual number of Harmonious Subsequences in this example is $$$4\,991\,221\,765 = 5 \times 998\,244\,353$$$, hence the output is zero as a result of finding its remainder after dividing by the number $$$998\,244\,353$$$.', '[]',
  '6fa4f3055c41419de53ad8508aaa795c4bccc1662f4c7c85b2c3795912e294dc', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":6}',
  'resolve', NULL, 'backlog', NULL, '2026-08-20',
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
  'cp31-cf-1824-b1', 'codeforces', '1824:B1', 'https://codeforces.com/contest/1824/problem/B1',
  'LuoTianyi and the Floating Islands (Easy Version)', '1824', 'B1',
  '1800', 'medium', '["combinatorics","math","probabilities","trees"]',
  'This is the easy version of the problem. The only difference is that in this version $$$k\le\min(n,3)$$$. You can make hacks only if both versions of the problem are solved.

     Chtholly and the floating islands. 

LuoTianyi now lives in a world with $$$n$$$ floating islands. The floating islands are connected by $$$n-1$$$ undirected air routes, and any two of them can reach each other by passing the routes. That means, the $$$n$$$ floating islands form a tree.

One day, LuoTianyi wants to meet her friends: Chtholly, Nephren, William, .... Totally, she wants to meet $$$k$$$ people. She doesn''t know the exact positions of them, but she knows that they are in pairwise distinct islands. She define an island is good if and only if the sum of the distances$$$^{\dagger}$$$ from it to the islands with $$$k$$$ people is the minimal among all the $$$n$$$ islands.

Now, LuoTianyi wants to know that, if the $$$k$$$ people are randomly set in $$$k$$$ distinct of the $$$n$$$ islands, then what is the expect number of the good islands? You just need to tell her the expect number modulo $$$10^9+7$$$.

$$$^{\dagger}$$$The distance between two islands is the minimum number of air routes you need to take to get from one island to the other.

## Input

The first line contains two integers $$$n$$$ and $$$k$$$ ($$$1\le k \le \min(n,3), 1\le n \le 2\cdot 10^5$$$) — the number of the islands and people respectively.

Next $$$n−1$$$ lines describe the air routes. The $$$i$$$-th of them contains two integers $$$u_i$$$ and $$$v_i$$$ ($$$1 \le u_i,v_i \le n, u_i \neq v_i$$$) — the islands connected by the $$$i$$$-th air route.

## Output

Print a single integer — the expect number of the good islands modulo $$$10^9 + 7$$$.

Formally, let $$$M = 10^9 + 7$$$. It can be shown that the answer can be expressed as an irreducible fraction $$$\frac{p}{q}$$$, where $$$p$$$ and $$$q$$$ are integers and $$$q \not \equiv 0$$$ ($$$\operatorname{mod} M$$$). Output the integer equal to $$$p \cdot q^{-1}$$$ $$$\operatorname{mod} M$$$. In other words, output such an integer $$$x$$$ that $$$0 \le x  \lt  M$$$ and $$$x \cdot q \equiv p$$$ ($$$\operatorname{mod} M$$$).

## Examples

Input

    4 2
    1 2
    2 3
    3 4

Output

    666666674

Input

    5 1
    1 2
    2 3
    3 4
    3 5

Output

    1

## Note

In the first example the air routes form the following tree:

     

If the people are in the islands $$$1$$$ and $$$2$$$, then islands $$$1$$$ and $$$2$$$ will be good.

The sum of the distances from island $$$1$$$ or $$$2$$$ to all the people is $$$1+0=1$$$, which is the minimal. While the sum of the distances from island $$$3$$$ to all the people is $$$2+1=3$$$, which is greater than $$$1$$$.

Like this, when the people are in island $$$1$$$ and $$$3$$$, then islands $$$1,2$$$ and $$$3$$$ will be good.

When the people are in islands $$$1$$$ and $$$4$$$, then islands $$$1,2,3$$$ and $$$4$$$ will be good.

When the people are in islands $$$2$$$ and $$$3$$$, then islands $$$2$$$ and $$$3$$$ will be good.

When the people are in islands $$$2$$$ and $$$4$$$, then islands $$$2,3$$$ and $$$4$$$ will be good.

When the people are in islands $$$3$$$ and $$$4$$$, then islands $$$3$$$ and $$$4$$$ will be good.

So the expect of the number of the good islands is $$$\frac{16}{6}$$$, which equals to $$$666666674$$$ modulo $$$10^9+7$$$.

In the second example the air routes form the following tree:

    

There is always the only good island, so the expected number is $$$1$$$.', '[{"alt":"Problem diagram","url":"https://espresso.codeforces.com/7f333c9e4caaaeb91bf9e9f4dec7834ac347c99e.png"},{"alt":"Problem diagram","url":"https://espresso.codeforces.com/bd181c06ef8f804b04e74dfb86151820ecf71365.png"},{"alt":"Problem diagram","url":"https://espresso.codeforces.com/6506d3d48ec469f47ab870658de54cb6820cf51f.png"}]',
  '97ed0980de0a1dbfb55acbd0e941e4af8b3fa4ad876be1900b72875b817a3286', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":7}',
  'resolve', NULL, 'backlog', NULL, '2026-08-20',
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
  'cp31-cf-1805-d', 'codeforces', '1805:D', 'https://codeforces.com/contest/1805/problem/D',
  'A Wide, Wide Graph', '1805', 'D',
  '1800', 'medium', '["dfs and similar","dp","graphs","greedy","trees"]',
  'You are given a tree (a connected graph without cycles) with $$$n$$$ vertices.

Consider a fixed integer $$$k$$$. Then, the graph $$$G_k$$$ is an undirected graph with $$$n$$$ vertices, where an edge between vertices $$$u$$$ and $$$v$$$ exists if and only if the distance between vertices $$$u$$$ and $$$v$$$ in the given tree is at least $$$k$$$.

For each $$$k$$$ from $$$1$$$ to $$$n$$$, print the number of connected components in the graph $$$G_k$$$.

## Input

The first line contains the integer $$$n$$$ ($$$2 \le n \le 10^5$$$) — the number of vertices in the graph.

Each of the next $$$n-1$$$ lines contains two integers $$$u$$$ and $$$v$$$ ($$$1 \le u, v \le n$$$), denoting an edge between vertices $$$u$$$ and $$$v$$$ in the tree. It is guaranteed that these edges form a valid tree.

## Output

Output $$$n$$$ integers: the number of connected components in the graph $$$G_k$$$ for each $$$k$$$ from $$$1$$$ to $$$n$$$.

## Examples

Input

    6
    1 2
    1 3
    2 4
    2 5
    3 6

Output

    1 1 2 4 6 6

Input

    5
    1 2
    2 3
    3 4
    3 5

Output

    1 1 3 5 5

## Note

In the first example: If $$$k=1$$$, the graph has an edge between each pair of vertices, so it has one component. If $$$k=4$$$, the graph has only edges $$$4 \leftrightarrow 6$$$ and $$$5 \leftrightarrow 6$$$, so the graph has $$$4$$$ components.

In the second example: when $$$k=1$$$ or $$$k=2$$$ the graph has one component. When $$$k=3$$$ the graph $$$G_k$$$ splits into $$$3$$$ components: one component has vertices $$$1$$$, $$$4$$$ and $$$5$$$, and two more components contain one vertex each. When $$$k=4$$$ or $$$k=5$$$ each vertex is a separate component.', '[]',
  '962d056c6418a514b9d4c9ba01367c76e1c53c9ca099cde5b597d97489d07d29', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":8}',
  'resolve', NULL, 'backlog', NULL, '2026-08-20',
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
  'cp31-cf-1775-d', 'codeforces', '1775:D', 'https://codeforces.com/contest/1775/problem/D',
  'Friendly Spiders', '1775', 'D',
  '1800', 'medium', '["dfs and similar","graphs","math","number theory","shortest paths"]',
  'Mars is home to an unusual species of spiders — Binary spiders.

Right now, Martian scientists are observing a colony of n spiders, the i-th of which has a_i legs.

Some of the spiders are friends with each other. Namely, the i-th and j-th spiders are friends if \gcd(a_i, a_j) \ne 1, i. e., there is some integer k \ge 2 such that a_i and a_j are simultaneously divided by k without a remainder. Here \gcd(x, y) denotes the greatest common divisor (GCD) of integers x and y.

Scientists have discovered that spiders can send messages. If two spiders are friends, then they can transmit a message directly in one second. Otherwise, the spider must pass the message to his friend, who in turn must pass the message to his friend, and so on until the message reaches the recipient.

Let''s look at an example.

Suppose a spider with eight legs wants to send a message to a spider with 15 legs. He can''t do it directly, because \gcd(8, 15) = 1. But he can send a message through the spider with six legs because \gcd(8, 6) = 2 and \gcd(6, 15) = 3. Thus, the message will arrive in two seconds.

Right now, scientists are observing how the s-th spider wants to send a message to the t-th spider. The researchers have a hypothesis that spiders always transmit messages optimally. For this reason, scientists would need a program that could calculate the minimum time to send a message and also deduce one of the optimal routes.

## Input

The first line of input contains an integer n (2 \le n \le 3\cdot10^5) — the number of spiders in the colony.

The second line of input contains n integers a_1, a_2, \ldots, a_n (1 \le a_i \le 3\cdot10^5) — the number of legs the spiders have.

The third line of input contains two integers s and t (1 \le s, t \le n) —the spiders between which the message must be sent.

## Output

If it is impossible to transmit a message between the given pair of spiders, print -1.

Otherwise, in the first line of the output print the integer t (t \ge 1) — the number of spiders that participate in the message transmission (i. e. the minimum time of message delivery in seconds plus one). In the second line, print t different integers b_1, b_2, \ldots, b_t (1 \le b_i \le n) — the ids of the spiders through which the message should follow, in order from sender to receiver.

If there are several optimal routes for the message, output any of them.

## Examples

Input

    7
    2 14 9 6 8 15 11
    5 6

Output

    3
    5 4 6

Input

    7
    2 14 9 6 8 15 11
    5 7

Output

    -1

Input

    7
    2 14 9 6 8 15 11
    5 5

Output

    1
    5

## Note

The first example is shown above. It shows that the message from the 5-th spider (with eight legs) to the 6-th spider (with 15 legs) is optimal to pass through the 4-th spider (with six legs).

In the second example, the spider number 7 (with 11 legs) is not friends with anyone, so it is impossible to send him a message.', '[{"alt":"Problem diagram","url":"https://espresso.codeforces.com/fc0717c0aa9818e770d2cb5049c62d4b9ee6e4d6.png"}]',
  '167d090da37e9d2d3edbeb2dce32f402cade2f558c4cb92a1bfeab7dc4e2c2f2', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":9}',
  'resolve', NULL, 'backlog', NULL, '2026-08-20',
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
  'cp31-cf-1768-d', 'codeforces', '1768:D', 'https://codeforces.com/contest/1768/problem/D',
  'Lucky Permutation', '1768', 'D',
  '1800', 'medium', '["constructive algorithms","dfs and similar","graphs","greedy"]',
  'You are given a permutation^\dagger p of length n.

In one operation, you can choose two indices 1 \le i  \lt  j \le n and swap p_i with p_j.

Find the minimum number of operations needed to have exactly one inversion^\ddagger in the permutation.

^\dagger A permutation is an array consisting of n distinct integers from 1 to n in arbitrary order. For example, [2,3,1,5,4] is a permutation, but [1,2,2] is not a permutation (2 appears twice in the array), and [1,3,4] is also not a permutation (n=3 but there is 4 in the array).

^\ddagger The number of inversions of a permutation p is the number of pairs of indices (i, j) such that 1 \le i  \lt  j \le n and p_i  \gt  p_j.

## Input

The first line contains a single integer t (1 \le t \le 10^4) — the number of test cases. The description of test cases follows.

The first line of each test case contains a single integer n (2 \le n \le 2 \cdot 10^5).

The second line of each test case contains n integers p_1,p_2,\ldots, p_n (1 \le p_i \le n). It is guaranteed that p is a permutation.

It is guaranteed that the sum of n over all test cases does not exceed 2 \cdot 10^5.

## Output

For each test case output a single integer — the minimum number of operations needed to have exactly one inversion in the permutation. It can be proven that an answer always exists.

## Example

Input

    4
    2
    2 1
    2
    1 2
    4
    3 4 1 2
    4
    2 4 3 1

Output

    0
    1
    3
    1

## Note

In the first test case, the permutation already satisfies the condition.

In the second test case, you can perform the operation with (i,j)=(1,2), after that the permutation will be [2,1] which has exactly one inversion.

In the third test case, it is not possible to satisfy the condition with less than 3 operations. However, if we perform 3 operations with (i,j) being (1,3),(2,4), and (3,4) in that order, the final permutation will be [1, 2, 4, 3] which has exactly one inversion.

In the fourth test case, you can perform the operation with (i,j)=(2,4), after that the permutation will be [2,1,3,4] which has exactly one inversion.', '[]',
  'db286ac309c91d18bf1e55333e765460c20748d62e3f5140ca9e190c2556a600', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":10}',
  'resolve', NULL, 'backlog', NULL, '2026-08-20',
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
  'cp31-cf-1732-c1', 'codeforces', '1732:C1', 'https://codeforces.com/contest/1732/problem/C1',
  'Sheikh (Easy version)', '1732', 'C1',
  '1800', 'medium', '["binary search","bitmasks","greedy","two pointers"]',
  'This is the easy version of the problem. The only difference is that in this version q = 1.

You are given an array of integers a_1, a_2, \ldots, a_n.

The cost of a subsegment of the array [l, r], 1 \leq l \leq r \leq n, is the value f(l, r) = \operatorname{sum}(l, r) - \operatorname{xor}(l, r), where \operatorname{sum}(l, r) = a_l + a_{l+1} + \ldots + a_r, and \operatorname{xor}(l, r) = a_l \oplus a_{l+1} \oplus \ldots \oplus a_r (\oplus stands for bitwise XOR).

You will have q = 1 query. Each query is given by a pair of numbers L_i, R_i, where 1 \leq L_i \leq R_i \leq n. You need to find the subsegment [l, r], L_i \leq l \leq r \leq R_i, with maximum value f(l, r). If there are several answers, then among them you need to find a subsegment with the minimum length, that is, the minimum value of r - l + 1.

## Input

Each test consists of multiple test cases. The first line contains an integer t (1 \leq t \leq 10^4) — the number of test cases. The description of test cases follows.

The first line of each test case contains two integers n and q (1 \leq n \leq 10^5, q = 1) — the length of the array and the number of queries.

The second line of each test case contains n integers a_1, a_2, \ldots, a_n (0 \leq a_i \leq 10^9) — array elements.

i-th of the next q lines of each test case contains two integers L_i and R_i (1 \leq L_i \leq R_i \leq n) — the boundaries in which we need to find the segment.

It is guaranteed that the sum of n over all test cases does not exceed 2 \cdot 10^5.

It is guaranteed that L_1 = 1 and R_1 = n.

## Output

For each test case print q pairs of numbers L_i \leq l \leq r \leq R_i such that the value f(l, r) is maximum and among such the length r - l + 1 is minimum. If there are several correct answers, print any of them.

## Example

Input

    6
    1 1
    0
    1 1
    2 1
    5 10
    1 2
    3 1
    0 2 4
    1 3
    4 1
    0 12 8 3
    1 4
    5 1
    21 32 32 32 10
    1 5
    7 1
    0 1 0 1 0 1 0
    1 7

Output

    1 1
    1 1
    1 1
    2 3
    2 3
    2 4

## Note

In the first test case, f(1, 1) = 0 - 0 = 0.

In the second test case, f(1, 1) = 5 - 5 = 0, f(2, 2) = 10 - 10 = 0. Note that f(1, 2) = (10 + 5) - (10 \oplus 5) = 0, but we need to find a subsegment with the minimum length among the maximum values of f(l, r). So, only segments [1, 1] and [2, 2] are the correct answers.

In the fourth test case, f(2, 3) = (12 + 8) - (12 \oplus 8) = 16.

There are two correct answers in the fifth test case, since f(2, 3) = f(3, 4) and their lengths are equal.', '[]',
  '93e99c719c13ee21eae1d174750bf3176145457f21710b2ae8685aa88dc2a984', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":11}',
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
  'cp31-cf-1725-m', 'codeforces', '1725:M', 'https://codeforces.com/contest/1725/problem/M',
  'Moving Both Hands', '1725', 'M',
  '1800', 'medium', '["dp","graphs","shortest paths"]',
  'Pak Chanek is playing one of his favourite board games. In the game, there is a directed graph with N vertices and M edges. In the graph, edge i connects two different vertices U_i and V_i with a length of W_i. By using the i-th edge, something can move from U_i to V_i, but not from V_i to U_i.

To play this game, initially Pak Chanek must place both of his hands onto two different vertices. In one move, he can move one of his hands to another vertex using an edge. To move a hand from vertex U_i to vertex V_i, Pak Chanek needs a time of W_i seconds. Note that Pak Chanek can only move one hand at a time. This game ends when both of Pak Chanek''s hands are on the same vertex.

Pak Chanek has several questions. For each p satisfying 2 \leq p \leq N, you need to find the minimum time in seconds needed for Pak Chanek to end the game if initially Pak Chanek''s left hand and right hand are placed on vertex 1 and vertex p, or report if it is impossible.

## Input

The first line contains two integers N and M (2 \leq N \leq 10^5, 0 \leq M \leq 2 \cdot 10^5) — the number of vertices and edges in the graph.

The i-th of the next M lines contains three integers U_i, V_i, and W_i (1 \le U_i, V_i \le N, U_i \neq V_i, 1 \le W_i \le 10^9) — a directed edge that connects two different vertices U_i and V_i with a length of W_i. There is no pair of different edges i and j such that U_i = U_j and V_i = V_j.

## Output

Output a line containing N-1 integers. The j-th integer represents the minimum time in seconds needed by Pak Chanek to end the game if initially Pak Chanek''s left hand and right hand are placed on vertex 1 and vertex j+1, or -1 if it is impossible.

## Example

Input

    5 7
    1 2 2
    2 4 1
    4 1 4
    2 5 3
    5 4 1
    5 2 4
    2 1 1

Output

    1 -1 3 4

## Note

If initially Pak Chanek''s left hand is on vertex 1 and his right hand is on vertex 5, Pak Chanek can do the following moves:

 - Move his right hand to vertex 4 in 1 second.
- Move his left hand to vertex 2 in 2 seconds.
- Move his left hand to vertex 4 in 1 second.

In total it needs 1+2+1=4 seconds. It can be proven that there is no other way that is faster.', '[{"alt":"Problem diagram","url":"https://espresso.codeforces.com/464d2c6c030b9a4294cf9ed10125aaef76a87c92.png"}]',
  '89e4a560488abff824545d9caf4612803881311e03c59c3eeed46aa6011a4d30', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":12}',
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
  'cp31-cf-1709-c', 'codeforces', '1709:C', 'https://codeforces.com/contest/1709/problem/C',
  'Recover an RBS', '1709', 'C',
  '1800', 'medium', '["constructive algorithms","greedy","implementation","strings"]',
  'A bracket sequence is a string containing only characters "(" and ")". A regular bracket sequence (or, shortly, an RBS) is a bracket sequence that can be transformed into a correct arithmetic expression by inserting characters "1" and "+" between the original characters of the sequence. For example:

 - bracket sequences "()()" and "(())" are regular (the resulting expressions are: "(1)+(1)" and "((1+1)+1)");
- bracket sequences ")(", "(" and ")" are not.

There was an RBS. Some brackets have been replaced with question marks. Is it true that there is a unique way to replace question marks with brackets, so that the resulting sequence is an RBS?

## Input

The first line contains a single integer t (1 \le t \le 5 \cdot 10^4) — the number of testcases.

The only line of each testcase contains an RBS with some brackets replaced with question marks. Each character is either ''('', '')'' or ''?''. At least one RBS can be recovered from the given sequence.

The total length of the sequences over all testcases doesn''t exceed 2 \cdot 10^5.

## Output

For each testcase, print "YES" if the way to replace question marks with brackets, so that the resulting sequence is an RBS, is unique. If there is more than one way, then print "NO".

## Example

Input

    5
    (?))
    ??????
    ()
    ??
    ?(?)()?)

Output

    YES
    NO
    YES
    YES
    NO

## Note

In the first testcase, the only possible original RBS is "(())".

In the second testcase, there are multiple ways to recover an RBS.

In the third and the fourth testcases, the only possible original RBS is "()".

In the fifth testcase, the original RBS can be either "((()()))" or "(())()()".', '[]',
  '74d64c4d1940c035307d46eb40031fa320e7bed74fcc1fc31416a0cb219d93d9', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":13}',
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
