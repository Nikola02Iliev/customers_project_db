WITH total_amout_profit_per_customer_cte AS
(
    SELECT 
        customers.customer_id,
        customers.email,
        customers.created_at::date AS joined_date,
        SUM(orders.total_amount) AS total_amount_from_customer
    FROM orders
    INNER JOIN customers ON orders.customer_id = customers.customer_id
    WHERE 
        EXTRACT(YEAR FROM customers.created_at::date) >= 2021
    AND
        EXTRACT(YEAR FROM customers.created_at::date) < 2023
    GROUP BY customers.customer_id
)

SELECT
    ROUND
    (
        SUM(total_amout_profit_per_customer_cte.total_amount_from_customer::NUMERIC),
        0
    ) AS total_amount_profit_from_customers_joined_2021_2022
FROM total_amout_profit_per_customer_cte;



