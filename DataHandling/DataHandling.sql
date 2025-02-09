DROP DATABASE IF EXISTS dbAtlit;
CREATE DATABASE dbAtlit;

USE dbAtlit;

DROP TABLE IF EXISTS tblAtlit;
CREATE TABLE
    tblAtlit (
        ID INT PRIMARY KEY,
        NAMA VARCHAR(50),
        JKELAMIN CHAR(1),
        BERAT INT,
        TINGGI INT,
        PRESTASI VARCHAR(255)
    );

INSERT INTO
    tblAtlit
VALUES
    (0, 'A', 'L', 57, 171, 'NASIONAL'),
    (1, 'B', 'P', 69, 168, 'NASIONAL'),
    (2, 'C', 'P', 74, 178, 'NASIONAL'),
    (3, 'D', 'L', 68, 174, 'INTERNASIONAL'),
    (4, 'E', 'P', 61, 172, 'LOKAL'),
    (5, 'F', 'L', 72, 172, 'LOKAL'),
    (6, 'G', 'L', 76, 181, 'LOKAL'),
    (7, 'H', 'L', 66, 172, 'INTERNASIONAL'),
    (8, 'I', 'P', 73, 171, 'NASIONAL'),
    (9, 'J', 'L', 67, 176, 'LOKAL');




DROP VIEW vwJawaban1;
CREATE VIEW
    vwJawaban1 AS
SELECT
    *
FROM
    tblAtlit;


DROP VIEW vwJawaban2;
CREATE VIEW
    vwJawaban2 AS
SELECT
    a1.NAMA AS "NAMA ATLIT 1",
    a1.BERAT AS "BERAT ATLIT 1",
    a2.NAMA AS "NAMA ATLIT 2",
    a2.BERAT AS "BERAT ATLIT 2",
    CONCAT (
        IF (a2.BERAT > a1.BERAT, a2.NAMA, a1.NAMA),
        ' LEBIH BERAT DARI ',
        IF (a2.BERAT > a1.BERAT, a1.NAMA, a2.NAMA),
        ' : ',
        ABS(a2.BERAT - a1.BERAT),
        ' Kg'
    ) AS "PERBANDINGAN BERAT BADAN"
FROM
    tblAtlit a1
    JOIN tblAtlit a2 ON a1.ID = a2.ID - 1;


DROP VIEW vwJawaban3;
CREATE VIEW
    vwJawaban3 AS
SELECT
    a1.NAMA AS "NAMA ATLIT 1",
    a1.TINGGI AS "TINGGI ATLIT 1",
    a2.NAMA AS "NAMA ATLIT 2",
    a2.TINGGI AS "TINGGI ATLIT 2",
    CONCAT (
        IF (a2.TINGGI > a1.TINGGI, a2.NAMA, a1.NAMA),
        ' LEBIH TINGGI DARI ',
        IF (a2.TINGGI > a1.TINGGI, a1.NAMA, a2.NAMA),
        ' : ',
        ABS(a2.TINGGI - a1.TINGGI),
        ' Cm'
    ) AS "PERBANDINGAN TINGGI BADAN"
FROM
    tblAtlit a1
    JOIN tblAtlit a2 ON a1.ID = a2.ID - 1
WHERE
    a1.TINGGI > 170
    AND a2.TINGGI > 170;


DROP VIEW vwJawaban4;
CREATE VIEW
    vwJawaban4 AS
SELECT
    a1.NAMA AS "NAMA ATLIT 1",
    a1.PRESTASI AS "PRESTASI ATLIT 1",
    a2.NAMA AS "NAMA ATLIT 2",
    a2.PRESTASI AS "PRESTASI ATLIT 2",
    CONCAT (
        a1.NAMA,
        ' ',
        a1.PRESTASI,
        CASE
            WHEN a1.PRESTASI > a2.PRESTASI THEN ' LEBIH BAIK DARI '
            WHEN a1.PRESTASI < a2.PRESTASI THEN ' LEBIH BURUK DARI '
            ELSE ' SAMA BAGUS DENGAN '
        END,
        a2.NAMA,
        ' ',
        a2.PRESTASI
    ) AS "PERBANDINGAN PRESTASI"
FROM
    tblAtlit a1
    JOIN tblAtlit a2 ON a1.ID = a2.ID - 1
ORDER BY
    FIELD (a1.PRESTASI, 'INTERNASIONAL', 'NASIONAL', 'LOKAL') DESC,
    FIELD (a2.PRESTASI, 'INTERNASIONAL', 'NASIONAL', 'LOKAL') DESC;



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