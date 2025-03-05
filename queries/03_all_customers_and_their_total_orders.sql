SELECT
    customers.customer_id,
    customers.first_name,
    customers.last_name,
    customers.email,
    COUNT(orders.order_id) AS orders_count
FROM orders
LEFT JOIN customers ON orders.customer_id = customers.customer_id
GROUP BY customers.customer_id;