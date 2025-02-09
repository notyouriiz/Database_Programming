/*
NAMA: FAIZ NOOR ADHYTIA
NIM: 22K30006

TUGAS 1
*/

-- DROP DATABASE KULIAH;

CREATE DATABASE KULIAH;
USE KULIAH;

CREATE TABLE tblMahasiswa(
    nim VARCHAR (10) PRIMARY KEY,
    nama VARCHAR (100) NOT NULL,
    alamat VARCHAR (255) NOT NULL,
    email VARCHAR (255),
    nohp VARCHAR (20) UNIQUE NOT NULL
);
ALTER TABLE tblMahasiswa 
ADD jkelamin ENUM ('L', 'P');

CREATE TABLE tblMataKuliah(
    kodematakuliah VARCHAR (5) PRIMARY KEY,
    namamatakuliah VARCHAR (30),
    sks INT
);

ALTER TABLE tblMataKuliah
DROP sks;

ALTER TABLE tblMataKuliah
ADD sks ENUM ('2', '4');


CREATE TABLE tblKRS(
    nim VARCHAR (10),
    kodematakuliah VARCHAR (5),
    Foreign Key (nim) REFERENCES tblMahasiswa (nim),
    Foreign Key (kodematakuliah) REFERENCES tblMatakuliah (kodematakuliah)
);

ALTER TABLE tblKRS
ADD jadwal DATETIME;

ALTER TABLE tblKRS
ADD kelas TIMESTAMP;


DESC tblMahasiswa;
DESC tblMatakuliah;
DESC tblKRS;


-- ______________________________________________________________________________________________________________________________________________ --


CREATE DATABASE JUALAN;
USE JUALAN;
--DROP DATABASE JUALAN;
CREATE TABLE tblBarang(
    kodebarang INT PRIMARY KEY,
    namabarang VARCHAR(100) NOT NULL,
    stok INT NOT NULL,
    foto VARCHAR(255) NOT NULL
);

CREATE TABLE tblCustomer(
    idcustomer INT PRIMARY KEY,
    namacustomer VARCHAR (100) NOT NULL,
    nohp VARCHAR (20) UNIQUE NOT NULL,
    email VARCHAR (255),
    alamatkirim VARCHAR (255) NOT NULL
);

CREATE TABLE tblTransaksi(
    kodebarang INTEGER,
    idcustomer INTEGER,
    jumlahbeli INT NOT NULL,
    hargabeli DOUBLE NOT NULL,
    Foreign Key (kodebarang) REFERENCES tblBarang (kodebarang),
    Foreign Key (idcustomer) REFERENCES tblCustomer (idcustomer)
);
ALTER TABLE tblTransaksi 
ADD diskon ENUM ('10%', '25%', '40%');

DESC tblBarang;
DESC tblCustomer;
DESC tblTransaksi;