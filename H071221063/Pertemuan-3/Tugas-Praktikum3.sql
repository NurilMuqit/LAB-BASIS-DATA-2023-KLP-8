-- No 1
CREATE DATABASE praktikum3
praktikum3CREATE TABLE mahasiswa(
NIM VARCHAR(10) PRIMARY KEY,
Nama VARCHAR(50) NOT NULL,
Kelas CHAR(1) NOT NULL,
`status` VARCHAR(50) NOT NULL,
Nilai INT)

DESC mahasiswa

INSERT INTO mahasiswa(NIM, Nama, Kelas, `status`, Nilai)
				VALUE("H071241056", "Kotlina", 'A', "Hadir", 100),
						("H071241060", "Pitonia", 'A', "Alfa", 85),
						("H071241063", "Javano", 'A', "Hadir", 50),
						("H071241065", "Ciplus Kuadra", 'B', "Hadir", 65),
						("H071241066", "Pihap E", 'B', "Hadir", 85),
						("H071241079", "Ruby", 'B', "Alfa", 90);
						
SELECT * FROM mahasiswa


-- No 2
UPDATE mahasiswa
SET Kelas = 'C', Nilai = 0
WHERE `status` = "Alfa"

-- No 3
DELETE FROM mahasiswa
WHERE Kelas = 'A' AND Nilai > 90;

-- No 4
INSERT INTO mahasiswa(NIM, Nama, Kelas, `status`)
				VALUE("H071221063", "Aditya", 'D', "Pindahan")
				
-- -------------------------------------------------------------	
		
UPDATE mahasiswa
SET Nilai = 50
WHERE `status` = "Alfa"

-- -------------------------------------------------------------

UPDATE mahasiswa
SET Kelas = 'A'


-- -----------------------
-- tugas tambahan
-- No 1
INSERT INTO books(isbn, title, pages, genre)
				VALUE (9786020332956,"Bumi", 440, "Teenlt"),
						(9786020822129,"Pulang", 400, "Aksi"),
						(9786020324784,"Hujan", 320, "Drama");

SELECT * FROM books
-- -------------------------------------------------------------
-- No 2						
INSERT INTO books(title, pages, genre)
				VALUE("SIKSA NERAKA", 10, "Religi")

-- No 3
UPDATE books
SET genre = "drama"
WHERE title = "Bumi"

-- No 4
DELETE FROM books
WHERE pages < 400






