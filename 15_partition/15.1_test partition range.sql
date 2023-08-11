
-- -------------------------------------------------------------------
-- Tạo bảng ko có partition
-- CREATE TABLE `members` (
--   `firstname` varchar(25) NOT NULL,
--   `lastname` varchar(25) NOT NULL,
--   `username` varchar(16) NOT NULL,
--   `email` varchar(35) DEFAULT NULL,
--   `joined` date NOT NULL
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
-- ALTER TABLE members_with_partition
-- PARTITION BY RANGE(YEAR(joined)) (
--     PARTITION p1990 VALUES LESS THAN (1991),
--     .....
--     PARTITION p2029 VALUES LESS THAN (2030),
--     PARTITION p2030 VALUES LESS THAN (MAXVALUE)
-- );

-- TC1: Test equad 
--    Query :  SELECT * from members where  joined = "2020-02-27";
--    Index :  joined
--    Data  :  9.999.999row
-- Không có index, partition :  -> Query Time: 9
-- Có index, không partition :  -> Query Time: 0.5
-- Không index, có partition :  -> Query Time: 0.48
-- Có index, có partition    :  -> Query Time: 0.1
--    => Index cột "joined" và partition cột "joined" có hiệu quả

-- TC2: Test sử dụng FUNCTION vào column 
--     Query :  SELECT * from members where  YEAR(joined) = "2020";
--     Index :  joined
--     Data  :  9.999.999row
-- Không có index, partition :  -> Query Time: 8.5
-- Có index, không partition :  -> Query Time: 9
-- Không index, có partition :  -> Query Time: 10.5
-- Có index, có partition    :  -> Query Time: 10.5
--     => Index cột "joined" và partition cột "joined" nhưng dùng func thì ko có hiệu quả

-- TC3: Test query cột khác 
--     Query :  SELECT * from members where  email = "rishi@outlook.com";
--     Index :  joined
--     Data  :  9.999.999row
-- Không có index, partition :  -> Query Time:  8
-- Có index, không partition :  -> Query Time:  9.6
-- Không index, có partition :  -> Query Time:  10
-- Có index, có partition    :  -> Query Time:  10
--     =>   Index cột "joined" và partition cột "joined" nhưng nhưng where cột khác thì không hiệu quả 





-- --------------------------------------------------------------------------------------------------
-- Tạo bảng có partition 
-- CREATE TABLE `members_with_partition` (
--   `firstname` varchar(25) NOT NULL,
--   `lastname` varchar(25) NOT NULL,
--   `username` varchar(16) NOT NULL,
--   `email` varchar(35) DEFAULT NULL,
--   `joined` date NOT NULL
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
-- 
-- ALTER TABLE members_with_partition
-- PARTITION BY RANGE(YEAR(joined)) (
--     PARTITION p1990 VALUES LESS THAN (1991),
--     PARTITION p1991 VALUES LESS THAN (1992),
--     PARTITION p1992 VALUES LESS THAN (1993),
--     PARTITION p1993 VALUES LESS THAN (1994),
--     PARTITION p1994 VALUES LESS THAN (1995),
--     PARTITION p1995 VALUES LESS THAN (1996),
--     PARTITION p1996 VALUES LESS THAN (1997),
--     PARTITION p1997 VALUES LESS THAN (1998),
--     PARTITION p1998 VALUES LESS THAN (1999),
--     PARTITION p1999 VALUES LESS THAN (2000),
--     PARTITION p2000 VALUES LESS THAN (2001),
--     PARTITION p2001 VALUES LESS THAN (2002),
--     PARTITION p2002 VALUES LESS THAN (2003),
--     PARTITION p2003 VALUES LESS THAN (2004),
--     PARTITION p2004 VALUES LESS THAN (2005),
--     PARTITION p2005 VALUES LESS THAN (2006),
--     PARTITION p2006 VALUES LESS THAN (2007),
--     PARTITION p2007 VALUES LESS THAN (2008),
--     PARTITION p2008 VALUES LESS THAN (2009),
--     PARTITION p2009 VALUES LESS THAN (2010),
--     PARTITION p2010 VALUES LESS THAN (2011),
--     PARTITION p2011 VALUES LESS THAN (2012),
--     PARTITION p2012 VALUES LESS THAN (2013),
--     PARTITION p2013 VALUES LESS THAN (2014),
--     PARTITION p2014 VALUES LESS THAN (2015),
--     PARTITION p2015 VALUES LESS THAN (2016),
--     PARTITION p2016 VALUES LESS THAN (2017),
--     PARTITION p2017 VALUES LESS THAN (2018),
--     PARTITION p2018 VALUES LESS THAN (2019),
--     PARTITION p2019 VALUES LESS THAN (2020),
--     PARTITION p2020 VALUES LESS THAN (2021),
--     PARTITION p2021 VALUES LESS THAN (2022),
--     PARTITION p2022 VALUES LESS THAN (2023),
--     PARTITION p2023 VALUES LESS THAN (2024),
--     PARTITION p2024 VALUES LESS THAN (2025),
--     PARTITION p2025 VALUES LESS THAN (2026),
--     PARTITION p2026 VALUES LESS THAN (2027),
--     PARTITION p2027 VALUES LESS THAN (2028),
--     PARTITION p2028 VALUES LESS THAN (2029),
--     PARTITION p2029 VALUES LESS THAN (2030),
--     PARTITION p2030 VALUES LESS THAN (MAXVALUE)
-- );
-- 









