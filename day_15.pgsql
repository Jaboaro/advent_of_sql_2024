SELECT s.timestamp, a.place_name 
FROM sleigh_locations s
JOIN areas a ON ST_Intersects(a.polygon, s.coordinate);
--ORDER BY timestamp DESC LIMIT 1;
