-- create view
CREATE VIEW view1 AS
SELECT CONCAT (first_name, " ",last_name),city FROM employee;

-- Menampilkan view
SELECT * FROM view1;

-- gabungan first_name dan last_name
-- menjadi kolom name
CREATE VIEW view2 (name,place) AS 
SELECT CONCAT (first_name, " ",last_name),city from employee;

SELECT * FROM view2;

-- Pembuatan view menggunakan atribut algoritma MERGE dengan nama v_merge,
-- yang berisi field name (merupakan gabungan first_name dan last_name) dan salary.
CREATE ALGORITHM = MERGE VIEW v_merge (name,salary)
AS SELECT CONCAT (first_name, " " ,last_name) ,salary 
FROM employee WHERE salary > 2000; 

SELECT * FROM v_merge;
SELECT * FROM v_merge WHERE salary < 5000;
SELECT CONCAT(first_name," ",last_name) ,salary
FROM employee
WHERE (salary>2000) AND (salary < 5000);

-- Contoh algoritma MERGE yang tidak bisa digunakan, karena terdapat GROUP BY
-- pada statement SELECT serta fungsi aggregate COUNT (), MySql akan memberikan
-- pesan warning dan merubah algorim=tma secara otomatis menjadu UNDEFINED
CREATE ALGORITHM = MERGE VIEW myview (city,number_of_employee) AS
SELECT city ,count(id) FROM employee GROUP BY city; 
