/*
    Fungsi matematika dalam sql

    String
    Matematika
    Statistik
    Logika
    Waktu
*/

CREATE DATABASE dbFungsi;
USE dbFungsi;

CREATE TABLE tblData (
    nama VARCHAR (255),
    tanggallahir VARCHAR (255),
    nilaites INT
);
INSERT INTO tblData VALUES
('Natalia Suwarno', '2001-03-1', 80),
('Dewi Wulandar', '2002-05-5', 60),
('Maria Andriyani', '2001-04-7', 55),
('Markus Hendriawan', '2002-05-12', 79),
('Robi William', '2001-03-12', 60),
('Vincent Herlambang', '1998-03-12', 95),
('Michael Wirya', '2001-03-21', 40);





-- ________________________________________________STRING FUNCTION__________________________________________________________ --

-- Function STRING (uppercase, lowercase)
SELECT nama,
    LOWER (nama) AS Huruf_Kecil,
    UPPER (nama) AS Huruf_Besar
FROM tblData;

-- Function mencari char lENGTH
SELECT nama,
    LENGTH (nama) AS Panjang_Nama
FROM tblData;

-- Function CONCAT (menggabungkan antar kolom)
SELECT nama,
    CONCAT ('Nama: ', nama, 'Nilai Tes: ', nilaites) AS Gabung
FROM tblData;

-- Function mencari keyword
SELECT nama,
    LOCATE ('Natalia', nama, 1) AS Cari_Keyword_Natalia
FROM tblData;

-- LOCATE but using SUBSTRING
SELECT nama,
    LOCATE ('Natalia', nama, 1) AS Cari_Keyword_Natalia,
    SUBSTR (nama, 3, 5) as Ambil
FROM tblData;

-- ________________________________________________STATISTICS FUNCTION__________________________________________________________ --

-- STATISTICS FUNCTION
SELECT nilaites,
    MAX (nilaites) AS Nilai_Tertinggi,
    MIN (nilaites) AS Nilai_Terendah,
    AVG (nilaites) AS Nilai_Rata_Rata,
    COUNT (nilaites) AS Jumlah_Data,
    SUM (nilaites) AS Jumlah_Nilai,
    STDDEV (nilaites) AS Standar_Deviasi_Nilai,
    MID (nilaites) AS Median_Nilai
FROM tblData;

-- ________________________________________________TIME FUNCTION__________________________________________________________ --

-- Function mencari tanggal 
SELECT tanggallahir,
    NOW() AS Saat_ini,
    YEAR(tanggallahir) AS Tanggal_Tahun,
    MONTH(tanggallahir) AS Tanggal_Bulan,
    DAY (tanggallahir) AS Hari,
    DAYNAME (tanggallahir) AS Nama_Hari,
    CURDATE () AS Tanggal_Saat_Ini,
    CURTIME () AS Waktu_Saat_Ini
FROM tblData;

-- Function umur
SELECT tanggallahir,
    YEAR(NOW()) - YEAR(tanggallahir) AS Umur_Tahun,
    DATEDIFF (NOW(), tanggallahir) AS Umur_Hari
FROM tblData;

-- ________________________________________________LOGICS FUNCTION__________________________________________________________ --

-- Function IF dan CASE
-- IF = 2 kondisi
SELECT nama, tanggallahir,
    YEAR(tanggallahir) AS Tahun_Lahir,
    IF ( YEAR(tanggallahir) >= 2000, 'Lahir Setelah Tahun 2000', 'Lahir Sebelum Tahun 2000') AS Keterangan
FROM tblData;

SELECT nama, nilaites,
    IF (nilaites >= 60, 'Lulus', 'Tidak Lulus') AS Nilai_Kelulusan
FROM tblData;

-- CASE = Banyak Kondisi
SELECT nama, nilaites,
    CASE 
            WHEN nilaites >= 80 THEN 'A' 
            WHEN nilaites BETWEEN 60 AND 79 THEN 'B'
            WHEN nilaites BETWEEN 50 AND 69 THEN 'C'
            WHEN nilaites BETWEEN 40 AND 59 THEN 'D'
        ELSE 'E'
    END AS Nilai_Huruf
FROM tblData;

-- IF and CASE Function
SELECT nama, nilaites,
    CASE 
            WHEN nilaites >= 80 THEN 'A' 
            WHEN nilaites BETWEEN 60 AND 79 THEN 'B'
            WHEN nilaites BETWEEN 50 AND 69 THEN 'C'
            WHEN nilaites BETWEEN 40 AND 59 THEN 'D'
        ELSE 'E'
    END AS Nilai_Huruf,
    IF (nilaites >= 60, 'Lulus', 'Tidak Lulus') AS Nilai_Kelulusan
FROM tblData;
