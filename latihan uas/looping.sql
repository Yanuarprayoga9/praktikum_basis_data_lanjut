DELIMITER //
CREATE PROCEDURE mod12(IN number INT(10))
BEGIN WHILE number MOD 12 > 0 DO 
SET number = number + 1;
END WHILE ;
SELECT number ;
END //
DELIMITER ;
CALL mod12(10);

DELIMITER //
CREATE PROCEDURE mod12(IN number INT(10))
BEGIN WHILE number MOD 12 > 0 DO 
SET number = number + 1;
END WHILE ;
SELECT number ;
END //
DELIMITER ;
CALL mod12(10);

DELIMITER //
CREATE PROCEDURE mod12(IN number INT(10))
BEGIN WHILE number MOD 12 > 0 DO 
SET number = number + 1;
END WHILE ;
SELECT number ;
END //
DELIMITER ;
CALL mod12(10);

