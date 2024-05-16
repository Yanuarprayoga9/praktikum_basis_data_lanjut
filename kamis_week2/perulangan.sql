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
CREATE PROCEDURE repeatDemo(IN number INT(10))
BEGIN 
REPEAT 
SET number = number + 1;
UNTIL number MOD 12 = 0
END REPEAT ;
SELECT number ;
END //

DELIMITER ;
CALL repeatDemo(10);


DELIMITER //
CREATE PROCEDURE iterateDemo(number INT(10))
BEGIN 
label1: LOOP 
SET number = number + 1;
IF number MOD 12 > 0 THEN
ITERATE label1;
END IF;
LEAVE label1;
END LOOP label1 ;
SELECT number ;
END //

DELIMITER ;
CALL iterateDemo(10);

