DELIMITER //

CREATE FUNCTION hideSalary(salary FLOAT(8,2))
RETURNS VARCHAR(20) DETERMINISTIC
BEGIN 
    DECLARE sal VARCHAR(50); -- Adjusted size to hold both 'Low Salary' and 'High Salary'
    IF salary < 4000 THEN 
        SET sal = 'Low Salary';
    ELSE 
        SET sal = 'High Salary';
    END IF;
    RETURN sal;
END //

DELIMITER ;

SELECT first_name ,last_name,hideSalary(salary)
FROM employee;




DELIMITER //
CREATE FUNCTION calcTax(job VARCHAR (20))
RETURNS FLOAT(3,2) DETERMINISTIC
BEGIN 
DECLARE tax FLOAT(3,2) DEFAULT 0.05;
CASE 
WHEN job = 'Manager' THEN SET tax=0.1;
WHEN job = 'Programmer' THEN SET tax=0.7;
WHEN job = 'Tester' THEN SET tax=0.6;
ELSE SET tax= 0.05;
END CASE;
RETURN tax;
END //

DELIMITER ;
SELECT first_name,last_name,calcTax(description)
FROM employee;