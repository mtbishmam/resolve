UPDATE problems
SET title = 'Max Straight',
    contest = 'AtCoder Beginner Contest 446',
    problem_index = 'D',
    statement_markdown = '## Problem Statement

You are given an integer sequence $A=(A_1,A_2,\ldots,A_N)$ of length $N$.

Find the maximum length of a subsequence $B=(B_1,B_2,\ldots,B_{|B|})$ of $A$ that satisfies the following condition:

- $B_i+1=B_{i+1}$ for every integer $i$ satisfying $1\le i\le |B|-1$.

A subsequence of a sequence is obtained by deleting zero or more elements and arranging the remaining elements in their original order.

## Constraints

- $1\le N\le 2\times 10^5$
- $1\le A_i\le 10^9$
- All input values are integers.

## Input

The input is given from Standard Input in the following format:

```text
N
A_1 A_2 ... A_N
```

## Output

Output the answer.

## Sample Input 1

```text
7
3 4 3 5 7 6 2
```

## Sample Output 1

```text
4
```

$B=(3,4,5,6)$ is a subsequence of $A$ that satisfies the condition, and its length is $4$. There is no valid subsequence with length greater than $4$.

## Sample Input 2

```text
5
5 4 3 2 1
```

## Sample Output 2

```text
1
```

## Sample Input 3

```text
10
1 2 3 4 5 6 7 8 9 10
```

## Sample Output 3

```text
10
```',
    statement_assets_json = '[]',
    statement_hash = 'e60eb5f5c6e10c2ecb4aa65818bea755575f050d8cf5759f7c9ce2c2f97a2015',
    statement_captured_at = '2026-08-15T17:24:00.000Z',
    metadata_status = 'complete',
    metadata_provenance_json = json_set(
      COALESCE(metadata_provenance_json, '{}'),
      '$.statement', 'official_url_v1',
      '$.statement_source', 'atcoder_english_html'
    ),
    updated_at = '2026-08-15T17:24:00.000Z'
WHERE platform = 'atcoder' AND problem_key = 'abc446_d';

UPDATE problems
SET title = 'Yarik and Array',
    contest = 'Codeforces Round 909 (Div. 3)',
    problem_index = 'C',
    rating = 1100,
    difficulty = 'easy',
    official_tags_json = '["dp","greedy","two pointers"]',
    statement_markdown = '## Problem Statement

A subarray is a continuous part of an array.

You are given an array $a$ of $n$ elements. Find the maximum sum of a non-empty subarray whose adjacent elements have alternating parity.

For example, $[1,2,3]$ is acceptable, while $[1,2,4]$ is not because $2$ and $4$ are both even and adjacent.

## Input

The first line contains an integer $t$ $(1\le t\le 10^4)$ — the number of test cases.

For each test case:

- The first line contains an integer $n$ $(1\le n\le 2\cdot 10^5)$ — the length of the array.
- The second line contains $n$ integers $a_1,a_2,\ldots,a_n$ $(-10^3\le a_i\le 10^3)$ — the array elements.

The sum of $n$ over all test cases does not exceed $2\cdot 10^5$.

## Output

For each test case, output a single integer — the maximum possible sum.

## Sample Input

```text
7
5
1 2 3 4 5
4
9 9 8 8
6
-1 4 -1 0 5 -4
4
-1 2 4 -3
1
-1000
3
101 -99 101
20
-10 5 -8 10 6 -10 7 9 -2 -6 7 2 -4 6 -1 7 -6 -7 4 1
```

## Sample Output

```text
15
17
8
4
-1000
101
10
```',
    statement_assets_json = '[]',
    statement_hash = '548ccf7fe03dad4c474b93798638422e68f1eb9e6170fdcae64200d753d85177',
    statement_captured_at = '2026-08-15T17:24:00.000Z',
    metadata_status = 'complete',
    metadata_provenance_json = json_set(
      json_set(
        COALESCE(metadata_provenance_json, '{}'),
        '$.difficulty', 'codeforces_rating_band_v1'
      ),
      '$.statement', 'official_url_v1',
      '$.statement_source', 'codeforces_html'
    ),
    updated_at = '2026-08-15T17:24:00.000Z'
WHERE platform = 'codeforces' AND problem_key = '1899:C';
