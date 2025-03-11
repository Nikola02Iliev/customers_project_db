--Current date 2025-03-10

WITH customers_activity_cte AS (
    SELECT
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        customers.email,
        CASE
            WHEN orders.order_date::date >= '2024-09-10' THEN 'active'
            ELSE 'inactive'
        END AS is_active
    FROM customers
    INNER JOIN orders ON customers.customer_id = orders.customer_id
),
distinct_statuses_cte AS (
    SELECT
        customers_activity_cte.customer_id,
        customers_activity_cte.first_name,
        customers_activity_cte.last_name,
        customers_activity_cte.email,
        customers_activity_cte.is_active
    FROM customers_activity_cte
    GROUP BY customers_activity_cte.customer_id, customers_activity_cte.first_name, customers_activity_cte.last_name, customers_activity_cte.email, customers_activity_cte.is_active
),
customers_inactive_cte AS (
    SELECT
        distinct_statuses_cte.customer_id,
        distinct_statuses_cte.first_name,
        distinct_statuses_cte.last_name,
        distinct_statuses_cte.email
    FROM distinct_statuses_cte
    GROUP BY distinct_statuses_cte.customer_id, distinct_statuses_cte.first_name, distinct_statuses_cte.last_name, distinct_statuses_cte.email
    HAVING COUNT(CASE WHEN is_active = 'active' THEN 1 END) = 0
),
get_latest_interaction_cte AS (
    SELECT
        customers.customer_id,
        customers.email,
        interactions.interaction_id,
        interactions.type,
        interactions.interaction_date::date AS interaction_date,
        COUNT(*) OVER(PARTITION BY customers.customer_id ORDER BY interactions.interaction_date::date DESC) AS latest_interaction_date
    FROM interactions
    INNER JOIN customers ON interactions.customer_id = customers.customer_id
    GROUP BY customers.customer_id, interactions.interaction_id
),
get_latest_interaction_with_customers_inactive_cte AS (
    SELECT 
        get_latest_interaction_cte.customer_id,
        get_latest_interaction_cte.email,
        get_latest_interaction_cte.interaction_id,
        get_latest_interaction_cte.type,
        get_latest_interaction_cte.interaction_date
    FROM get_latest_interaction_cte
    INNER JOIN customers_inactive_cte ON get_latest_interaction_cte.customer_id = customers_inactive_cte.customer_id
    WHERE get_latest_interaction_cte.latest_interaction_date = 1
)
SELECT 
    *,
    COALESCE(
        (
            SELECT JSON_AGG(
                json_build_object(
                    'order_date', orders.order_date::date,
                    'total_amount', orders.total_amount,
                    'status', orders.status
                )
            )
            FROM orders
            WHERE orders.customer_id = get_latest_interaction_with_customers_inactive_cte.customer_id
        ),
        '[]'::json
    ) AS order_history
FROM get_latest_interaction_with_customers_inactive_cte;
