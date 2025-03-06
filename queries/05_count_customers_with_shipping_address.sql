SELECT
    state,
    COUNT(customer_id) AS count_customers
FROM addresses
WHERE address_type IN('shipping')
GROUP BY state;