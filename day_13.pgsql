SELECT 
    split_part(email_addresses, '@', 2) AS domain,
    count(*) AS total_users,
    string_agg(email_addresses, ', ') AS ussers
FROM (SELECT unnest(email_addresses) as email_addresses FROM contact_list)
GROUP BY domain
ORDER by total_users DESC
LIMIT 5;