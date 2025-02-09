CREATE DATABASE dbCursor;
USE dbCursor;

CREATE TABLE tblData(
    noid int PRIMARY KEY,
    nama VARCHAR(255) NOT NULL,
    alamat VARCHAR(255) NOT NULL
);

INSERT INTO tblData VALUES
(1, 'Linda', 'Solo'),
(2, 'L', 'Semarang'),
(3, 'Lin', 'Jakarta'),
(4, 'Lind', 'Banten'),
(5, 'Arga', 'Bogor'),
(6, 'Ar', 'Bandung'),
(7, 'A', 'Solo'),
(8, 'Budi', 'Bandung'),
(9, 'Bud', 'Jakarta'),
(10, 'B', 'Semarang');

SELECT * FROM tblData;




DELIMITER $$
CREATE PROCEDURE spBacaData()
BEGIN
    DECLARE vJumlahData INT DEFAULT 0;
    DECLARE i INT DEFAULT 1;
    DECLARE vNoid INT;
    DECLARE vNama VARCHAR(255);
    DECLARE vAlamat VARCHAR(255);
    DECLARE done INT DEFAULT 0;

    DECLARE cData CURSOR FOR
        SELECT noid, nama, alamat FROM tblData;
        
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    SELECT COUNT(*) INTO vJumlahData
    FROM tblData;

    OPEN cData;

    bacadata: WHILE done = 0 DO
        FETCH cData INTO vNoid, vNama, vAlamat;
        IF done = 0 THEN
            SELECT vNoid, vNama, vAlamat;
        END IF;
    END WHILE bacadata;

    CLOSE cData;
END;
$$
DELIMITER ;
call spBacaData();

DELIMITER $$
CREATE PROCEDURE spGetNamaByAlamat(IN pAlamat VARCHAR(255))
BEGIN
    DECLARE vNoid INT;
    DECLARE vNama VARCHAR(255);
    DECLARE vAlamat VARCHAR(255);
    DECLARE done INT DEFAULT 0;

    DECLARE cData CURSOR FOR
        SELECT noid, nama, alamat FROM tblData WHERE alamat = pAlamat;
        
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN cData;

    bacadata: WHILE done = 0 DO
        FETCH cData INTO vNoid, vNama, vAlamat;
        IF done = 0 THEN
            SELECT vNama, vAlamat;
        END IF;
    END WHILE bacadata;

    CLOSE cData;
END;
$$
DELIMITER ;
CALL spGetNamaByAlamat('Solo');