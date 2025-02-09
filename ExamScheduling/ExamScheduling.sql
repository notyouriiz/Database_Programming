DROP DATABASE IF EXISTS dbPPKN;
CREATE DATABASE dbPPKN;
USE dbPPKN;

DROP TABLE IF EXISTS tblMataKuliah;
CREATE TABLE tblMataKuliah (
    KODE_MKU CHAR(1) PRIMARY KEY,
    MATA_KULIAH_MKU VARCHAR(50),
    JUMLAH INT
);

DROP TABLE IF EXISTS tblJadwalUjian;
CREATE TABLE tblJadwalUjian (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    KODE_MKU CHAR(1),
    MATA_KULIAH_MKU VARCHAR(50),
    JAM VARCHAR(11),
    HARI VARCHAR(10),
    UNIQUE (MATA_KULIAH_MKU, JAM, HARI)
);

INSERT INTO tblMataKuliah VALUES 
('K', 'KEWARGANEGARAAN', 6),
('P', 'PANCASILA', 5),
('R', 'RELIGIUSITAS', 4);

DELIMITER $$
DROP FUNCTION IF EXISTS sfWaktuUnik;
CREATE FUNCTION sfWaktuUnik()
RETURNS VARCHAR(11)
DETERMINISTIC
BEGIN
    DECLARE random_start INT;
    DECLARE random_end INT;
    SET random_start = FLOOR(RAND() * 8) + 8; -- Generates hour between 8 and 15
    SET random_end = random_start + 2; -- Adds 2 hours to start time
    RETURN CONCAT(LPAD(random_start, 2, '0'), ':00-', LPAD(random_end, 2, '0'), ':00');
END 
$$
DELIMITER ;

DELIMITER $$

DROP PROCEDURE IF EXISTS spScheduleUjian;
CREATE PROCEDURE spScheduleUjian()
BEGIN
    DECLARE vdone INT DEFAULT 0;
    DECLARE vmk_kode CHAR(1);
    DECLARE vmk_nama VARCHAR(50);
    DECLARE vmk_jumlah INT;
    DECLARE vhari VARCHAR(10);
    DECLARE vjam VARCHAR(11);
    DECLARE cursor_mk CURSOR FOR SELECT KODE_MKU, MATA_KULIAH_MKU, JUMLAH FROM tblMataKuliah;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET vdone = 1;

    OPEN cursor_mk;

    read_mk: LOOP
        FETCH cursor_mk INTO vmk_kode, vmk_nama, vmk_jumlah;
        IF vdone THEN
            LEAVE read_mk;
        END IF;

        WHILE vmk_jumlah > 0 DO
            SET vhari = ELT(FLOOR(RAND() * 5) + 1, 'SENIN', 'SELASA', 'RABU', 'KAMIS', 'JUMAT');
            SET vjam = sfWaktuUnik();

            -- Check if the schedule is available
            IF NOT EXISTS (SELECT * FROM tblJadwalUjian WHERE HARI = vhari AND JAM = vjam AND MATA_KULIAH_MKU = vmk_nama) THEN
                INSERT INTO tblJadwalUjian (KODE_MKU, MATA_KULIAH_MKU, JAM, HARI) VALUES (vmk_kode, vmk_nama, vjam, vhari);
                SET vmk_jumlah = vmk_jumlah - 1;
            END IF;
        END WHILE;
    END LOOP;

    CLOSE cursor_mk;
END 
$$
DELIMITER ;

CALL spScheduleUjian();
SELECT * FROM tblJadwalUjian;
SELECT * FROM tblmatakuliah;