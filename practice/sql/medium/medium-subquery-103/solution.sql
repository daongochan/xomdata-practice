-- Xom Data · Products more expensive than the category average
-- Problem: https://xomdata.com/practice/medium-subquery-103
-- Solved: 2026-09-15

WITH avg_category AS (
    SELECT
        category,
        AVG(price * 1.0) AS avg_cate_price
    FROM products
    GROUP BY category
)
SELECT
    p.product_name,
    p.category,
    p.price,
    ROUND(p.price - ac.avg_cate_price,0) AS diff_from_avg,
    ROUND((p.price - ac.avg_cate_price) * 100.0 / ac.avg_cate_price,2) AS pct_above
FROM products p
JOIN avg_category ac ON ac.category = p.category 
AND p.price > ac.avg_cate_price
ORDER BY 
    pct_above DESC,
    p.product_name ASC;
