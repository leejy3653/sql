-- 문제 1. 
-- 현재 급여가 많은 직원부터 직원의 사번, 이름, 그리고 연봉을 출력 하시오.
select a.emp_no as 사번, concat(b.first_name, ' ', b.last_name)as 이름, a.salary as 연봉
from salaries a, employees b
where a.emp_no =b.emp_no
-- group by a.emp_no
order by a.salary desc;

-- 문제2.
-- 전체 사원의 사번, 이름, 현재 직책을 이름 순서로 출력하세요.
select a.emp_no as 사번, concat(a.first_name, ' ', a.last_name)as 이름, b.title as'현재직책'
from employees a, titles b
where a.emp_no = b.emp_no
-- group by a.emp_no
order by concat(a.first_name, ' ', a.last_name) asc;
-- 문제3.
-- 전체 사원의 사번, 이름, 현재 부서를 이름 순서로 출력하세요..
select a.emp_no as '사번',  concat(b.first_name, ' ', b.last_name)as 이름, c.dept_name as'현재 부서'
from dept_emp a, employees b, departments c
where a.dept_no = c.dept_no
and a.emp_no  = b.emp_no
-- group by a.emp_no
order by concat(b.first_name, ' ', b.last_name) asc;

-- 문제4.
-- 전체 사원의 사번, 이름, 연봉, 직책, 부서를 모두 이름 순서로 출력합니다.
select a.emp_no, concat(a.first_name, ' ', a.last_name)as '이름', b.salary, c.title, e.dept_name
from  employees a, salaries b, titles c, dept_emp d, departments e 
where a.emp_no = b.emp_no 
and b.emp_no = c.emp_no 
and c.emp_no = d.emp_no 
and e.dept_no = d.dept_no
and b.to_date = '9999-01-01'
and d.to_date=b.to_date
and c.to_date=b.to_date
order by '이름' asc;

-- 문제5.
-- ‘Technique Leader’의 직책으로 과거에 근무한 적이 있는 모든 사원의 사번과 이름을 출력하세요.
-- (현재 ‘Technique Leader’의 직책(으로 근무하는 사원은 고려하지 않습니다.)
-- 이름은 first_name과 last_name을 합쳐 출력합니다.
  select a.emp_no as '사번', concat(a.first_name, ' ', a.last_name) as '이름'
    from employees a, titles b
   where a.emp_no = b.emp_no
     and b.to_date != '9999-01-01'
     and b.title = 'Technique Leader';

-- 문제6.
-- 직원 이름(last_name) 중에서 S(대문자)로 시작하는 직원들의 이름, 부서명,직책을 조회하세요.
 select concat(a.first_name, ' ', a.last_name) as '이름', c.dept_name as '부서', d.title as '직책'
    from employees a, dept_emp b, departments c, titles d
   where a.emp_no = b.emp_no
     and a.emp_no = d.emp_no
     and b.dept_no = c.dept_no
     and b.to_date = '9999-01-01'
     and d.to_date = b.to_date
     and a.last_name like 'S%';

-- 문제7.
-- 현재, 직책이 Engineer인 사원 중에서 현재 급여가 40000 이상인 사원을 급여가 큰 순서대로 출력하세요.
select concat(a.first_name, ' ', a.last_name) as '이름', c.salary as '급여'
  from employees a, titles b, salaries c
 where a.emp_no = b.emp_no
   and a.emp_no = c.emp_no
   and b.title = 'Engineer'
   and c.to_date = '9999-01-01'
   and b.to_date = c.to_date
   and salary >= '40000'
order by c.salary desc;

-- 문제8.
-- 현재 급여가 50000이 넘는 직책을 직책, 급여로 급여가 큰 순서대로 출력하시오
select a.title as '직책', b.salary as '급여'
  from titles a, salaries b
 where a.emp_no = b.emp_no
   and b.salary >= '50000'
   and b.to_date = '9999-01-01'
group by a.title
order by b.salary desc;

-- 문제9.
-- 현재, 부서별 평균 연봉을 연봉이 큰 부서 순서대로 출력하세요.
select d.dept_name as '부서', avg(salary) as '평균 연봉'
  from salaries s, dept_emp de, departments d
 where s.emp_no = de.emp_no
   and de.dept_no = d.dept_no
   and de.to_date = '9999-01-01'
   and s.to_date = de.to_date
group by d.dept_name
order by avg(salary) desc;

-- 문제10.
-- 현재, 직책별 평균 연봉을 연봉이 큰 직책 순서대로 출력하세요.
select t.title as '직책', avg(s.salary) as '평균 연봉'
  from salaries s, titles t
 where s.emp_no = t.emp_no
   and t.to_date = '9999-01-01'
   and s.to_date = t.to_date
group by t.title
order by avg(s.salary) desc;