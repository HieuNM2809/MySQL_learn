- Unsigned: đi vs kiểu int, không âm, tăng giới hạn lưu trữ (mang giá trị âm lên giá trị dương)
- Decimal : 
    + Lưu số phập phân ( precision (tổng số chữ số) và scale (số chữ số sau dấu thập phân))
    + Float  : 4 bytes, scale 7 số
    + Double : 8 bytes, scale 14 số
- Thời gian: 
    SELECT CURDATE();
    SELECT CURTIME();
    SELECT NOW();                -> local time
    SELECT CURRENT_TIMESTAMP();  -> local time or UTC (Coordinated Universal Time) 
    VD: INSERT INTO people (name, birthdate, birthtime, birthdt) VALUES ('Hazel', CURDATE(), CURTIME(), NOW())
    
    + Link key format : https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html
    + Link key DATE TIME FUNCTION : https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html



----------------------------------------- Data type --------------------------------------------------------------------------

+ ZEROFILL: Thêm số 0 ở trước cho bằng chiều dài kiểu SỐ. 
 -> VD: int(6)    - 000123

+ UNSIGNED: Set kiểu dữ liệu SỐ không âm, tăng phạm vi vùng phía dương.