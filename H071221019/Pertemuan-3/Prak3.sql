-- 1
CREATE DATABASE praktikum3

USE praktikum3

CREATE TABLE mahasiswa (
	NIM VARCHAR(10) PRIMARY KEY,
	Nama VARCHAR(50) NOT NULL,
	Kelas CHAR(1) NOT NULL,
	status VARCHAR(50) NOT NULL,
	Nilai INT(11)
);

DESC mahasiswa

INSERT INTO mahasiswa
VALUES ('H071241056','Kotlina','A', 'Hadir', 100),
		('H071241060','Pitonia','A', 'Alfa', 85),
		('H071241063','Javano','A', 'Hadir', 50),
		('H071241065','Ciplus Kuadra','B', 'Hadir', 65),
		('H071241066','Pihap E','B', 'Hadir', 85),
		('H071241079','Ruby','B', 'Alfa', 90);

SELECT * FROM mahasiswa

-- 2
UPDATE mahasiswa
SET Kelas = 'C', Nilai = 0
WHERE status = 'Alfa';

SELECT * FROM mahasiswa

-- 3
DELETE FROM mahasiswa
WHERE Kelas = 'A' AND Nilai > 90;

SELECT * FROM mahasiswa

-- 4
INSERT INTO mahasiswa(Nim, Nama, Kelas, STATUS)
VALUE ('H071221019','Vicky Jesflinto','A','Pindahan')

UPDATE mahasiswa
SET Nilai = 50
WHERE status = 'Alfa';

UPDATE mahasiswa
SET kelas = 'A'

SELECT * FROM mahasiswa

-- 5
USE library

DESC books
-- 5.1
ALTER TABLE books
MODIFY id INT AUTO_INCREMENT;

INSERT INTO books (isbn, title, pages, genre)
VALUES (9786020332956, 'Bumi', 440, 'Teenlit'),
		(9786020822129, 'Pulang', 400, 'Aksi'),
		(9786020324784, 'Hujan', 320, 'Drama');
		
SELECT * FROM books

-- 5.2
INSERT INTO books(title, pages, genre)
VALUE ('Siksa Kubur', 450, 'Religi')

-- 5.3
UPDATE books
SET genre = 'Drama'
WHERE title = 'Bumi';

-- 5.4
DELETE FROM books
WHERE pages < 400;
