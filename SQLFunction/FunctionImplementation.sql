CREATE DATABASE dbPernikahan;
USE dbPernikahan;

-- NO. 1
CREATE TABLE tblPasutri (
    noid INT PRIMARY KEY,
    nama VARCHAR(50),
    jkelamin CHAR(1),
    tgllahir DATETIME,
    kotaasal VARCHAR(50),
    pasangan INT,
    tglnikah DATETIME,
    Foreign Key (pasangan) REFERENCES tblPasutri (noid) 
);
INSERT INTO tblPasutri (noid, nama, jkelamin, tgllahir, kotaasal, tglnikah)
VALUES
    (1, 'YUNITA TRIRATNADI A', 'W', '1981-11-29 23:11:10', 'YOGYAKARTA', '2008-09-11 12:09:41'),
    (2, 'YULIA', 'W', '1976-12-05 19:12:21', 'SEMARANG', '2011-10-23 05:10:45'),
    (3, 'YOLA AZERTI SARI', 'W', '1983-06-01 03:06:40', 'MAGELANG', '2011-06-08 17:06:28'),
    (4, 'YETI SULIANA', 'W', '1986-04-18 04:04:50', 'YOGYAKARTA', '2005-01-14 21:01:04'),
    (5, 'YETI KURNIATI P', 'W', '1976-02-18 21:02:18', 'MUNTILAN', '2008-11-19 23:11:50'),
    (6, 'ZIAD', 'P', '1981-07-08 17:07:06', 'YOGYAKARTA', '2008-09-11 12:09:41'),
    (7, 'TUNJUNG ARIWIBOWO', 'P', '1978-10-25 07:10:39', 'YOGYAKARTA', '2011-10-23 05:10:45'),
    (8, 'SUGIMAN', 'P', '1976-09-28 01:09:38', 'MUNTILAN', '2011-06-08 17:06:28'),
    (9, 'SIGIT SUTOPO', 'P', '1976-06-22 00:06:50', 'YOGYAKARTA', '2005-01-14 21:01:04'),
    (10, 'RICKY PERMANADJAYA', 'P', '1989-06-09 07:06:23', 'MAGELANG', '2008-11-19 23:11:50');

UPDATE tblPasutri SET pasangan = 6 WHERE noid = 1;
UPDATE tblPasutri SET pasangan = 7 WHERE noid = 2;
UPDATE tblPasutri SET pasangan = 8 WHERE noid = 3;
UPDATE tblPasutri SET pasangan = 9 WHERE noid = 4;
UPDATE tblPasutri SET pasangan = 10 WHERE noid = 5;
UPDATE tblPasutri SET pasangan = 1 WHERE noid = 6;
UPDATE tblPasutri SET pasangan = 2 WHERE noid = 7;
UPDATE tblPasutri SET pasangan = 3 WHERE noid = 8;
UPDATE tblPasutri SET pasangan = 4 WHERE noid = 9;
UPDATE tblPasutri SET pasangan = 5 WHERE noid = 10;

SELECT * FROM tblpasutri;

-- NO.2
SELECT
    PRIA.nama AS PRIA,
    WANITA.nama AS WANITA,
    PRIA.tglnikah AS 'TANGGAL MENIKAH',
    CASE
        WHEN TIMESTAMPDIFF(YEAR, PRIA.tglnikah, NOW()) >= 15 THEN 'SUDAH MENIKAH >= 15 TAHUN'
        ELSE 'BELUM MENIKAH > 15 TAHUN'
    END AS KETERANGAN
FROM
    tblPasutri AS PRIA
JOIN
    tblPasutri AS WANITA ON PRIA.pasangan = WANITA.noid
WHERE
    PRIA.jkelamin = 'P'
    AND WANITA.jkelamin = 'W';


-- No.3
SELECT 
    P.nama AS 'PRIA LAHIR SEBELUM 1990',
    P.kotaasal AS 'KOTA ASAL PRIA',
    W.nama AS 'WANITA',
    W.kotaasal AS 'KOTA ASAL WANITA',
    IF (P.kotaasal = W.kotaasal, 'Nikah Sekota', 'Nikah Beda Kota') AS KETERANGAN
FROM tblpasutri as P
JOIN tblpasutri AS W on P.pasangan = W.noid
WHERE P.jkelamin = 'P' AND P.tgllahir < '1990-01-01 00:00:00';

-- No. 4
SELECT
    P.nama AS PRIA,
    TIMESTAMPDIFF(YEAR, P.tgllahir, NOW()) AS 'UMUR PRIA',
    W.nama AS WANITA,
    TIMESTAMPDIFF(YEAR, W.tgllahir, NOW()) AS 'UMUR WANITA',
    CASE
        WHEN TIMESTAMPDIFF(YEAR, P.tgllahir, NOW()) > TIMESTAMPDIFF(YEAR, W.tgllahir, NOW()) THEN CONCAT('UMUR PRIA LEBIH TUA: ', TIMESTAMPDIFF(YEAR, P.tgllahir, NOW()) - TIMESTAMPDIFF(YEAR, W.tgllahir, NOW()), ' TAHUN')
        WHEN TIMESTAMPDIFF(YEAR, P.tgllahir, NOW()) < TIMESTAMPDIFF(YEAR, W.tgllahir, NOW()) THEN CONCAT('UMUR WANITA LEBIH TUA: ', TIMESTAMPDIFF(YEAR, W.tgllahir, NOW()) - TIMESTAMPDIFF(YEAR, P.tgllahir, NOW()), ' TAHUN')
        ELSE 'UMUR PRIA SAMA DENGAN UMUR WANITA'
    END AS KETERANGAN
FROM
    tblPasutri AS W ON P.pasangan = W.noid;

--NO.5
SELECT
    nama AS 'Nama Lengkap',
    SUBSTRING_INDEX(nama, ' ', 1) AS 'Nama Depan',
    CASE
        WHEN LENGTH(nama) - LENGTH(REPLACE(nama, ' ', '')) > 0 THEN SUBSTRING_INDEX(nama, ' ', -2)
        ELSE ''  6
    END AS 'Nama Belakang'
FROM tblPasutri;

-- No.6
SELECT
    nama AS 'Nama Lengkap',
    SUBSTRING_INDEX(nama, ' ', 1) AS 'Nama Depan',
    CASE
        WHEN LENGTH(nama) - LENGTH(REPLACE(nama, ' ', '')) > 1 THEN SUBSTRING_INDEX(SUBSTRING_INDEX(nama, ' ', 2), ' ', -1)
        ELSE ''
    END AS 'Nama Tengah',
    CASE
        WHEN LENGTH(nama) - LENGTH(REPLACE(nama, ' ', '')) > 0 THEN SUBSTRING_INDEX(nama, ' ', -1)
        ELSE ''
    END AS 'Nama Belakang'
FROM tblPasutri;