CREATE DATABASE db_praktikum;

USE db_praktikum;

CREATE TABLE students (
	student_id INT PRIMARY KEY
	name VARCHAR(50) NOT NULL,
	email VARCHAR(255) UNIQUE,
	gender CHAR(1), 
);

CREATE TABLE classes (
	class_id INT PRIMARY KEY AUTO_INCREMENT
	class_name VARCHAR(50), 
);

CREATE TABLE class_student (
	enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
	grade CHAR(1) DEFAULT 'E',
	student_id INT,
	class_id INT,
	
	FOREIGN KEY (student_id) REFERENCES students(student_id),
	FOREIGN KEY (class_id) REFERENCES classes(class_id)
);

DESC classes