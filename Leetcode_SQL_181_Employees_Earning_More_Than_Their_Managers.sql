--Problem Description: https://leetcode.jp/problemdetail.php?id=181

/*
July 2021 Solution
thoughts: Left Join
*/
SELECT Employee.Name AS Employee
FROM Employee
LEFT JOIN
(
  SELECT *
  FROM Employee
  WHERE ManagerID LIKE "NULL"
) AS Manager ON Manager.Id = Employee.ManagerId
WHERE Employee.Salary > Manager.Salary;

/*
March 2021 Solution
Thoughts: INNER JOIN
*/
SELECT Employee.Name AS Employee
FROM Employee
INNER JOIN Employee AS Manager
ON Employee.ManagerId = Manager.Id
WHERE Employee.Salary > Manager.Salary;

/*
Revised March solution
Thoughts: INNER JOIN ON clause will decide the table(name)!!
*/
SELECT Employee.Name AS Employee
FROM Employee AS Manager
INNER JOIN Employee AS Employee
ON Manager.Id = Employee.ManagerId
WHERE Employee.Salary > Manager.Salary;
