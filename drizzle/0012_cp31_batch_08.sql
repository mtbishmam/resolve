INSERT INTO problems (
  id, platform, problem_key, url, title, contest, problem_index, rating,
  difficulty, official_tags_json, statement_markdown, statement_assets_json,
  statement_hash, statement_captured_at, metadata_status,
  metadata_provenance_json, legacy_metadata_json, import_source,
  import_provenance_json, review_status, state, status, archived_at, due_date,
  sprint_id, next_review_date, created_at, updated_at
) VALUES (
  'cp31-cf-1925-d', 'codeforces', '1925:D', 'https://codeforces.com/contest/1925/problem/D',
  'Good Trip', '1925', 'D',
  '1900', 'medium', '["combinatorics","dp","math","probabilities"]',
  'There are $$$n$$$ children in a class, $$$m$$$ pairs among them are friends. The $$$i$$$-th pair who are friends have a friendship value of $$$f_i$$$.

The teacher has to go for $$$k$$$ excursions, and for each of the excursions she chooses a pair of children randomly, equiprobably and independently. If a pair of children who are friends is chosen, their friendship value increases by $$$1$$$ for all subsequent excursions (the teacher can choose a pair of children more than once). The friendship value of a pair who are not friends is considered $$$0$$$, and it does not change for subsequent excursions.

Find the expected value of the sum of friendship values of all $$$k$$$ pairs chosen for the excursions (at the time of being chosen). It can be shown that this answer can always be expressed as a fraction $$$\dfrac{p}{q}$$$ where $$$p$$$ and $$$q$$$ are coprime integers. Calculate $$$p\cdot q^{-1} \bmod (10^9+7)$$$.

## Input

Each test contains multiple test cases. The first line contains the number of test cases $$$t$$$ ($$$1 \le t \le 5 \cdot 10^4$$$). Description of the test cases follows.

The first line of each test case contains $$$3$$$ integers $$$n$$$, $$$m$$$ and $$$k$$$ ($$$2 \le n \le 10^5$$$, $$$0 \le m \le \min \Big(10^5$$$, $$$ \frac{n(n-1)}{2} \Big)$$$, $$$1 \le k \le 2 \cdot 10^5$$$) — the number of children, pairs of friends and excursions respectively.

The next $$$m$$$ lines contain three integers each — $$$a_i$$$, $$$b_i$$$, $$$f_i$$$ — the indices of the pair of children who are friends and their friendship value. ($$$a_i \neq b_i$$$, $$$1 \le a_i,b_i \le n$$$, $$$1 \le f_i \le 10^9$$$). It is guaranteed that all pairs of friends are distinct.

It is guaranteed that the sum of $$$n$$$ and sum $$$m$$$ over all test cases does not exceed $$$10^5$$$ and the sum of $$$k$$$ over all test cases does not exceed $$$2 \cdot 10^5$$$.

## Output

For each test case, print one integer — the answer to the problem.

## Example

Input

    4
    100 0 24
    2 1 10
    1 2 1
    3 1 2
    2 1 1
    5 2 4
    1 2 25
    3 2 24

Output

    0
    55
    777777784
    40000020

## Note

For the first test case, there are no pairs of friends, so the friendship value of all pairs is $$$0$$$ and stays $$$0$$$ for subsequent rounds, hence the friendship value for all excursions is $$$0$$$.

For the second test case, there is only one pair possible $$$(1, 2)$$$ and its friendship value is initially $$$1$$$, so each turn they are picked and their friendship value increases by $$$1$$$. Therefore, the total sum is $$$1+2+3+\ldots+10 = 55$$$.

For the third test case, the final answer is $$$\frac{7}{9} = 777\,777\,784\bmod (10^9+7)$$$.', '[]',
  '070f117af7e0fcb753440de2fe4dc5621a39198d4e0d2dd89c0c2ced779de25a', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":13}',
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
  'cp31-cf-1918-d', 'codeforces', '1918:D', 'https://codeforces.com/contest/1918/problem/D',
  'Blocking Elements', '1918', 'D',
  '1900', 'medium', '["binary search","data structures","dp","implementation","two pointers"]',
  'You are given an array of numbers $$$a_1, a_2, \ldots, a_n$$$. Your task is to block some elements of the array in order to minimize its cost. Suppose you block the elements with indices $$$1 \leq b_1  \lt  b_2  \lt  \ldots  \lt  b_m \leq n$$$. Then the cost of the array is calculated as the maximum of:

 - the sum of the blocked elements, i.e., $$$a_{b_1} + a_{b_2} + \ldots + a_{b_m}$$$.
- the maximum sum of the segments into which the array is divided when the blocked elements are removed. That is, the maximum sum of the following ($$$m + 1$$$) subarrays: [$$$1, b_1 − 1$$$], [$$$b_1 + 1, b_2 − 1$$$], [$$$\ldots$$$], [$$$b_{m−1} + 1, b_m - 1$$$], [$$$b_m + 1, n$$$] (the sum of numbers in a subarray of the form [$$$x,x − 1$$$] is considered to be $$$0$$$).

For example, if $$$n = 6$$$, the original array is [$$$1, 4, 5, 3, 3, 2$$$], and you block the elements at positions $$$2$$$ and $$$5$$$, then the cost of the array will be the maximum of the sum of the blocked elements ($$$4 + 3 = 7$$$) and the sums of the subarrays ($$$1$$$, $$$5 + 3 = 8$$$, $$$2$$$), which is $$$\max(7,1,8,2) = 8$$$.

You need to output the minimum cost of the array after blocking.

## Input

The first line of the input contains a single integer $$$t$$$ ($$$1 \leq t \leq 30\,000$$$) — the number of queries.

Each test case consists of two lines. The first line contains an integer $$$n$$$ ($$$1 \leq n \leq 10^5$$$) — the length of the array $$$a$$$. The second line contains $$$n$$$ elements $$$a_1, a_2, \ldots, a_n$$$ ($$$1 \leq a_i \leq 10^9$$$) — the array $$$a$$$.

It is guaranteed that the sum of $$$n$$$ over all test cases does not exceed $$$10^5$$$.

## Output

For each test case, output a single number — the minimum cost of blocking the array.

## Example

Input

    3
    6
    1 4 5 3 3 2
    5
    1 2 3 4 5
    6
    4 1 6 3 10 7

Output

    7
    5
    11

## Note

The first test case matches with the array from the statement. To obtain a cost of $$$7$$$, you need to block the elements at positions $$$2$$$ and $$$4$$$. In this case, the cost of the array is calculated as the maximum of:

 - the sum of the blocked elements, which is $$$a_2 + a_4 = 7$$$.
- the maximum sum of the segments into which the array is divided when the blocked elements are removed, i.e., the maximum of $$$a_1$$$, $$$a_3$$$, $$$a_5 + a_6 = \max(1,5,5) = 5$$$.

So the cost is $$$\max(7,5) = 7$$$.

In the second test case, you can block the elements at positions $$$1$$$ and $$$4$$$.

In the third test case, to obtain the answer $$$11$$$, you can block the elements at positions $$$2$$$ and $$$5$$$. There are other ways to get this answer, for example, blocking positions $$$4$$$ and $$$6$$$.', '[]',
  '6c2def6831c09b6ad7ec5cc08c0d3a7c8825830fad43c06864426ac62732ddaf', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":14}',
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
  'cp31-cf-1912-a', 'codeforces', '1912:A', 'https://codeforces.com/contest/1912/problem/A',
  'Accumulator Apex', '1912', 'A',
  '1900', 'medium', '["data structures","implementation","sortings"]',
  'Allyn is playing a new strategy game called "Accumulator Apex". In this game, Allyn is given the initial value of an integer $$$x$$$, referred to as the accumulator, and $$$k$$$ lists of integers. Allyn can make multiple turns. On each turn, Allyn can withdraw the leftmost element from any non-empty list and add it to the accumulator $$$x$$$ if the resulting $$$x$$$ is non-negative. Allyn can end the game at any moment. The goal of the game is to get the largest possible value of the accumulator $$$x$$$. Please help Allyn find the largest possible value of the accumulator $$$x$$$ they can get in this game.

## Input

The first line of the input contains two integers $$$x$$$ and $$$k$$$ ($$$0 \leq x \leq 10^9, 1 \leq k \leq 10^5$$$) — the initial value of the accumulator $$$x$$$ and the number of lists. The next $$$k$$$ lines contain the description of lists: an integer $$$l_i$$$ ($$$l_i \ge 1$$$) followed on the same line by $$$l_i$$$ elements of the list in the order from left to right. Each element of lists does not exceed $$$10^9$$$ by the absolute value, and the total size of all lists does not exceed $$$10^5$$$.

## Output

The sole line of the output should contain the largest value of the accumulator $$$x$$$ Allyn can get.

## Examples

Input

    1 3
    2 -1 2
    2 -2 3
    2 -3 4

Output

    4

Input

    1 2
    3 -1 -1 4
    4 1 -3 -4 8

Output

    4

## Note

In the first input, we start with $$$x = 1$$$. Then, we can take the first integer from the first list and get $$$x = 0$$$ — adding the next integer $$$2$$$ from the first list we get $$$x = 2$$$. After that, we can add the integers from the second list and obtain $$$x = 3$$$. Finally, we can add the integers from the third list and obtain $$$x = 4$$$.

In the second input, we can add the first integer from the second list and get $$$x = 2$$$. Then, by adding the elements from the first list, we get $$$x = 4$$$. We cannot add more integers to increase $$$x$$$.', '[]',
  '24bd1660a7e6cc6924ee3399ca9ebfb0d25dd7d298f6a0fa0532817a33fd2166', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":15}',
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
  'cp31-cf-1906-e', 'codeforces', '1906:E', 'https://codeforces.com/contest/1906/problem/E',
  'Merge Not Sort', '1906', 'E',
  '1900', 'medium', '["constructive algorithms","dp"]',
  'You are currently researching the Merge Sort algorithm. Merge Sort is a sorting algorithm that is based on the principle of Divide and Conquer. It works by dividing an array into two subarrays of equal length, sorting each subarrays, then merging the sorted subarrays back together to form the final sorted array.

You are particularly interested in the merging routine. Common merge implementation will combine two subarrays by iteratively comparing their first elements, and move the smaller one to a new merged array. More precisely, the merge algorithm can be presented by the following pseudocode.

    
        Merge(A[1..N], B[1..N]):
            C = []
            i = 1
            j = 1
            while i <= N AND j <= N:
                if A[i] < B[j]:
                    append A[i] to C
                    i = i + 1
                else:
                    append B[j] to C
                    j = j + 1 
            while i <= N:
                append A[i] to C
                i = i + 1 
            while j <= N:
                append B[j] to C
                j = j + 1 
            return C
    

During your research, you are keen to understand the behaviour of the merge algorithm when arrays $$$A$$$ and $$$B$$$ are not necessarily sorted. For example, if $$$A = [3, 1, 6]$$$ and $$$B = [4, 5, 2]$$$, then $$$\text{Merge}(A, B) = [3, 1, 4, 5, 2, 6]$$$.

To further increase the understanding of the merge algorithm, you decided to work on the following problem. You are given an array $$$C$$$ of length $$$2 \cdot N$$$ such that it is a permutation of $$$1$$$ to $$$2 \cdot N$$$. Construct any two arrays $$$A$$$ and $$$B$$$ of the same length $$$N$$$, such that $$$\text{Merge}(A, B) = C$$$, or determine if it is impossible to do so.

## Input

The first line consists of an integer $$$N$$$ ($$$1 \leq N \leq 1000$$$).

The following line consists of $$$2 \cdot N$$$ integers $$$C_i$$$. The array $$$C$$$ is a permutation of $$$1$$$ to $$$2 \cdot N$$$.

## Output

If it is impossible to construct two arrays $$$A$$$ and $$$B$$$ of length $$$N$$$ such that $$$\text{Merge}(A, B) = C$$$, then output -1.

Otherwise, output the arrays $$$A$$$ and $$$B$$$ in two lines. The first line consists of $$$N$$$ integers $$$A_i$$$. The second line consists of $$$N$$$ integers $$$B_i$$$. If there are several possible answers, output any of them.

## Examples

Input

    3
    3 1 4 5 2 6

Output

    3 1 6
    4 5 2

Input

    4
    1 2 3 4 5 6 7 8

Output

    2 3 5 7
    1 4 6 8

Input

    2
    4 3 2 1

Output

    -1

## Note

Explanation for the sample input/output #1

The solution $$$A = [3, 1, 4]$$$ and $$$B = [5, 2, 6]$$$ is also correct.

Explanation for the sample input/output #2

The solution $$$A = [1, 2, 3, 4]$$$ and $$$B = [5, 6, 7, 8]$$$ is also correct.', '[]',
  '2406fb7201c3904faa7073370746f59b98ceb7667a2a74176d6950926ad2164a', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":16}',
  'resolve', NULL, 'backlog', NULL, '2026-08-29',
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
  'cp31-cf-1902-e', 'codeforces', '1902:E', 'https://codeforces.com/contest/1902/problem/E',
  'Collapsing Strings', '1902', 'E',
  '1900', 'medium', '["data structures","strings","trees"]',
  'You are given $$$n$$$ strings $$$s_1, s_2, \dots, s_n$$$, consisting of lowercase Latin letters. Let $$$|x|$$$ be the length of string $$$x$$$.

Let a collapse $$$C(a, b)$$$ of two strings $$$a$$$ and $$$b$$$ be the following operation:

 - if $$$a$$$ is empty, $$$C(a, b) = b$$$;
- if $$$b$$$ is empty, $$$C(a, b) = a$$$;
- if the last letter of $$$a$$$ is equal to the first letter of $$$b$$$, then $$$C(a, b) = C(a_{1,|a|-1}, b_{2,|b|})$$$, where $$$s_{l,r}$$$ is the substring of $$$s$$$ from the $$$l$$$-th letter to the $$$r$$$-th one;
- otherwise, $$$C(a, b) = a + b$$$, i. e. the concatenation of two strings.

Calculate $$$\sum\limits_{i=1}^n \sum\limits_{j=1}^n |C(s_i, s_j)|$$$.

## Input

The first line contains a single integer $$$n$$$ ($$$1 \le n \le 10^6$$$).

Each of the next $$$n$$$ lines contains a string $$$s_i$$$ ($$$1 \le |s_i| \le 10^6$$$), consisting of lowercase Latin letters.

The total length of the strings doesn''t exceed $$$10^6$$$.

## Output

Print a single integer — $$$\sum\limits_{i=1}^n \sum\limits_{j=1}^n |C(s_i, s_j)|$$$.

## Examples

Input

    3
    aba
    ab
    ba

Output

    20

Input

    5
    abab
    babx
    xab
    xba
    bab

Output

    126', '[]',
  'b9b08d3354800d759caacc55cd6085838781c7699563fb634e22063f2ce6188e', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":17}',
  'resolve', NULL, 'backlog', NULL, '2026-08-29',
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
  'cp31-cf-1898-d', 'codeforces', '1898:D', 'https://codeforces.com/contest/1898/problem/D',
  'Absolute Beauty', '1898', 'D',
  '1900', 'medium', '["greedy","math"]',
  'Kirill has two integer arrays $$$a_1,a_2,\ldots,a_n$$$ and $$$b_1,b_2,\ldots,b_n$$$ of length $$$n$$$. He defines the absolute beauty of the array $$$b$$$ as $$$$$$\sum_{i=1}^{n} |a_i - b_i|.$$$$$$ Here, $$$|x|$$$ denotes the absolute value of $$$x$$$.

Kirill can perform the following operation at most once:

 - select two indices $$$i$$$ and $$$j$$$ ($$$1 \leq i  \lt  j \leq n$$$) and swap the values of $$$b_i$$$ and $$$b_j$$$.

Help him find the maximum possible absolute beauty of the array $$$b$$$ after performing at most one swap.

## Input

Each test contains multiple test cases. The first line contains the number of test cases $$$t$$$ ($$$1 \leq t \leq 10\,000$$$). The description of test cases follows.

The first line of each test case contains a single integer $$$n$$$ ($$$2\leq n\leq 2\cdot 10^5$$$) — the length of the arrays $$$a$$$ and $$$b$$$.

The second line of each test case contains $$$n$$$ integers $$$a_1, a_2, \ldots, a_n$$$ ($$$1\leq a_i\leq 10^9$$$) — the array $$$a$$$.

The third line of each test case contains $$$n$$$ integers $$$b_1, b_2, \ldots, b_n$$$ ($$$1\leq b_i\leq 10^9$$$) — the array $$$b$$$.

It is guaranteed that the sum of $$$n$$$ over all test cases does not exceed $$$2\cdot 10^5$$$.

## Output

For each test case, output one integer — the maximum possible absolute beauty of the array $$$b$$$ after no more than one swap.

## Example

Input

    6
    3
    1 3 5
    3 3 3
    2
    1 2
    1 2
    2
    1 2
    2 1
    4
    1 2 3 4
    5 6 7 8
    10
    1 8 2 5 3 5 3 1 1 3
    2 9 2 4 8 2 3 5 3 1
    3
    47326 6958 358653
    3587 35863 59474

Output

    4
    2
    2
    16
    31
    419045

## Note

In the first test case, each of the possible swaps does not change the array $$$b$$$.

In the second test case, the absolute beauty of the array $$$b$$$ without performing the swap is $$$|1-1| + |2-2| = 0$$$. After swapping the first and the second element in the array $$$b$$$, the absolute beauty becomes $$$|1-2| + |2-1| = 2$$$. These are all the possible outcomes, hence the answer is $$$2$$$.

In the third test case, it is optimal for Kirill to not perform the swap. Similarly to the previous test case, the answer is $$$2$$$.

In the fourth test case, no matter what Kirill does, the absolute beauty of $$$b$$$ remains equal to $$$16$$$.', '[]',
  '346e60f368be7a91083fa705f92b34c1859addcb042045c9a7f4cd2dd2b99b31', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":18}',
  'resolve', NULL, 'backlog', NULL, '2026-08-29',
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
  'cp31-cf-1882-d', 'codeforces', '1882:D', 'https://codeforces.com/contest/1882/problem/D',
  'Tree XOR', '1882', 'D',
  '1900', 'medium', '["bitmasks","dfs and similar","dp","greedy","trees"]',
  'You are given a tree with $$$n$$$ vertices labeled from $$$1$$$ to $$$n$$$. An integer $$$a_{i}$$$ is written on vertex $$$i$$$ for $$$i = 1, 2, \ldots, n$$$. You want to make all $$$a_{i}$$$ equal by performing some (possibly, zero) spells.

Suppose you root the tree at some vertex. On each spell, you can select any vertex $$$v$$$ and any non-negative integer $$$c$$$. Then for all vertices $$$i$$$ in the subtree$$$^{\dagger}$$$ of $$$v$$$, replace $$$a_{i}$$$ with $$$a_{i} \oplus c$$$. The cost of this spell is $$$s \cdot c$$$, where $$$s$$$ is the number of vertices in the subtree. Here $$$\oplus$$$ denotes the bitwise XOR operation.

Let $$$m_r$$$ be the minimum possible total cost required to make all $$$a_i$$$ equal, if vertex $$$r$$$ is chosen as the root of the tree. Find $$$m_{1}, m_{2}, \ldots, m_{n}$$$.

$$$^{\dagger}$$$ Suppose vertex $$$r$$$ is chosen as the root of the tree. Then vertex $$$i$$$ belongs to the subtree of $$$v$$$ if the simple path from $$$i$$$ to $$$r$$$ contains $$$v$$$.

## Input

Each test contains multiple test cases. The first line contains the number of test cases $$$t$$$ ($$$1 \le t \le 10^{4}$$$). The description of the test cases follows.

The first line of each test case contains a single integer $$$n$$$ ($$$1 \le n \le 2 \cdot 10^{5}$$$).

The second line of each test case contains $$$n$$$ integers $$$a_1, a_2, \ldots, a_n$$$ ($$$0 \le a_i  \lt  2^{20}$$$).

Each of the next $$$n-1$$$ lines contains two integers $$$u$$$ and $$$v$$$ ($$$1 \le u, v \le n$$$), denoting that there is an edge connecting two vertices $$$u$$$ and $$$v$$$.

It is guaranteed that the given edges form a tree.

It is guaranteed that the sum of $$$n$$$ over all test cases does not exceed $$$2 \cdot 10^{5}$$$.

## Output

For each test case, print $$$m_1, m_2, \ldots, m_n$$$ on a new line.

## Example

Input

    2
    4
    3 2 1 0
    1 2
    2 3
    2 4
    1
    100

Output

    8 6 12 10 
    0

## Note

In the first test case, to find $$$m_1$$$ we root the tree at vertex $$$1$$$.

 - In the first spell, choose $$$v=2$$$ and $$$c=1$$$. After performing the spell, $$$a$$$ will become $$$[3, 3, 0, 1]$$$. The cost of this spell is $$$3$$$.
- In the second spell, choose $$$v=3$$$ and $$$c=3$$$. After performing the spell, $$$a$$$ will become $$$[3, 3, 3, 1]$$$. The cost of this spell is $$$3$$$.
- In the third spell, choose $$$v=4$$$ and $$$c=2$$$. After performing the spell, $$$a$$$ will become $$$[3, 3, 3, 3]$$$. The cost of this spell is $$$2$$$.

Now all the values in array $$$a$$$ are equal, and the total cost is $$$3 + 3 + 2 = 8$$$.

The values $$$m_2$$$, $$$m_3$$$, $$$m_4$$$ can be found analogously.

In the second test case, the goal is already achieved because there is only one vertex.', '[]',
  'c4cbbdbba2ee86dd861d98ed733405ac77a23e0801be1a98c3407e84af47cc18', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":19}',
  'resolve', NULL, 'backlog', NULL, '2026-08-29',
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
  'cp31-cf-1842-d', 'codeforces', '1842:D', 'https://codeforces.com/contest/1842/problem/D',
  'Tenzing and His Animal Friends', '1842', 'D',
  '1900', 'medium', '["constructive algorithms","graphs","greedy"]',
  'Tell a story about me and my animal friends.

Tenzing has $$$n$$$ animal friends. He numbers them from $$$1$$$ to $$$n$$$.

One day Tenzing wants to play with his animal friends. To do so, Tenzing will host several games.

In one game, he will choose a set $$$S$$$ which is a subset of $$$\{1,2,3,...,n\}$$$ and choose an integer $$$t$$$. Then, he will play the game with the animals in $$$S$$$ for $$$t$$$ minutes.

But there are some restrictions:

 - Tenzing loves friend $$$1$$$ very much, so $$$1$$$ must be an element of $$$S$$$.
- Tenzing doesn''t like friend $$$n$$$, so $$$n$$$ must not be an element of $$$S$$$.
- There are m additional restrictions. The $$$i$$$-th special restriction is described by integers $$$u_i$$$, $$$v_i$$$ and $$$y_i$$$, suppose $$$x$$$ is the total time that exactly one of $$$u_i$$$ and $$$v_i$$$ is playing with Tenzing. Tenzing must ensure that $$$x$$$ is less or equal to $$$y_i$$$. Otherwise, there will be unhappiness.

Tenzing wants to know the maximum total time that he can play with his animal friends. Please find out the maximum total time that Tenzing can play with his animal friends and a way to organize the games that achieves this maximum total time, or report that he can play with his animal friends for an infinite amount of time. Also, Tenzing does not want to host so many games, so he will host at most $$$n^2$$$ games.

## Input

The first line of input contains two integers $$$n$$$ and $$$m$$$ ($$$2 \leq n \leq 100$$$, $$$0 \leq m \leq \frac{n(n-1)}{2}$$$) — the number of animal friends and the number of special restrictions.

The $$$i$$$-th of the following $$$m$$$ lines of input contains three integers $$$u_i$$$, $$$v_i$$$ and $$$y_i$$$ ($$$1\leq u_i \lt v_i\leq n$$$, $$$0\leq y_i\leq 10^9$$$) — describing the $$$i$$$-th special restriction. It is guaranteed that for $$$1 \leq i  \lt  j \leq m$$$, $$$(u_i,v_i) \neq (u_j,v_j)$$$.

## Output

If Tenzing can play with his animal friends for an infinite amount of time, output "inf". (Output without quotes.)

Otherwise, in the first line, output the total time $$$T$$$ ($$$0 \leq t \leq 10^{18}$$$) and the number of games $$$k$$$ ($$$0 \leq k \leq n^2$$$).

In the following $$$k$$$ lines of output, output a binary string $$$s$$$ of length $$$n$$$ and an integer $$$t$$$ ($$$0 \leq t \leq 10^{18}$$$) — representing the set $$$S$$$ and the number of minutes this game will be played. If $$$s_i=\texttt{1}$$$, then $$$i \in S$$$, otherwise if $$$s_i=\texttt{0}$$$, then $$$i \notin S$$$.

Under the constraints of this problem, it can be proven that if Tenzing can only play with his friends for a finite amount of time, then he can only play with them for at most $$$10^{18}$$$ minutes.

## Examples

Input

    5 4
    1 3 2
    1 4 2
    2 3 1
    2 5 1

Output

    4 4
    10000 1
    10010 1
    10100 1
    11110 1

Input

    3 0

Output

    inf

## Note

In the first test case:

 - Tenzing will host a game with friend $$$\{1\}$$$ for $$$1$$$ minute.
- Tenzing will host a game with friends $$$\{1,4\}$$$ for $$$1$$$ minute.
- Tenzing will host a game with friends $$$\{1,3\}$$$ for $$$1$$$ minute.
- Tenzing will host a game with friends $$$\{1,2,3,4\}$$$ for $$$1$$$ minute.

If after that, Tenzing host another game with friends $$$\{1,2\}$$$ for $$$1$$$ minute. Then the time of exactly one of friends $$$2$$$ or $$$3$$$ with Tenzing will becomes $$$2$$$ minutes which will not satisfy the $$$3$$$-rd special restriction.

In the second test case, there is no special restrictions. So Tenzing can host a game with friend $$$\{1\}$$$ for an infinite amount of time.', '[]',
  '782023580101ddf16c61e41b6f18cf81c3d8717e58b70b9a84b2b322eb228a66', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":20}',
  'resolve', NULL, 'backlog', NULL, '2026-08-29',
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
  'cp31-cf-1820-d', 'codeforces', '1820:D', 'https://codeforces.com/contest/1820/problem/D',
  'The Butcher', '1820', 'D',
  '1900', 'medium', '["brute force","data structures","implementation","sortings","two pointers"]',
  'Anton plays his favorite game "Defense of The Ancients 2" for his favorite hero — The Butcher. Now he wants to make his own dinner. To do this he will take a rectangle of height $$$h$$$ and width $$$w$$$, then make a vertical or horizontal cut so that both resulting parts have integer sides. After that, he will put one of the parts in the box and cut the other again, and so on.

More formally, a rectangle of size $$$h \times w$$$ can be cut into two parts of sizes $$$x \times w$$$ and $$$(h - x) \times w$$$, where $$$x$$$ is an integer from $$$1$$$ to $$$(h - 1)$$$, or into two parts of sizes $$$h \times y$$$ and $$$h \times (w - y)$$$, where $$$y$$$ is an integer from $$$1$$$ to $$$(w - 1)$$$.

He will repeat this operation $$$n - 1$$$ times, and then put the remaining rectangle into the box too. Thus, the box will contain $$$n$$$ rectangles, of which $$$n - 1$$$ rectangles were put in the box as a result of the cuts, and the $$$n$$$-th rectangle is the one that the Butcher has left after all $$$n - 1$$$ cuts.

Unfortunately, Butcher forgot the numbers $$$h$$$ and $$$w$$$, but he still has $$$n$$$ rectangles mixed in random order. Note that Butcher didn''t rotate the rectangles, but only shuffled them. Now he wants to know all possible pairs $$$(h, w)$$$ from which this set of rectangles can be obtained. And you have to help him do it!

It is guaranteed that there exists at least one pair $$$(h, w)$$$ from which this set of rectangles can be obtained.

## Input

Each test consists of multiple test cases. The first line contains a single integer $$$t$$$ ($$$1 \le t \le 10^4$$$) — the number of test cases. The description of test cases follows.

The first line of each test case contains a single integer $$$n$$$ ($$$1 \le n \le 2 \cdot 10^5$$$) — the number of rectangles obtained.

The $$$i$$$-th of the next $$$n$$$ lines contains two integers $$$a_i$$$ and $$$b_i$$$ ($$$1 \le a_i, b_i \le 10^6$$$) — the height and width of the $$$i$$$-th rectangle.

It is guaranteed that the sum of $$$n$$$ over all test cases does not exceed $$$2 \cdot 10^5$$$.

## Output

For each test case, on the first line output a single integer $$$m$$$ — the number of pairs $$$(h, w)$$$ denoting the sizes of rectangles from which the given rectangles can be obtained. Two rectangles are considered different if they have different heights or widths.

On each of the following $$$m$$$ lines print output integers $$$h_i$$$ and $$$w_i$$$ — the height and width of the rectangle from which the given rectangles can be obtained. You can output the rectangles in any order.

## Example

Input

    4
    3
    1 2
    3 5
    1 3
    3
    1 1
    1 1
    1 1
    1
    10 10
    4
    3 2
    5 5
    2 2
    8 7

Output

    1
    4 5
    2
    1 3
    3 1
    1
    10 10
    1
    13 7

## Note

In the first test case, Butcher could only have a rectangle of size $$$4 \times 5$$$. Then the cuts could look like this (first the green cut was made, then the red one):

  

In the second test case, Butcher could have either a rectangle of $$$1 \times 3$$$ or $$$3 \times 1$$$. The cuts would have looked like this (first the green cut was made, then the red cut):

  

In the third test case, Butcher did not make any cuts, so the rectangle is $$$10 \times 10$$$.', '[{"alt":"Problem diagram","url":"https://espresso.codeforces.com/9775e0102a78191a35fe439c0e66f50bf52f8aef.png"},{"alt":"Problem diagram","url":"https://espresso.codeforces.com/6e90d25875f6c63953ac6a855e538b7e6347e696.png"}]',
  'abe09a4bb501a553d606db3a2b590dd6749a7f6fd34bdf211f703e8183b8fcb3', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":21}',
  'resolve', NULL, 'backlog', NULL, '2026-08-30',
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
  'cp31-cf-1817-b', 'codeforces', '1817:B', 'https://codeforces.com/contest/1817/problem/B',
  'Fish Graph', '1817', 'B',
  '1900', 'medium', '["brute force","constructive algorithms","dfs and similar","graphs"]',
  'You are given a simple undirected graph with $$$n$$$ nodes and $$$m$$$ edges. Note that the graph is not necessarily connected. The nodes are labeled from $$$1$$$ to $$$n$$$.

We define a graph to be a Fish Graph if it contains a simple cycle with a special node $$$u$$$ belonging to the cycle. Apart from the edges in the cycle, the graph should have exactly $$$2$$$ extra edges. Both edges should connect to node $$$u$$$, but they should not be connected to any other node of the cycle.

Determine if the graph contains a subgraph that is a Fish Graph, and if so, find any such subgraph.

In this problem, we define a subgraph as a graph obtained by taking any subset of the edges of the original graph.

     Visualization of example 1. The red edges form one possible subgraph that is a Fish Graph.

## Input

The first line of input contains the integer $$$t$$$ ($$$1 \leq t \leq 1000$$$), the number of test cases. The description of test cases follows.

The first line of each test case contains two integers, $$$n$$$ and $$$m$$$ ($$$1 \le n, m \le 2\,000$$$) — the number of nodes and the number of edges.

Each of the next $$$m$$$ lines contains the description of an edge. Each line contains two integers $$$u_i$$$ and $$$v_i$$$ ($$$1 \leq u_i, v_i \leq n$$$, $$$u_i\neq v_i$$$) — an edge connects node $$$u_i$$$ to node $$$v_i$$$.

It is guaranteed that no two edges connect the same unordered pair of nodes.

Furthermore, it is guaranteed that the sum of $$$n$$$ and the sum of $$$m$$$ over all test cases both do not exceed $$$2\,000$$$.

## Output

For each testcase, output "YES" if the graph contains a subgraph that is a Fish Graph, otherwise print "NO". If the answer is "YES", on the following lines output a description of the subgraph.

The first line of the description contains one integer $$$k$$$ — the number of edges of the subgraph.

On the next $$$k$$$ lines, output the edges of the chosen subgraph. Each of the $$$k$$$ lines should contains two integers $$$u$$$ and $$$v$$$ ($$$1\le u, v\le n$$$, $$$u\neq v$$$) — the edge between $$$u$$$ and $$$v$$$ belongs to the subgraph. The order in which $$$u$$$ and $$$v$$$ are printed does not matter, as long as the two nodes are connected by an edge in the original graph. The order in which you print the edges does not matter, as long as the resulting subgraph is a fish graph.

If there are multiple solutions, print any.

## Example

Input

    3
    7 8
    1 2
    2 3
    3 4
    4 1
    4 5
    4 6
    4 2
    6 7
    7 7
    6 7
    1 2
    2 3
    3 4
    4 1
    1 3
    3 5
    4 4
    1 3
    3 4
    4 1
    1 2

Output

    YES
    6
    5 4
    6 4
    4 3
    1 4
    2 1
    3 2
    YES
    5
    5 3
    2 3
    3 1
    4 3
    1 4
    NO

## Note

In the first example, a possible valid subgraph contains the cycle $$$1 \rightarrow 2 \rightarrow 3 \rightarrow 4 \rightarrow 1$$$. The special node of this cycle is node $$$4$$$. The two extra edges $$$4 - 5$$$ and $$$4 - 6$$$ are both connected to $$$4$$$, completing the Fish Graph.

In the second example, a possible valid subgraph contains the cycle $$$1 \rightarrow 3 \rightarrow 4 \rightarrow 1$$$. The special node of this cycle is node $$$3$$$. The two extra edges $$$3 - 2$$$ and $$$3 - 5$$$ are both connected to $$$3$$$, completing the Fish Graph.

In the last example, it can be proven that there is no valid subgraph.', '[{"alt":"Problem diagram","url":"https://espresso.codeforces.com/d4948becce5d44359306c804c5e536e116fca5cd.png"}]',
  '42b2c7ed56a23b7e8fb44527df933ebf63255b7dda453ca4f4b2e0492573669c', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":22}',
  'resolve', NULL, 'backlog', NULL, '2026-08-30',
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
  'cp31-cf-1799-d1', 'codeforces', '1799:D1', 'https://codeforces.com/contest/1799/problem/D1',
  'Hot Start Up (easy version)', '1799', 'D1',
  '1900', 'medium', '["dp"]',
  'This is an easy version of the problem. The constraints of $$$t$$$, $$$n$$$, $$$k$$$ are the only difference between versions.

You have a device with two CPUs. You also have $$$k$$$ programs, numbered $$$1$$$ through $$$k$$$, that you can run on the CPUs.

The $$$i$$$-th program ($$$1 \le i \le k$$$) takes $$$cold_i$$$ seconds to run on some CPU. However, if the last program we ran on this CPU was also program $$$i$$$, it only takes $$$hot_i$$$ seconds ($$$hot_i \le cold_i$$$). Note that this only applies if we run program $$$i$$$ multiple times consecutively  — if we run program $$$i$$$, then some different program, then program $$$i$$$ again, it will take $$$cold_i$$$ seconds the second time.

You are given a sequence $$$a_1, a_2, \ldots, a_n$$$ of length $$$n$$$, consisting of integers from $$$1$$$ to $$$k$$$. You need to use your device to run programs $$$a_1, a_2, \ldots, a_n$$$ in sequence. For all $$$2 \le i \le n$$$, you cannot start running program $$$a_i$$$ until program $$$a_{i - 1}$$$ has completed.

Find the minimum amount of time needed to run all programs $$$a_1, a_2, \ldots, a_n$$$ in sequence.

## Input

Input consists of multiple test cases. The first line contains a single integer $$$t$$$, the number of test cases ($$$1 \le t \le 5000$$$).

The first line of each test case contains $$$n$$$ and $$$k$$$ ($$$1 \le n, k \le 5000$$$).

The second line of each test case contains $$$n$$$ integers $$$a_1, a_2, \ldots, a_n$$$ ($$$1 \le a_i \le k$$$).

The third line of each test case contains $$$k$$$ integers $$$cold_1, cold_2, \ldots, cold_k$$$ ($$$1 \le cold_i \le 10^9$$$).

The fourth line of each test case contains $$$k$$$ integers $$$hot_1, hot_2, \ldots, hot_k$$$ ($$$1 \le hot_i \le cold_i$$$).

It is guaranteed the sum of $$$n$$$ and the sum of $$$k$$$ over all test cases do not exceed $$$5000$$$.

## Output

For each test case, print the minimum time needed to run all programs in the given order.

## Example

Input

    9
    3 2
    1 2 2
    3 2
    2 1
    4 2
    1 2 1 2
    5 3
    2 1
    4 3
    1 2 3 1
    100 100 100
    1 1 1
    5 2
    2 1 2 1 1
    65 45
    54 7
    5 3
    1 3 2 1 2
    2 2 2
    1 1 1
    5 1
    1 1 1 1 1
    1000000000
    999999999
    5 6
    1 6 1 4 1
    3 6 4 1 4 5
    1 1 1 1 4 1
    1 3
    3
    4 5 6
    1 2 3
    8 3
    3 3 3 1 2 3 2 1
    10 10 8
    10 10 5

Output

    6
    11
    301
    225
    8
    4999999996
    11
    6
    63

## Note

In the first test case, we can do the following:

 - Run program $$$a_1 = 1$$$ on CPU $$$1$$$. It takes $$$cold_1 = 3$$$ seconds to run.
- Run program $$$a_2 = 2$$$ on CPU $$$2$$$. It takes $$$cold_2 = 2$$$ seconds to run.
- Run program $$$a_3 = 2$$$ on CPU $$$2$$$. The last program run on this CPU was also program $$$2$$$, so it takes $$$hot_2 = 1$$$ second to run.

In total, we need $$$3 + 2 + 1 = 6$$$ seconds to run them all. We can show this is optimal.

In the second test case, we can use do the following:

 - Run program $$$a_1 = 1$$$ on CPU $$$1$$$. It takes $$$cold_1 = 5$$$ seconds to run.
- Run program $$$a_2 = 2$$$ on CPU $$$2$$$. It takes $$$cold_2 = 3$$$ seconds to run.
- Run program $$$a_3 = 1$$$ on CPU $$$1$$$. The last program run on this CPU was also program $$$1$$$, so it takes $$$hot_1 = 2$$$ seconds to run.
- Run program $$$a_4 = 2$$$ on CPU $$$2$$$. The last program run on this CPU was also program $$$2$$$, so it takes $$$hot_2 = 1$$$ second to run.

In total, we need $$$5 + 3 + 2 + 1 = 11$$$ seconds. We can show this is optimal.', '[]',
  'a8f7613af11ea7c3581b98d6d23172e057edc6a7f0eac411627c3ae9774e32aa', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":23}',
  'resolve', NULL, 'backlog', NULL, '2026-08-30',
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
  'cp31-cf-1794-d', 'codeforces', '1794:D', 'https://codeforces.com/contest/1794/problem/D',
  'Counting Factorizations', '1794', 'D',
  '1900', 'medium', '["combinatorics","divide and conquer","dp","math","number theory"]',
  'The prime factorization of a positive integer $$$m$$$ is the unique way to write it as $$$\displaystyle m=p_1^{e_1}\cdot p_2^{e_2}\cdot \ldots \cdot p_k^{e_k}$$$, where $$$p_1, p_2, \ldots, p_k$$$ are prime numbers, $$$p_1  \lt  p_2  \lt  \ldots  \lt  p_k$$$ and $$$e_1, e_2, \ldots, e_k$$$ are positive integers.

For each positive integer $$$m$$$, $$$f(m)$$$ is defined as the multiset of all numbers in its prime factorization, that is $$$f(m)=\{p_1,e_1,p_2,e_2,\ldots,p_k,e_k\}$$$.

For example, $$$f(24)=\{2,3,3,1\}$$$, $$$f(5)=\{1,5\}$$$ and $$$f(1)=\{\}$$$.

You are given a list consisting of $$$2n$$$ integers $$$a_1, a_2, \ldots, a_{2n}$$$. Count how many positive integers $$$m$$$ satisfy that $$$f(m)=\{a_1, a_2, \ldots, a_{2n}\}$$$. Since this value may be large, print it modulo $$$998\,244\,353$$$.

## Input

The first line contains one integer $$$n$$$ ($$$1\le n \le 2022$$$).

The second line contains $$$2n$$$ integers $$$a_1, a_2, \ldots, a_{2n}$$$ ($$$1\le a_i\le 10^6$$$)  — the given list.

## Output

Print one integer, the number of positive integers $$$m$$$ satisfying $$$f(m)=\{a_1, a_2, \ldots, a_{2n}\}$$$ modulo $$$998\,244\,353$$$.

## Examples

Input

    2
    1 3 2 3

Output

    2

Input

    2
    2 2 3 5

Output

    5

Input

    1
    1 4

Output

    0

## Note

In the first sample, the two values of $$$m$$$ such that $$$f(m)=\{1,2,3,3\}$$$ are $$$m=24$$$ and $$$m=54$$$. Their prime factorizations are $$$24=2^3\cdot 3^1$$$ and $$$54=2^1\cdot 3^3$$$.

In the second sample, the five values of $$$m$$$ such that $$$f(m)=\{2,2,3,5\}$$$ are $$$200, 225, 288, 500$$$ and $$$972$$$.

In the third sample, there is no value of $$$m$$$ such that $$$f(m)=\{1,4\}$$$. Neither $$$1^4$$$ nor $$$4^1$$$ are prime factorizations because $$$1$$$ and $$$4$$$ are not primes.', '[]',
  '980de5c7e453b9984c45fa4c0e9ec8ccdb439d2af27875c847daad355013704a', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":24}',
  'resolve', NULL, 'backlog', NULL, '2026-08-30',
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
  'cp31-cf-1777-d', 'codeforces', '1777:D', 'https://codeforces.com/contest/1777/problem/D',
  'Score of a Tree', '1777', 'D',
  '1900', 'medium', '["bitmasks","combinatorics","dfs and similar","dp","math","probabilities","trees"]',
  'You are given a tree of $$$n$$$ nodes, rooted at $$$1$$$. Every node has a value of either $$$0$$$ or $$$1$$$ at time $$$t=0$$$.

At any integer time $$$t \gt 0$$$, the value of a node becomes the bitwise XOR of the values of its children at time $$$t - 1$$$; the values of leaves become $$$0$$$ since they don''t have any children.

Let $$$S(t)$$$ denote the sum of values of all nodes at time $$$t$$$.

Let $$$F(A)$$$ denote the sum of $$$S(t)$$$ across all values of $$$t$$$ such that $$$0 \le t \le 10^{100}$$$, where $$$A$$$ is the initial assignment of $$$0$$$s and $$$1$$$s in the tree.

The task is to find the sum of $$$F(A)$$$ for all $$$2^n$$$ initial configurations of $$$0$$$s and $$$1$$$s in the tree. Print the sum modulo $$$10^9+7$$$.

## Input

Each test contains multiple test cases. The first line contains the number of test cases $$$t$$$ ($$$1 \le t \le 10^5$$$). The description of the test cases follows.

The first line of each test case contains $$$n$$$ ($$$1 \le n \le 2 \cdot 10^5$$$) — the number of nodes in the tree.

The next $$$n-1$$$ lines of each test case contain two integers each — $$$u$$$, $$$v$$$ indicating an edge between $$$u$$$ and $$$v$$$ ($$$1 \le u, v \le n$$$).

It is guaranteed that the sum of $$$n$$$ over all test cases does not exceed $$$2 \cdot 10^5$$$.

## Output

Output the sum modulo $$$10^9+7$$$ for each test case.

## Example

Input

    1
    6
    1 2
    1 3
    3 4
    3 5
    3 6

Output

    288

## Note

Let us find $$$F(A)$$$ for the configuration $$$A = [0,1,0,0,1,1]$$$ ($$$A[i]$$$ denotes the value of node $$$i$$$). Initially (at $$$t = 0$$$) our tree is as shown in the picture below. In each node, two values are shown: the number and the value of this node. $$$S(0)$$$ for this configuration is $$$3$$$.

  

At $$$t = 1$$$ the configuration changes to $$$[1,0,0,0,0,0]$$$. The tree looks as shown below. $$$S(1) = 1$$$.

  

At $$$t = 2$$$ the configuration changes to $$$[0,0,0,0,0,0]$$$. The tree looks as shown below. $$$S(2) = 0$$$.

  

For all $$$t \gt 2$$$, the graph remains unchanged, so $$$S(t)=0$$$ for all $$$t  \gt  2$$$. So, for the initial configuration $$$A = [0,1,0,0,1,1]$$$, the value of $$$F(A) = 3 + 1 = 4$$$.

Doing this process for all possible $$$2^{6}$$$ configurations yields us an answer of $$$\textbf{288}$$$.', '[{"alt":"Problem diagram","url":"https://espresso.codeforces.com/329312e5ee6230e401caf8cc6acb8966fb3de20c.png"},{"alt":"Problem diagram","url":"https://espresso.codeforces.com/27f10509e64a1c19104e13cc38a0cd12dba77155.png"},{"alt":"Problem diagram","url":"https://espresso.codeforces.com/7419ba8701bcbe3a03851e2650736635e5e3794c.png"}]',
  'c97e26bb645792f11de40c01ceb494f06e0e9085a8db843c6fcd268a1d259f46', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":25}',
  'resolve', NULL, 'backlog', NULL, '2026-08-30',
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
  'cp31-cf-1759-g', 'codeforces', '1759:G', 'https://codeforces.com/contest/1759/problem/G',
  'Restore the Permutation', '1759', 'G',
  '1900', 'medium', '["binary search","constructive algorithms","data structures","greedy","math"]',
  'A sequence of $$$n$$$ numbers is called permutation if it contains all numbers from $$$1$$$ to $$$n$$$ exactly once. For example, the sequences [$$$3, 1, 4, 2$$$], [$$$1$$$] and [$$$2,1$$$] are permutations, but [$$$1,2,1$$$], [$$$0,1$$$] and [$$$1,3,4$$$] — are not.

For a permutation $$$p$$$ of even length $$$n$$$ you can make an array $$$b$$$ of length $$$\frac{n}{2}$$$ such that:

 - $$$b_i = \max(p_{2i - 1}, p_{2i})$$$ for $$$1 \le i \le \frac{n}{2}$$$

For example, if $$$p$$$ = [$$$2, 4, 3, 1, 5, 6$$$], then:

 - $$$b_1 = \max(p_1, p_2) = \max(2, 4) = 4$$$
- $$$b_2 = \max(p_3, p_4) = \max(3,1)=3$$$
- $$$b_3 = \max(p_5, p_6) = \max(5,6) = 6$$$
 As a result, we made $$$b$$$ = $$$[4, 3, 6]$$$.

For a given array $$$b$$$, find the lexicographically minimal permutation $$$p$$$ such that you can make the given array $$$b$$$ from it.

If $$$b$$$ = [$$$4,3,6$$$], then the lexicographically minimal permutation from which it can be made is $$$p$$$ = [$$$1,4,2,3,5,6$$$], since:

 - $$$b_1 = \max(p_1, p_2) = \max(1, 4) = 4$$$
- $$$b_2 = \max(p_3, p_4) = \max(2, 3) = 3$$$
- $$$b_3 = \max(p_5, p_6) = \max(5, 6) = 6$$$

A permutation $$$x_1, x_2, \dots, x_n$$$ is lexicographically smaller than a permutation $$$y_1, y_2 \dots, y_n$$$ if and only if there exists such $$$i$$$ ($$$1 \le i \le n$$$) that $$$x_1=y_1, x_2=y_2, \dots, x_{i-1}=y_{i-1}$$$ and $$$x_i \lt y_i$$$.

## Input

The first line of input data contains a single integer $$$t$$$ ($$$1 \le t \le 10^4$$$) — the number of test cases.

The description of the test cases follows.

The first line of each test case contains one even integer $$$n$$$ ($$$2 \le n \le 2 \cdot 10^5$$$).

The second line of each test case contains exactly $$$\frac{n}{2}$$$ integers $$$b_i$$$ ($$$1 \le b_i \le n$$$) — elements of array $$$b$$$.

It is guaranteed that the sum of $$$n$$$ values over all test cases does not exceed $$$2 \cdot 10^5$$$.

## Output

For each test case, print on a separate line:

 - lexicographically minimal permutation $$$p$$$ such that you can make an array $$$b$$$ from it;
- or a number -1 if the permutation you are looking for does not exist.

## Example

Input

    6
    6
    4 3 6
    4
    2 4
    8
    8 7 2 3
    6
    6 4 2
    4
    4 4
    8
    8 7 4 5

Output

    1 4 2 3 5 6 
    1 2 3 4 
    -1
    5 6 3 4 1 2 
    -1
    1 8 6 7 2 4 3 5

## Note

The first test case is parsed in the problem statement.', '[]',
  'f986909502be2c5e19bebf9b9303e82f2b850cbe3a963b26abf20400e66b5aa7', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":26}',
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
  'cp31-cf-1747-d', 'codeforces', '1747:D', 'https://codeforces.com/contest/1747/problem/D',
  'Yet Another Problem', '1747', 'D',
  '1900', 'medium', '["binary search","bitmasks","constructive algorithms","data structures"]',
  'You are given an array $$$a$$$ of $$$n$$$ integers $$$a_1, a_2, a_3, \ldots, a_n$$$.

You have to answer $$$q$$$ independent queries, each consisting of two integers $$$l$$$ and $$$r$$$.

 - Consider the subarray $$$a[l:r]$$$ $$$=$$$ $$$[a_l, a_{l+1}, \ldots, a_r]$$$. You can apply the following operation to the subarray any number of times (possibly zero)-  - Choose two integers $$$L$$$, $$$R$$$ such that $$$l \le L \le R \le r$$$ and $$$R - L + 1$$$ is odd.
- Replace each element in the subarray from $$$L$$$ to $$$R$$$ with the XOR of the elements in the subarray $$$[L, R]$$$.
- The answer to the query is the minimum number of operations required to make all elements of the subarray $$$a[l:r]$$$ equal to $$$0$$$ or $$$-1$$$ if it is impossible to make all of them equal to $$$0$$$.

You can find more details about XOR operation here.

## Input

The first line contains two integers $$$n$$$ and $$$q$$$ $$$(1 \le n, q \le 2 \cdot 10^5)$$$  — the length of the array $$$a$$$ and the number of queries.

The next line contains $$$n$$$ integers $$$a_1, a_2, \ldots, a_n$$$ $$$(0 \le a_i \lt 2^{30})$$$  — the elements of the array $$$a$$$.

The $$$i$$$-th of the next $$$q$$$ lines contains two integers $$$l_i$$$ and $$$r_i$$$ $$$(1 \le l_i \le r_i \le n)$$$  — the description of the $$$i$$$-th query.

## Output

For each query, output a single integer  — the answer to that query.

## Example

Input

    7 6
    3 0 3 3 1 2 3
    3 4
    4 6
    3 7
    5 6
    1 6
    2 2

Output

    -1
    1
    1
    -1
    2
    0

## Note

In the first query, $$$l = 3, r = 4$$$, subarray = $$$[3, 3]$$$. We can apply operation only to the subarrays of length $$$1$$$, which won''t change the array; hence it is impossible to make all elements equal to $$$0$$$.

In the second query, $$$l = 4, r = 6$$$, subarray = $$$[3, 1, 2]$$$. We can choose the whole subarray $$$(L = 4, R = 6)$$$ and replace all elements by their XOR $$$(3 \oplus 1 \oplus 2) = 0$$$, making the subarray $$$[0, 0, 0]$$$.

In the fifth query, $$$l = 1, r = 6$$$, subarray = $$$[3, 0, 3, 3, 1, 2]$$$. We can make the operations as follows:

 - Choose $$$L = 4, R = 6$$$, making the subarray $$$[3, 0, 3, 0, 0, 0]$$$.
- Choose $$$L = 1, R = 5$$$, making the subarray $$$[0, 0, 0, 0, 0, 0]$$$.', '[]',
  '03db02219ecfdf5612409d2c59f83854c19fc4dad12a9df2c15a6d9d742fdad5', '2026-08-04T05:56:04.840Z', 'complete',
  '{"title":"codeforces_problem_page_2026_08_04","rating":"cp31_band_and_codeforces_page_2026_08_04","difficulty":"codeforces_rating_band_v1","official_tags":"codeforces_problem_page_2026_08_04","statement":"codeforces_problem_page_2026_08_04","sprint":"cp31_local_ordered_lists_2026_08_04"}', '{}', 'cp31_august_2026',
  '{"source":"cp31_local_ordered_lists","sprint_order":27}',
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
