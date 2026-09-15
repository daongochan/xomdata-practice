-- Xom Data · Average score per subject
-- Problem: https://xomdata.com/practice/medium-groupby-027
-- Solved: 2026-09-15

SELECT
    s.subject_name,
    s.credits,
    COUNT(g.id) AS student_count,
    ROUND(AVG(g.final_score),2) as avg_score,
    ROUND(COUNT(CASE WHEN g.final_score >= 5 THEN 1 END) * 100.0 / COUNT(*),2) AS pass_rate,
    RANK() OVER (ORDER BY ROUND(AVG(g.final_score),2) DESC) AS rank_by_avg,
    NTILE(4) OVER (ORDER BY ROUND(AVG(g.final_score),2) DESC, s.subject_name ASC) AS difficulty_quartile
FROM subjects s
JOIN grades g ON g.subject_id = s.id
GROUP BY s.id
ORDER BY rank_by_avg, s.subject_name;
