-- Create the trigger
CREATE TRIGGER DeleteURLTrigger
ON url_table
AFTER DELETE
AS
BEGIN
  SET NOCOUNT ON;

  INSERT INTO deleted_table (original_url, shorten_url)
  SELECT original_url, shorten_url
  FROM deleted;
END;
