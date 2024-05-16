CREATE TABLE employee(
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR (15),
    last_name VARCHAR(15),
    start_date DATE,
    enda_date DATE,
    salary FLOAT (8,2),
    city VARCHAR (10),
    description VARCHAR (15)
)

SELECT id_kendaraan,no_kendaraan,merk
FROM kendaraan where harga_sewa = (SELECT MAX(harga_sewa) from kendaraan);

SELECT k.id_kendaraan,j.jenis_kendaraan
FROM kendaraan k 
JOIN jns_kendaraan j ON j.id_kendaraan = k.id_kendaraan
WHERE j.jenis_bbm NOT IN (SELECT jenis_bbm from jns_kendaraan where jenis_bbm='Solar');

SELECT * from kendaraan where status_kendaraan IN (select status_kendaraan from kendaraan where status_kendaraan='Baik');

SELECT * from kendaraan 
where harga_sewa > ANY (SELECT harga_sewa from kendaraan where harga_sewa<4000);

-- 
SELECT s.id_sewa,k.no_kendaraan,k.merk
FROM sewa s
JOIN detail_sewa ds ON ds.id_sewa=s.id_sewa
JOIN kendaraan k ON ds.id_kendaraan = k.id_kendaraan
WHERE ds.biaya_sewa = (SELECT MAX(biaya_sewa) from detail_sewa);

SELECT * FROM kendaraan where harga_sewa < any  (SELECT harga_sewa from kendaraan where harga_sewa < 2500);

SELECT k.id_kendaraan , j.jenis_kendaraan ,k.merk,k.harga_sewa
FROM kendaraan k 
JOIN jns_kendaraan ON j.id_kendaraan = k .id_kendaraan
where j.jenis_bbm IN (SELECT jenis_bbm from jns_kendaraan where jenis_bbm='')

SELECT 