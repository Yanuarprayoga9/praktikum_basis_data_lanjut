create trigger before add inputan 0 maka + 1000

DELIMITER //
CREATE TRIGGER salaryzero 
BEFORE INSERT ON employee
FOR EACH ROW 
BEGIN 
IF NEW.salary = 0 THEN
SET NEW.salary = 1000;
ELSE 
SET NEW.salary = NEW.salary + 100;
END IF;
END //
DELIMITER ;

INSERT into employee
VALUES ( 10,'Emily', 'Brown', '2024-03-15', '2025-03-15', 0, 'Francisco', 'Developer');
INSERT into employee
VALUES ( 11,'ynr', 'Brown', '2024-03-15', '2025-03-15', 100, 'Francisco', 'Developer');

-- trigger if
mengurani karyawan jr dev
DELIMITER //
CREATE TRIGGER entry_level 
BEFORE INSERT ON employee
FOR EACH ROW
BEGIN 
IF NEW.description = 'Programmer' THEN 
SET NEW.salary = 1000;
ELSEIF NEW.description = 'Tester' THEN 
SET NEW.salary = 900;
ELSE 
SET NEW.salary = 500;
END IF;
END //
DELIMITER ;

INSERT into employee
VALUES ( 13,'ynr', 'Brown', '2024-03-15', '2025-03-15', 0, 'Francisco', 'Tester');


-- trigger count
DELIMITER //
CREATE FUNCTION countByCIty (cityname VARCHAR(10))
RETURNS INT DETERMINISTIC
BEGIN
DECLARE count_city INT;
SELECT COUNT(*) INTO count_city from employee WHERE city LIKE cityname;
RETURN count_city;
END //
DELIMITER ;

-- trigger param out
DELIMITER //
CREATE PROCEDURE countByDesc (OUT count_desk INT)
BEGIN
SELECT COUNT(*) INTO count_desk from employee where description="Tester";
END //
DELIMITER ;

-- trigger insert
DELIMITER &
CREATE TRIGGER beli_barang AFTER INSERT ON beli 
FOR EACH ROW BEGIN 
INSERT INTO stok SET 
kd_barang = NEW.kd_barang ,jumlah= New.jumlah 
ON DUPLICATE KEY UPDATE jumlah = jumlah + New.jumlah;
END &

DELIMITER //
CREATE TRIGGER insert_job 
BEFORE INSERT ON employee
FOR EACH ROW
BEGIN 
INSERT INTO job 
SET title = NEW.description;
END //
DELIMITER ;

INSERT into employee
VALUES ( 14,'ynr', 'Brown', '2024-03-15', '2025-03-15', 0, 'Francisco', 'Makan');

DELIMITER //
CREATE TRIGGER update_job
BEFORE UPDATE
ON employee
FOR EACH ROW
BEGIN
UPDATE job SET
title = new.description
WHERE title =  "Makan";
END //
DELIMITER ;
UPDATE employee SET  description="PRemg" where description="Makan";
