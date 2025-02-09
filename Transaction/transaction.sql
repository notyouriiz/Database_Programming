/*Inno DB*/
DROP DATABASE IF EXISTS dbTransaction;
CREATE DATABASE dbTransaction;
USE dbTransaction;

CREATE TABLE tblListToDo (
    nourut INT,
    jam TIMESTAMP,
    kegiatan VARCHAR(255) 
) engine = InnoDB;
SET autocommit = 0;

/*
    1. commit = data disetujui dan dikirim ke database
    2. Rollback = data tidak disetujui dan dikembalikan
*/

/*COMMIT*/
INSERT INTO tblListToDo VALUES
(1, '2024-06-12 10:00:00', 'Diskusi Kelompok');

SELECT *
FROM tblListToDo;

/* Dengan menggunakan transaction*/
START TRANSACTION;
INSERT INTO tblListToDo VALUES
(3, '2024-06-12 16:00:00', 'Kuliah');
COMMIT;



/*Rollback*/
START TRANSACTION;
INSERT INTO tblListToDo VALUES
(4, '2024-06-13 16:00:00', 'Kuliah');
SAVEPOINT svp130624;

INSERT INTO tblListToDo VALUES
(5, '2024-06-13 16:00:00', 'Kuliah');
ROLLBACK TO svp130624;