delimiter //

CREATE TRIGGER before_insert BEFORE INSERT ON 
employee
FOR EACH ROW 
BEGIN 
IF NEW.salary IS NULL OR NEW.salary = 0 THEN 
SET NEW.salary = NEW.salary + 100;
END IF;
END//


INSERT INTO employee(id, first_name, last_name, start_date, end_date, salary, city, description) 
VALUES (11, 'John', 'Lenon', '1996-07-25', '2006-07-25', 0, 'Canberra', 'Programmer');


select * from employee where first_name = 'John';



CREATE TABLE beli(
  id_beli INT(11) NOT NULL AUTO_INCREMENT,
  kd_barang VARCHAR(5) DEFAULT NULL,
  nama_barang VARCHAR(20) DEFAULT NULL,
  jumlah INT(11) DEFAULT NULL,
  PRIMARY KEY (id_beli)
) ENGINE = MYISAM DEFAULT CHARSET=utf8;

CREATE TABLE jual(
  id_jual INT(11) NOT NULL AUTO_INCREMENT,
  kd_pelanggan VARCHAR(10) NOT NULL,
  kd_barang VARCHAR(20) NOT NULL,
  jumlah INT(11) DEFAULT NULL,
  PRIMARY KEY (id_jual)
) ENGINE = MYISAM DEFAULT CHARSET=utf8;

CREATE TABLE stok (
  kd_barang VARCHAR(5) NOT NULL,
  jumlah INT(11) NOT NULL,
  PRIMARY KEY (kd_barang)
) ENGINE = MYISAM DEFAULT CHARSET=utf8;


DELIMITER &
CREATE TRIGGER beli_barang AFTER INSERT ON beli 
FOR EACH ROW BEGIN 
INSERT INTO stok SET 
kd_barang = NEW.kd_barang ,jumlah= New.jumlah 
ON DUPLICATE KEY UPDATE jumlah = jumlah + New.jumlah;
END &

INSERT INTO beli Values (1,'K001','PENSIL',30);
INSERT INTO beli Values (2,'K001','PENSIL',23);

select * from stok;
select * from beli;



-- ///////////////////////////// TASK //////////////////////////////////////
1. Dengan menggunakan database perpustakaan dan table yang terdapat dalam
database tersebut, buatlah trigger untuk mengurangi stok buku saat dilakukan
peminjaman berdasarkan judul buku yang dipinjam.
2. Buatlah trigger untuk menambahkan jumlah buku, saat terjadi pengembalian buku.
3. Buatlah trigger untuk menjumlahkan harga sewa saat terjadi peminjaman buku.
-- ///////////////////////////// TASK //////////////////////////////////////


-- ///////////////////////////// TASK 1 //////////////////////////////////////
-- ///////////////////////////////////////////////////////////////////////////
DELIMITER //
CREATE TRIGGER kurangi_stok_setelah_dipinjam AFTER INSERT ON detail_peminjaman
FOR EACH ROW  
BEGIN
    IF UPPER(NEW.status_peminjaman) = 'PINJAM' THEN
UPDATE detail_buku 
SET jumlah_buku = jumlah_buku-1
WHERE id_buku = NEW.id_buku;
    END IF;

END;//

DELIMITER ;
select * from detail_buku where id_buku='B2.001';
INSERT INTO detail_peminjaman
values ('T.202', 'B2.001','pinjam');
select * from detail_buku where id_buku='B2.001';
-- ///////////////////////////////////////////////////////////////////////////////////
-- ///////////////////////////// TASK 1 COMPLETE //////////////////////////////////////





-- ///////////////////////////// TASK 2 //////////////////////////////////////
-- ///////////////////////////////////////////////////////////////////////////
-- 
-- 2. Buatlah trigger untuk menambahkan jumlah buku, saat terjadi pengembalian buku.
-- 

DELIMITER //

CREATE TRIGGER tambah_stok_setelah_dipinjam
AFTER INSERT ON detail_peminjaman
FOR EACH ROW
BEGIN
    -- Jika status peminjaman adalah "kembali"
    IF NEW.status_peminjaman = 'kembali' THEN
        -- Update jumlah buku dalam tabel detail_buku
        UPDATE detail_buku 
        SET jumlah_buku = jumlah_buku + 1
        WHERE id_buku = NEW.id_buku;
    END IF;
END;
//

DELIMITER ;




select * from detail_buku where id_buku='B2.001';
INSERT INTO detail_peminjaman
values ('T.200', 'B2.001','kembali');
select * from detail_buku where id_buku='B2.001';
-- ///////////////////////////////////////////////////////////////////////////////////
-- ///////////////////////////// TASK 2 COMPLETE //////////////////////////////////////







-- ///////////////////////////// TASK 3 //////////////////////////////////////
-- ///////////////////////////////////////////////////////////////////////////
-- 
-- 2. Buatlah trigger untuk menambahkan jumlah buku, saat terjadi pengembalian buku.
-- 

-- menampilkan nama dan harga sewa buku
select b.judul_buku ,db.harga_sewa
from buku b 
JOIN detail_buku db
ON db.id_buku = b.id_buku;

-- menampilkan anggota,peminjaman,dan detailpeminjaman
select a.nama_anggota,*.p ,dp.status_peminjaman 
from peminjaman p
JOIN p.id_anggota = a.id_anggota  

DELIMITER //
CREATE TRIGGER total_harga_sewa
AFTER INSERT ON detail_peminjaman
FOR EACH ROW
BEGIN
DECLARE harga_sewa_buku INT;
SELECT harga_sewa INTO harga_sewa_buku
FROM detail_buku
WHERE id_buku = NEW.id_buku;
UPDATE peminjaman
SET total_harga_sewa = total_harga_sewa + harga_sewa_buku
WHERE id_peminjaman = NEW.id_peminjaman;
END//
DELIMITER ;

 INSERT INTO detail_peminjaman (id_peminjaman,
id_buku, status_peminjaman)
VALUES ('T.104', 'B2.005', 'pinjam')

-- ///////////////////////////////////////////////////////////////////////////////////
-- ///////////////////////////// TASK 2 COMPLETE //////////////////////////////////////




drop trigger kurangi_stok_setelah_dipinjam;
drop trigger tambah_stok_setelah_dipinjam;

UPDATE buku SET id_buku = 'B2.001' WHERE id_buku = 'B.2.001';
UPDATE buku SET id_buku = 'B2.002' WHERE id_buku = 'B.2.002';
UPDATE buku SET id_buku = 'B2.003' WHERE id_buku = 'B.2.003';
UPDATE buku SET id_buku = 'B2.004' WHERE id_buku = 'B.2.004';
UPDATE buku SET id_buku = 'B2.005' WHERE id_buku = 'B.2.005';
UPDATE buku SET id_buku = 'B2.006' WHERE id_buku = 'B.2.006';

-- 1t 

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

--  2
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
    UPDATE employee SET 
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



-- 3

DELIMITER $$

CREATE PROCEDURE countEmployees(OUT employee_count INT)
BEGIN
    SELECT COUNT(*) INTO employee_count FROM employee WHERE city = 'Vancouver';
END$$

DELIMITER ;
