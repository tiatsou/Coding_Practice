--Problem Number & Name: 550. Game Play Analysis IV

--Create Data
CREATE TABLE Activity (
  `player_id` INTEGER,
  `device_id` INTEGER,
  `event_date` DATETIME,
  `games_played` INTEGER
);

INSERT INTO Activity
  (`player_id`, `device_id`, `event_date`, `games_played`)
VALUES
  ('1', '2', '2016-03-01', '5'),
  ('1', '2', '2016-03-02', '6'),
  ('2', '3', '2017-06-25', '1'),
  ('3', '1', '2016-03-02', '0'),
  ('3', '4', '2018-07-03', '5');

/*
August 2021 Solution
Note: It took about 1 ms to execute.
*/
SELECT ROUND(
(
SELECT COUNT(DISTINCT(a.player_id)) AS divider
FROM Activity a
INNER JOIN Activity b
ON a.player_id = b. player_id AND DATE(b.event_date) = DATE(a.event_date) + 1
) / COUNT(DISTINCT(act.player_id)), 2) AS fraction
FROM Activity AS act;

/*
August 2021 Solution
Note: 
1. It took about 1 ms to execute.
2. Need to have "COUNT(DISTINCT())" on both side of the /.
*/
SELECT ROUND(COUNT(DISTINCT(subq.player_id)) / COUNT(DISTINCT(act.player_id)),2) AS fraction
FROM Activity AS act,
(
SELECT a.player_id
FROM Activity a
INNER JOIN Activity b
ON a.player_id = b. player_id AND DATE(b.event_date) = DATE(a.event_date) + 1
) AS subq;

/*
April 2021 Solution
Thoughts: DATEDIFF()
Note: It took about 1 ms to execute.
*/
SELECT ROUND(COUNT(DISTINCT(subq.player_id)) / COUNT(DISTINCT(a.player_id)),2) AS fraction
FROM Activity AS a,
(                                                      
  SELECT a1.player_id
  FROM Activity AS a1
  INNER JOIN Activity AS a2 ON a2.player_id = a1.player_id
  AND DATEDIFF(a2.event_date, a1.event_date) = 1
) AS subq;

/*
April 2021 Solution
Thoughts: LEFT JOIN, DATEDIFF()
Note: It took about 1 ms to execute.
*/
SELECT ROUND(COUNT(DISTINCT(subq.player_id)) / COUNT(DISTINCT(a.player_id)),2) AS fraction
FROM Activity AS a
LEFT JOIN                                                     
(                                                      
  SELECT a1.player_id
  FROM Activity AS a1
  INNER JOIN Activity AS a2 ON a2.player_id = a1.player_id
  AND DATEDIFF(a2.event_date, a1.event_date) = 1
) AS subq
ON a.player_id = subq.player_id;