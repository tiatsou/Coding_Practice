--Problem Number & Name: 574. Winning Candidate

/*
August 2021 Solution
*/
SELECT Name
FROM Candidate
WHERE id = 
(
  SELECT CandidateId 
  FROM
  (
    SELECT CandidateId, COUNT(*) AS ct
    FROM Vote
    GROUP BY CandidateId
    ORDER BY ct DESC
    LIMIT 1
  ) AS subq
);

/*
August 2021 Revised Solution
*/
SELECT Name
FROM Candidate
WHERE id = (
  SELECT CandidateId
  FROM Vote
  GROUP BY CandidateId
  ORDER BY COUNT(*) DESC
  LIMIT 1;


/*
April 2021 Solution
Thoughts: get the MAX cnt of CandidateId, INNER JOIN Candidate table and Vote Table 
*/
SELECT DISTINCT(Name) AS Name
FROM Candidate
INNER JOIN Vote ON Vote.CandidateId = Candidate.id
WHERE CandidateId = 
(
  SELECT CandidateId
  FROM Vote
  GROUP BY CandidateId
  HAVING COUNT(CandidateId) = 
  (
    SELECT MAX(cnt) AS maxcnt
    FROM 
    (
      SELECT CandidateId, COUNT(CandidateId) AS cnt FROM Vote
      GROUP BY CandidateId
    ) AS sub1
  )
);

/*
April 2021 Solution
Thoughts: no join, get the answer by filter the id with MAX cnt of CandidateId
*/
SELECT Name
FROM Candidate
WHERE id = 
(
  SELECT CandidateId
  FROM
  (
    SELECT DISTINCT(CandidateId), COUNT(CandidateId) OVER(PARTITION BY CandidateId) AS cnt 
    FROM Vote
  ) AS sub1
  WHERE cnt = 
  (
    SELECT MAX(cnt)
    FROM
    (
      SELECT DISTINCT(CandidateId), COUNT(CandidateId) OVER(PARTITION BY CandidateId) AS cnt 
      FROM Vote
    ) AS sub1
  )
);
