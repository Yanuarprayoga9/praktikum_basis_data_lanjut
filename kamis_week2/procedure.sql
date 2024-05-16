-- ### PROCEDURE

--  mengambil semua data employee----
select * from employee

--  procedure mengambil semua data employee----
DELIMITER && 
CREATE PROCEDURE show_employees()
BEGIN
SELECT * FROM employee;
END && 


--  call to show employees----
CALL show_employees;

-- PARAMETER IN
--  IN cityName Varchar(255) ----
DELIMITER &&
CREATE PROCEDURE getEmployeeByCity(IN cityName VARCHAR(255))
BEGIN
SELECT * FROM employee WHERE city=cityName;
END &&

DELIMITER ;

--  call to getEmployeeCity----
CALL getEmployeeByCity("Vancouver");

-- PARAMETER IN
--  IN numEmployee Varchar(255) ----
DELIMITER && 
CREATE PROCEDURE getNumEmployee(OUT numEmployee INT)
BEGIN 
SELECT COUNT(*) INTO numEmployee FROM employee;
END &&

DELIMITER ;

--  call to getEmployeeCity----
CALL getNumEmployee(@num);





-- LATIHAN
-- 1. Buatlah procedure untuk menambahkan data pada tabel employee
-- 2. Buatlah procedure untuk mengupdate data pada tabel employee
-- 3. Buatlah procedure untuk menghitung jumlah karyawan yang tinggal di city
-- Vancouver

--  1 ----
DELIMITER $$

CREATE PROCEDURE addEmployee(
    IN first_name VARCHAR(15),
    IN last_name VARCHAR(15),
    IN start_date DATE,
    IN end_date DATE,
    IN salary FLOAT(8,2),
    IN city VARCHAR(10),
    IN description VARCHAR(15)
)
BEGIN
    INSERT INTO employee (first_name, last_name, start_date, end_date, salary, city, description)
    VALUES (first_name, last_name, start_date, end_date, salary, city, description);
END$$

DELIMITER ;
--  call to addEMployee----

CALL addEmployee('John', 'Doe', '2024-05-16', '2025-05-16', 5000.00, 'New York', 'Programmer');
CALL show_employees();





--  2 ----

DELIMITER $$

CREATE PROCEDURE updateEmployee(
    IN employee_id INT,
    IN new_first_name VARCHAR(15),
    IN new_last_name VARCHAR(15),
    IN new_start_date DATE,
    IN new_end_date DATE,
    IN new_salary FLOAT(8,2),
    IN new_city VARCHAR(10),
    IN new_description VARCHAR(15)
)
BEGIN
    UPDATE employee 
    SET 
        first_name = new_first_name,
        last_name = new_last_name,
        start_date = new_start_date,
        end_date = new_end_date,
        salary = new_salary,
        city = new_city,
        description = new_description
    WHERE id = employee_id;
END$$

DELIMITER ;

CALL updateEmployee(1, 'Jane', 'Smith', '2023-01-01', '2024-12-31', 6000.00, 'Jakarta', 'Sr Dev');
CALL show_employees();


--  3 ----
DELIMITER $$

CREATE PROCEDURE countEmployees(OUT employee_count INT)
BEGIN
    SELECT COUNT(*) INTO employee_count FROM employee WHERE city = 'Vancouver';
END$$

DELIMITER ;

CALL countEmployees(@employee_count);
SELECT @employee_count;
