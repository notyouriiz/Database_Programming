/*
    TRIGGER
        Adalah otomatisasi data di Database, terdapat 3:
            1. otomatis untuk insert
            2. otomatis untuk update
            3. otomatis untuk read
        Syarat penggunaan:
            1. menentukan apakah trigger diekesekusi sebelum (BEFORE) atau setelah (AFTER) data diproses (I / O / D )
            2. menentukan nilai dari trigger apakah nilai yang lama (OLD) atau baru (NEW)
*/

-- Membuat otomatisasi rekapitulasi data untuk pendaftaran kegiatan seminar fikom dicatat berdasarkan angkatan


DROP DATABASE dbSeminar;
CREATE DATABASE dbSeminar;
USE dbSeminar;

CREATE TABLE tblPendaftaran(
    nim VARCHAR (10),
    nama VARCHAR (100)
);

DROP TABLE tblrekapitulasi;
CREATE TABLE tblRekapitulasi(
    angkatan VARCHAR(2),
    jumlah INT
);

INSERT INTO tblPendaftaran VALUES
('20.K1.0100', 'IWAN'),
('20.K1.0102', 'WANTO'),
('23.K1.0104', 'BUDI'),
('22.K1.0106', 'INEM'),
('22.K1.0110', 'BUDIONO');
SELECT * FROM tblPendaftaran;
SELECT * FROM tblrekapitulasi;

DELIMITER $$
    CREATE TRIGGER trgRekapNambah
    AFTER INSERT ON tblPendaftaran
    FOR EACH ROW
    BEGIN
    DECLARE vAngkatan VARCHAR(2);
    DECLARE vJumlah INTEGER;

    SET vAngkatan := LEFT(NEW.nim, 2);

    SELECT COUNT(*) INTO vJumlah
    FROM tblrekapitulasi 
    WHERE angkatan = vAngkatan;

    IF vJumlah = 0 THEN
        INSERT INTO tblrekapitulasi VALUES
        (vAngkatan, 1);
    ELSE
        UPDATE tblrekapitulasi
        SET jumlah = jumlah+1
        WHERE angkatan = vAngkatan;
    END IF;
END $$
DELIMITER ;

DELIMITER $$
    CREATE TRIGGER trgRekapKurang
    AFTER DELETE ON tblPendaftaran
    FOR EACH ROW
        BEGIN
            DECLARE vAngkatan VARCHAR(2);
            SET vAngkatan := LEFT(OLD.nim, 2);

        UPDATE tblrekapitulasi
        SET JUMLAH = JUMLAH-1
        WHERE angkatan = vAngkatan;
            
        END $$
DELIMTER ;