-- Creating a stored procedure to insert data into a table
CREATE PROCEDURE InsertURL
    @original_url VARCHAR(30),
    @shorten_url VARCHAR(30),
    @expire_date DATETIME
AS
BEGIN
    INSERT INTO URL_table (original_url, shorten_url, expire_date)
    VALUES (@original_url, @shorten_url, @expire_date);
END
