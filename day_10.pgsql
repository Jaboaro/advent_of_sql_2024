-- OPTION 1 
WITH
drink_count AS (
    SELECT 
        date,
        sum(
            CASE
                WHEN drink_name = 'Eggnog' THEN quantity
                ELSE 0 END
        )AS eggnog,
        sum(
            CASE
                WHEN drink_name = 'Hot Cocoa' THEN quantity
                ELSE 0 END
        ) AS hot_cocoa,
        sum(
            CASE
                WHEN drink_name = 'Peppermint Schnapps' THEN quantity
                ELSE 0 END
        )AS peppermint_schnapps

    FROM drinks 
    GROUP BY date
    ORDER BY date
)
SELECT date FROM drink_count 
WHERE
    eggnog = 198 AND
    peppermint_schnapps = 298 AND
    hot_cocoa = 38;

-- OPTION 2 (USING PIVOT)
WITH 
    pivot_drink_count AS (
        SELECT * 
        FROM crosstab('SELECT date, drink_name, sum(quantity) FROM drinks GROUP BY date, drink_name ORDER BY 1,2',
        'SELECT DISTINCT drink_name FROM drinks ORDER BY 1') AS (
        date DATE,
        baileys NUMERIC,
        eggnog NUMERIC,
        hot_cocoa NUMERIC,
        mulled_wine NUMERIC,
        peppermint_schnapps NUMERIC,
        sherry NUMERIC
        )
    )
SELECT date FROM pivot_drink_count 
WHERE
    eggnog = 198 AND
    peppermint_schnapps = 298 AND
    hot_cocoa = 38;
