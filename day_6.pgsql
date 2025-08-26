SELECT 
    c.name AS child_name,  
    g.name AS gift_name,
    g.price AS gift_price
FROM children c
JOIN gifts g
    ON c.child_id = g.child_id
WHERE g.price > (SELECT avg(price) FROM gifts)
ORDER BY g.price ASC
LIMIT 3;