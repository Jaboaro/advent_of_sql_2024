WITH
    reindeer_speed_by_exercise AS (
        SELECT 
            reindeer_id, 
            exercise_name, 
            ROUND(avg(speed_record),2) AS avg_speed_exercise
        FROM training_sessions
        GROUP BY reindeer_id, exercise_name
    ),
    reindeer_max_avg_speed AS (
        SELECT reindeer_id, max(avg_speed_exercise) AS max_avg_speed
        FROM reindeer_speed_by_exercise
        GROUP BY reindeer_id
        ORDER BY max_avg_speed DESC
        LIMIT 3
    )



SELECT r.reindeer_name, t.max_avg_speed 
FROM reindeer_max_avg_speed t
JOIN reindeers r
ON
    r.reindeer_id = t.reindeer_id
ORDER BY t.max_avg_speed DESC;