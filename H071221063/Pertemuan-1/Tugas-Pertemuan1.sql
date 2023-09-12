
-- NO 1
CREATE DATABASE library -- membuat database library
CREATE TABLE books( -- membuat tabel books
id INT PRIMARY KEY,
isbn VARCHAR(50) UNIQUE,
title VARCHAR(50) NOT NULL,
pages INT,
SUMMARY TEXT,
genre VARCHAR(50) NOT NULL
)

DROP TABLE books
DESCRIBE books

-- --NO 2 sampai 4
ALTER TABLE books -- mengubah struktur tabel books
MODIFY isbn CHAR(13), -- memodifikasi atribut isbn
DROP SUMMARY

ALTER TABLE books DROP SUMMARY -- menghapus atribut summary

DESCRIBE books -- menampilkan struktur tabel books secara detail

-- NO 5
CREATE DATABASE db_praktikum -- membuat database

CREATE TABLE students( -- membuat table students
student_id INT PRIMARY KEY,
name VARCHAR(50),
email VARCHAR(255) UNIQUE,
gender CHAR(1)
)

CREATE TABLE classes( -- membuat tabel classes
class_id INT PRIMARY KEY AUTO_INCREMENT,
class_name VARCHAR(50)
)

CREATE TABLE class_student( -- membuat tabel class_student
enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
grade CHAR(1) DEFAULT 'E',
student_id INT,
class_id INT,

FOREIGN KEY (student_id) REFERENCES students(student_id), -- menghubungkan tabel class_student dengan tabel student
FOREIGN KEY (class_id) REFERENCES classes(class_id) -- menghubungkan tabel class_student dengan tabel classes
)

DESCRIBE class_student


