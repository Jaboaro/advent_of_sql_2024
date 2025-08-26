WITH
    gaps AS (
        SELECT 
            id + 1 AS gap_start, 
            -1+lead(id,1) OVER (ORDER BY ID) AS gap_end
        FROM sequence_table 
    ),
    gaps_series AS (
        SELECT 
            gap_start, 
            gap_end,
            GENERATE_SERIES(gap_start, gap_end) AS gap_numbers
        FROM GAPS
        WHERE gap_end-gap_start +1 >= 1
    )


SELECT 
    gap_start, 
    gap_end,
    array_agg(gap_numbers) AS missing_numbers
FROM gaps_series 
GROUP BY gap_start, gap_end
ORDER BY gap_start;
