-- 1 --
create database praktikum3

use praktikum3

create table Mahasiswa (
    NIM varchar(10) primary key,
    Nama varchar(50) not null,
    Kelas char(1) not null,
    Status varchar(50) not null,
    Nilai int(11)
);

desc mahasiswa

insert into Mahasiswa
values('H071241056','Kotlina','A','Hadir',100),
	   ('H071241060','Pitonia','A','Alfa',85),
	   ('H071241063','Javano','A','Hadir',50),
	   ('H071241065','Ciplus Kuadra','B','Hadir',65),
	   ('H071241066','Pihap E','B','Hadir',85),
	   ('H071241079','Rubi','B','Alfa',90);
	 
-- 2 --
update Mahasiswa 
set Kelas='C', Nilai=0 
where Status='Alfa'

-- 3 --
delete from mahasiswa
where kelas = 'A' and nilai > 90

select * from mahasiswa

-- 4 --
insert into mahasiswa (nim, nama, kelas, status)
value ('H071211057','Andi', 'C', 'Pindahan');

update Mahasiswa
set nilai = '50'
where status = 'Alfa'

update mahasiswa
set kelas = 'A'

-- Tugas Tambahan --
-- 1 --
alter table books 
modify id int not null auto_increment;

insert into books (isbn, title, pages, genre)
values (9786020332956, 'Bumi', 440, 'Teenit'), 
       (9786020822129, 'Pulang', 400, 'Aksi'), 
       (9786020324784, 'Hujan', 320, 'Drama');

-- 2 --
insert into books(title, pages, genre)
value ('Jumanji', 430, 'Adventure')

-- 3 --
update books
set title = 'Bumi'
where genre = 'Drama'

-- 4 --
delete from books
where pages < 400