/*
    STOREDE PROSEDUR
    1. BAHASA PROSEDURAL
    2. ADA VARIABEL & TIPE DATABASE
    3. LOGICAL STATEMENT (IF ELSE | CASE WHEN)
    4. LOOPING
    5. CURSOR
    6. PARAMETER
*/


CREATE DATABASE dbSP;
USE dbSP;

DROP TABLE IF EXISTS tblSP;
CREATE TABLE tblSP (
    NOURUT INT PRIMARY KEY,
    KETERANGAN VARCHAR(255) NOT NULL
);

/*
    KARENA DALAM PROSEDUR MAKA DAPAT PERINTAH YANG DAPAT DIJALANKAN SECARA BERURUTAN, 
    KARENA DALAM DELIMITER DEFAULT (;) MAKA DELIMITER DIGANTI DENGAN DELIMITER LAIN DAN SELECTNYA MENGGUNAKAN DELIMITER YANG SAMA

    DELIMITER $$
    CREATE PROCEEDURE nama(
        PARAMETER
        )
    BEGIN
        DECLARE VARIABLE
        DECLARE Dtype
        TULIS PERINTAH PROCEDURE
    END;

    ----
    CALL nama();
*/

-- PROCEEDURE spHELLO()
DROP PROCEDURE IF EXISTS spHELLO;
DELIMITER $$
    CREATE PROCEDURE spHELLO(
        pNama VARCHAR (255)
    )
    BEGIN
        SELECT CONCAT("HELLO THERE, ", pNama);
    END;
$$
DELIMITER ; -- BACK INTO DEFAULT PARAMETER


-- PROCEDURE spCHECK()
DROP PROCEDURE IF EXISTS spCHECK;
DELIMITER $$
    CREATE PROCEDURE spCHECK(
        pAngka INT
    )
    BEGIN
        DECLARE vPesan VARCHAR (10);
        IF MOD (pAngka, 2) = 0 THEN
            SET vPesan := "GENAP";
        ELSE
            SET vPesan := "GENAP";
        END IF;
        SELECT CONCAT(pAngka, " Adalah = ", vPesan) AS "HASIL";
    END;
$$
DELIMITER ;

-- PROCEDURE sp
DROP PROCEDURE IF EXISTS spCHECKNOL;
DELIMITER $$ 
    CREATE PROCEDURE spCHECKNOL(
        pAngka INT
    )
    BEGIN
        DECLARE vPesan VARCHAR (100);
        IF pAngka = 0 THEN 
            SET vPesan := " ADALAH 0";
        ELSEIF (pAngka > 0) THEN 
            SET vPesan := " ADALAH > 0";
        ELSE
            SET vPesan := " ADALAH < 0";
        END IF;
        SELECT CONCAT ("INPUTAN ANGKA ", pAngka, vPesan) AS "HASIL CHECKING";
    END;
$$
DELIMITER ;

-- PROCEDURE
DROP PROCEDURE IF EXISTS IF EXISTS spMATH;
DELIMITER $$
    CREATE PROCEDURE spMATH(
        pA INT,
        pB INT,
        pOperasi VARCHAR(20)
    )
    BEGIN
        DECLARE vHasil INT;
        CASE 
            WHEN pOperasi = '+' THEN
                SET vHasil := pA+pB;
            WHEN pOperasi = '-' THEN
                SET vHasil := pA-pB;
            WHEN pOperasi = '*' THEN
                SET vHasil := pA*pB;
            WHEN pOperasi = '/' THEN
                SET vHasil := pA/pB;
        END CASE;
        SELECT CONCAT (pA, pOperasi, pB, " = ", vHasil) AS "HASIL OPERASI MATH";
    END;
$$
DELIMITER ; 

/*
    LOOPING DALAM SQL:
    1. LOOP - END LOOP
    2. WHILE - END WHILE
    3. REPEAT - UNTIL - END REPEAT

    UNTUK KELUAR
    1. BREAK(Java/C/Php) = LEAVE(Sql)
*/
-- PROCEDURE spLOOP()
DROP PROCEDURE IF EXISTS spLOOP;
DELIMITER $$
    CREATE PROCEDURE spLOOP(
        pDari INT,
        pSampai INT
    )
    BEGIN
        DECLARE KOUNTER INT;

        -- LOOP - END LOOP
            SET KOUNTER := pDari;
        carasatu: LOOP
            SELECT KOUNTER AS "LOOP";
            SET KOUNTER := KOUNTER + 1;
            IF KOUNTER > pSampai 
                THEN LEAVE carasatu;
            END IF;
        END LOOP carasatu;

        -- WHILE - END WHILE LOOP
        SET KOUNTER := pDari;
        caradua: WHILE KOUNTER <= pSampai DO
        SELECT KOUNTER AS "WHILE";
            SET KOUNTER := KOUNTER + 1;
        END WHILE caradua;

        -- REPEAT - UNTIL LOOP
        SET KOUNTER := pDari;
        caratiga: REPEAT
            SELECT KOUNTER AS "REPEAT";
            SET KOUNTER := KOUNTER + 1;
            UNTIL KOUNTER > pSampai
        END REPEAT caratiga;
    END;
$$
DELIMITER ;

---------------------------------------------------------------- CALL PROCEDURE --------------------------------------------------------

-- spHELLO()
CALL spHELLO('FAIZ');

-- spCHECK()
CALL spCHECK(8);

-- spCHECKNOL()
CALL spCHECKNOL(12);

-- spMATH()
CALL spMATH(7, 5, '+');
CALL spMATH(7, 5, '-');
CALL spMATH(7, 5, '*');
CALL spMATH(7, 5, '/');

-- spLOOP()
CALL spLOOP(3, 7);
CALL spLOOP(3, 7);
CALL spLOOP(3, 7);