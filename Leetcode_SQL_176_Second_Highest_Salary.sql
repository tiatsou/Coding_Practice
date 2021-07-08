-- Creating Data
CREATE TABLE Employee (
  `Id` INTEGER,
  `Salary` INTEGER
);

INSERT INTO Employee
  (`Id`, `Salary`)
VALUES
  ('1', '100'),
  ('2', '200'),
  ('3', '300'),
  ('4', '500'),
  ('5', '500'),
  ('6', '400');

/* 
Solution 01
Thought: To find the 2nd MAX one, eliminate the MAX one and the remaining MAX is the 2nd.
*/
SELECT MAX(Salary) AS SecondHighestSalary
FROM Employee
WHERE Salary <
(SELECT MAX(Salary)
FROM Employee);

/* 
Solution 02
Thought: RANK
*/
SELECT Salary AS SecondHighestSalary
FROM
(
  SELECT *, DENSE_RANK()OVER(ORDER BY Salary DESC) AS rank_ 
  FROM Employee
) AS subq
WHERE rank_ = 2;

/* 
Solution 03
Thought: Select the second one by pick only one from the 2nd place.
*/
SELECT Salary AS SecondHighestSalary
FROM Employee
GROUP BY Salary
ORDER BY Salary DESC
LIMIT 1,1;