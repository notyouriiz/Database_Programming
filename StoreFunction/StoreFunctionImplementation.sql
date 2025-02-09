-- Membuat database
CREATE DATABASE dbsf2;
USE dbsf2;

-- Membuat tabel yang berisi alfabet
DELIMITER $$
CREATE FUNCTION sfCaesar(pKata VARCHAR(255), pKunci INT)
RETURNS VARCHAR(255)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE n INT;
    DECLARE encrypted_char CHAR(1);
    DECLARE encrypted_text VARCHAR(255) DEFAULT '';
    DECLARE char_index INT;

    /* Mengubah input menjadi huruf besar */
    SET pKata = UPPER(pKata);
    SET n = LENGTH(pKata);

    WHILE i <= n DO
        SET encrypted_char = SUBSTRING(pKata, i, 1);

        IF encrypted_char BETWEEN 'A' AND 'Z' THEN
            SELECT id INTO char_index FROM tblAlphabet WHERE letter = encrypted_char;
            IF pKunci > 0 THEN
                SET char_index = (char_index + pKunci) % 26;
            ELSE
                SET char_index = (char_index + 26 + pKunci) % 26;
            END IF;
            SELECT letter INTO encrypted_char FROM tblAlphabet WHERE id = char_index;
        END IF;

        SET encrypted_text = CONCAT(encrypted_text, encrypted_char);
        SET i = i + 1;
    END WHILE;

    RETURN encrypted_text;
END
$$
DELIMITER ;

DELIMITER $$
CREATE FUNCTION sfCaesarDecrypt(pKata VARCHAR(255), pKunci INT)
RETURNS VARCHAR(255)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE n INT;
    DECLARE decrypted_char CHAR(1);
    DECLARE decrypted_text VARCHAR(255) DEFAULT '';
    DECLARE char_index INT;

    /* Mengubah input menjadi huruf besar */
    SET pKata = UPPER(pKata);
    SET n = LENGTH(pKata);

    WHILE i <= n DO
        SET decrypted_char = SUBSTRING(pKata, i, 1);

        IF decrypted_char BETWEEN 'A' AND 'Z' THEN
            SELECT id INTO char_index FROM tblAlphabet WHERE letter = decrypted_char;
            IF pKunci > 0 THEN
                SET char_index = (char_index - pKunci + 26) % 26;
            ELSE
                SET char_index = (char_index - pKunci) % 26;
                IF char_index < 0 THEN
                    SET char_index = char_index + 26;
                END IF;
            END IF;
            SELECT letter INTO decrypted_char FROM tblAlphabet WHERE id = char_index;
        END IF;

        SET decrypted_text = CONCAT(decrypted_text, decrypted_char);
        SET i = i + 1;
    END WHILE;

    RETURN decrypted_text;
END
$$
DELIMITER ;

SELECT sfCaesar('IKOM', 7);
SELECT sfCaesar('IKOM', 5);
SELECT sfCaesarDecrypt('PRVT', 7);
SELECT sfCaesarDecrypt('NPTR', 5);