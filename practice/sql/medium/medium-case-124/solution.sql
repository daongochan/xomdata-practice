-- Xom Data · Classify student academic performance
-- Problem: https://xomdata.com/practice/medium-case-124
-- Solved: 2026-09-15

WITH score_avg AS (
    SELECT
        s.id AS student_id,
        s.full_name,
        s.student_code,
        ROUND(AVG(sr.final_score * 1.0), 2) AS avg_score
    FROM students s
    JOIN scores sr ON sr.student_id = s.id
    GROUP BY s.id, s.full_name, s.student_code
),
grade_rank AS (
    SELECT
        *,
        -- SỬA LỖI: Viết lại cấu trúc CASE WHEN phẳng, ngắn gọn và chỉ cần 1 từ khóa END
        CASE 
            WHEN avg_score >= 9 THEN 'Excellent' 
            WHEN avg_score >= 8 THEN 'Good' 
            WHEN avg_score >= 7 THEN 'Fair' 
            WHEN avg_score >= 5 THEN 'Average' 
            ELSE 'Poor'
        END AS grade
    FROM score_avg
)
SELECT
    full_name,
    student_code,
    avg_score,
    grade,
    DENSE_RANK() OVER(ORDER BY avg_score DESC) as class_rank
FROM grade_rank
ORDER BY
    avg_score DESC,
    student_id ASC
LIMIT 20;
