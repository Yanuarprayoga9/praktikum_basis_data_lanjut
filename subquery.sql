SELECT e.first_name , e.description
FROM employee e
WHERE e.description IN (SELECT title from job);

SELECT * from kendaraan where harga_sewa = (SELECT max(harga_sewa) from kendaraan);

SELECT id_kendaraan,jenis_kendaraan,jenis_bbm FROM jns_kendaraan where jenis_bbm NOT IN (SELECT jenis_bbm from jns_kendaraan where jenis_bbm='Solar'); 
SELECT * from kendaraan where status_kendaraan IN (Select status_kendaraan From kendaraan where status_kendaraan="Baik");