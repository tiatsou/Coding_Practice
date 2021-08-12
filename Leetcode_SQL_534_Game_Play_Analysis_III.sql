-- Problem Number & Name: 534. Game Play Analysis III

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
Thoughts: Window Function
*/
SELECT player_id, DATE(event_date) AS event_date, SUM(games_played) OVER(PARTITION BY player_id ORDER BY DATE(event_date) ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS `games_played_so_far`
FROM Activity;

/*
April 2021 Solution
Thoughts: Join
*/
SELECT a.player_id, DATE(a.event_date) event_date, SUM(b.games_played) AS games_played_so_far
FROM Activity AS a
LEFT JOIN Activity AS b
ON b.player_id = a.player_id AND b.event_date <= a.event_date
GROUP BY a.player_id, a.event_date;
