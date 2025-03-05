--Current Date 2025-05-03

/*
SELECT
    order_id,
    status,
    total_amount,
    order_date::date AS date
FROM orders
WHERE 
    order_date::date <= '2025-05-03' 
AND
    order_date::date >= '2025-03-02'
;
*/

SELECT
    COUNT(order_id) count_orders_last_30_days
FROM orders
WHERE 
    order_date::date <= '2025-05-03' 
AND
    order_date::date >= '2025-03-02'
;