/*
Despite of this problem defines "peers" as employees who share both the both 
the same manager and the same level in hierarchy, the expected answer does 
only takes account of same-level-employees as peers. In this dataset, 
to be "real peers" and to be same-manager-employees are exactly the same thing, 
by the way.
*/
WITH RECURSIVE
    company_hierarchy AS (
        SELECT 
            staff_id,
            staff_name,
            1 AS hierarchy_level,
            array[1] AS path,
            manager_id
        FROM staff
        WHERE manager_id IS NULL

        UNION ALL
        
        SELECT 
            s.staff_id,
            s.staff_name,
            hierarchy_level + 1,
            path || array[s.staff_id],
            s.manager_id
        FROM staff s, company_hierarchy ch
        WHERE s.manager_id = ch.staff_id
    )

SELECT 
    staff_id, 
    staff_name, 
    hierarchy_level,
    path,
    manager_id,
    count(*) OVER (PARTITION BY manager_id) AS peers_same_manager,
    count(*) OVER (PARTITION BY hierarchy_level) AS peers_same_level,
    count(*) OVER (PARTITION BY manager_id,hierarchy_level) AS real_peers
FROM company_hierarchy
ORDER BY peers_same_level DESC, hierarchy_level ASC, staff_id ASC
LIMIT 5;