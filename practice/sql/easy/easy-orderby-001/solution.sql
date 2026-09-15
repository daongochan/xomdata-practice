-- Xom Data · Active menu sorted by price
-- Problem: https://xomdata.com/practice/easy-orderby-001
-- Solved: 2026-09-15

SELECT
    dish_name,
    price
FROM menu
WHERE status = 'Active'    
ORDER BY price asc, dish_name asc;
