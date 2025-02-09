CREATE DATABASE dbolimpiade;
use dbolimpiade;
create table tblathlete(
    ID INT,
    Name VARCHAR (255), 
    Sex CHAR,
    Age INT,
    Height INT,
    Weight INT,
    Team VARCHAR (255),
    NOC VARCHAR(10),
    Games VARCHAR (255),
    Year VARCHAR (255),
    Season VARCHAR (255),
    City VARCHAR (255),
    Sport VARCHAR (255),
    Event VARCHAR (255),
    Medal VARCHAR (255)
);

INSERT INTO tblathlete VALUES
(1, 'A Dijiang', 'M', 24, 180, 80, 'China', 'CHN', '1992 Summer', 1992, 'Summer', 'Barcelona', 'Basketball', 'Basketball Men''s Basketball', NULL),
(2, 'A Lamusi', 'M', 23, 170, 60, 'China', 'CHN', '2012 Summer', 2012, 'Summer', 'London', 'Judo', 'Judo Men''s Extra-Lightweight', NULL),
(3, 'Gunnar Nielsen Aaby', 'M', 24, NULL, NULL, 'Denmark', 'DEN', '1920 Summer', 1920, 'Summer', 'Antwerpen', 'Football', 'Football Men''s Football', NULL),
(4, 'Edgar Lindenau Aabye', 'M', 34, NULL, NULL, 'Denmark/Sweden', 'DEN', '1900 Summer', 1900, 'Summer', 'Paris', 'Tug-Of-War', 'Tug-Of-War Men''s Tug-Of-War', 'Gold'),
(5, 'Christine Jacoba Aaftink', 'F', 21, 185, 82, 'Netherlands', 'NED', '1988 Winter', 1988, 'Winter', 'Calgary', 'Speed Skating', 'Speed Skating Women''s 500 metres', NULL), 
(5, 'Christine Jacoba Aaftink', 'F', 21, 185, 82, 'Netherlands', 'NED', '1988 Winter', 1988, 'Winter', 'Calgary', 'Speed Skating', 'Speed Skating Women''s 1,000 metres', NULL),
(5, 'Christine Jacoba Aaftink', 'F', 25, 185, 82, 'Netherlands', 'NED', '1992 Winter', 1992, 'Winter', 'Albertville', 'Speed Skating', 'Speed Skating Women''s 500 metres', NULL),
(5, 'Christine Jacoba Aaftink', 'F', 25, 185, 82, 'Netherlands', 'NED', '1992 Winter', 1992, 'Winter', 'Albertville', 'Speed Skating', 'Speed Skating Women''s 1,000 metres', NULL),
(5, 'Christine Jacoba Aaftink', 'F', 27, 185, 82, 'Netherlands', 'NED', '1994 Winter', 1994, 'Winter', 'Lillehammer', 'Speed Skating', 'Speed Skating Women''s 500 metres', NULL),
(6, 'Aage Andreasen', 'M', 24, NULL, NULL, 'Denmark', 'DEN', '1920 Summer', 1920, 'Summer', 'Antwerpen', 'Football', 'Football Men''s Football', NULL);

DELIMITER $$
CREATE PROCEDURE spCountGenderBySport()
BEGIN
    DECLARE vSport VARCHAR(255);
    DECLARE vJumlahPria INT DEFAULT 0;
    DECLARE vJumlahWanita INT DEFAULT 0;
    DECLARE done INT DEFAULT 0;

    DECLARE curSport CURSOR FOR
        SELECT DISTINCT Sport FROM tblathlete;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN curSport;

    readSport: WHILE done = 0 DO
        FETCH curSport INTO vSport;
        IF done = 0 THEN
            SELECT 
                vSport AS Sport,
                (SELECT COUNT(*) FROM tblathlete WHERE Sport = vSport AND Sex = 'M') AS "Jumlah Pria",
                (SELECT COUNT(*) FROM tblathlete WHERE Sport = vSport AND Sex = 'F') AS "Jumlah Wanita";
        END IF;
    END WHILE readSport;

    CLOSE curSport;
END;
$$
DELIMITER ;

CALL spCountGenderbySport();