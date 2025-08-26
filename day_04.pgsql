SELECT toy_id,
    (SELECT count(*) FROM
        (SELECT unnest(new_tags) 
        EXCEPT 
        SELECT unnest(previous_tags))) AS added_tags,
    (SELECT count(*) FROM
        (SELECT toy_id, unnest(previous_tags) 
        INTERSECT 
        SELECT toy_id, unnest(new_tags))) AS unchanged_tags,
    (SELECT count(*) FROM
        (SELECT toy_id, unnest(previous_tags) 
        EXCEPT 
        SELECT toy_id, unnest(new_tags))) AS removed_tags
FROM toy_production
ORDER BY added_tags DESC
LIMIT 1; 

