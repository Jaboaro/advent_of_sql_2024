SELECT 
    cleaning_receipts->>'drop_off'
    AS drop_off_date,
    cleaning_receipts AS receipt_details
FROM (
    SELECT 
        jsonb_array_elements(cleaning_receipts) 
        AS cleaning_receipts 
        FROM santarecords
)
WHERE cleaning_receipts->>'color' = 'green' AND
    cleaning_receipts->>'garment' = 'suit'
ORDER BY drop_off_date DESC
LIMIT 1;