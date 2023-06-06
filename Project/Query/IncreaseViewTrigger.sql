CREATE TRIGGER IncreaseViewTrigger
ON URL_table
AFTER UPDATE
AS
BEGIN
    -- Insert the original_url and the increasing date into the view_table
    INSERT INTO view_table (original_url, increasing_date)
    SELECT URL_table.original_url, GETDATE()
    FROM URL_table
    INNER JOIN inserted ON URL_table.shorten_url = inserted.shorten_url;
END;
