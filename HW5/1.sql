CREATE TRIGGER no_insert
ON Book
INSTEAD OF INSERT
AS
BEGIN
    PRINT 'No change was done'
END;

INSERT INTO Book (Bookname, yearpublish, authorname, QTY) VALUES ('Test Book', 2023, 'Test Author', 5);
