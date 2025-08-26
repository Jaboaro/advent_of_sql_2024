SELECT 
    t1.production_date, 
    t1.toys_produced, 
    t2.toys_produced AS previous_day_production,
    t1.toys_produced - t2.toys_produced AS production_change,
    round(
        100.0*(t1.toys_produced - t2.toys_produced)/t2.toys_produced,2
    ) AS production_change_percentage
FROM toy_production AS t1
JOIN toy_production AS t2 --LEFT JOIN doesn't delete first day
    ON t1.production_date = t2.production_date + 1
ORDER BY production_change_percentage DESC
LIMIT 1;