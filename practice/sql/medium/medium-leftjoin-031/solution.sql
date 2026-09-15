-- Xom Data · Candidates not yet interviewed
-- Problem: https://xomdata.com/practice/medium-leftjoin-031
-- Solved: 2026-09-15

SELECT
    c.full_name,
    c.email,
    c.application_date,
    ROW_NUMBER() OVER(ORDER BY c.application_date ASC, c.full_name) AS queue_position,
    ROUND(PERCENT_RANK() OVER(ORDER BY c.application_date ASC, c.full_name) * 100, 2) AS older_than_pct
FROM candidates c
WHERE NOT EXISTS (
    SELECT 1
    FROM interviews i
    WHERE i.candidate_id = c.id)
ORDER BY queue_position;
