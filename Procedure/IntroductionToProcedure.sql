/*
    No. 1
    Buat perulangan untuk bilangan 1-75
    1. Loop 1-25
    2. repeat 26-50
    3. while 51-75
    konversi semua bilangan ke dalam biner (bin), oktal(oct), hexa (hex)
    store dalam 1 spNomor1;
*/

-- DROP DATABASE IF EXISTS dbLatihan7;
CREATE DATABASE dbLatihan7;
USE dbLatihan7;

-- TABLE NO. 1
DROP TABLE IF EXISTS tblComputerOrg;
CREATE TABLE tblComputerOrg(
    num INT,
    bin VARCHAR(32),
    oct VARCHAR(32),
    hex VARCHAR(32)
);

-- TABLE NO. 2
DROP TABLE IF EXISTS tblAstrologi;
CREATE TABLE tblAstrologi(
    nama VARCHAR (255),
    tgllahir DATETIME,
    astrologi VARCHAR (255),
    umur INT,
    harilahir VARCHAR (255)
);

-- TABLE NO. 3
DROP TABLE IF EXISTS tblNarcissus;
CREATE TABLE tblNarcissus (
    Narsis INT
);

------------------------ PROCEDURE ---------------

-- PROCEDURE NO. 1
DROP PROCEDURE IF EXISTS spNomor1;
DELIMITER $$
CREATE PROCEDURE spNomor1()
BEGIN
    DECLARE KOUNTER INT;

    -- Loop for range 1-25 using LOOP
    SET KOUNTER := 1;
    carasatu: LOOP
        IF KOUNTER > 25 THEN 
            LEAVE carasatu;
        END IF;
        INSERT INTO tblComputerOrg (num, bin, oct, hex)
        VALUES (KOUNTER, BIN(KOUNTER), OCT(KOUNTER), HEX(KOUNTER));
        SET KOUNTER := KOUNTER + 1;
    END LOOP carasatu;

    -- Loop for range 26-50 using WHILE
    SET KOUNTER := 26;
    caradua: WHILE KOUNTER <= 50 DO
        INSERT INTO tblComputerOrg (num, bin, oct, hex)
        VALUES (KOUNTER, BIN(KOUNTER), OCT(KOUNTER), HEX(KOUNTER));
        SET KOUNTER := KOUNTER + 1;
    END WHILE caradua;

    -- Loop for range 51-75 using REPEAT UNTIL
    SET KOUNTER := 51;
    caratiga: REPEAT
        INSERT INTO tblComputerOrg (num, bin, oct, hex)
        VALUES (KOUNTER, BIN(KOUNTER), OCT(KOUNTER), HEX(KOUNTER));
        SET KOUNTER := KOUNTER + 1;
    UNTIL KOUNTER > 75
    END REPEAT caratiga;
END;
$$
DELIMITER ;

-- PROCEDURE NO. 2
DROP PROCEDURE IF EXISTS spNomor2;
DELIMITER $$
CREATE PROCEDURE spNomor2(
    IN pNama VARCHAR(100),
    IN pTgllahir DATE
)
BEGIN
    DECLARE vAstrologi VARCHAR(20);
    DECLARE vUmur INT;
    DECLARE vHarilahir VARCHAR(20);
    DECLARE vCurrentDate DATE;
    SET vCurrentDate = CURDATE();

    -- Calculate age
    SET vUmur = TIMESTAMPDIFF(YEAR, pTgllahir, vCurrentDate);

    -- Calculate day of the week
    SET vHarilahir = DAYNAME(pTgllahir);

    -- Determine the astrological sign using CASE
    SET vAstrologi = CASE
        WHEN (MONTH(pTgllahir) = 3 AND DAY(pTgllahir) >= 21) OR (MONTH(pTgllahir) = 4 AND DAY(pTgllahir) <= 18) THEN 'ARIES'
        WHEN (MONTH(pTgllahir) = 4 AND DAY(pTgllahir) >= 19) OR (MONTH(pTgllahir) = 5 AND DAY(pTgllahir) <= 19) THEN 'TAURUS'
        WHEN (MONTH(pTgllahir) = 5 AND DAY(pTgllahir) >= 20) OR (MONTH(pTgllahir) = 6 AND DAY(pTgllahir) <= 20) THEN 'GEMINI'
        WHEN (MONTH(pTgllahir) = 6 AND DAY(pTgllahir) >= 21) OR (MONTH(pTgllahir) = 7 AND DAY(pTgllahir) <= 21) THEN 'CANCER'
        WHEN (MONTH(pTgllahir) = 7 AND DAY(pTgllahir) >= 22) OR (MONTH(pTgllahir) = 8 AND DAY(pTgllahir) <= 21) THEN 'LEO'
        WHEN (MONTH(pTgllahir) = 8 AND DAY(pTgllahir) >= 22) OR (MONTH(pTgllahir) = 9 AND DAY(pTgllahir) <= 21) THEN 'VIRGO'
        WHEN (MONTH(pTgllahir) = 9 AND DAY(pTgllahir) >= 22) OR (MONTH(pTgllahir) = 10 AND DAY(pTgllahir) <= 22) THEN 'LIBRA'
        WHEN (MONTH(pTgllahir) = 10 AND DAY(pTgllahir) >= 23) OR (MONTH(pTgllahir) = 11 AND DAY(pTgllahir) <= 21) THEN 'SCORPIO'
        WHEN (MONTH(pTgllahir) = 11 AND DAY(pTgllahir) >= 22) OR (MONTH(pTgllahir) = 12 AND DAY(pTgllahir) <= 20) THEN 'SAGITARIUS'
        WHEN (MONTH(pTgllahir) = 12 AND DAY(pTgllahir) >= 21) OR (MONTH(pTgllahir) = 1 AND DAY(pTgllahir) <= 19) THEN 'CAPICORN'
        WHEN (MONTH(pTgllahir) = 1 AND DAY(pTgllahir) >= 20) OR (MONTH(pTgllahir) = 2 AND DAY(pTgllahir) <= 17) THEN 'AQUARIUS'
        WHEN (MONTH(pTgllahir) = 2 AND DAY(pTgllahir) >= 18) OR (MONTH(pTgllahir) = 3 AND DAY(pTgllahir) <= 20) THEN 'PISCES'
        ELSE 'UNKNOWN'
    END;

    -- Insert the data into the table
    INSERT INTO tblAstrologi (nama, tgllahir, astrologi, umur, harilahir)
    VALUES (pNama, pTgllahir, vAstrologi, vUmur, vHarilahir);

    -- Return the result set
    SELECT nama, tgllahir, astrologi, umur, harilahir
    FROM tblAstrologi;
END;
$$
DELIMITER ;

-- PROCEDURE NO. 3
-- DROP PROCEDURE IF EXISTS spNomor3;
-- DELIMITER $$

-- CREATE PROCEDURE spNomor3()
-- BEGIN
--     DECLARE num INT DEFAULT 1;
--     DECLARE sum_digits INT;
--     DECLARE temp INT;
--     DECLARE digit INT;

--     WHILE num <= 1000 DO
--         SET temp = num;
--         SET sum_digits = 0;

--         -- Calculate sum of digits raised to the power of 3
--         WHILE temp > 0 DO
--             SET digit = temp % 10;
--             SET sum_digits = sum_digits + POW(digit, 3);
--             SET temp = FLOOR(temp / 10);
--         END WHILE;

--         -- Check if the number is Narcissistic
--         IF sum_digits = num THEN
--             -- Insert Narcissistic number into table
--             INSERT INTO tblNarcissus (Narsis) VALUES (num);
--         END IF;

--         SET num = num + 1;
--     END WHILE;

--     -- Select all Narcissistic numbers from the table
--     SELECT * FROM tblNarcissus;
-- END$$

-- DELIMITER ;

--------------------------------- CALL PROCEDURE --------------------------------

-- Call PROCEDURE NO. 1
CALL spNomor1();

-- CALL PROCEDURE NO. 2
CALL spNomor2('Novi', '1985-04-15');
CALL spNomor2('Diana', '1989-06-28');
CALL spNomor2('Benny', '1984-12-15');

-- -- Call PROCEDURE NO. 3
-- CALL spNomor3();

--------------------------------- DISPLAY LOGIC --------------------------------

-- NO. 1
DROP VIEW IF EXISTS vwJawaban1;
CREATE VIEW VwJawaban1 AS
SELECT * FROM tblComputerOrg;

-- NO. 2
DROP VIEW IF EXISTS vwJawaban2;
CREATE VIEW VwJawaban2 AS
SELECT * FROM tblAstrologi;

-- -- NO. 3
-- DROP VIEW IF EXISTS vwJawaban3;
-- CREATE VIEW VwJawaban3 AS
-- SELECT * FROM tblNarcissus;

--------------------------------- DISPLAY OUTPUT --------------------------------

-- NO. 1
SELECT * FROM
VwJawaban1;

-- NO. 2
SELECT * FROM
VwJawaban2;

-- -- NO. 3
-- SELECT * FROM
-- VwJawaban3;