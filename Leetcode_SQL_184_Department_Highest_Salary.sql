--Problem Description: https://leetcode.jp/problemdetail.php?id=184

/*
Select the #1 in each group.
1. use Rank() to find the #1
2. find the #1 aka MAX() and INNER JOIN the MAX

alteration: Select the #X in each group
1. Rank() can easily steer to the #X
2. MAX() LIMIT 1, (X-1)
*/

## RANK() ##
SELECT sub.Name, Salary, d.Name AS Department
FROM 
(
SELECT *, RANK()OVER(PARTITION BY DepartmentId ORDER BY Salary DESC) AS rank_
FROM Employee
) AS sub
LEFT JOIN Department d ON d.Id = sub.DepartmentId
WHERE rank_ = 1;

## INNER JOIN ##
SELECT dpt.Name AS Department, epy.Name AS Employee, epy.Salary AS Salary
FROM Employee AS epy
LEFT JOIN Department AS dpt ON dpt.Id = epy.DepartmentId
INNER JOIN
(
  SELECT DepartmentId, MAX(Employee.Salary) AS max
  FROM Employee
  GROUP BY DepartmentId
) AS subq
ON subq.DepartmentId = epy.DepartmentId AND epy.Salary = subq.max;

