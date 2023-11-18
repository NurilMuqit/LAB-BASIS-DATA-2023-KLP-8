CREATE DATABASE praktikum3;
USE praktikum3;

## Nomor 1
CREATE TABLE COLUMNS(
	NIM VARCHAR(10) PRIMARY KEY,
	Nama VARCHAR(50) NOT NULL,
	Kelas CHAR(1) NOT NULL,
	`status` VARCHAR(50) NOT NULL,
	Nilai INT
);

DROP DATABASE praktikum3;

DESCRIBE columns;

INSERT INTO COLUMNS (NIM, Nama, Kelas, `status`, Nilai)
VALUES ('H071241056', 'Kotlina', 'A', 'Hadir' ,100),
		('H071241060' , 'Pitonia', 'A', 'Alfa', 85),
		('H071241063', 'Javano',  'A', 'Hadir', 50),
		('H071241065', 'Ciplus Kuadra', 'B', 'Hadir', 65),
		('H071241066', 'Pihap E', 'B', 'Hadir', 85),
		('H071241079', 'Ruby', 'B', 'Alfa', 90);
		
SELECT * FROM columns;

## Nomor 2
UPDATE COLUMNS
SET Nilai = 0, Kelas = 'C'
WHERE `status` = 'Alfa';

## Nomor 3
DELETE FROM columns
WHERE Nilai > 90 AND Kelas = 'A';

## Nomor 4
INSERT INTO columns (NIM, Nama, Kelas, `status`)
VALUES ('H071221095', 'Salsa', 'B', 'Pindahan');

UPDATE columns
SET Nilai = 50
WHERE `status` = 'Alfa';

UPDATE columns
SET Kelas = 'A';

### Latihan Soal
## Nomor 1
USE library;
ALTER TABLE books
MODIFY id INT AUTO_INCREMENT;

DESCRIBE books;

SELECT * FROM books;

INSERT INTO books (isbn, title, pages, genre)
VALUES ('9786020332956', 'Bumi', 440, 'Teenlit'),
		('9786020822129', 'Pulang', 400, 'Aksi'),
		('9786020324784', 'Hujan', 320, 'Drama');
		
## Nomor 2
INSERT INTO books (isbn, title, pages, genre)
VALUES (NULL, 'Holy Mother', 520, 'Horor');

## Nomor 3
UPDATE books
SET genre = 'drama'
WHERE title = 'Bumi';

## Nomor 4
DELETE FROM books
WHERE pages < 400;