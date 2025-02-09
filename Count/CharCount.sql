CREATE DATABASE dbQuizP10;
USE dbQuizP10;

/*Nomor 1*/
DROP PROCEDURE IF EXISTS spHitungHuruf;
DELIMITER $$
CREATE PROCEDURE spHitungHuruf (pKalimat VARCHAR(255))
BEGIN
    DECLARE vResult VARCHAR(255);
    DECLARE vChar CHAR(1);
    DECLARE vCount INT;
    DECLARE vIndex INT;
    DECLARE vTempKalimat VARCHAR(255);

    SET vIndex = 1;
    SET vResult = '';
    SET vTempKalimat = UPPER(pKalimat);

    WHILE vIndex <= LENGTH(vTempKalimat) DO
        SET vChar = SUBSTR(vTempKalimat, vIndex, 1);
        SET vCount = 0;

        IF LOCATE(CONCAT(',', vChar, '='), vResult) = 0 THEN
            SET vCount = LENGTH(vTempKalimat) - LENGTH(REPLACE(vTempKalimat, vChar, ''));

            IF vCount > 0 THEN
                SET vResult = CONCAT(vResult, vChar, '=', vCount, ', ');
            END IF;
        END IF;

        SET vIndex = vIndex + 1;
    END WHILE;

    SELECT TRIM(TRAILING ', ' FROM vResult) AS output;
END;
$$
DELIMITER ;

CALL spHitungHuruf('BOLA');


/*Nomor 2*/
DROP PROCEDURE IF EXISTS spBersusun;
DELIMITER $$
CREATE PROCEDURE spBersusun (pKalimat VARCHAR(255))
BEGIN
    DECLARE vResult VARCHAR(255);
    DECLARE vLength INT;
    DECLARE vIndex INT;

    SET vLength = LENGTH(pKalimat);
    SET vIndex = vLength;

    CREATE TEMPORARY TABLE result_table (kalimat VARCHAR(255));

    WHILE vIndex > 0 DO
        INSERT INTO result_table (kalimat) VALUES (LEFT(pKalimat, vIndex));
        SET vIndex = vIndex - 1;
    END WHILE;

    SELECT * FROM result_table;
END;
$$
DELIMITER ;
CALL spBersusun('IKOMUNIKA');
