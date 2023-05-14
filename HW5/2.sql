DISABLE TRIGGER no_insert ON Book;

CREATE TRIGGER tr_Book_Audit
ON Book
AFTER INSERT, DELETE
AS
BEGIN
    IF EXISTS (SELECT * FROM inserted)
    BEGIN
        INSERT INTO Book_Audit (Bookname, yearpublish, authorname, QTY, Ins_or_del)
        SELECT Bookname, yearpublish, authorname, QTY, 1 FROM inserted;
    END
    IF EXISTS (SELECT * FROM deleted)
    BEGIN
        INSERT INTO Book_Audit (Bookname, yearpublish, authorname, QTY, Ins_or_del)
        SELECT Bookname, yearpublish, authorname, QTY, 0 FROM deleted;
    END
END

INSERT INTO Book (Bookname, yearpublish, authorname, QTY)
VALUES ('The Great Gatsby', 1925, 'F. Scott Fitzgerald', 10);


DELETE FROM Book WHERE ID = 1;


