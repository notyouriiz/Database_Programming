drop database if exists dbPenggajian;
create database dbPenggajian;
use dbPenggajian;

create table tblBuruh (
idpekerja int primary key,
nama varchar(100)
);

insert into tblBuruh values
(1, 'Harno'),
(2, 'Lena'),
(3, 'Wartoyo'),
(4, 'Azis'),
(5, 'Hendro');

create table tblPresensi (
    idpekerja int,
    tanggal date,
    jammasuk time,
    jamkeluar time,
    gajiharian double,
    lemburmasuk time,
    lemburkeluar time,
    lemburperjam double,
    foreign key (idpekerja) references tblBuruh(idpekerja)
);
insert into tblPresensi values
(1, '2022-11-01', '07:30:00', '17:00:00', 80000 , '17:30', '20:10', 20000),
(1, '2022-11-02', '07:28:00', '17:30:00', 75000 , '17:40', '21:13', 20000),
(2, '2022-11-01', '07:40:00', '17:45:00', 82000 , '17:55', '23:50', 20000),
(2, '2022-11-02', '07:50:00', '17:15:00', 77000 , '17:15', '02:10', 20000),
(4, '2022-11-01', '07:35:00', '17:25:00', 67500 , '17:20', '01:15', 20000),
(4, '2022-11-02', '07:38:00', '17:55:00', 55000 , '17:25', '20:40', 20000),
(5, '2022-11-01', '07:39:00', '17:56:00', 76000 , '17:33', '21:17', 20000),
(5, '2022-11-02', '07:41:00', '17:58:00', 78000 , '17:56', '23:40', 20000),
(5, '2022-11-03', '07:50:00', '17:34:00', 65000 , '17:05', '01:50', 20000),
(5, '2022-11-04', '07:36:00', '17:35:00', 77500 , '17:15', '03:10', 20000);

-- _______________________________________________JAWABAN________________________________________________________________

-- 1. CHECKING DATA INPUT CORRECTTLY
SELECT 
    idpekerja as 'ID',
    nama as 'Nama'
FROM tblburuh;

SELECT 
    idpekerja as '',
    tanggal as 'Tanggal',
    jammasuk as 'Jam Masuk',
    jamkeluar as 'Jam Keluar',
    gajiharian as 'Gaji Harian',
    lemburmasuk as 'Lembur Masuk',
    lemburkeluar as 'Lembur Keluar',
    lemburperjam as 'Lembur/Jam'
FROM tblpresensi;

    SELECT 
    tblBuruh.idpekerja AS 'ID',
    tblBuruh.nama AS 'Nama',
    tblPresensi.jammasuk AS 'Jam Masuk',
    tblPresensi.jamkeluar AS 'Jam Keluar',
    CASE 
        WHEN jammasuk >= '07:30:00' THEN '07:30:00'
        ELSE 'INVALID'
    END AS 'MASUK VALID',
    CASE 
        WHEN jamkeluar <= '17:30:00' THEN '17:30:00'
        ELSE 'INVALID'
    END AS 'KELUAR VALID'
FROM 
    tblBuruh JOIN tblPresensi ON tblBuruh.idpekerja = tblPresensi.idpekerja;


-- 3. GAJI/HARI dengan ketentuan dimana per harinya bekerja 10 jam
SELECT
    tblPresensi.idpekerja AS ID,
    tblBuruh.nama AS NAMA,
    tblPresensi.jammasuk,
    tblPresensi.jamkeluar,
    CASE
        WHEN tblPresensi.jammasuk >= '07:30:00' THEN '07:30:00'
        ELSE tblPresensi.jammasuk
    END AS 'MASUK VALID',
    CASE
        WHEN tblPresensi.jamkeluar <= '17:30:00' THEN '17:30:00'
        ELSE tblPresensi.jamkeluar
    END AS 'KELUAR VALID',
    tblPresensi.gajiharian AS 'GAJI HARIAN',
    CONCAT(
        TIMESTAMPDIFF(MINUTE,
            GREATEST(tblPresensi.jammasuk, '07:30:00'),
            LEAST(tblPresensi.jamkeluar, '17:30:00')
        ),
        ' MENIT'
    ) AS KERJA,
    ROUND(
        (
            tblPresensi.gajiharian / 600
        ) *
        (
            TIMESTAMPDIFF(MINUTE,
                GREATEST(tblPresensi.jammasuk, '07:30:00'),
                LEAST(tblPresensi.jamkeluar, '17:30:00')
            )
        ),
        0
    ) AS GAJI
FROM
    tblPresensi
INNER JOIN
    tblBuruh ON tblPresensi.idpekerja = tblBuruh.idpekerja
ORDER BY
    tblPresensi.idpekerja, tblPresensi.tanggal;

-- 4. Gaji Lemburan
SELECT
    tblPresensi.idpekerja AS ID,
    tblBuruh.nama AS NAMA,
    tblPresensi.lemburmasuk AS 'LEMBUR MASUK',
    CASE
        WHEN tblPresensi.lemburmasuk <= '17:30:00' THEN '17:30:00'
        ELSE tblPresensi.lemburmasuk
    END AS 'LEMBUR MASUK VALID',
    CASE
        WHEN tblPresensi.lemburkeluar > '23:00:00' THEN '23:00:00'
        WHEN tblPresensi.lemburkeluar <= '05:00:00' THEN '05:00:00'
        ELSE tblPresensi.lemburkeluar
    END AS 'LEMBUR KELUAR VALID',
    tblPresensi.lemburperjam AS 'LEMBUR PER JAM'
FROM
    tblPresensi
INNER JOIN
    tblBuruh ON tblPresensi.idpekerja = tblBuruh.idpekerja
WHERE
    tblPresensi.lemburmasuk <= '23:00:00' AND tblPresensi.lemburkeluar >= '17:30:00'
ORDER BY
    tblPresensi.idpekerja, tblPresensi.tanggal;

-- 5. Gaji harian proporsional
SELECT 
    tblBuruh.idpekerja AS 'ID',
    tblBuruh.nama AS 'NAMA',
    CASE 
        WHEN tblPresensi.lemburmasuk < '17:30:00' THEN tblPresensi.lemburmasuk
        WHEN tblPresensi.lemburkeluar > '20:10:00' THEN tblPresensi.lemburkeluar
        ELSE 'INVALID'
    END AS 'LEMBUR MASUK VALID',
    CASE 
        WHEN tblPresensi.lemburkeluar > '02:10:00' THEN tblPresensi.lemburkeluar
        WHEN tblPresensi.lemburmasuk < '17:30:00' THEN tblPresensi.lemburmasuk
        ELSE 'INVALID'
    END AS 'LEMBUR KELUAR VALID',
    tblPresensi.lemburperjam AS 'UANG LEMBUR'
FROM 
    tblBuruh 
JOIN 
    tblPresensi 
ON 
    tblBuruh.idpekerja = tblPresensi.idpekerja;



-- 7. Grand Total Gaji Buruh
SELECT 
    tblBuruh.idpekerja AS 'ID',
    tblBuruh.nama AS 'NAMA',
    SUM (tblPresensi.gajiharian + tblPresensi.lemburperjam * (DATEDIFF(tblPresensi.tanggal, '2022-11-01') + 1)) AS 'GAJI',
    SUM (tblPresensi.lemburperjam * (DATEDIFF(tblPresensi.tanggal, '2022-11-01') + 1)) AS 'LEMBUR',
    SUM (tblPresensi.gajiharian + tblPresensi.lemburperjam * (DATEDIFF(tblPresensi.tanggal, '2022-11-01') + 1)) AS 'GRAND TOTAL PENDAPATAN BURUH'
FROM 
    tblBuruh 
JOIN 
    tblPresensi 
ON 
    tblBuruh.idpekerja = tblPresensi.idpekerja
GROUP BY 
    tblBuruh.idpekerja, tblBuruh.nama;
