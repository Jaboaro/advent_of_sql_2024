WITH RECURSIVE
    company_hierarchy AS (
        SELECT 
            staff_id,
            staff_name,
            1 AS hierarchy_level,
            array[1] AS path
        FROM staff
        WHERE manager_id IS NULL

        UNION ALL
        
        SELECT 
            s.staff_id,
            s.staff_name,
            hierarchy_level + 1,
            path || array[s.staff_id]
        FROM staff s, company_hierarchy ch
        WHERE s.manager_id = ch.staff_id
    )

SELECT * FROM company_hierarchy
ORDER BY hierarchy_level DESC
LIMIT 5;
