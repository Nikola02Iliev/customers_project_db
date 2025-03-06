WITH total_customers_cte AS
(
    SELECT
        COUNT(customer_id) AS customers_count
    FROM customers
)

SELECT
    type AS interaction_type,
    COUNT(interaction_id) AS count_interactions,
    ROUND(
        COUNT(interaction_id)::NUMERIC / total_customers_cte.customers_count,
        2 
    ) AS avarage_interactions_per_customer
FROM interactions, total_customers_cte
GROUP BY type, total_customers_cte.customers_count;
