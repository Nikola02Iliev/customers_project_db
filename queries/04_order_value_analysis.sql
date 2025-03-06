WITH avarage_total_amount_cte AS (
SELECT
    ROUND(AVG(total_amount), 2) AS avarage_total_amount
FROM orders
),
revenue_from_delivered_orders_cte AS (
    SELECT
        SUM(total_amount) AS revenue_from_delivered_orders
    FROM orders
WHERE status IN('delivered')
)

SELECT
    *
FROM avarage_total_amount_cte, revenue_from_delivered_orders_cte;
