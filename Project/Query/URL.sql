CREATE TABLE URL_table (
    id INT IDENTITY(1,1) PRIMARY KEY,
    original_url VARCHAR(30) NOT NULL,
    shorten_url VARCHAR(30) NOT NULL,
    submit_date DATETIME DEFAULT GETDATE(),
    expire_date DATETIME,
    url_view INT DEFAULT 0
);
