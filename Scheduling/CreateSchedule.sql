DROP DATABASE IF EXISTS dbPKN;
CREATE DATABASE dbPKN;
USE dbPKN;

CREATE TABLE tblMataKuliah (
    KodeMKU CHAR(1) PRIMARY KEY,
    MatkulMKU VARCHAR(50),
    jumlah INT
);

CREATE TABLE tblDosen (
    KodeDosen CHAR(1),
    MatkulMKU VARCHAR(50),
    dosen VARCHAR(50),
    PRIMARY KEY (KodeDosen, MatkulMKU)
);

CREATE TABLE tblJadwalUjian (
    id INT PRIMARY KEY AUTO_INCREMENT,
    KodeMKU CHAR(1),
    MatkulMKU VARCHAR(50),
    KodeDosen CHAR(1),
    dosen VARCHAR(50),
    JAM VARCHAR(11),
    HARI VARCHAR(10),
    UNIQUE (MatkulMKU, JAM, HARI, KodeDosen)
);

INSERT INTO tblMataKuliah VALUES 
('K', 'KEWARGANEGARAAN', 8),
('P', 'PANCASILA', 5),
('R', 'RELIGIUSITAS', 9);

INSERT INTO tblDosen VALUES 
('A', 'KEWARGANEGARAAN', 'Ali'),
('A', 'PANCASILA', 'Ali'),
('R', 'RELIGIUSITAS', 'Romi'),
('B', 'KEWARGANEGARAAN', 'Beni'),
('B', 'PANCASILA', 'Beni'),
('S', 'RELIGIUSITAS', 'Sugeng');

DELIMITER $$
CREATE FUNCTION sfWaktuUnik()
RETURNS VARCHAR(11)
DETERMINISTIC
BEGIN
    DECLARE random_start INT;
    DECLARE random_end INT;
    SET random_start = FLOOR(RAND() * 8) + 8; 
    SET random_end = random_start + 2; 
    RETURN CONCAT(LPAD(random_start, 2, '0'), ':00-', LPAD(random_end, 2, '0'), ':00');
END 
$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER trgCheckKetersediaanMatkul
BEFORE INSERT ON tblJadwalUjian
FOR EACH ROW
BEGIN
    IF EXISTS (SELECT 1 FROM tblJadwalUjian WHERE JAM = NEW.JAM AND HARI = NEW.HARI AND dosen = NEW.dosen) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Dosen cannot be double-booked';
    END IF;
END 
$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE spScheduleUjian()
BEGIN
    DECLARE vdone INT DEFAULT 0;
    DECLARE vmk_kode CHAR(1);
    DECLARE vmk_nama VARCHAR(50);
    DECLARE vmk_jumlah INT;
    DECLARE vhari VARCHAR(10);
    DECLARE vjam VARCHAR(11);
    DECLARE vkd_dosen CHAR(1);
    DECLARE vnama_dosen VARCHAR(50);
    DECLARE cursor_mk CURSOR FOR SELECT KodeMKU, MatkulMKU, jumlah FROM tblMataKuliah;
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

            SELECT KodeDosen, dosen INTO vkd_dosen, vnama_dosen
            FROM tblDosen
            WHERE MatkulMKU = vmk_nama
            ORDER BY RAND()
            LIMIT 1;

            IF NOT EXISTS (
                SELECT 1 FROM tblJadwalUjian 
                WHERE JAM = vjam 
                    AND HARI = vhari 
                    AND dosen = vnama_dosen
            ) THEN
                INSERT INTO tblJadwalUjian (KodeMKU, MatkulMKU, KodeDosen, dosen, JAM, HARI) 
                VALUES (vmk_kode, vmk_nama, vkd_dosen, vnama_dosen, vjam, vhari);
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
SELECT * FROM tblMataKuliah;
SELECT * FROM tblDosen;