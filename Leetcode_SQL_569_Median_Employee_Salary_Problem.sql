--Problem Number & Name: 569. Median Employee Salary Problem


/*
August 2021 Solution
Thoughts: RANK(), CTE
NOTE: 	1. no need to use DENSE_RANK as it will order by Id(unique) when ranking.
	2. need to ORDER BY Id as well when ranking as we need to get the "position number" to find the median(depends on even and odd).
*/
WITH temp AS (
  SELECT *, RANK() OVER(PARTITION BY Company ORDER BY Salary, Id)
  AS rk, COUNT(*) OVER(PARTITION BY Company) AS ct
  FROM Employee
)
SELECT Id, Company, Salary
FROM temp
WHERE 
CASE WHEN ct % 2 = 0 THEN rk IN (FLOOR(ct / 2), FLOOR(ct / 2) + 1)
ELSE rk = CEILING(ct / 2) END;


/*
May 2021 Solution
Thoughts: DENSE_RANK(), CTE
*/
WITH CTE AS
(
  SELECT DENSE_RANK() OVER(PARTITION BY Company ORDER BY Salary, ID) AS rk, COUNT(Id) OVER(PARTITION BY Company) AS ct, Id, Company, Salary FROM Employee
)
SELECT Id, Company, Salary
FROM CTE
WHERE 
CASE WHEN ct % 2 = 0 THEN rk IN (FLOOR(ct/2), FLOOR(ct/2)+1)
ELSE rk = ROUND(ct/2)
END;

/*
May 2021 Solution
Thoughts: DENSE_RANK()
*/
SELECT Id, Company, Salary
FROM 
(
  SELECT DENSE_RANK() OVER(PARTITION BY Company ORDER BY Salary, ID) AS rk, COUNT(Id) OVER(PARTITION BY Company) AS ct, Id, Company, Salary FROM Employee
) AS subq
WHERE 
CASE WHEN ct % 2 = 0 THEN rk IN (FLOOR(ct/2), FLOOR(ct/2)+1)
ELSE rk = ROUND(ct/2)
END;
