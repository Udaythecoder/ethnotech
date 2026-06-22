create database fun;
use fun;
set sql_safe_updates=0;

create table pro(p_id int,p_name text,country varchar(10),sixers int);
desc pro;
alter table pro rename column goals to sixers;
insert into pro values(01,'dhoni','india',120),(02,'virat','india',100),(03,'warner','australia',94),(04,'klaseen','southafr',100),(05,'smith','australia',86),(06,'peddi','usa',115); 
select* from pro;
## procedure to get players
DELIMITER //
CREATE PROCEDURE GetAllPlayer()
BEGIN
    SELECT * FROM pro;
END //
DELIMITER ;
call getallplayer()
;
## procedure to get players on id
DELIMITER //
CREATE PROCEDURE GetPlayerID(IN pid INT)
BEGIN
    SELECT *
    FROM pro
    WHERE p_id = pid;
END//
DELIMITER ;
call getplayerid(4);

## procedure to get players by country
DELIMITER //
CREATE PROCEDURE GetPlayerCountry(IN p_country VARCHAR(50))
BEGIN
    SELECT *
    FROM pro
    WHERE Country = p_country;
END //
DELIMITER ;
call getplayercountry('australia');

## procedure to get high sixerplayers
DELIMITER //
CREATE PROCEDURE Maxsixers()
BEGIN
    SELECT p_name,country 
    FROM pro where sixers=(select max(sixers) from pro);
END //
DELIMITER ;
call maxsixers();

## procedure to insertplayers
DELIMITER //
create PROCEDURE InsertPlayer(
    IN pid INT,
    IN pname VARCHAR(50),
    IN pcountry VARCHAR(50),
    IN pruns INT
)
BEGIN
    INSERT INTO pro
    VALUES(pid,pname,pcountry,pruns);
END //
DELIMITER ;
call insertplayer(07,'yuvaraj','india',100);

## procedure to update players
DELIMITER //
CREATE PROCEDURE Updatesixers(
    IN pid INT,
    IN newsixers INT
)
BEGIN
    UPDATE pro
    SET sixers = newsixers
    WHERE p_id = pid;
END //
DELIMITER ;
call updatesixers(5,118);

## procedure to deleteplayers
DELIMITER //
CREATE PROCEDURE DeletePlayer(IN playername text)
BEGIN
    DELETE FROM pro
    WHERE P_name = playername;
END //
DELIMITER ;
call deleteplayer('yuvaraj');

## procedure to get playersabovecondition
DELIMITER //
CREATE PROCEDURE PlayersAbove115()
BEGIN
    SELECT *
    FROM pro
    WHERE sixers > 115;
END //
DELIMITER ;
call playersabove115();


DELIMITER //
CREATE PROCEDURE CountPlayers(IN var varchar(10))
BEGIN
    SELECT country,COUNT(*) AS Total_Players
    FROM pro group by country ;
END //
DELIMITER ;
call countplayers('india');
select* from pro;

use fun;
#window function
SELECT p_Name,
       sixers,
       ROW_NUMBER() OVER(ORDER BY sixers DESC) AS Row_Num
FROM pro;

SELECT p_Name,
       sixers,country,
       ROW_NUMBER() OVER(ORDER BY sixers asc) AS Row_Num
FROM pro;

SELECT p_Name,
       sixers,
       RANK() OVER(ORDER BY sixers DESC) AS Rank_No
FROM pro;

SELECT p_Name,
       sixers,
       DENSE_RANK() OVER(ORDER BY sixers DESC) AS Dense_Rank1
FROM pro;

SELECT p_Name,
       Country,
       sixers,
       RANK() OVER(
           PARTITION BY Country
           ORDER BY sixers DESC
       ) AS Country_Rank
FROM pro;

SELECT *
FROM
(
    SELECT p_Name,
           sixers,
           DENSE_RANK() OVER(ORDER BY sixers DESC) AS rnk
    FROM pro
) x
WHERE rnk = 2;

SELECT *
FROM
(
    SELECT p_Name,
           sixers,
           DENSE_RANK() OVER(ORDER BY sixers DESC) AS rnk
    FROM pro
) x
WHERE rnk <= 3;

use fun;
select* from pro;

CREATE TABLE players (
    id INT,
    name VARCHAR(50),
    country VARCHAR(50),
    runs INT
);
INSERT INTO players VALUES
(1,'dhoni','india',120),
(2,'virat','india',100),
(3,'warner','australia',94),
(4,'klaseen','southafr',100),
(5,'smith','australia',118),
(6,'peddi','usa',115),
(7,'yuvaraj','india',100);
#before insert
DELIMITER $$
CREATE TRIGGER check_runs
BEFORE INSERT
ON players
FOR EACH ROW
BEGIN
    IF NEW.runs < 100 THEN
        SET NEW.runs = 120;
    END IF;
END$$
DELIMITER ;
INSERT INTO players
VALUES (8,'rohit','india',50);
select* from players;

#after insert
CREATE TABLE player_log(
    msg VARCHAR(100)
);
DELIMITER $$
CREATE TRIGGER insert_log
AFTER INSERT
ON players
FOR EACH ROW
BEGIN
    INSERT INTO player_log
    VALUES(CONCAT(NEW.name,' added successfully'));
END$$
DELIMITER ;
INSERT INTO players
VALUES(8,'rohit','india',130);
#before update
DELIMITER $$
CREATE TRIGGER validate_update
BEFORE UPDATE
ON players
FOR EACH ROW
BEGIN
    IF NEW.runs < 0 THEN
        SET NEW.runs = OLD.runs;
    END IF;
END$$
DELIMITER ;
set SQL_SAFE_UPDATES=0;
UPDATE players
SET runs = -50
WHERE id = 1;
#AFTER UPDATE
DELIMITER $$
CREATE TRIGGER update_log
AFTER UPDATE
ON players
FOR EACH ROW
BEGIN
    INSERT INTO player_log
    VALUES(
        CONCAT(
            OLD.name,
            ' runs changed from ',
            OLD.runs,
            ' to ',
            NEW.runs
        )
    );
END$$
DELIMITER ;
UPDATE players
SET runs = 150
WHERE id = 2;
#before delete
DELIMITER $$
CREATE TRIGGER prevent_delete
BEFORE DELETE
ON players
FOR EACH ROW
BEGIN
    IF OLD.runs > 110 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT='Deletion Not Allowed';
    END IF;
END$$
DELIMITER ;
select* from players;
DELETE FROM players
WHERE id = 8 and runs=100;
#after delete
CREATE TABLE deleted_players(
    id INT,
    name VARCHAR(50),
    country VARCHAR(50),
    runs INT
);
DELIMITER $$
CREATE TRIGGER deleted_record
AFTER DELETE
ON players
FOR EACH ROW
BEGIN
    INSERT INTO deleted_players
    VALUES(
        OLD.id,
        OLD.name,
        OLD.country,
        OLD.runs
    );
END$$
DELIMITER ;
DELETE FROM players
WHERE id = 3;
select* from players;
select* from deleted_players;