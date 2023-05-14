CREATE VIEW BookWithWriterAndQTY AS
SELECT Book.ID, Book.Bookname, Book.authorname, Book.QTY
FROM Book;

CREATE TRIGGER ChangeQTY
INSTEAD OF INSERT ON BookWithWriterAndQTY
FOR EACH ROW
BEGIN
  IF NEW.QTY < 1000 THEN
    SET NEW.QTY = 1000;
  END IF;
  INSERT INTO Book(ID, Bookname, yearpublish, authorname, QTY)
  VALUES (NEW.ID, NEW.Bookname, NEW.yearpublish, NEW.authorname, NEW.QTY);
END;

