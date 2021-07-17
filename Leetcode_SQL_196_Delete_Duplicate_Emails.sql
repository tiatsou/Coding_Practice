--Problem Description: https://leetcode.jp/problemdetail.php?id=196

-- Creating data
CREATE TABLE Person (
  `Id` INTEGER,
  `Email` VARCHAR(16)
);

INSERT INTO Person
  (`Id`, `Email`)
VALUES
  ('1', 'john@example.com'),
  ('2', 'bob@example.com'),
  ('3', 'john@example.com'),
  ('4', 'john@example.com'),
  ('5', 'bob@example.com'),
  ('6', 'Amy@example.com'),
  ('7', 'bob@example.com');

/*
July 2021 solution
thoughts: JOIN ON clause decide the table name! (silimar to Leetcide_SQL_181)
*/
DELETE p2.* 
FROM Person p1
INNER JOIN Person AS p2
ON p2.Email = p1.Email AND p1.Id < p2.Id;

SELECT *
FROM Person;

/*
April 2021 solution
*/
DELETE p1 FROM Person AS p1 
INNER JOIN Person AS p2
ON p1.Email = p2.Email
WHERE p1.Id > p2.Id;

SELECT * FROM Person;
