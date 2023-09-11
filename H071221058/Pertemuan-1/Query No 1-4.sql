-- 1. BUAT DATABASE library
CREATE DATABASE library;
USE library;

-- CREATE TABLE BOOKS
CREATE TABLE books (
	id INT PRIMARY KEY,
	isbn VARCHAR(50) UNIQUE,
	title VARCHAR(50) NOT NULL,
	pages INT,
	summary TEXT,
	genre VARCHAR(50) NOT NULL  
);

-- 2. MODIFY isbn -> CHAR(13)
ALTER TABLE books
MODIFY isbn CHAR(13);

-- 3. Hapus field summary
ALTER TABLE books
DROP COLUMN summary;

-- 4. TAMPILKAN TABLE
DESCRIBE books;