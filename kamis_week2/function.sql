

----------------------
-- mencari jml dari tabel beli dimana jumlah = param
-- p_jumlah int
-- return int 
--------------------
DELIMITER $$
CREATE FUNCTION tampil_jml_brg (p_jumlah INT) RETURNS INT DETERMINISTIC
BEGIN
    DECLARE jml INT;
    SELECT COUNT(*) INTO jml FROM beli WHERE jumlah = p_jumlah;
    RETURN jml;
END$$
DELIMITER ;



