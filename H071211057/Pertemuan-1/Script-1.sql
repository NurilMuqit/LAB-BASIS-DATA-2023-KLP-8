create database library

use library

CREATE TABLE books (
  id INT PRIMARY KEY, 
  isbn VARCHAR(50) UNIQUE, 
  title VARCHAR(50) NOT NULL, 
  pages INT,
  summary TEXT,
  genre VARCHAR(50) NOT NULL
);

desc books

alter table books
modify isbn char(13),drop column summary

desc books

create database db_praktikum
use db_praktikum

desc students

CREATE TABLE students (
  student_id int(11) PRIMARY KEY,
  name varchar(50),
  email varchar(255) UNIQUE,
  gender char(1)
);

desc students
desc classes

create table classes (
	class_id int (11) auto_increment primary key,
	class_name varchar(50)
);


desc class_student
CREATE TABLE class_student (
  enrollment_id int(11) AUTO_INCREMENT PRIMARY KEY,
  grade char(1) DEFAULT 'E',
  student_id int(11),
  class_id int(11),
  FOREIGN KEY (student_id) REFERENCES students(student_id),
  FOREIGN KEY (class_id) REFERENCES classes(class_id)
);