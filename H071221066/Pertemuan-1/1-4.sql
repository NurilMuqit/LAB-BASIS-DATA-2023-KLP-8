-- no 1
CREATE DATABASE library;
USE library;

CREATE TABLE books (
	id INT PRIMARY KEY,
	isbn VARCHAR(50) UNIQUE,
	title VARCHAR(50) NOT NULL,
	pages INT,
	summary TEXT,
	genre VARCHAR(50) NOT NULL
);

-- no 2
ALTER TABLE books
MODIFY isbn CHAR(13);

-- no 3
ALTER TABLE books DROP summary;

-- no 4
DESCRIBE books;
SHOW TABLES;