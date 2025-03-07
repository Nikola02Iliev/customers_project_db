WITH total_orders_cte AS
(
    SELECT
        COUNT(order_id) AS orders_count
    FROM orders
)
,
total_orders_shipping_cte AS
(
    SELECT
        COUNT(order_id) AS total_orders_shipping
    FROM orders
    INNER JOIN addresses ON orders.address_id = addresses.address_id
    WHERE addresses.address_type IN('shipping')
)
,
total_orders_billing_cte AS
(
    SELECT
        COUNT(order_id) AS total_orders_billing
    FROM orders
    INNER JOIN addresses ON orders.address_id = addresses.address_id
    WHERE addresses.address_type IN('billing')
),
grouped_address_types_cte AS
(
    SELECT
        addresses.address_type AS address_types
    FROM orders
    INNER JOIN addresses ON orders.address_id = addresses.address_id
    WHERE addresses.address_type IN('shipping','billing')
    GROUP BY address_types
)

SELECT
    grouped_address_types_cte.address_types,
    CASE
    WHEN grouped_address_types_cte.address_types = 'shipping' 
    THEN
    ROUND
    (
        (total_orders_shipping_cte.total_orders_shipping * 100) / total_orders_cte.orders_count, 2
    )
    WHEN grouped_address_types_cte.address_types = 'billing' 
    THEN 
    ROUND
    (
        (total_orders_billing_cte.total_orders_billing * 100) / total_orders_cte.orders_count, 2
    )
    END AS orders_percantage_by_address_type
FROM total_orders_cte, total_orders_shipping_cte, total_orders_billing_cte, grouped_address_types_cte;

