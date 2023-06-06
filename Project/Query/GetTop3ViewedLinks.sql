CREATE FUNCTION dbo.GetTop3ViewedLinks()
RETURNS TABLE
AS
RETURN (
    WITH RankedLinks AS (
        SELECT original_url, shorten_url, views,
            DENSE_RANK() OVER (ORDER BY views DESC) AS rank
        FROM URL
    )
    SELECT original_url, shorten_url, views
    FROM RankedLinks
    WHERE rank <= 3
);
