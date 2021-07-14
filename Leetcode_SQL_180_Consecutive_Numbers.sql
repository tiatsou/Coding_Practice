-- Problem Description: https://leetcode.jp/problemdetail.php?id=180

-- Creating Data
CREATE TABLE Logs (
  `Id` INTEGER,
  `Num` INTEGER
);

INSERT INTO Logs
  (`Id`, `Num`)
VALUES
  ('1', '1'),
  ('2', '1'),
  ('3', '1'),
  ('4', '5'),
  ('5', '2'),
  ('6', '2'),
  ('7', '3'),
  ('8', '3'),
  ('9', '3'),
  ('10', '4');

-- March 2021 Solution
SELECT L1.Num AS ConsecutiveNums
FROM Logs AS L1
INNER JOIN Logs AS L2 ON L2.id + 1 = L1.id AND L1.Num = L2.Num
INNER JOIN Logs AS L3 ON L3.id + 2 = L1.id AND L2.Num = L3.Num;

-- July 2021 Solution
SELECT L1.Num AS ConsecutiveNums
FROM Logs L1
INNER JOIN Logs L2 ON L1.Id = L2.Id + 1
INNER JOIN Logs L3 ON L1.Id = L3.Id + 2
WHERE L1.Num = L2.Num AND L1.Num = L3.Num;
