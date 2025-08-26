WITH
total_sales AS (
    SELECT
        DATE_PART('YEAR', sale_date) AS year,
        DATE_PART('QUARTER',sale_date) AS quarter,
        sum(amount) AS total_sales
    FROM sales
    group by year,quarter
)

SELECT 
    *,
    total_sales/
    LAG(total_sales,1) OVER (order by year,quarter)-1 AS growth_rate
FROM total_sales
ORDER BY growth_rate DESC;