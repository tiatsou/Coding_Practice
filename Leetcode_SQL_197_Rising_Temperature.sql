--Problem Description: https://leetcode.jp/problemdetail.php?id=197

--Data Creation
CREATE TABLE Weather (
  `Id_INT_` INTEGER,
  `RecordDate_DATE_` DATETIME,
  `Temperature_INT_` INTEGER
);

INSERT INTO Weather
  (`Id_INT_`, `RecordDate_DATE_`, `Temperature_INT_`)
VALUES
  ('1', '2015-01-01', '10'),
  ('2', '2015-01-04', '33'),
  ('3', '2015-01-03', '31'),
  ('4', '2015-01-02', '30'),
  ('5', '2015-01-11', '20'),
  ('6', '2015-01-10', '15');


/*
April 2021 Solution
Thoughts: DATEDIFF()
*/
SELECT w2.Id_INT_ AS ID
FROM Weather w1
INNER JOIN Weather w2
ON DATEDIFF(w2.RecordDate_DATE_, w1.RecordDate_DATE_) = 1
AND w1.Temperature_INT_ < w2.Temperature_INT_;


/*
July 2021 Solution
thoughts: DATE()
*/
SELECT w2.Id_INT_ AS ID
FROM Weather AS w1
INNER JOIN Weather AS w2 ON DATE(w1.RecordDate_DATE_)+1 = DATE(w2.RecordDate_DATE_)
WHERE w2.Temperature_INT_ > w1.Temperature_INT_;

