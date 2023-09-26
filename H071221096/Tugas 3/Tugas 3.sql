-- nomor 1
CREATE DATABASE praktikum3;

USE praktikum3;

CREATE TABLE mahasiswa (
	NIM VARCHAR (10) PRIMARY KEY,
	Nama VARCHAR (50) NOT NULL,
	Kelas CHAR (1) NOT NULL,
	`status` VARCHAR (50) NOT NULL,
	Nilai INT (11)
	);
	
DESC mahasiswa;

INSERT INTO mahasiswa (NIM, Nama, Kelas, `status`, Nilai) 
VALUES ("H071241056", "Kotlina", "A", "Hadir", 100),
		("H071241060", "Pitonia", "A", "Alfa", 85),
		("H071241063", "Javano", "A", "Hadir", 50),
		("H071241065", "Ciplus Kuadra", "B", "Hadir", 65),
		("H071241066", "Pihab E", "B", "Hadir", 85),
		("H071241079", "Ruby", "B", "Alfa", 90);
SELECT * FROM mahasiswa;

-- nomor 2
UPDATE mahasiswa
SET Nilai = 0 , Kelas = "C"
WHERE `status` = "Alfa"

-- nomor 3
DELETE FROM mahasiswa
WHERE nilai > 90 AND kelas = "A"

-- nomor 4
INSERT INTO mahasiswa (NIM, Nama, Kelas, `status`) 
VALUE ("H071221096", "Mayko Raditya Wirawan", "D", "Pindahan");

UPDATE mahasiswa
SET nilai = 50
WHERE status = "Alfa"

UPDATE mahasiswa 
SET Kelas = "A"

-- soal tambahan

-- nomor 1
USE library; 

DESC books

INSERT INTO books (isbn, title, pages, genre)
VALUES ("9786020332956", "Bumi", 440, "Teenlit"),
		 ("9786020822129", "Pulang", 400, "Aksi"),
		 ("9786020324784", "Hujan", 320, "Drama");
SELECT * FROM books

-- nomor 2
INSERT INTO books (title, pages, genre)
VALUE ("The Color of Heaven", 296, "Self-Discovery");

-- nomor 3
UPDATE books
SET genre = "Drama"
WHERE title = "Bumi"

-- nomor 4
DELETE FROM books
WHERE pages < 400
		
		