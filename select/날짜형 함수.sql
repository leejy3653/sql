-- curdate(), current_date : 
select curdate(), current_date;

-- curtime(), current_time : hh, mm, ss
select curtime(), current_time;

-- now(), sysdate(), current_timestamp() : yyy, MM, dd, hh, mm, ss
select now(), sysdate(), current_timestamp();

-- now() vs sysdate()
-- now() : 쿼리 실행하기 전에
-- sysdete() : 쿼리가 실행되며서
-- 즉, now는 쿼리가 들어갈때의 시간 sysdate는 쿼리가 출력될때의 시간
select now(), sleep(2), now(); -- sleep(2) : 2초간 지연
select now(), sleep(2), sysdate(); -- 쿼리가 실행될때의 시간, 그리고 2초후 쿼리가 출력될때의 시간

-- date_format (월에 c는 1자리 m은 2자리) 
-- https://www.w3schools.com/sql/func_mysql_date_format.asp 참고
select date_format(now(), '%Y년 %m월 %d일 %h시 %i분 %s초');
select date_format(now(), '%y-%c-%e %h:%i:%s:%f');

-- period_diff(p1, p2)
-- : YYMM, YYYYMM으로 표기되는 p1과 p2의 차이의 개월을 반환한다.
-- ex) 직원들의 근무개월수 구하기
select concat(first_name, ' ', last_name) as name,
period_diff(date_format(curdate(), '%y%m'),
date_format(hire_date, '%y%m'))as 근무개월수
from employees;

-- date_add, adddate
-- date sub, subdate
-- (date, INTERVAL expr type)
-- : 날짜 date에 type 형식으로 지정한 expr값을 더하거나 뺀다.
-- ex) 각 직원들의 6개월 후 근무 평가일
select concat(first_name, ' ', last_name) as name,
hire_date,
date_add(hire_date, interval 6 month) as 근무평가일
from employees;

-- cast
select now(), cast(now() as date), cast(now() as datetime);

select 1-2, cast(1-2 as unsigned);

select cast(cast(1-2 as unsigned)as signed);

