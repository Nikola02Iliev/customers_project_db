--Analyzed year 2021

WITH first_quarter_customers_cte AS (
    SELECT COUNT(customer_id) AS count_customers,
        created_at::date,
        updated_at::date
    FROM customers
    WHERE created_at::date >= '2021-01-01'
        AND updated_at::date <= '2021-03-31'
    GROUP BY created_at::date, updated_at::date
),
second_quarter_customers_cte AS (
    SELECT COUNT(customer_id) AS count_customers,
        created_at::date,
        updated_at::date
    FROM customers
    WHERE created_at::date >= '2021-04-01'
        AND updated_at::date <= '2021-06-30'
    GROUP BY created_at::date, updated_at::date
),
third_quarter_customers_cte AS (
    SELECT COUNT(customer_id) AS count_customers,
        created_at::date,
        updated_at::date
    FROM customers
    WHERE created_at::date >= '2021-07-01'
        AND updated_at::date <= '2021-09-30'
    GROUP BY created_at::date, updated_at::date
),
fourth_quarter_customers_cte AS (
    SELECT COUNT(customer_id) AS count_customers,
        created_at::date,
        updated_at::date
    FROM customers
    WHERE created_at::date >= '2021-10-01'
        AND updated_at::date <= '2021-12-31'
    GROUP BY created_at::date, updated_at::date
),
united_quarters_customers_cte AS (
    SELECT created_at::date AS joined_date, updated_at::date AS updated_date, count_customers
    FROM first_quarter_customers_cte
    UNION ALL
    SELECT created_at::date AS joined_date, updated_at::date AS updated_date, count_customers
    FROM second_quarter_customers_cte
    UNION ALL
    SELECT created_at::date AS joined_date, updated_at::date AS updated_date, count_customers
    FROM third_quarter_customers_cte
    UNION ALL
    SELECT created_at::date AS joined_date, updated_at::date AS updated_date, count_customers
    FROM fourth_quarter_customers_cte
),
active_customers_per_quarter_cte AS
(
    SELECT
    COUNT(customer_id) AS total_active_by_quarter
    FROM customers
    WHERE created_at::date >= '2021-01-01'
        AND updated_at::date <= '2021-03-31'
UNION ALL
SELECT
    COUNT(customer_id) AS total_active_by_quarter
    FROM customers
    WHERE created_at::date >= '2021-04-01'
        AND updated_at::date <= '2021-06-30'
UNION ALL 
SELECT
    COUNT(customer_id) AS total_active_by_quarter
    FROM customers
    WHERE created_at::date >= '2021-07-01'
        AND updated_at::date <= '2021-09-30'
UNION ALL
SELECT
    COUNT(customer_id) AS total_active_by_quarter
    FROM customers
    WHERE created_at::date >= '2021-10-01'
        AND updated_at::date <= '2021-12-31'
),
total_active_customers_cte AS
(
    SELECT 
        SUM(total_active_by_quarter) AS total_active_customers
    FROM
    active_customers_per_quarter_cte
)


SELECT
CASE
    WHEN united_quarters_customers_cte.joined_date >= '2021-01-01' AND united_quarters_customers_cte.joined_date <= '2021-03-31' THEN '1st'
    WHEN united_quarters_customers_cte.joined_date >= '2021-04-01' AND united_quarters_customers_cte.joined_date <= '2021-06-30' THEN '2nd'
    WHEN united_quarters_customers_cte.joined_date >= '2021-07-01' AND united_quarters_customers_cte.joined_date <= '2021-09-30' THEN '3rd'
    WHEN united_quarters_customers_cte.joined_date >= '2021-10-01' AND united_quarters_customers_cte.joined_date <= '2021-12-31' THEN '4th'
END AS year_quarter,
    ROUND((SUM(count_customers)::NUMERIC * 100) / total_active_customers_cte.total_active_customers,0) AS percantage_active_customers_per_quarter
FROM united_quarters_customers_cte, total_active_customers_cte
GROUP BY year_quarter, total_active_customers_cte.total_active_customers
ORDER BY year_quarter ASC;




