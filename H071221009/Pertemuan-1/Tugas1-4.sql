CREATE DATABASE library
USE library
-- nomor 1
CREATE TABLE books (
	id INT PRIMARY KEY,
	isbn VARCHAR(50),
	title VARCHAR(50) NOT NULL,
	pages INT,
	summary TEXT,
	genre VARCHAR(50) NOT NULL,
	
	UNIQUE(isbn)
);
-- nomor 2
ALTER TABLE books
MODIFY isbn CHAR(13);
-- nomor 3
ALTER TABLE books DROP summary;
-- nomor 4
SHOW TABLES;
