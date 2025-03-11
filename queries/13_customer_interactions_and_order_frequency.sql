WITH order_interactions_cte AS
(
    SELECT
        customers.customer_id,
        orders.order_id,
        COUNT(interactions.interaction_id) AS number_of_interactions
    FROM customers
    INNER JOIN orders ON customers.customer_id = orders.customer_id
    INNER JOIN interactions ON customers.customer_id = interactions.customer_id
    GROUP BY orders.order_id, customers.customer_id
)

SELECT 
customers.customer_id,
customers.first_name,
customers.last_name,
customers.email,
COUNT(order_interactions_cte.order_id) AS number_of_orders,
order_interactions_cte.number_of_interactions
FROM order_interactions_cte
INNER JOIN customers ON order_interactions_cte.customer_id = customers.customer_id
GROUP BY customers.customer_id, order_interactions_cte.number_of_interactions;
