https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html#sqlmode_error_for_division_by_zero

-- To View Modes:
SELECT @@GLOBAL.sql_mode;
SELECT @@SESSION.sql_mode;
 
-- To Set Them:
SET GLOBAL sql_mode = 'modes';
SET SESSION sql_mode = 'modes';


VD: SET SESSION sql_mode = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION,ONLY_FULL_GROUP_BY';
- ONLY_FULL_GROUP_BY: Nếu bật, mấy trường ko group by thì không select được