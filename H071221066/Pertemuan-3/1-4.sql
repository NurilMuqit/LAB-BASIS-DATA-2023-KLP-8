CREATE DATABASE praktikum3;

-- no 1
CREATE TABLE mahasiswa (
	NIM VARCHAR(10) PRIMARY KEY,
	Nama VARCHAR(50) NOT NULL,
	Kelas CHAR(1) NOT NULL,
	STATUS VARCHAR(50) NOT NULL,
	Nilai INT
);
DESC mahasiswa;

INSERT INTO mahasiswa
VALUES ('H071241056', 'Kotlina', 'A', 'Hadir', 100),
		('H071241060', 'Pitonia', 'A', 'Alfa', 85),
		('H071241063', 'Javano', 'A', 'Hadir', 50),
		('H071241065', 'Ciplus Kuadra', 'B', 'Hadir', 65),
		('H071241066', 'Pihap E', 'B', 'Hadir', 85),
		('H071241079', 'Ruby', 'B', 'Alfa', 90);

-- no 2
UPDATE mahasiswa 
SET Nilai = 0, Kelas = 'C'
WHERE STATUS = 'Alfa';

-- no 3
DELETE FROM mahasiswa 
WHERE kelas = 'A' AND Nilai > 90;

-- no 4
INSERT INTO mahasiswa (NIM, Nama, Kelas, STATUS)
VALUE ('H071221066', 'Zabryna Andiny', 'B', 'Pindahan');

UPDATE mahasiswa
SET Nilai = 50
WHERE STATUS = 'Alfa';

UPDATE mahasiswa 
SET kelas = 'A';

SELECT * FROM mahasiswa;

DROP TABLE mahasiswa;



-- SOAL TAMBAHAN --

-- NO 1
USE library;
DESC books;

ALTER TABLE books
MODIFY id INT(11) AUTO_INCREMENT; 
--
INSERT INTO books (isbn, title, pages, genre)
VALUES ('9786020332956', 'Bumi', 440, 'Teenlit'),
		('9786020822129', 'Pulang', 400, 'Aksi'),
		('9786020324784', 'Hujan', 320, 'Drama');

SELECT * FROM books;

-- no 2
INSERT INTO books (title, pages, genre)
VALUE ('Melodylan', 250, 'Fiksi');

-- no 3 
UPDATE books
SET genre = 'drama'
WHERE title = 'Bumi';

-- no 4 
DELETE FROM books
WHERE pages < 400;