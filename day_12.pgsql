-- OPTION 1: CALCULATING PERCENTAGE RANK BY HAND

WITH
num_gifts AS (
    SELECT 
        gift_name, 
        count(*) AS n_gifts  
    FROM gift_requests gr
    JOIN gifts g ON g.gift_id = gr.gift_id
    GROUP BY gift_name
)

SELECT 
    gift_name, 
    round(
    1.0*(num_elem_less_than_it)
    /(SELECT count(*)-1 FROM num_gifts),2)
    AS percentile
FROM( 
    SELECT 
        n1.gift_name, 
        count(CASE
                WHEN n2.gift_name IS NOT NULL THEN 1
                END
        ) AS num_elem_less_than_it
    FROM num_gifts n1
    LEFT JOIN num_gifts n2
        ON n1.n_gifts > n2.n_gifts
            AND n1.gift_name != n2.gift_name  
    GROUP BY n1.gift_name
)
ORDER BY percentile DESC, gift_name
LIMIT 10;

-- OPTION 2: USING PERCENT_RANK
WITH
num_gifts AS (
    SELECT 
        gift_name, 
        count(*) AS n_gifts  
    FROM gift_requests gr
    JOIN gifts g ON g.gift_id = gr.gift_id
    GROUP BY gift_name
),
percentile_table AS (
    SELECT 
        gift_name, 
        ROUND(percent_rank() OVER (
        ORDER BY n_gifts
        )::numeric,2) AS percentile
    FROM num_gifts
)

SELECT gift_name, percentile
FROM percentile_table
WHERE percentile = (
    SELECT DISTINCT percentile
    FROM percentile_table
    ORDER BY percentile DESC
    LIMIT 1 OFFSET 1
)
ORDER BY gift_name ASC
LIMIT 1;
