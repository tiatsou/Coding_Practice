-- Problem Description: https://leetcode.jp/problemdetail.php?id=262

-- Creating Data
CREATE TABLE Trips (
  `Id` INTEGER,
  `Client_Id` INTEGER,
  `Driver_Id` INTEGER,
  `City_Id` INTEGER,
  `Status` VARCHAR(19),
  `Request_at` DATETIME
);

INSERT INTO Trips
  (`Id`, `Client_Id`, `Driver_Id`, `City_Id`, `Status`, `Request_at`)
VALUES
  ('1', '1', '10', '1', 'completed', '2013-10-01'),
  ('2', '2', '11', '1', 'cancelled_by_driver', '2013-10-01'),
  ('3', '3', '12', '6', 'completed', '2013-10-01'),
  ('4', '4', '13', '6', 'cancelled_by_client', '2013-10-01'),
  ('5', '1', '10', '1', 'completed', '2013-10-02'),
  ('6', '2', '11', '6', 'completed', '2013-10-02'),
  ('7', '3', '12', '6', 'completed', '2013-10-02'),
  ('8', '2', '12', '12', 'completed', '2013-10-03'),
  ('9', '3', '10', '12', 'completed', '2013-10-03'),
  ('10', '4', '13', '12', 'cancelled_by_driver', '2013-10-03'),
  ('9', '3', '10', '12', 'completed', '2013-10-05'),
  ('9', '3', '10', '12', 'cancelled_by_driver', '2013-10-05');

CREATE TABLE Users (
  `Users_Id` INTEGER,
  `Banned` VARCHAR(3),
  `Role` VARCHAR(6)
);

INSERT INTO Users
  (`Users_Id`, `Banned`, `Role`)
VALUES
  ('1', 'No', 'client'),
  ('2', 'Yes', 'client'),
  ('3', 'No', 'client'),
  ('4', 'No', 'client'),
  ('10', 'No', 'driver'),
  ('11', 'No', 'driver'),
  ('12', 'No', 'driver'),
  ('13', 'No', 'driver');


/*
Aug 2021 Solution
*/
SELECT DATE(Request_at) AS Day, ROUND((SUM(IF(Status != 'completed',1,0)) / COUNT(*)),2) AS `Cancellation Rate`
FROM Trips
INNER JOIN 
(
  SELECT Users_Id FROM Users
  WHERE Role = 'client' AND Banned != 'Yes'
) AS c ON c.Users_Id = Trips.Client_Id
INNER JOIN
(
  SELECT Users_Id FROM Users
  WHERE Role = 'driver' AND Banned != 'Yes'
) AS d ON d.Users_Id = Trips.Driver_Id
GROUP BY Request_at
HAVING Request_at BETWEEN '2013-10-01' AND '2013-10-03';

/*
July 2021 Solution
Thought: Without JOIN
*/

SELECT DATE(Request_at) AS Day, ROUND(SUM(CASE WHEN Status LIKE 'cancelled%' THEN 1 ELSE 0 END) / COUNT(*), 2) AS `Cancellation Rate`
FROM
(
  SELECT *
  FROM Trips
  WHERE Client_Id IN
  (
    SELECT Users_Id 
    FROM Users
    WHERE Banned = 'No'
    AND Role = 'client'
  )
  AND Driver_Id IN
  (
    SELECT Users_Id 
    FROM Users
    WHERE Banned = 'No'
    AND Role = 'driver'
  )
) AS subq
GROUP BY Request_at
HAVING Request_at BETWEEN '2013-10-01' AND '2013-10-03';

/*
Apr 2021 Solution
Thought: CASE WHEN
*/
SELECT DATE(Request_at) AS Day, ROUND(SUM(CASE WHEN Status LIKE 'cancelled%' THEN 1 ELSE 0 END)/ COUNT(*),2) AS 'Cancellation Rate'
FROM Trips AS t
LEFT JOIN Users AS u1
ON u1.Users_Id = t.Client_Id 
LEFT JOIN Users AS u2
ON u2.Users_Id = t.Driver_Id
WHERE u1.Banned != 'Yes' AND u2.Banned != 'Yes'
AND Request_at BETWEEN '2013-10-01' AND '2013-10-03'
GROUP BY Request_at;

/*
Apr 2021 Solution
Thought: IF
*/
SELECT DATE(Request_at) AS Day, ROUND(SUM(IF(Status LIKE 'cancelled%', 1, 0))/ COUNT(*),2) AS 'Cancellation Rate'
FROM Trips AS t
LEFT JOIN Users AS u1
ON u1.Users_Id = t.Client_Id 
LEFT JOIN Users AS u2
ON u2.Users_Id = t.Driver_Id
WHERE u1.Banned != 'Yes' AND u2.Banned != 'Yes'
AND Request_at BETWEEN '2013-10-01' AND '2013-10-03'
GROUP BY Request_at;
