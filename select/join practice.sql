-- ANSI JOIN 1999

-- 1. join ~ on (ANSI SQL 1999)
select a.emp_no, a.first_name as 직원명, c.dept_name as 부서명
from employees a
join dept_emp b
on a.emp_no =b.emp_no
join departments c
on b.dept_no =c.dept_no;

-- 2. equijoin
select a.emp_no, a.first_name as 직원명, c.dept_name as 부서명
from employees a, dept_emp b, departments c
where a.emp_no =b.emp_no
and b.dept_no =c.dept_no;

-- 3. join ~ on  vs Natural join
-- join ~ on 
select a.first_name, b.title
from employees a
join titles b
on a.emp_no = b.emp_no;

-- Natural join
select a.first_name, b.title
from employees a
natural join titles b;

-- Natural join의 문제점
select count(*)
from salaries a
natural join titles b;

-- join ~ using 사용 ->Natural join의 문제점을 해결 할 때
select count(*)
from salaries a
join titles b using(emp_no);