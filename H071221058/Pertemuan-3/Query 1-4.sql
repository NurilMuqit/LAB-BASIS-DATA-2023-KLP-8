# Create DB
CREATE DATABASE praktikum3;
USE praktikum3;

# Table mahasiswa
CREATE TABLE mahasiswa (
	NIM VARCHAR(10) PRIMARY KEY,
	Nama VARCHAR(50) NOT NULL,
	Kelas CHAR(1) NOT NULL,
	status VARCHAR(50) NOT NULL,
	Nilai INT 
);


INSERT INTO mahasiswa 
VALUES 
('H071241056','Kotlina','A','Hadir',100),
('H071241060','Pitonia','A','Alfa',85),
('H071241063','Javano','A','Hadir',50),
('H071241065','Ciplus Kuadra','B','Hadir',65),
('H071241066','Pihap E','B','Hadir',85),
('H071241079','Ruby','B','Alfa',90);


DESC mahasiswa;
SELECT * FROM mahasiswa;

# Nomor 2
UPDATE mahasiswa
SET 
	nilai = 0,
	Kelas = 'C'
WHERE STATUS = 'alfa';
SELECT * FROM mahasiswa;



# Nomor 3
DELETE FROM mahasiswa
WHERE nilai > 90 AND Kelas = 'A'
SELECT * FROM mahasiswa;



# Nomor 4
INSERT INTO mahasiswa (NIM,Nama,Kelas,Status)
VALUE ('H071221058','Mahen','B','Pindahan');
--
UPDATE mahasiswa 
SET nilai = 50 
WHERE status = 'Alfa';
--
UPDATE mahasiswa
SET Kelas = 'A'

SELECT * FROM mahasiswa;

# Live Coding library

USE library;
SELECT * FROM books;
DESC books;

# Nomor 1
ALTER TABLE books
MODIFY id INT(11) AUTO_INCREMENT; 
--
INSERT INTO books (isbn,title,pages,genre)
VALUES 
('9786020332956','Bumi',440,'Teenlit'),
('9786020822129','Pulang',400,'Aksi'),
('9786020324784','Hujan',320,'Drama');

# Nomor 2
INSERT INTO books (title,pages,genre)
VALUE ('Dilan',900,'Romance');

#Nomor 3
UPDATE books 
SET genre = 'drama'
WHERE title ='Bumi';

#Nomor 4
DELETE FROM books
WHERE pages < 400;

DELETE FROM books
