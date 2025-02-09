/* CREATE DATABASE APOTIK;*/
/*USE APOTIK;*/
CREATE TABLE tblPasien(
    kode_pasien INT PRIMARY KEY,
    nama_pasien VARCHAR(100) NOT NULL,
    tempat_lahir VARCHAR(100) DEFAULT 'SEMARANG',
    tanggal_lahir DATETIME,
    jenis_kelamin ENUM ('L', 'P'),
    golongan_darah ENUM ('A', 'B', 'AB', 'O'),
    alamat VARCHAR(100) NOT NULL,
    no_hp VARCHAR(20) UNIQUE,
    warna SET ('BIRU', 'MERAH', 'KUNING', 'HIJAU', 'HITAM', 'PUTIH')
);
SHOW TABLES;

ALTER TABLE tblPasien
ADD email VARCHAR (255);
DESC tblPasien;

ALTER TABLE tblPasien
DROP COLUMN warna;
DESC tblpasien;


CREATE TABLE tblObat(
    kode_obat CHAR(2) PRIMARY KEY,
    nama_obat VARCHAR(10) NOT NULL,
    tanggal_produksi DATETIME, 
    expired_date DATETIME
);
SHOW TABLES;
ALTER TABLE tblObat
ADD kemasan VARCHAR(20);
ALTER TABLE tblObat
ADD petunjuk VARCHAR(255);
DESC tblObat;

CREATE TABLE tblAntrian(
    nomor_antrian INT PRIMARY KEY, 
    tanggal DATETIME DEFAULT NOW(),
    kode_pasien INT,
    Foreign Key (kode_pasien) REFERENCES tblPasien (kode_pasien)
);
SHOW TABLES;
DESC tblAntrian;

CREATE TABLE tblBeli(
    nomor_antrian INT (11),
    kode_obat CHAR (2),
    harga DOUBLE,
    dosis INT,
    Foreign Key (nomor_antrian) REFERENCES tblAntrian (nomor_antrian),
    Foreign Key (kode_obat) REFERENCES tblObat (kode_obat)
);
