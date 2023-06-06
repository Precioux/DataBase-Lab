CREATE VIEW MappingDetails AS
SELECT
    original_url,
    shorten_url,
    DATEDIFF(day, GETDATE(), expire_date) AS remaining_days,
    views
FROM
    URL
