WITH orders_count_per_status_cte AS 
(
    SELECT
        status,
        COUNT(order_id) AS orders_count
    FROM orders
    GROUP BY status
),
sum_orders_cte AS
(
    SELECT
        COUNT(order_id) AS total_orders
    FROM orders
)

SELECT
    orders_count_per_status_cte.*,
    (orders_count_per_status_cte.orders_count * 100 / sum_orders_cte.total_orders) AS distrubution_by_percentage
FROM
orders_count_per_status_cte,
sum_orders_cte;

