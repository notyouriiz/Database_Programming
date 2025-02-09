CREATE DATABASE dbTransaksiBarang;
USE dbTransaksiBarang;

CREATE TABLE tblTransaksi (
    notransaksi VARCHAR (2) PRIMARY KEY,
    tanggal DATE NOT NULL
);
INSERT INTO tblTransaksi 
VALUES
    ('T1', '2024-4-1'),
    ('T2', '2024-4-1'),
    ('T3', '2024-12-10'),
    ('T4', '2024-12-10'),
    ('T5', '2024-11-5');
SELECT * FROM tbltransaksi;

CREATE TABLE tblBarang (
    kodebarang VARCHAR (2) PRIMARY KEY,
    namabarang VARCHAR (255) NOT NULL
);
INSERT INTO tblBarang
VALUES
    ('B1', 'BARANG 1'),
    ('B2', 'BARANG 2'),
    ('B3', 'BARANG 3'),
    ('B4', 'BARANG 4'),
    ('B5', 'BARANG 5'),
    ('B6', 'BARANG 6'),
    ('B7', 'BARANG 7');
SELECT * FROM tblbarang;

CREATE TABLE tblDetilTransaksi (
    notransaksi VARCHAR (2),
    kodebarang VARCHAR (2),
    jumlah INT NOT NULL,
    harga DOUBLE NOT NULL,
    Foreign Key (notransaksi) REFERENCES tblTransaksi (notransaksi),
    Foreign Key (kodebarang) REFERENCES tblBarang (kodebarang)
);
INSERT INTO tblDetilTransaksi 
VALUES
    ('T1', 'B1', 1, 5000),
    ('T1', 'B3', 2, 7000),
    ('T1', 'B5', 3, 9000),
    ('T2', 'B7', 5, 6000),
    ('T2', 'B2', 1, 7500),
    ('T3', 'B4', 4, 8000),
    ('T3', 'B6', 7, 11000),
    ('T3', 'B1', 8, 5000),
    ('T4', 'B2', 9, 7500),
    ('T5', 'B4', 1, 8000);
    SELECT * FROM tbldetiltransaksi;


-- _________________________________________________________GROUP BY_____________________________________________________________

-- 1. 
SELECT notransaksi,
    COUNT (notransaksi) as Jumlah
FROM tbldetiltransaksi
GROUP BY notransaksi;

-- 2.
SELECT notransaksi,
    SUM (jumlah) AS 'Jumlah Barang Dibeli'
FROM tbldetiltransaksi
GROUP BY notransaksi;

-- 3
SELECT notransaksi,
    SUM ((jumlah)*(harga)) AS 'Total Harga'
FROM tbldetiltransaksi
GROUP BY notransaksi;

-- 4.
SELECT 
    tblBarang.kodebarang,
    tblbarang.namabarang,
    tbldetiltransaksi.jumlah as Jumlah
FROM
    tblbarang CROSS JOIN tbldetiltransaksi USING (kodebarang)
GROUP BY tblbarang.kodebarang;

-- 5.
SELECT
    tblbarang.kodebarang,
    tblbarang.namabarang,
    tbltransaksi.tanggal,
    COUNT (jumlah) AS 'Jumlah Terjual', (COUNT(jumlah)*(harga)) AS 'Total Harga'
FROM
    tblbarang CROSS JOIN tbltransaksi CROSS JOIN tbldetiltransaksi
GROUP BY tblbarang.kodebarang;


--________________________________________________________________HAVING________________________________________________________________

-- 1.
SELECT
    notransaksi as 'Nomor Transaksi',
    COUNT (notransaksi) AS 'Jumlah Harga'
FROM
    tbldetiltransaksi
GROUP BY notransaksi;