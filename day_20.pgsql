/*
Firstly, I tried to create a JSON as the problem suggest but since there can be repeated keys in a url,
I just used a simple array.
*/
WITH 
url_keys AS (
    SELECT 
        url,
        string_to_array(split_part(url, '?', 2), '&') AS query_parameters,
        split_part(
            unnest(string_to_array(split_part(url, '?', 2), '&')), '=', 1
        ) AS keys
    FROM web_requests
    WHERE url LIKE '%utm_source=advent-of-sql%'
)

SELECT
    url,
    query_parameters,
    count(DISTINCT keys) AS count_params
FROM url_keys
GROUP BY url, query_parameters
ORDER BY count_params DESC, url
LIMIT 5;


