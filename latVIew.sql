-- tabel anggota
CREATE TABLE anggota (
    id_anggota VARCHAR(7) NOT NULL,
    nama_anggota VARCHAR(25) NOT NULL,
    alamat_anggota VARCHAR(50) NOT NULL,
    kota_anggota VARCHAR(15) NOT NULL,
    telp_anggota VARCHAR(15),
    PRIMARY KEY (id_anggota)
);
INSERT INTO anggota (id_anggota, nama_anggota, alamat_anggota, kota_anggota, telp_anggota) 
VALUES 
('A.1.001', 'Aminah', 'Jl. S.Parman No.15', 'Cilacap', '543210'),
('A.1.002', 'Asmuni', 'Jl. A. Yani No.25', 'Cilacap', '567890'),
('A.1.003', 'Bagyo', 'J1. Cerme No.18', 'Kebumen', '565755'),
('A.1.004', 'Darusman', 'Jl. Kutilang No.19', 'Purwokerto', '435678'),
('A.1.005', 'Mukijo', 'Jl. Veteran No.27', 'Purwokerto', '765747');



CREATE TABLE buku (
    id_buku VARCHAR(7) NOT NULL,
    judul_buku VARCHAR(30) NOT NULL,
    penerbit_buku VARCHAR(15) NOT NULL,
    tahun_terbit YEAR(4),
    id_penulis VARCHAR(5) NOT NULL,
    PRIMARY KEY (id_buku)
);
INSERT INTO buku (id_buku, judul_buku, penerbit_buku, tahun_terbit, id_penulis) 
VALUES 
('B.2.001', 'Algoritma dan Pemrograman', 'CV. Satu Lagi', 2014, 'P.002'),
('B.2.002', 'Fisika Dasar', 'Penerbit Dua', 2014, 'P.001'),
('B.2.003', 'Interaksi Manusia & Komputer', 'CV. Satu Lagi', 2013, 'P.003'),
('B.2.004', 'Jaringan Komputer', 'CV. Satu Lagi', 2015, 'P.003'),
('B.2.005', 'Jaringan Komputer', 'Penerbit Dua', 2015, 'P.004'),
('B.2.006', 'Kecerdasan Buatan', 'Penerbit Tiga', 2015, 'P.002');




CREATE TABLE detail_buku (
    id_buku VARCHAR(7) NOT NULL,
    kategori_buku VARCHAR(25) NOT NULL,
    jumlah_buku INT NOT NULL,
    harga_sewa INT NOT NULL
);
INSERT INTO detail_buku (id_buku, kategori_buku, jumlah_buku, harga_sewa) 
VALUES 
('B.2.001', 'Pemrograman', 5, 1500),
('B.2.002', 'Teknik', 4, 2000),
('B.2.003', 'Multimedia', 5, 1500),
('B.2.004', 'Jaringan & Internet', 7, 2500),
('B.2.005', 'Jaringan & Internet', 5, 2000),
('B.2.006', 'Pemrograman Lanjut', 5, 1500);




CREATE TABLE penulis (
    id_penulis VARCHAR(5) NOT NULL,
    nama_penulis VARCHAR(15) NOT NULL,
    alamat_penulis VARCHAR(50) NOT NULL,
    kota_penulis VARCHAR(15),
    email VARCHAR(50),
    PRIMARY KEY (id_penulis)
);
INSERT INTO penulis (id_penulis, nama_penulis, alamat_penulis, kota_penulis, email) 
VALUES 
('P.001', 'Darmini', 'J1. Anggrek no.21 Sidareja', 'Cilacap', 'darmini@mini_com.com'),
('P.002', 'Tukimin', 'Jl. Petanahan no.5', 'Kebumen', '2qmin@tuotuo.com'),
('P.003', 'Pariyem', 'Jl. Veteran no.20', 'Jakarta', 'pair_yem@dewadewi.com'),
('P.004', 'Waginah', 'Jl. Laut no.13 Sidakaya', 'Cilacap', 'wag_inah@mini_com.com');




CREATE TABLE peminjaman (
    id_peminjaman VARCHAR(6) NOT NULL,
    tanggal_peminjaman DATE NOT NULL,
    id_anggota VARCHAR(7) NOT NULL,

    PRIMARY KEY (id_peminjaman)
);
INSERT INTO peminjaman (id_peminjaman, tanggal_peminjaman, id_anggota) 
VALUES 
('T.101', '2016-02-03', 'A.1.002'),
('T.102', '2016-02-03', 'A.1.004'),
('T.103', '2016-02-05', 'A.1.003'),
('T.104', '2016-02-06', 'A.1.005');




CREATE TABLE Detail_Peminjaman (
    id_peminjaman VARCHAR(6) NOT NULL,
    id_buku VARCHAR(7) NOT NULL,
    status_peminjaman VARCHAR(10)
);

INSERT INTO Detail_Peminjaman (id_peminjaman, id_buku, status_peminjaman) 
VALUES 
('T.101', 'B.2.001', 'kembali'),
('T.101', 'B.2.006', 'pinjam'),
('T.102', 'B.2.002', 'pinjam'),
('T.102', 'B.2.003', 'pinjam'),
('T.103', 'B.2.004', 'pinjam'),
('T.104', 'B.2.005', 'pinjam');

-- 2
CREATE VIEW v_buku AS
SELECT buku.id_buku, buku.judul_buku, buku.penerbit_buku, penulis.nama_penulis, penulis.email
FROM buku
JOIN penulis ON buku.id_penulis = penulis.id_penulis;

-- 3
CREATE VIEW v_pinjam AS
SELECT anggota.nama_anggota, peminjaman.tanggal_peminjaman, buku.judul_buku
FROM peminjaman
JOIN anggota ON peminjaman.id_anggota = anggota.id_anggota
JOIN Detail_Peminjaman ON peminjaman.id_peminjaman = Detail_Peminjaman.id_peminjaman
JOIN buku ON Detail_Peminjaman.id_buku = buku.id_buku;

-- 4
CREATE VIEW v_detail (nama_penulis,jumlah_buku) AS
SELECT p.nama_penulis,COUNT(b.id_penulis)
FROM penulis p 
JOIN buku b ON p.id_penulis = b.id_penulis
GROUP  BY b.id_penulis;

-- 5 
-- tanggal_peminjaman(peminjaman)
-- db.biaya_sewa(detail_buku)
-- peminjaman(id_peminjaman)=>detail_peminjaman()=>
CREATE VIEW pendapatan AS
SELECT p.tanggal_peminjaman,sum(db.harga_sewa)
FROM peminjaman p 
JOIN detail_peminjaman dp ON dp.id_peminjaman=p.id_peminjaman
JOIN buku b ON b.id_buku=dp.id_buku
JOIN detail_buku db ON db.id_buku = b.id_buku
GROUP BY p.tanggal_peminjaman;

-- 6
SELECT tahun_terbit,COUNT(tahun_terbit) as jumlah_buku
from buku 
group by tahun_terbit;


-- 7
CREATE VIEW data_peminjaman AS
SELECT p.id_peminjaman as id_pinjam,p.tanggal_peminjaman,a.nama_anggota as peminjam,CONCAT(a.alamat_anggota," ",a.kota_anggota) as alamat,a.telp_anggota
FROM peminjaman p 
JOIN anggota a ON a.id_anggota=p.id_anggota;


-- 8
CREATE VIEW kota_anggota AS
SELECT kota_anggota,COUNT(kota_anggota)
FROM anggota
GROUP BY kota_anggota;


-- nama_peminjam(anggota=id_anggota)
-- tanggal_peminjam(tanggal_peminjaman)
-- judul_buku -> 
-- relasi peminjaman(id_peminjaman) -> detail_peminjaman(id_buku) -> buku.judul_buku



SELECT a.nama_anggota as nama_peminjaman,p.tanggal_peminjaman,b.judul_buku,b.tahun_terbit
FROM peminjaman p
JOIN anggota a ON a.id_anggota = p.id_anggota
JOIN detail_peminjaman dt ON dt.id_peminjaman= p.id_peminjaman 
JOIN buku b ON b.id_buku = dt.id_buku
order BY b.tahun_terbit DESC;


-- nama penulis
SELECT p.nama_penulis,COUNT(b.id_penulis)
from penulis p 
JOIN buku b ON p.id_penulis=b.id_penulis
group by b.id_penulis;


SELECT COUNT(id_penulis) from buku
group by id_penulis;

-- tanggal_peminjaman(peminjaman)
-- harga_sewa ada di detail_buku
-- relasi peminjaman(id_peminjaman),detail_peminjaman(id_buku),buku(id_buku),detail_buku(id_buku) 
-- db.harga_sewa

SELECT p.tanggal_peminjaman,sum(db.harga_sewa)
FROM peminjaman p
JOIN detail_peminjaman dp ON dp.id_peminjaman = p.id_peminjaman
JOIN buku b ON b.id_buku = dp.id_buku 
JOIN detail_buku db ON db.id_buku = b.id_buku
Group by p.tanggal_peminjaman;