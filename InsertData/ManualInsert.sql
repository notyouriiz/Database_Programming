/*
    NAMA: FAIZ NOOR ADHYTIA
    NIM: 22.K3.0006
*/
--DROP DATABASE dbPsikologi;
CREATE DATABASE dbPsikologi;
USE dbPsikologi;

CREATE TABLE tblKlien (
    kodeklien INT PRIMARY KEY,
    namaklien VARCHAR(255) NOT NULL,
    alamat VARCHAR(255) NOT NULL,
    nokontak VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL
);
INSERT INTO tblKlien (kodeklien, namaklien, alamat, nokontak, email) 
VALUES
(11, 'Budi Santoso', '321 Jalan Utama', '+62 83-523452', 'budisantoso@example.com'),
(12, 'Dewi Lestari', '654 Jalan Raya', '+62 83-523133', 'dewilestari@example.com'),
(13, 'Rina Wahyuni', '987 Jalan Permai', '+62 83-5543126', 'rinawahyuni@example.com'),
(14, 'Agus Wibowo', '246 Jalan Damai', '+62 83-5245643', 'aguswibowo@example.com'),
(15, 'Siti Rahayu', '369 Jalan Bahagia', '+62 83-5223443', 'sitirahayu@example.com'),
(16, 'Hendri Susanto', '481 Jalan Sejahtera', '+62 87-8123647', 'hendrisusanto@example.com'),
(17, 'Ani Fitriani', '753 Jalan Harmoni', '+62 85-8452763', 'anifitriani@example.com'),
(18, 'Joko Pranowo', '852 Jalan Makmur', '+62 81-8125433', 'jokopranowo@example.com'),
(19, 'Yuli Setiawan', '963 Jalan Jaya', '+62 86-8554276', 'yulisetiawan@example.com'),
(20, 'Rini Indah', '111 Jalan Indah', '+62 82-8127654', 'riniindah@example.com');
SELECT
    kodeklien as KODE_KLIEN,
    namaklien as NAMA_KLIEN,
    alamat as ALAMAT,
    nokontak as NOMOR_KONTAK,
    email as EMAIL
FROM tblklien;



CREATE TABLE tblTarif (
    kodetes INT PRIMARY KEY,
    namates VARCHAR(255) NOT NULL,
    tarifdasar DOUBLE NOT NULL
);
INSERT INTO tblTarif (kodetes, namates, tarifdasar) 
VALUES
(111, 'Tes Psikometri', 60.00),
(112, 'Konsultasi Psikologis', 70.00),
(113, 'Hipnoterapi', 90.00),
(114, 'Konseling Grief', 80.00),
(115, 'Psikoedukasi', 65.00),
(116, 'Asesmen Kesehatan Mental', 95.00),
(117, 'Konseling Perilaku', 75.00),
(118, 'Pemahaman Diri', 85.00),
(119, 'Teknik Relaksasi', 55.00),
(120, 'Terapi Seni', 100.00);
SELECT
    kodetes AS KODE_TES,
    namates AS NAMA_TES,
    tarifdasar AS TARIF_DASAR
FROM tbltarif;



CREATE TABLE tblTransaksi (
    notransaksi INT PRIMARY KEY,
    tanggaltransaksi VARCHAR(255) NOT NULL,
    kodeklien INT,
    Foreign Key (kodeklien) REFERENCES tblklien (kodeklien) 
);
INSERT INTO tblTransaksi (notransaksi, tanggaltransaksi, kodeklien) 
VALUES
(511, '2024-03-11', 11),
(512, '2024-03-12', 12),
(513, '2024-03-13', 13),
(514, '2024-03-14', 14),
(515, '2024-03-15', 15),
(516, '2024-03-16', 16),
(517, '2024-03-17', 17),
(518, '2024-03-18', 18),
(519, '2024-03-19', 19),
(520, '2024-03-20', 20);
SELECT
    notransaksi as NOMOR_TRANSAKSI,
    tanggaltransaksi as TANGGAL_TRANSAKSI,
    kodeklien as KODE_KLIEN
FROM tbltransaksi;



CREATE TABLE tblDetilInformasi (
    harga DOUBLE,
    kodetes INT,
    notransaksi INT,
    Foreign Key (kodetes) REFERENCES tblTarif (kodetes),
    Foreign Key (notransaksi) REFERENCES tblTransaksi (notransaksi)
);
INSERT INTO tblDetilInformasi (harga, kodetes, notransaksi)  -- HARGA DALAM SATUAN RIBU
VALUES
(60.00, 111, 511),
(70.00, 112, 512),
(90.00, 113, 513),
(80.00, 114, 514),
(65.00, 115, 515),
(95.00, 116, 516),
(75.00, 117, 517),
(85.00, 118, 518),
(55.00, 119, 519),
(100.00, 120, 520);
SELECT 
    harga as HARGA,
    kodetes as KODE_TES,
    notransaksi as NOMOR_TRANSAKSI
FROM tblDetilInformasi;