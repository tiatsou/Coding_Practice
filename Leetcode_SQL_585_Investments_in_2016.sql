--Question: https://leetcode.jp/problemdetail.php?id=585
/* Note for this practice
1. When filtering a pair of values, instead of using CONCAT() to pair the value, the need-to-paired values can be directly selected
2. the use of =, LIKE, IN
*/

SELECT SUM(TIV_2016) AS TIV_2016
FROM insurance
WHERE TIV_2015 = 
(
 SELECT TIV_2015
 FROM insurance
 GROUP BY TIV_2015
 ORDER BY COUNT(TIV_2015) DESC LIMIT 1
)
AND
(LAT, LON) IN
(
  SELECT LAT, LON
  FROM insurance
  GROUP BY LAT, LON
  HAVING COUNT(*) = 1
)
