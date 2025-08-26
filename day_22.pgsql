-- OPTION 1 (Using ANY)
SELECT count(*) AS numofelveswithsql
FROM elves
WHERE 'SQL' = ANY(string_to_array(skills,','));

-- OPTION 2
SELECT count(*) AS numofelveswithsql  
FROM elves
WHERE 
    upper(skills) LIKE '%,SQL,%' OR --In the middle
    upper(skills) LIKE  '%,SQL' OR -- Last item
    upper(skills) LIKE  'SQL,%' OR -- First item
    upper(skills) = 'SQL'; -- The only item


