
https://dev.mysql.com/doc/refman/8.0/en/window-functions-usage.html

---------------------- Khác nhau giữa Window functions và GROUP BY ---------------------

+ Window functions Tính trung bình  Avg (salary) của tất cả các dòng
+ GROUP BY tính của 1 dòng

VD: SELECT emp_no,
      department,
      salary,
      Avg (salary)
         OVER (
           partition BY department) AS dept_avg
      FROM   emps;

------------------------ OVER() - TÍNH Aggregate functions trên mỗi dòng  --------------------------------------------

+ Gắn Aggregate functions (VD: AVG, COUNT,.. ) lên mỗi dòng 

------------------------- OVER(PARTITION BY department) - Lấy trung bình cho mỗi dòng và group by theo department -------------------------------------------------

-- Lấy trung bình cho mỗi dòng và group by theo department
AVG(salary) OVER(PARTITION BY department) AS dept_avg, 

-- Lấy trung bình cho mỗi dòng
AVG(salary) OVER() AS company_avg  

------------------------- OVER(PARTITION BY department ORDER BY salary DESC) - Order By -------------------------------------------------

MIN(salary) OVER(PARTITION BY department ORDER BY salary DESC)