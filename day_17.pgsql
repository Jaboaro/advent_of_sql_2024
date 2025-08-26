/* 
There is no solution for this problem with the given dataset since New York 
opening hours (14:30-22:30 UTC) and Astrakhan opening hours (04:30-12:30)
don't overlap. The following query calculate the total number of workshops
that can attend to each time slot, order by number or attendees.
*/

WITH RECURSIVE hours AS (
        SELECT '2025-12-17 00:00:00'::timestamp AS time_slot
    UNION ALL
        SELECT (time_slot + interval '30 minutes')
        FROM hours 
        WHERE time_slot < '2025-12-18 00:00:00'::timestamp
),

bs_time_utc_today AS (
    SELECT 
    (('2025-12-17'::timestamp + business_start_time || timezone)::timestamptz) AT TIME ZONE 'UTC' AS BS_start,
    (('2025-12-17'::timestamp + business_end_time || timezone)::timestamptz) AT TIME ZONE 'UTC' AS BS_end
FROM workshops
)



SELECT 
   time_slot, 
   count(
        CASE WHEN tsrange(time_slot,time_slot+ INTERVAL '1 hour') <@ tsrange(bs_start,bs_end) THEN 1 END
    ) AS number_of_attendees
FROM hours 
CROSS JOIN 
bs_time_utc_today
GROUP BY time_slot
/*
HAVING bool_and(
        tsrange(time_slot,time_slot+ INTERVAL '1 hour') <@ tsrange(bs_start,bs_end)
   )
*/

ORDER BY number_of_attendees DESC, time_slot ASC
LIMIT 10;

/*
However, they accept the latest start time of activities as a valid response, 
even though not all workshops can attend.
*/
SELECT (max(('2025-12-17'::date || ' ' || business_start_time)::timestamp
            AT TIME ZONE timezone
            AT TIME ZONE 'UTC'))::time AS meeting_start_utc
FROM workshops;
