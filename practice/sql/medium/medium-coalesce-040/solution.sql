-- Xom Data · Book count and average price by genre
-- Problem: https://xomdata.com/practice/medium-coalesce-040
-- Solved: 2026-09-15

SELECT
    g.genre_name,
    COUNT(b.id) AS book_count,
    ROUND(COALESCE(AVG(b.price * 1.0),0),0) AS avg_price,
    COALESCE(MIN(b.price),0) AS min_price,
    COALESCE(MAX(b.price),0) AS max_price,
    COALESCE(MAX(b.price) - MIN(b.price),0) AS price_range,
    RANK() OVER(ORDER BY COUNT(b.id) DESC) AS coverage_rank,
    NTILE(3) OVER(ORDER BY COUNT(b.id) DESC) AS library_focus
FROM genres g
LEFT JOIN books b ON b.genre_id = g.id
GROUP BY g.id, g.genre_name
ORDER BY
    coverage_rank ASC,
    g.genre_name;
