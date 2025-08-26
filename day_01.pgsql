WITH
    complexity AS (
        SELECT 
            toy_name, 
            CASE 
                WHEN difficulty_to_make = 1 THEN 'Simple Gift'
                WHEN difficulty_to_make = 2 THEN 'Moderate Gift'
                ELSE 'Complex Gift' END AS gift_complexity
        FROM toy_catalogue
    ),

    workshop AS (
        SELECT 
            toy_name,  
            CASE
                WHEN category = 'outdoor' THEN 'Outside Workshop'
                WHEN category = 'educational' THEN 'Learning Workshop'
                ELSE 'General Workshop'
                END AS workshop_assignment
        FROM toy_catalogue
    ),


    wish_info AS (
        SELECT
            list_id,
            w.child_id,
            wishes->>'first_choice' AS primary_wish,
            wishes->>'second_choice' AS backup_wish,
            wishes->'colors'->>0 AS favorite_color,
            json_array_length(wishes->'colors') AS color_count
        FROM wish_lists w
    )


SELECT 
    c.name,
    w.primary_wish,
    w.backup_wish,
    w.favorite_color,
    w.color_count,
    complexity.gift_complexity,
    workshop.workshop_assignment
FROM wish_info w
JOIN children c ON w.child_id = c.child_id
JOIN complexity ON w.primary_wish = complexity.toy_name
JOIN workshop ON w.primary_wish = workshop.toy_name
ORDER BY c.name
LIMIT 5;
