-- Xom Data · Customer spending per order
-- Problem: https://xomdata.com/practice/medium-join-001
-- Solved: 2026-09-15

SELECT
    c.full_name,
    COUNT(o.id) AS order_count,
    COALESCE(SUM(total_amount),0) AS total_spending,
    COALESCE(AVG(total_amount),0) AS avg_order_value,
    ROW_NUMBER() OVER(ORDER BY COALESCE(SUM(total_amount),0) DESC) AS spending_rank
FROM customers c
LEFT JOIN orders o ON o.customer_id = c.id
GROUP BY c.id, c.full_name
ORDER BY spending_rank;
