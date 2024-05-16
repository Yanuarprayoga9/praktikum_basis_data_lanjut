DELIMITER //
CREATE FUNCTION countJobs()
RETURNS INT DETERMINISTIC
BEGIN
DECLARE count INT;
SELECT count(*) INTO count FROM job;
RETURN count; 
END //
DELIMITER ;

DELIMITER //
CREATE FUNCTION tax(salary FLOAT (8,2),description VARCHAR(10))
RETURNS FLOAT (8,2) DETERMINISTIC
BEGIN
DECLARE result FLOAT(8,2);
if description="Tester" THEN
        SET result = salary * 0.9;
ELSE
        SET result = salary;
END IF;
RETURN result;
END //
DELIMITER ;

SELECT first_name ,tax(salary,description) from employee;



DELIMITER //
CREATE FUNCTION taxset (job VARCHAR(10))
RETURNS FLOAT (3,2) DETERMINISTIC
BEGIN
case job
WHEN 'Tester' THEN RETURN 0.1;
WHEN 'Developer' THEN RETURN 0.2;
ELSE RETURN 0.2;
END CASE;
END //
DELIMITER ;
SELECT first_name ,taxset(description),description from employee;


