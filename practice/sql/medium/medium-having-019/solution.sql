-- Xom Data · High-rated sellers with many orders
-- Problem: https://xomdata.com/practice/medium-having-019
-- Solved: 2026-09-15

WITH count_order AS (
    SELECT
        s.store_name,
        s.reputation_score,
        COUNT(o.id) AS order_count
    FROM sellers s
    JOIN orders o ON o.seller_id = s.id AND s.reputation_score >= 4.5
    GROUP BY s.id, s.store_name, s.reputation_score
    HAVING COUNT(o.id) >= 3
)
SELECT
    *,
    DENSE_RANK() OVER (ORDER BY order_count DESC) AS rank_by_orders,
    SUM(order_count) OVER(ORDER BY order_count DESC, store_name ASC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as cumulative_orders
FROM count_order
ORDER BY 
    rank_by_orders ASC,
    store_name ASC;
