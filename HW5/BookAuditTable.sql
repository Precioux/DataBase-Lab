CREATE TABLE Book_Audit (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    Bookname VARCHAR(30),
    yearpublish INT,
    authorname VARCHAR(40),
    QTY INT,
	Ins_or_del INT
);
