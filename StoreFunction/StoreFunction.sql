/*
Store Function atau SF adalah SP yang mengahsilkan output
*/

CREATE DATABASE dbSF;
USE dbSF;

DROP TABLE tblSF;
CREATE TABLE tblSF (
    nomor INT,
    nama VARCHAR(255)
);

/*
BUAT STORE FUNCTION UNTUK MEMASUKKAN NILAI KE DALAM TABEL
*/

DROP FUNCTION IF EXISTS sfinputdata;
DELIMITER $$
CREATE FUNCTION sfinputdata (pNomor INT, pNama VARCHAR(255))
RETURNS VARCHAR(255)
DETERMINISTIC
READS SQL DATA
MODIFIES SQL DATA
BEGIN
    DECLARE vJumlah INT;
    DECLARE vPesan VARCHAR(255);

    SELECT COUNT(*) INTO vJumlah
    FROM tblSF
    WHERE nama = pNama;
    
    IF
        vJumlah = 0 then -- check data apakah ada atau tidak
        INSERT INTO tblSF (nomor, nama) VALUES (pNomor, pNama);
        SET vPesan = CONCAT ('DATA ', pNama, ' BELUM DISIMPAN'); -- munculkan pesan ketika data tidak ditemukan
    ELSE
        SET vPesan = CONCAT ('DATA ', pNama, ' SUDAH ADA'); -- pesan bila data sudah ada
    END IF;
    RETURN vPesan;
    
END;
$$
DELIMITER;


SELECT sfinputdata (17, 'AIRA') AS "PESAN"; 
SELECT sfinputdata (17, 'AIRA') AS "PESAN";

SELECT * FROM tblSF;