WITH helper_cte AS 
(
SELECT
    customers.customer_id,
    customers.first_name,
    customers.last_name,
    customers.email,
    orders.order_date::date
FROM customers
INNER JOIN orders ON customers.customer_id = orders.customer_id
WHERE EXTRACT(YEAR FROM orders.order_date) IN (2023, 2024)
GROUP BY customers.customer_id, orders.order_date::date
)

SELECT DISTINCT
    helper_cte.customer_id,
    helper_cte.first_name,
    helper_cte.last_name,
    helper_cte.email
FROM helper_cte
ORDER BY helper_cte.customer_id;



