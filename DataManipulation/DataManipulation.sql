/*
Data Manipulation

SELECT * FROM .. WHERE .. -> UNTUK MENGAMBIL DATA
*/

CREATE DATABASE dbNilai;
USE dbNilai;

CREATE TABLE tblMapel (
    kodemapel VARCHAR (3) PRIMARY KEY,
    namamapel VARCHAR (100)
);
INSERT INTO tblMapel VALUES
('MAT', 'MATEMATIKA'),
('ING', 'INGGRIS'),
('IND', 'INDONESIA'),
('MAN', 'MANDARIN'),
('KIM', 'KIMIA'),
('FIS', 'FISIKA'),
('BIO', 'BIOLOGI');
SELECT * FROM tblMapel;

CREATE TABLE tblKomponen (
    kode VARCHAR (3) PRIMARY KEY,
    komponen VARCHAR (100),
    prosentase INTEGER
);
INSERT INTO tblKomponen VALUES
('TGS', 'TUGAS', 40),
('UTS', 'UJIAN TENGAH', 30),
('UAS', 'UJIAN AKHIR', 30);
SELECT * FROM tblKomponen;

CREATE TABLE tblSiswa (
    nis VARCHAR (3) PRIMARY KEY,
    nama VARCHAR (100)
);
INSERT INTO tblSiswa VALUES
('S01','REZA'),
('S02','JOVITA'),
('S03','ANDRE'),
('S04','MERLIN');
SELECT * FROM tblSiswa;

CREATE TABLE tblNilai (
    nis VARCHAR (3),
    kode VARCHAR (3),
    kodemapel VARCHAR (3),
    nilai INTEGER,
    Foreign Key (nis) REFERENCES tblSiswa (nis),
    Foreign Key (kode) REFERENCES tblKomponen (kode),
    Foreign Key (kodemapel) REFERENCES tblMapel (kodemapel)
);
INSERT INTO tblNilai (kodemapel, kode, nis, nilai)
SELECT
    tblMapel.kodemapel,
    tblKomponen.kode,
    tblSiswa.nis,
    RAND()*100
FROM tblKomponen, tblMapel, tblSiswa;
SELECT * FROM tblNilai;

/*______________________________________________________________________________________________________________________*/

-- 1.
SELECT dbNilai.tblmapel.namamapel
FROM dbNilai.tblmapel;

-- 2.
SELECT 
    K.kode,
    K.komponen,
    K.prosentase
FROM tblKomponen K; -- -> aslinya adalah FROM tblKomponen as K;

-- 3. (KARTESIA / MENGALIKAN TABEL)
SELECT
    tblMapel.kodemapel,
    tblKomponen.kode,
    tblSiswa.nis,
    RAND()*100
FROM tblKomponen, tblMapel, tblSiswa;

/*___________________________________________________________________________________________________________________*/
-- MULTI TABEL

-- 1. Join 2 Table
SELECT 
    tblSiswa.nama,
    tblNilai.nilai
FROM 
    tblNilai, tblSiswa
WHERE 
    tblSiswa.nis = tblNilai.nis;

-- 2. Join 3 Table
SELECT
    tblSiswa.nis,
    tblKomponen.komponen,
    tblNilai.nilai
FROM
    tblNilai, tblSiswa, tblKomponen
WHERE
    tblNilai.nis = tblSiswa.nis
    AND
    tblNilai.kode = tblkomponen.kode;

-- 3. Natural Join
/*
1. kolom harus namanya sama
2. tipe data harus sama
3. letakka di FROM
4. definisi tabel harus jelas FK dan PK
*/
SELECT
    tblSiswa.nama,
    tblNilai.nilai
FROM
    tblNilai
    NATURAL JOIN
    tblSiswa;

-- 4. INNER JOIN
SELECT
    tblSiswa.nama,
    tblNilai.nilai
FROM
    tblNilai 
        INNER JOIN
    tblSiswa 
        ON 
    (tblNilai.nis = tblSiswa.nis);

-- 5. CROSS JOIN
SELECT
    tblSiswa.nama,
    tblNilai.nilai
FROM
    tblNilai
        CROSS JOIN
    tblSiswa
        USING
    (nis);

-- 6. NATURAL JOIN 3 TABLES
SELECT
    tblSiswa.nama,
    tblNilai.nilai,
    tblKomponen.komponen
FROM
    tblNilai
        NATURAL JOIN
    tblSiswa
        NATURAL JOIN
    tblKomponen;

-- 7. INNER JOIN 3 TABLES
SELECT
    tblSiswa.nama,
    tblNilai.nilai,
    tblKomponen.komponen
FROM
    tblNilai 
        INNER JOIN
    tblSiswa
        INNER JOIN
    tblKomponen
        ON 
    (tblNilai.nis = tblSiswa.nis);

-- 8. CROSS JOIN 3 TABLES
SELECT
    tblSiswa.nama,
    tblNilai.nilai,
    tblKomponen.komponen
FROM
    tblNilai
        CROSS JOIN
    tblKomponen
        CROSS JOIN
    tblSiswa
        USING
    (nis);
DELETE from tblNilai WHERE nilai>50;

-- 9. OUTER JOIN (LEFT JOIN)
SELECT
    tblKomponen.kode AS kiri,
    tblNilai.kode AS kanan
FROM
    tblKomponen
        LEFT JOIN
    tblNilai
        ON (tblKomponen.kode = tblNilai.kode);

-- 10. OUTER JOIN (RIGHT JOIN)
SELECT
    tblNilai.kode AS kiri,
    tblKomponen.kode AS kanan
FROM
    tblNilai
        RIGHT JOIN
    tblKomponen
        ON (tblNilai.kode = tblKomponen.kode);
DELEE FROM tblNilai WHERE kode = 'UAS';