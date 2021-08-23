--Problem Number & Name: 571. Find Median Given Frequency of Numbers

--Data Preparation
CREATE TABLE Numbers (
  `Number` INTEGER,
  `Frequency` INTEGER
);

INSERT INTO Numbers
  (`Number`, `Frequency`)
VALUES
  ('0', '3'),
  ('1', '3'),
  ('2', '5'),
  ('3', '1');

/*
August 2021 Solution
Thoughts: CTE
*/
WITH Main AS
(
  SELECT *, SUM(Frequency) OVER(ORDER BY Number ROWS BETWEEN UNBOUNDED
                                PRECEDING AND CURRENT ROW) AS Accu 
  FROM Numbers
)
SELECT AVG(Number) AS median
FROM Main
WHERE Accu 
BETWEEN 
(SELECT SUM(Frequency) / 2 FROM Numbers) 
AND 
(SELECT SUM(Frequency) / 2 FROM Numbers) + Frequency;

/*
April 2021 Solution
Thoughts: FROM t1, t2
*/
SELECT AVG(Number) AS Median
FROM 
(
SELECT Number, Frequency, accu_num, ct
FROM
  (
    SELECT *, SUM(Frequency) OVER(ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS accu_num 
    FROM Numbers
  ) AS subq1,
  (
    SELECT SUM(Frequency) AS ct
    FROM Numbers
  ) AS subq2
) AS subq
WHERE accu_num BETWEEN FLOOR(ct / 2) AND FLOOR(ct / 2) + Frequency;
