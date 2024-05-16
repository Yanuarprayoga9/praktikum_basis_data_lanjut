
DELIMITER //

CREATE FUNCTION addtax(salary FLOAT(8,2))
RETURNS FLOAT(8,2) DETERMINISTIC
BEGIN
    DECLARE tax FLOAT DEFAULT 0.05;
    RETURN salary * (1 - tax);
END //

DELIMITER ;

select first_name,addtax(salary) FROM employee;



DELIMITER //

CREATE PROCEDURE checkScope()
BEGIN 
DECLARE first_name VARCHAR(15) DEFAULT 'bob';
SELECT id,first_name FROM employee WHERE first_name  = first_name;
END //

DELIMITER ;

CALL checkScope();