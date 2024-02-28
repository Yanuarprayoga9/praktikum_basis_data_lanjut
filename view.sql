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

-- Query pada langkah ke 6 dapat dijalankan dengan mengganti algoritma MERGE
-- dengan algoritma TEMPTABLE
CREATE ALGORITHM = TEMPTABLE VIEW tempView (city,number_of_empoyee) AS
SELECT city ,count(id) FROM employee GROUP BY city ;

-- Update view2 yang memiliki city ‘Toronto’ diupdate menjadi ‘Canberra’. Update data
-- pada view2 juga terjadi pada table yang direferensi, yaitu table employee. Data
-- sebelum diupdate sebagai berikut :
SELECT * FROM view2;
UPDATE view2 SET place = "Canberra" WHERE place = "Toronto";
SELECT * FROM view2;
SELECT * FROM employee WHERE city = "Canberra";

-- Penggunaan insert untuk mengupdate view
INSERT INTO view2 VALUES ('Miss Marple', 'London');
UPDATE view2 SET name="John Doe" WHERE name = "James Bond";


-- Penggunaan CHECK OPTION :
CREATE VIEW v1 AS
SELECT first_name,salary,city FROM employee WHERE 
salary < 3000
WITH CHECK OPTION;

CREATE VIEW v2 AS 
SELECT * FROM V1 WHERE salary > 0 WITH LOCAL CHECK OPTION ;

CREATE VIEW v3 AS
SELECT * FROM v1 WHERE salary > 0 WITH CASCADED CHECK OPTION ;

INSERT INTO v2 VALUES ("Doe", 3500 , "Indonesia");

INSERT INTO v3 VALues ("Hancock",3500,"Jakarta");

-- Pada contoh di atsa kita membuat view v1 yang berisi data dari employee yang memiliki
-- salary < 3000. Kemudian kita mendefinisikan view v2 dengan tambahan batasan salary > 0
-- dan LOCAL CHECK OPTION. Selain itu, kita juga mendefinisikan v3 dengan tambahan batasan
-- salary > 0 namun dengan CASCADED CHECK OPTION.

-- merubah view dengan alter view
ALTER VIEW view1 (name,city) AS SELECT CONCAT (first_name," ",last_name),city FROM employee;
SELECT * FROM view1;

-- melihat sintaks untuk pembiatan view 
SHOW CREATE VIEW voew1\G

DESC view1;