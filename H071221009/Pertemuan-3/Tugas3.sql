CREATE DATABASE praktikum3
USE praktikum3

-- nomor 1
CREATE TABLE mahasiswa (
NIM VARCHAR(10) PRIMARY KEY,
Nama VARCHAR(50) NOT NULL,
Kelas CHAR(1) NOT NULL,
status VARCHAR(50) NOT NULL,
Nilai INT);

DESCRIBE mahasiswa;

DROP TABLE mahasiswa;

INSERT INTO mahasiswa
VALUES ('H071241056', 'Kotlina', 'A', 'Hadir', 100),
('H071241060', 'Pitonia', 'A', 'Alfa', 85),
('H071241063', 'Javano', 'A', 'Hadir', 50),
('H071241065', 'Ciplus Kuadra', 'B', 'Hadir', 65),
('H071241066', 'Pihap E', 'B', 'Hadir', 85),
('H071241079', 'Ruby', 'B', 'Alfa', 90);

-- nomor 2
UPDATE mahasiswa
SET Nilai = 0, Kelas = 'C'
WHERE STATUS = 'Alfa';

-- nomor 3
DELETE FROM mahasiswa
WHERE Nilai > 90 AND Kelas = 'A';

-- nomor 4
SELECT * FROM mahasiswa;

DELETE FROM mahasiswa
WHERE STATUS = 'Pindahan';

INSERT INTO mahasiswa (NIM, Nama, Kelas, STATUS)
VALUE ('H071221009', 'Nurul Alya', 'A', 'Pindahan');

UPDATE mahasiswa
SET Nilai = 50
WHERE STATUS = 'Alfa';

UPDATE mahasiswa
SET Kelas = 'A';

-- soal tambahan
USE library

SELECT * FROM books;
-- nomor 1
ALTER TABLE books
MODIFY id INT(11) AUTO_INCREMENT;

INSERT INTO books (isbn, title, pages, genre)
VALUES 
('9786020332956', 'Bumi', 440, 'Teenlit'),
('9786020822129', 'Pulang', 400, 'Aksi'),
('9786020324784', 'Hujan', 320, 'Drama');

-- nomor 2
INSERT INTO books (title, pages, genre)
VALUE ('Matahari', 400, 'Fantasi');

-- nomor 3
UPDATE books
SET genre = 'Drama'
WHERE title = 'Bumi';

-- nomor 4
DELETE FROM books
WHERE pages < 400;