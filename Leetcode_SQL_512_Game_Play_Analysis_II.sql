--Problem Description: https://leetcode.jp/problemdetail.php?id=512

--Data Creation
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
  ('1', '2', '2016-05-02', '6'),
  ('2', '3', '2017-06-25', '1'),
  ('3', '4', '2016-03-01', '0'),
  ('3', '1', '2017-07-03', '5'),
  ('2', '1', '2017-06-26', '5');


/*
Aug 2021 Solution
Thought: RANK() to find the first day
*/
SELECT player_id, device_id
FROM
(
SELECT player_id, device_id, RANK() OVER(PARTITION BY player_id ORDER BY event_date) AS ranks
FROM Activity
) AS subq
WHERE ranks = 1;

/*
Apr 2021 Solution
Thought: MIN() to find the first day
*/
SELECT a1.player_id, a1.device_id
FROM Activity AS a1
INNER JOIN
(
  SELECT player_id, MIN(event_date) AS first_day
  FROM Activity
  GROUP BY player_id
) AS a2 
ON a1.player_id = a2.player_id AND a1.event_date = a2.first_day;
