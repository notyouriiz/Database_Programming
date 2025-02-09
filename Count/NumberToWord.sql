USE dbquizp10;

CREATE TABLE NumberWords (
    num INT PRIMARY KEY,
    word VARCHAR(20)
);

INSERT INTO NumberWords (num, word) VALUES
(1, 'SATU'), (2, 'DUA'), (3, 'TIGA'), (4, 'EMPAT'), (5, 'LIMA'),
(6, 'ENAM'), (7, 'TUJUH'), (8, 'DELAPAN'), (9, 'SEMBILAN'),
(10, 'SEPULUH'), (11, 'SEBELAS'), (20, 'DUA PULUH'), (30, 'TIGA PULUH'),
(40, 'EMPAT PULUH'), (50, 'LIMA PULUH'), (60, 'ENAM PULUH'), (70, 'TUJUH PULUH'),
(80, 'DELAPAN PULUH'), (90, 'SEMBILAN PULUH'), (100, 'SERATUS'), (200, 'DUA RATUS'),
(300, 'TIGA RATUS'), (400, 'EMPAT RATUS'), (500, 'LIMA RATUS'), (600, 'ENAM RATUS'),
(700, 'TUJUH RATUS'), (800, 'DELAPAN RATUS'), (900, 'SEMBILAN RATUS');

DELIMITER $$

CREATE FUNCTION sfTerbilang(pAngka INT) RETURNS VARCHAR(255)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE vOutput VARCHAR(255) DEFAULT '';
    DECLARE ratus INT;
    DECLARE puluh INT;
    DECLARE satuan INT;

    SET ratus := FLOOR(pAngka DIV 100) * 100;
    SET puluh := FLOOR((pAngka MOD 100) DIV 10) * 10;
    SET satuan := pAngka MOD 10;

    IF ratus > 0 THEN
        SELECT word INTO vOutput FROM NumberWords WHERE num = ratus;
    END IF;

    IF puluh > 0 THEN
        IF puluh = 10 AND satuan > 0 THEN
            SELECT word INTO vOutput FROM NumberWords WHERE num = (puluh + satuan);
            RETURN TRIM(vOutput);
        ELSE
            SELECT word INTO @tmpPuluh FROM NumberWords WHERE num = puluh;
            SET vOutput := CONCAT(vOutput, ' ', @tmpPuluh);
        END IF;
    END IF;

    IF satuan > 0 AND puluh != 10 THEN
        SELECT word INTO @tmpSatuan FROM NumberWords WHERE num = satuan;
        SET vOutput := CONCAT(vOutput, ' ', @tmpSatuan);
    END IF;

    RETURN TRIM(vOutput);
END
$$
DELIMITER ;

DROP PROCEDURE IF EXISTS spTerbilang;
DELIMITER $$
CREATE PROCEDURE spTerbilang(pAngka BIGINT)
BEGIN
    DECLARE vOutput VARCHAR(255);
    DECLARE juta INT;
    DECLARE ribu INT;
    DECLARE ratus INT;

    SET juta := FLOOR(pAngka DIV 1000000);
    SET ribu := FLOOR((pAngka MOD 1000000) DIV 1000);
    SET ratus := pAngka MOD 1000;

    SET vOutput := '';

    IF juta > 0 THEN
        SET vOutput := CONCAT(vOutput, sfTerbilang(juta), ' JUTA ');
    END IF;

    IF ribu > 0 THEN
        SET vOutput := CONCAT(vOutput, sfTerbilang(ribu), ' RIBU ');
    END IF;

    IF ratus > 0 THEN
        SET vOutput := CONCAT(vOutput, sfTerbilang(ratus));
    END IF;

    SELECT TRIM(vOutput) AS OUTPUT;
END
$$
DELIMITER ;

CALL spTerbilang(31526253);