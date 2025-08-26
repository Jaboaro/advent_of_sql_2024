SELECT place_name, sum(time_interval) AS time_interval
FROM(
    SELECT
        a.place_name, 
        LAG(timestamp, 1, NULL) 
        OVER (ORDER BY timestamp DESC) - s.timestamp AS time_interval
    FROM sleigh_locations s
    JOIN areas a ON ST_Intersects(a.polygon, s.coordinate)

)
GROUP BY place_name
ORDER BY time_interval DESC;
