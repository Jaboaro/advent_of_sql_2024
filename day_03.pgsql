WITH num_guests AS(
    SELECT xpath('//food_item_id/text()',menu_data)::text[] AS array_food_ids,
        CASE
            WHEN xpath_exists('//attendance_details/headcount/total_present/text()',menu_data)
                THEN (xpath('//attendance_details/headcount/total_present/text()',menu_data))[1]::text::int
            WHEN xpath_exists('//attendance_record/total_guests/text()', menu_data)
                THEN (xpath('//attendance_record/total_guests/text()', menu_data))[1]::text::int
            WHEN xpath_exists('//total_count/text()',menu_datA)
                THEN (xpath('//total_count/text()',menu_data))[1]::text::int
            END AS num_guests
    FROM christmas_menus
)

SELECT 
    unnest(array_food_ids) AS food_id, 
    count(*) AS frequency 
FROM  num_guests 
WHERE num_guests>78
GROUP BY food_id
ORDER BY frequency DESC
LIMIT 5;
