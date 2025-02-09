CREATE DATABASE dbSP2;
USE dbSP2;

-- No. 1
DROP PROCEDURE IF EXISTS HitungWaktu;

DELIMITER $$
CREATE PROCEDURE HitungWaktu(IN totalDetik INT) -- IN untuk parameter INPUT
BEGIN
    DECLARE hari INT;
    DECLARE jam INT;
    DECLARE menit INT;
    DECLARE detik INT;

    -- Hitung jumlah hari
    SET hari = totalDetik DIV 86400;
    SET totalDetik = totalDetik MOD 86400;

    -- Hitung jumlah jam
    SET jam = totalDetik DIV 3600;
    SET totalDetik = totalDetik MOD 3600;

    -- Hitung jumlah menit
    SET menit = totalDetik DIV 60;
    SET totalDetik = totalDetik MOD 60;

    -- Sisa detik
    SET detik = totalDetik;

    -- Hasil
    SELECT hari AS Hari, jam AS Jam, menit AS Menit, detik AS Detik;
END
$$
DELIMITER ;
CALL HitungWaktu(10000);



-- No. 4
DROP PROCEDURE IF EXISTS MultiplyDigits;

DELIMITER $$
CREATE PROCEDURE MultiplyDigits(IN bilangan INT)
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE hasil INT DEFAULT 1;
    DECLARE digit CHAR(1);

    -- Loop hingga hanya tersisa satu digit
    WHILE i <= LENGTH(bilangan) DO
        SET digit = SUBSTRING(bilangan, i, 1);
        SET hasil = hasil * digit;
        
        -- Tampilkan proses perhitungan
        SELECT CONCAT_WS(' * ', SUBSTRING(bilangan, 1, i)) AS Calculation, hasil AS Result;
        
        SET i = i + 1;
    END WHILE;

    -- Tampilkan hasil akhir
    SELECT hasil AS FinalResult;
END
$$
DELIMITER ;
CALL MultiplyDigits(12346);


-- No. 5
DROP PROCEDURE IF EXISTS PecahUang;

DELIMITER $$
CREATE PROCEDURE PecahUang(IN jumlah_uang INT)
BEGIN
    DECLARE uang INT DEFAULT jumlah_uang;
    DECLARE lembar_100000 INT;
    DECLARE lembar_50000 INT;
    DECLARE lembar_20000 INT;
    DECLARE lembar_10000 INT;
    DECLARE lembar_5000 INT;
    DECLARE lembar_2000 INT;
    DECLARE lembar_1000 INT;
    DECLARE koin_500 INT;

    -- Inisialisasi jumlah lembar/koin
    SET lembar_100000 = uang DIV 100000;
    SET uang = uang - lembar_100000 * 100000;
    SET lembar_50000 = uang DIV 50000;
    SET uang = uang - lembar_50000 * 50000;
    SET lembar_20000 = uang DIV 20000;
    SET uang = uang - lembar_20000 * 20000;
    SET lembar_10000 = uang DIV 10000;
    SET uang = uang - lembar_10000 * 10000;
    SET lembar_5000 = uang DIV 5000;
    SET uang = uang - lembar_5000 * 5000;
    SET lembar_2000 = uang DIV 2000;
    SET uang = uang - lembar_2000 * 2000;
    SET lembar_1000 = uang DIV 1000;
    SET uang = uang - lembar_1000 * 1000;
    SET koin_500 = uang DIV 500;

    -- Tampilkan hasil
    SELECT 
        CONCAT(lembar_100000, ' Lembar 100.000') AS Uang,
        CONCAT(lembar_50000, ' Lembar 50.000') AS Uang,
        CONCAT(lembar_20000, ' Lembar 20.000') AS Uang,
        CONCAT(lembar_10000, ' Lembar 10.000') AS Uang,
        CONCAT(lembar_5000, ' Lembar 5.000') AS Uang,
        CONCAT(lembar_2000, ' Lembar 2.000') AS Uang,
        CONCAT(lembar_1000, ' Lembar 1.000') AS Uang,
        CONCAT(koin_500, ' Koin 500') AS Uang;
END
$$
DELIMITER ;
CALL PecahUang(18500);


-- No. 6
DROP PROCEDURE IF EXISTS HitungHuruf;

DELIMITER $$
CREATE PROCEDURE HitungHuruf(IN kalimat VARCHAR(255))
BEGIN
    DECLARE panjang INT;
    DECLARE i INT DEFAULT 1;
    DECLARE huruf CHAR(1);
    DECLARE vokal_count INT DEFAULT 0;
    DECLARE konsonan_count INT DEFAULT 0;
    DECLARE karakter_lain_count INT DEFAULT 0;

    -- Hitung panjang kalimat
    SET panjang = LENGTH(kalimat);

    -- Loop untuk setiap karakter dalam kalimat
    WHILE i <= panjang DO
        -- Ambil karakter pada posisi i
        SET huruf = SUBSTRING(kalimat, i, 1);

        -- Periksa apakah huruf adalah huruf vokal, konsonan, atau karakter lain
        IF huruf REGEXP '[aeiouAEIOU]' THEN
            SET vokal_count = vokal_count + 1;
        ELSEIF huruf REGEXP '[a-zA-Z]' THEN
            SET konsonan_count = konsonan_count + 1;
        ELSE
            SET karakter_lain_count = karakter_lain_count + 1;
        END IF;

        SET i = i + 1;
    END WHILE;

    -- Tampilkan hasil
    SELECT vokal_count AS "Huruf vokal",
        konsonan_count AS "Konsonan",
        karakter_lain_count AS "Karakter lain (spasi)"
    FROM DUAL;
END
$$
DELIMITER ;
CALL HitungHuruf('FAKULTAS ILMU KOMPUTER');
CALL HitungHuruf('FAKULTAS EKONOMI DAN BISNIS');


-- No. 7
DROP PROCEDURE IF EXISTS HitungNilaiHuruf;

DELIMITER $$
CREATE PROCEDURE HitungNilaiHuruf(IN nilai_angka INT)
BEGIN
    DECLARE nilai_huruf VARCHAR(10);

    -- Tentukan nilai huruf berdasarkan nilai angka
    IF nilai_angka > 80 THEN
        SET nilai_huruf = 'A';
    ELSEIF nilai_angka >= 75 AND nilai_angka <= 79 THEN
        SET nilai_huruf = 'AB';
    ELSEIF nilai_angka >= 70 AND nilai_angka <= 74 THEN
        SET nilai_huruf = 'B';
    ELSEIF nilai_angka >= 65 AND nilai_angka <= 69 THEN
        SET nilai_huruf = 'BC';
    ELSEIF nilai_angka >= 60 AND nilai_angka <= 64 THEN
        SET nilai_huruf = 'C';
    ELSEIF nilai_angka >= 55 AND nilai_angka <= 59 THEN
        SET nilai_huruf = 'CD';
    ELSEIF nilai_angka >= 50 AND nilai_angka <= 54 THEN
        SET nilai_huruf = 'D';
    ELSE
        SET nilai_huruf = 'E';
    END IF;

    -- Tampilkan hasil
    SELECT nilai_huruf AS "Nilai Huruf";
END
$$
DELIMITER ;
CALL HitungNilaiHuruf(85);
CALL HitungNilaiHuruf(50);
CALL HitungNilaiHuruf(76);


-- No. 8
DROP PROCEDURE IF EXISTS AngkaArabKeRomawi;

DELIMITER $$
CREATE PROCEDURE AngkaArabKeRomawi(IN angka_arab INT)
BEGIN
    DECLARE romawi VARCHAR(20) DEFAULT '';

    -- Cek apakah angka dalam rentang yang diizinkan
    IF angka_arab < 1 OR angka_arab > 3999 THEN
        SELECT 'Angka harus berada dalam rentang 1 hingga 3999' AS Result;
    ELSE
        -- Konversi angka Arab ke Romawi
        WHILE angka_arab >= 1000 DO
            SET romawi = CONCAT(romawi, 'M');
            SET angka_arab = angka_arab - 1000;
        END WHILE;
        WHILE angka_arab >= 900 DO
            SET romawi = CONCAT(romawi, 'CM');
            SET angka_arab = angka_arab - 900;
        END WHILE;
        WHILE angka_arab >= 500 DO
            SET romawi = CONCAT(romawi, 'D');
            SET angka_arab = angka_arab - 500;
        END WHILE;
        WHILE angka_arab >= 400 DO
            SET romawi = CONCAT(romawi, 'CD');
            SET angka_arab = angka_arab - 400;
        END WHILE;
        WHILE angka_arab >= 100 DO
            SET romawi = CONCAT(romawi, 'C');
            SET angka_arab = angka_arab - 100;
        END WHILE;
        WHILE angka_arab >= 90 DO
            SET romawi = CONCAT(romawi, 'XC');
            SET angka_arab = angka_arab - 90;
        END WHILE;
        WHILE angka_arab >= 50 DO
            SET romawi = CONCAT(romawi, 'L');
            SET angka_arab = angka_arab - 50;
        END WHILE;
        WHILE angka_arab >= 40 DO
            SET romawi = CONCAT(romawi, 'XL');
            SET angka_arab = angka_arab - 40;
        END WHILE;
        WHILE angka_arab >= 10 DO
            SET romawi = CONCAT(romawi, 'X');
            SET angka_arab = angka_arab - 10;
        END WHILE;
        WHILE angka_arab >= 9 DO
            SET romawi = CONCAT(romawi, 'IX');
            SET angka_arab = angka_arab - 9;
        END WHILE;
        WHILE angka_arab >= 5 DO
            SET romawi = CONCAT(romawi, 'V');
            SET angka_arab = angka_arab - 5;
        END WHILE;
        WHILE angka_arab >= 4 DO
            SET romawi = CONCAT(romawi, 'IV');
            SET angka_arab = angka_arab - 4;
        END WHILE;
        WHILE angka_arab >= 1 DO
            SET romawi = CONCAT(romawi, 'I');
            SET angka_arab = angka_arab - 1;
        END WHILE;

        -- Tampilkan hasil konversi
        SELECT romawi AS Result;
    END IF;
END
$$
DELIMITER ;
CALL AngkaArabKeRomawi(27);




DROP TABLE tbldenominations;
CREATE TABLE IF NOT EXISTS tbldenominations (
    denomination_name VARCHAR(50),
    denomination_value INT
);

-- Populate the table with the denominations if not already present
INSERT INTO tbldenominations (denomination_name, denomination_value) VALUES 
('Lembar 100.000', 100000),
('Lembar 50.000', 50000),
('Lembar 20.000', 20000),
('Lembar 10.000', 10000),
('Lembar 5.000', 5000),
('Lembar 2.000', 2000),
('Lembar 1.000', 1000),
('Koin 500', 500)

DROP PROCEDURE IF EXISTS spPecahanUang;

CREATE PROCEDURE spPecahanUang(IN jumlah_uang INT)
BEGIN
    DECLARE vUang INT DEFAULT jumlah_uang; -- input an 
    DECLARE vLembar_koin INT; -- lembar uang
    DECLARE idx INT DEFAULT 0; -- index tabel
    DECLARE vDenom_count INT; -- hitung total uang
    DECLARE vDenom_name VARCHAR(50); -- deklarasi nama uang
    DECLARE vDenom_value INT; -- hitung total pecahan uang

    -- Get the count of denominations
    SELECT COUNT(*) INTO vDenom_count FROM tbldenominations; -- menghitung pecahan uang berdasarkan tabel

    -- Temporary table untuk menampung macam pecahan uang
    CREATE TEMPORARY TABLE tbltmpTempResults (
        denomination_name VARCHAR(50),
        count INT
    );

    -- Loop tabel
    WHILE idx < vDenom_count DO
        SELECT denomination_name, denomination_value -- ambil nama dan nilai uang
        INTO vDenom_name, vDenom_value FROM tbldenominations -- input ke tabel 
        ORDER BY denomination_value DESC -- pengurutan pecahan uang pada output
        LIMIT idx, 1; -- hanya boleh mengembalikan nilai 1 row
        -- math menghitung pecahan uang
        SET vLembar_koin = vUang DIV vDenom_value;
        SET vUang = vUang - vLembar_koin * vDenom_value;

        INSERT INTO tbltmpTempResults (denomination_name, count) VALUES (vDenom_name, vLembar_koin); -- 

        SET idx = idx + 1; -- looping
    END WHILE;

    -- Select results
    SELECT CONCAT(count, ' ', denomination_name) AS Uang FROM tbltmpTempResults; -- input ke tabel sementara

    -- Clean up temporary table
    DROP TEMPORARY TABLE IF EXISTS tbltmpTempResults; -- bersihkan tabel untuk persiapan output lainnya
END;
DELIMITER ;

CALL spPecahanUang(250000);
CALL spPecahanUang(2500000);
CALL spPecahanUang(50000);