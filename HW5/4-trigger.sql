CREATE TRIGGER QTYChanger
ON BookWithWriterAndQTY
INSTEAD OF INSERT
AS
BEGIN
  SET NOCOUNT ON;
  INSERT INTO Book(Bookname, authorname, QTY)
  SELECT Bookname, authorname, 
    CASE WHEN QTY < 1000 THEN 1000 ELSE QTY END
  FROM inserted;
END;

INSERT INTO BookWithWriterAndQTY (Bookname, authorname, QTY)
VALUES ('Book1', 'Author1', 500);



