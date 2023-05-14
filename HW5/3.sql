CREATE TRIGGER no_update_bookname
ON Book
FOR UPDATE
AS
BEGIN
    IF UPDATE(Bookname)
    BEGIN
        RAISERROR('Update not allowed on Bookname column', 16, 1)
        ROLLBACK TRANSACTION
    END
END

INSERT INTO Book (Bookname, yearpublish, authorname, QTY)
VALUES ('The Great Gatsby', 1925, 'F. Scott Fitzgerald', 10);

UPDATE Book
SET Bookname = 'To Kill a Mockingbird'
WHERE ID = 1;
