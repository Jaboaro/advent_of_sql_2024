WITH letters_ab AS (
    SELECT * FROM letters_a
    UNION ALL
    SELECT * FROM letters_b
)
SELECT 
    string_agg(chr(value), '') AS result
FROM letters_ab 
WHERE 
    value BETWEEN 97 AND 122 OR     --a-z
    value BETWEEN 65 AND 90 OR      --A-Z
    value BETWEEN 32 AND 34 OR      -- ! " space
    value BETWEEN 39 AND 41 OR      -- ' ( )
    value BETWEEN 44 AND 46 OR      -- , - .
    value IN (58, 59, 63);          -- : ; ?