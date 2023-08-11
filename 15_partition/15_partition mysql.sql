-- https://viblo.asia/p/gioi-thieu-ve-partitioning-trong-mysql-jvEla6kz5kw  
-- https://www.tranvanbinh.vn/2020/12/ky-thuat-partitioning-trong-mysql.html
-- https://arctype.com/blog/mysql-partition-table/#vertical-partitioning

-- https://hevodata.com/learn/mysql-partition/
-- https://hevodata.com/learn/mysql-partition/
-- https://www.w3resource.com/mysql/mysql-partition.php
-- https://www.percona.com/blog/what-is-mysql-partitioning/

-- 1. Check xem db có support partion
SHOW PLUGINS; 
-- 1.1. Show all partition
SELECT PARTITION_NAME, TABLE_ROWS FROM INFORMATION_SCHEMA.PARTITIONS WHERE TABLE_NAME='sales'; 
-- 1.2. Example
 SELECT * FROM range_crypto PARTITION (p3) WHERE close BETWEEN 35000 and 38000;

-- or
 SELECT
   PLUGIN_NAME as Name,
   PLUGIN_VERSION as Version,
   PLUGIN_STATUS as Status
 FROM INFORMATION_SCHEMA.PLUGINS
 WHERE PLUGIN_TYPE='STORAGE ENGINE';

-- 2. Gồn 6 loại: 
    - Range partitioning
    - List partitioning
    - Hash partitioning
    - Key partitioning
    - Columns partitioning
    - Subpartitioning

-- =================  RANGE
CREATE TABLE userslogs (
    username VARCHAR(20) NOT NULL,
    logdata BLOB NOT NULL,
    created DATETIME NOT NULL,
    PRIMARY KEY(username, created)
)
PARTITION BY RANGE( YEAR(created) )(
    PARTITION from_2013_or_less VALUES LESS THAN (2014),
    PARTITION from_2014 VALUES LESS THAN (2015),
    PARTITION from_2015 VALUES LESS THAN (2016),
    PARTITION from_2016_and_up VALUES LESS THAN MAXVALUE

-- ================== LIST
CREATE TABLE serverlogs (
    serverid INT NOT NULL, 
    logdata BLOB NOT NULL,
    created DATETIME NOT NULL
)
PARTITION BY LIST (serverid)(
    PARTITION server_east VALUES IN(1,43,65,12,56,73),
    PARTITION server_west VALUES IN(534,6422,196,956,22)
);

-- ================== HASH
CREATE TABLE serverlogs2 (
    serverid INT NOT NULL, 
    logdata BLOB NOT NULL,
    created DATETIME NOT NULL
)
PARTITION BY HASH(serverid)
PARTITIONS 10;
-- HASH: là column được chỉ định để phân chia table
-- 10: là số lượng partition mà bạn muốn chia
--> Công thức tính : MOD(expression, number of partitions) 
--> VD: MOD(1,10) -> vào partition 1 ( chia lấy phần dư)

-- ================== KEY Partitioning.
Đây là loại rất giống với HASH nhưng nó khác ở chỗ, 
giá trị để xác định partion nằm trên 1 hoặc nhiều column khác nhau, 
giá trị không nhất thiết phải là Integer.
Ví dụ sau sẽ tạo 1 Key partition với việc không chỉ định rõ key,
khi đó MySQL sẽ tự động lấy PrimariKey hoặc Unikey để sử dụng: