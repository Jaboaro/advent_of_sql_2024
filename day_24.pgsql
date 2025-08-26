SELECT 
    song_title,
    count(*) AS total_plays,
    sum(
        CASE
            WHEN up.duration < s.song_duration THEN 1
            ELSE 0
            END
    ) AS total_skips
FROM user_plays up 
JOIN songs s
    ON s.song_id = up.song_id
GROUP BY song_title
ORDER BY total_plays DESC, total_skips ASC, song_title;