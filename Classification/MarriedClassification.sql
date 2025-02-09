drop database if exists dbCatatSipil;

create database dbCatatSipil;

use dbCatatSipil;

create table
    tblPernikahan (
        noid smallint primary key auto_increment,
        nama varchar(30) not null,
        jkelamin char(1),
        tgllahir timestamp,
        kotaasal varchar(20) default 'Semarang',
        pasangan smallint,
        tglnikah datetime
    );

ALTER TABLE tblPernikahan ADD CONSTRAINT fk Foreign Key (pasangan) REFERENCES tblPernikahan (noid);

insert into
    tblPernikahan (
        nama,
        jkelamin,
        tgllahir,
        kotaasal,
        pasangan,
        tglnikah
    )
values
    (
        'YUNITA TRIRATNADI A',
        'W',
        '1981-11-29 23:11:10',
        'YOGYAKARTA',
        6,
        '2008-09-11 12:09:41'
    ),
    (
        'YULIA',
        'W',
        '1976-12-05 19:12:21',
        'SEMARANG',
        7,
        '2011-10-23 05:10:45'
    ),
    (
        'YOLA AZERTI SARI',
        'W',
        '1983-06-01 03:06:40',
        'MAGELANG',
        8,
        '2011-06-08 17:06:28'
    ),
    (
        'YETI SULIANA',
        'W',
        '1986-04-18 04:04:50',
        'YOGYAKARTA',
        9,
        '2005-01-14 21:01:04'
    ),
    (
        'YETI KURNIATI P',
        'W',
        '1976-02-18 21:02:18',
        'MUNTILAN',
        10,
        '2008-11-19 23:11:50'
    ),
    (
        'ZIAD',
        'P',
        '1981-07-08 17:07:06',
        'YOGYAKARTA',
        1,
        '2008-09-11 12:09:41'
    ),
    (
        'TUNJUNG ARIWIBOWO',
        'P',
        '1978-10-25 07:10:39',
        'YOGYAKARTA',
        2,
        '2011-10-23 05:10:45'
    ),
    (
        'SUGIMAN',
        'P',
        '1976-09-28 01:09:38',
        'MUNTILAN',
        3,
        '2011-06-08 17:06:28'
    ),
    (
        'SIGIT SUTOPO',
        'P',
        '1976-06-22 00:06:50',
        'YOGYAKARTA',
        4,
        '2005-01-14 21:01:04'
    ),
    (
        'RICKY PERMANADJAYA',
        'P',
        '1989-06-09 07:06:23',
        'MAGELANG',
        5,
        '2008-11-19 23:11:50'
    );

-- JAWABAN SOAL
-- No. 1
CREATE VIEW vwJawaban1 AS
SELECT
    *
FROM
    tblPernikahan;

-- No. 2
CREATE VIEW vwJawaban2 AS
SELECT
    P.nama AS PRIA,
    W.nama AS WANITA,
    P.tglnikah AS 'TANGGAL MENIKAH',
    if (
        YEAR (NOW ()) - YEAR (P.tglnikah) >= 15,
        'SUDAH MENIKAH >= 15 TAHUN',
        'BELUM MENIKAH >= 15 TAHUN'
    ) AS KETERANGAN
FROM
    tblPernikahan AS P,
    tblPernikahan AS W
WHERE
    P.jkelamin = 'P'
    AND W.jkelamin = 'W'
    AND P.noid = W.pasangan;

-- No. 3
CREATE VIEW vwJawaban3 AS
SELECT
    P.nama AS 'PRIA LAHIR < 1980',
    P.kotaasal AS 'KOTA ASAL PRIA',
    W.nama AS 'WANITA',
    W.kotaasal AS 'KOTA ASAL WANITA',
    if (
        P.kotaasal = W.kotaasal, 
        'NIKAH SEKOTA', 'NIKAH BEDA KOTA'
        ) AS KETERANGAN
FROM
    tblPernikahan AS P,
    tblPernikahan AS W
WHERE
    P.jkelamin = 'P'
    AND W.jkelamin = 'W'
    AND P.noid = W.pasangan
    AND YEAR (P.tgllahir) < 1980;

-- No. 4
CREATE VIEW vwJawaban4 AS
SELECT
    P.nama AS PRIA,
    YEAR (NOW()) - YEAR (P.tgllahir) AS 'UMUR PRIA',
    W.nama AS WANITA,
    YEAR (NOW()) - YEAR (W.tgllahir) AS 'UMUR WANITA',
    CASE 
        WHEN  
            YEAR(NOW() - YEAR(P.tgllahir) > YEAR(NOW()) - YEAR (W.tgllahir)) THEN 'PRIA LEBIH TUA'
        WHEN
            YEAR(NOW() - YEAR(P.tgllahir) < YEAR(NOW()) - YEAR (W.tgllahir)) THEN 'WANITA LEBIH TUA'
        ELSE
            'UMUR PRIA SAMA DENGAN UMUR WANITA'
    END AS KETERANGAN
FROM
    tblPernikahan AS P,
    tblPernikahan AS W
WHERE
    P.jkelamin = 'P'
    AND W.jkelamin = 'W'
    AND P.noid = W.pasangan;

-- No. 5
CREATE VIEW vwJawaban5 AS
SELECT
    nama AS 'NAMA LENGKAP',
    INSTR(nama, ' ') AS SPASI, # cek spasi di mana
    if (
        INSTR (nama, ' ') = 0, nama,
        LEFT (nama, INSTR(nama, ' '))
    ) AS 'NAMA DEPAN',
    INSTR (nama, ' ') + 1 AS 'CEK BELAKANG',
    LENGTH (nama) AS 'PANJANG SELURUHNYA',
    LENGTH (nama) - (INSTR(nama, ' ') + 1) AS SISANYA,
    MID (
        nama, 
        INSTR (nama, ' ') + 1, 
        LENGTH (nama) - (INSTR(nama, ' ') + 1) 
        ) AS 'NAMA BELAKANG'
FROM
    tblpernikahan;

-- No. 6
CREATE VIEW vwJawaban6 AS
SELECT
    nama AS 'NAMA LENGKAP',
    --INSTR(nama, ' ') AS SPASI, # cek spasi di mana
    if (
        INSTR (nama, ' ') = 0, nama,
        LEFT (nama, INSTR(nama, ' '))
    ) AS 'NAMA DEPAN',
    --INSTR (nama, ' ') + 1 AS 'CEK BELAKANG',
    --LENGTH (nama) AS 'PANJANG SELURUHNYA',
    --LENGTH (nama) - (INSTR(nama, ' ') + 1) AS SISANYA,
    MID (
        nama, 
        INSTR (nama, ' ') + 1, 
        LENGTH (nama) - (INSTR(nama, ' ') + 1) 
        ) AS 'NAMA BELAKANG'
FROM
    tblpernikahan;

-- VIEW JAWABAN
SELECT
    *
FROM
    vwJawaban1;

SELECT
    *
FROM
    vwJawaban2;

SELECT
    *
FROM
    vwJawaban3;

SELECT
    *
FROM
    vwJawaban4;

SELECT
    *
FROM
    vwJawaban5;

SELECT
    *
FROM
    vwJawaban6;


DROP VIEW vwJawaban5;