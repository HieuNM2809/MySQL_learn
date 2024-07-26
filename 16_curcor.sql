-- ----------------------------------------------------  THÊM TABLE ------------------
CREATE TABLE don_hang (
    ma_dh INT PRIMARY KEY AUTO_INCREMENT,
    ngay_dat_hang DATE NOT NULL,
    tong_tien DECIMAL(15, 2) NOT NULL
);

CREATE TABLE chi_tiet_don_hang (
    ma_ctdh INT PRIMARY KEY AUTO_INCREMENT,
    ma_dh INT NOT NULL,
    ma_sp INT NOT NULL,
    so_luong INT NOT NULL,
    don_gia DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (ma_dh) REFERENCES don_hang(ma_dh)
);

-- ----------------------------------------------------  THÊM DATA ------------------
INSERT INTO don_hang (ngay_dat_hang, tong_tien)
VALUES
('2023-01-15', 500000),
('2023-02-20', 800000),
('2023-03-10', 350000),
('2023-04-05', 1200000),
('2023-05-30', 650000);

INSERT INTO chi_tiet_don_hang (ma_dh, ma_sp, so_luong, don_gia)
VALUES
(1, 101, 2, 150000),
(1, 102, 1, 200000),
(2, 103, 3, 100000),
(2, 101, 2, 150000),
(3, 102, 1, 200000),
(3, 104, 1, 150000),
(4, 105, 5, 80000),
(4, 106, 2, 150000),
(5, 103, 4, 100000),
(5, 107, 1, 250000);

-- ----------------------------------------------------  THÊM PROCEDURE ------------------
DROP PROCEDURE IF EXISTS TaoBaoCaoDoanhThu;
DELIMITER //
CREATE PROCEDURE TaoBaoCaoDoanhThu(IN nam INT)
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE thang INT;
    DECLARE doanh_thu DECIMAL(15, 2);
	DECLARE so_don_hang DECIMAL(15, 2);
    DECLARE tong_doanh_thu DECIMAL(15, 2) DEFAULT 0; -- Biến lưu trữ tổng doanh thu
		
    DECLARE cur CURSOR FOR 
        SELECT DISTINCT MONTH(ngay_dat_hang) AS thang
        FROM don_hang
        WHERE YEAR(ngay_dat_hang) = nam
        ORDER BY thang;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    CREATE TABLE IF NOT EXISTS bao_cao_doanh_thu_tam (
        nam INT,
        thang INT,
        doanh_thu DECIMAL(15, 2),
        so_don_hang INT
    );

    DELETE FROM bao_cao_doanh_thu_tam;
		
    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO thang;
        IF done THEN
            LEAVE read_loop;
        END IF;

        SELECT 
            SUM(ct.so_luong * ct.don_gia) AS doanh_thu,
            COUNT(DISTINCT dh.ma_dh) AS so_don_hang
        INTO doanh_thu, so_don_hang
        FROM don_hang dh
        JOIN chi_tiet_don_hang ct ON dh.ma_dh = ct.ma_dh
        WHERE YEAR(dh.ngay_dat_hang) = nam AND MONTH(dh.ngay_dat_hang) = thang;

        INSERT INTO bao_cao_doanh_thu_tam (nam, thang, doanh_thu, so_don_hang)
        VALUES (nam, thang, doanh_thu, so_don_hang);

        -- Cộng dồn doanh thu vào biến tổng
        SET tong_doanh_thu = tong_doanh_thu + doanh_thu;
    END LOOP;

    CLOSE cur;

    -- Sử dụng lại biến tổng doanh thu
    SELECT CONCAT('Tổng doanh thu năm ', nam, ': ', tong_doanh_thu) AS tong_doanh_thu_nam;
	SELECT * FROM `bao_cao_doanh_thu_tam`;

END //
DELIMITER ;


-- ---------------------------------------------------- CALL ------------------
CALL TaoBaoCaoDoanhThu(2023);
SELECT * FROM `bao_cao_doanh_thu_tam`;
