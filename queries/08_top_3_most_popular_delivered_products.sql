SELECT 
product_name,
SUM(quantity) AS total_quantity
FROM order_items
INNER JOIN orders ON orders.order_id = order_items.order_id
WHERE orders.status IN('delivered')
GROUP BY product_name
ORDER BY total_quantity DESC
LIMIT 3;
