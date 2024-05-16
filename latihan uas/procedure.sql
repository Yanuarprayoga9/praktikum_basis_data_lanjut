DELIMITER / / 
CREATE PROCEDURE addDataEmployee (
    id INT,
    first_name varchar(15),
    last_name
    varchar(15),
    start_date date,
    end_date date,
    salary float (8, 2),
    city varchar(10),
    description varchar(15)
) BEGIN 
INSERT INTO employee 
VALUES (id,first_name,last_name,start_date,end_date,salary,city,description);
END / / 

DELIMITER;

INSERT into employee
CALL addDataEmployee( 15,'ynr', 'Brown', '2024-03-15', '2025-03-15', 0, 'Francisco', 'Makan');


DELIMITER //
CREATE PROCEDURE updateJob(
    IN newid INT,
    IN newtitle varchar(20)
)
BEGIN 
UPDATE job SET title=newtitle WHERE id = newid;
END //
DELIMITER ;

CALL updateJob(1,"Tester");
CALL updateJob(2,"Accountant");
CALL updateJob(3,"Programmer");
CALL updateJob(4,"Profesor");
CALL updateJob(5,"PRemg");
CALL updateJob(6,"Makan");


DELIMITER //
CREATE PROCEDURE getCountJob(OUT numJobs INT)
BEGIN
SELECT COUNT(*) INTO numJobs from job;
END //
DELIMITER ;

CALL getCountJob(@numJobs);
select @numJobs;