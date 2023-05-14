CREATE TRIGGER PreventDelete
ON Book
INSTEAD OF DELETE
AS
BEGIN
  RAISERROR('Deleting from Book table is not allowed', 16, 1);
END;

INSERT INTO book (Bookname, yearpublish, authorname, QTY) VALUES ('The Catcher in the Rye', 1951, 'J.D. Salinger', 10);

DELETE FROM Book WHERE ID = 1;
