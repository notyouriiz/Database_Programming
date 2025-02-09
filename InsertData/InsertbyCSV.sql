-- BASIC OPERATION --
/*
    hanya ada 3 operasi dalam sql:
    INSERT, UPDATE, DELETE

    prioritas pada insert adalah table yang memiliki PRIMARY KEY | karena menjadi reference bagi tabel lain
    
*/


USE dbApotik;

INSERT INTO tblObat
(kodeobat, namaobat, tglproduksi, exdate)
VALUES 
('02', 'OBAT A', '2024-02-15', '2029-06-22');

-- tanpa menyebut nama kolom, HARUS URUT TABEL--
INSERT INTO tblObat
VALUES 
('02', 'OBAT A', '2024-02-15', '2029-06-22');

-- insert multi value pada table --
INSERT INTO tblObat
VALUES 
('02', 'OBAT A', '2024-02-15', '2029-06-22'),
('03', 'OBAT B', '2024-02-15', '2029-06-22'),
('04', 'OBAT C', '2024-02-15', '2029-06-22'),
('05', 'OBAT D', '2024-02-15', '2029-06-22');

-- setting HEADER TABLE --
SELECT 
    kodeobat as KODE_OBAT,
    namaobat as NAMA_OBAT,
    tglproduksi as TANGGAL_PRODUKSI,
    exdate as EXDATE
FROM tblObat;

DELETE FROM tblPasien;
INSERT INTO tblPasien (
    kodepasien INT PRIMARY KEY,
    namapasien VARCHAR (255),
    tempatlahir VARCHAR (255) DEFAULT 'JAWA TENGAH',
    tanggallahir VARCHAR (255),
    jkelamin ENUM ('L', 'P'),
    goldarah ENUM ('A', 'B', 'AB', 'O'),
    alamat VARCHAR (255)
);
VALUES
(1, 'LilA', DEFAULT, '1991-09-01', 'P', 'AB', 'SEMARANG'),
(2, 'LilB', DEFAULT, '1992-08-02', 'P', 'A', 'SEMARANG'),
(3, 'LilC', DEFAULT, '1993-08-03', 'P', 'B', 'SEMARANG'),
(4, 'LilD', DEFAULT, '1994-08-04', 'P', 'AB', 'SEMARANG'),
(5, 'LilE', DEFAULT, '1995-08-05', 'P', 'A', 'SEMARANG'),
(6, 'LilF', DEFAULT, '1996-08-06', 'L', 'B', 'SEMARANG'),
(7, 'LilG', DEFAULT, '1997-08-07', 'L', 'O', 'SEMARANG'),
(8, 'LilH', DEFAULT, '1998-08-08', 'L', 'B', 'SEMARANG'),
(9, 'LilI', DEFAULT, '1999-08-09', 'L', 'O', 'SEMARANG'),
(10, 'LilJ', DEFAULT, '2000-08-10', 'L', 'B', 'SEMARANG');

SELECT
    kodepasien AS KODE_PASIEN,
    namapasien AS NAMA_PASIEN,
    tempatlahir AS TEMPAT_LAHIR,
    tanggallahir AS TANGGAL_LAHIR,
    jkelamin AS JENIS_KELAMIN,
    goldarah AS GOLONGAN_DARAH,
    alamat AS ALAMAT
FROM tblPasien;

-- level berikutnya yang diperhatikan adalah level PK dan FK --

INSERT INTO tblAntrian

(	1	,	'2023-02-07'    ,   4	),
(	2	,	'2023-10-28'	,	4	),
(	3	,	'2024-01-16'	,	3	),
(	4	,	'2023-03-11'	,	3	),
(	5	,	'2023-09-04'	,	2	),
(	6	,	'2023-10-13'	,	5	),
(	7	,	'2023-05-05'	,	10	),
(	8	,	'2023-07-27'	,	6	),
(	9	,	'2023-08-16'	,	7	),
(	10	,	'2023-10-13'	,	4	),
(	11	,	'2023-09-11'	,	6	),
(	12	,	'2024-01-15'	,	4	),
(	13	,	'2023-04-03'	,	6	),
(	14	,	'2023-03-02'	,	9	),
(	15	,	'2023-12-21'	,	3	),
(	16	,	'2023-05-24'	,	3	),
(	17	,	'2023-01-26'	,	4	),
(	18	,	'2023-02-14'	,	10	),
(	19	,	'2024-01-30'	,	9	),
(	20	,	'2023-11-02'	,	7	),
(	21	,	'2023-01-22'	,	1	),
(	22	,	'2023-09-03'	,	9	),
(	23	,	'2023-02-15'	,	1	),
(	24	,	'2023-08-26'	,	2	),
(	25	,	'2023-11-03'	,	3	),
(	26	,	'2023-07-17'	,	3	),
(	27	,	'2023-12-24'	,	5	),
(	28	,	'2023-05-01'	,	6	),
(	29	,	'2023-11-12'	,	6	),
(	30	,	'2023-10-09'	,	8	);


LOAD DATA LOCAL INFILE 'C:/Semester 4/Database Programming/Pertemuan 2/tblBeli.csv' INTO TABLE tblBeli 
FIELD TERMINATED BY ';'
ENCLOSED BY ''''
LINES TERMINATED BY '/r/n'
IGNORE 1 LINES;

UPDATE tblbeli
SET kodeobat = RIGHT(kodeobat, 1);

DROP tblbeli;
SELECT * FROM tblBeli;