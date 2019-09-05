-- 단일행 연산

-- ex) 현재 Fai Bale이 근무하는 부서에서 근무하는 직원의 사번, 전체 이름을 출력해보세요.

-- sol 1-1)
select a.dept_no
  from dept_emp a, employees b
 where a.emp_no = b.emp_no
   and to_date = '9999-01-01'
   and concat(b.first_name , ' ', b.last_name) = 'Fai Bale';

-- sol 1-2)
select a.dept_no, concat(b.first_name , ' ', b.last_name) as '전체이름'
  from dept_emp a, employees b
 where a.emp_no = b.emp_no
   and to_date = '9999-01-01'
   and a.dept_no = 'd004';-- 첫번째 에서 나온 값 입력
   
-- sol subquery를 사용)
select b.emp_no, concat(b.first_name , ' ', b.last_name) as '전체이름'
  from dept_emp a, employees b
 where a.emp_no = b.emp_no
   and to_date = '9999-01-01'
   and a.dept_no = (select a.dept_no
					  from dept_emp a, employees b
					 where a.emp_no = b.emp_no
                       and to_date = '9999-01-01'
					   and concat(b.first_name , ' ', b.last_name) = 'Fai Bale');
-- 서브쿼리는 괄호로 묶여야 함
-- 서브쿼리 내에 order by 금지
-- group by 절 외에 거의 모든 절에서 사용가능 (특히, from절과 where절에서 많이 사용)
-- where 절인 경우,
-- 	1) 단일행 연산자: =, >, <, >=, <=, <>

-- 실습문제 1) 현재 전체사원의 평균 연봉보다 적은 급여를 받는 사원의  이름, 급여를 나타내세요.
select concat(a.first_name, ' ', a.last_name) as 이름, b.salary as 급여
from employees a, salaries b
where a.emp_no = b.emp_no
and to_date = '9999-01-01'
and b.salary<(select avg(salary)
				from salaries
			   where to_date = '9999-01-01');


-- 실습문제 2) 현재 가장적은 평균 급여를 받고 있는 직책에해서  평균 급여를 구하세요   
  select b.title as 직책, avg(a.salary)as 평균급여
    from salaries a, titles b
   where a.emp_no = b.emp_no
     and a.to_date = '9999-01-01'
     and b.to_date = '9999-01-01'
group by b.title
order by avg(a.salary) asc 
   limit 1;

-- 57317.5736
-- 풀이1) TOP-K
 select b.title, avg(a.salary) as 평균급여
    from salaries a, titles b
   where a.emp_no = b.emp_no
     and a.to_date = '9999-01-01'
     and b.to_date = '9999-01-01'
group by b.title
having round (avg(a.salary))= (select round (avg(a.salary))as 평균급여
								 from salaries a, titles b
								where a.emp_no = b.emp_no
								  and a.to_date = '9999-01-01'
								  and b.to_date = '9999-01-01'
							 group by b.title
						     order by avg(a.salary) asc 
								limit 0, 1);
                                                                
-- 풀이2)                             
  select b.title, avg(a.salary) as 평균급여
    from salaries a, titles b
   where a.emp_no = b.emp_no
     and a.to_date = '9999-01-01'
     and b.to_date = '9999-01-01'
group by b.title
having round (avg(a.salary))= (select min(a.평균급여)
                                from (select round (avg(a.salary))as 평균급여
										from salaries a, titles b
									   where a.emp_no = b.emp_no
								         and a.to_date = '9999-01-01'
								         and b.to_date = '9999-01-01'
							 group by b.title) as a);
                             
-- 3. join으로 풀기
  select (avg(a.salary))as 평균급여
	from salaries a, titles b
   where a.emp_no = b.emp_no
     and a.to_date = '9999-01-01' 
	 and b.to_date = '9999-01-01'
group by b.title
order by avg(a.salary) asc
   limit 0,1;

-- where 절인 경우,
-- 2) 다중(복수)행 연산자: in, any, all, not in
-- 	2-1) any 사용법
-- 			1. =any : in과 완전 동일
-- 			2. >any, >=any : 최소값 반환
-- 			3. <any, <=any : 최대값 반환
-- 			4. <>any, !=any : !=all 와 동일
-- 	2-2) all 사용법
-- 			1. =all : 
-- 			2. >all, >=all : 최대값
-- 			3. <all, <=all : 최소값

-- 1) 현재 급여가 50000 이상인 직원 이름 출력
-- 방법1 join
select concat(b.first_name, ' ', b.last_name), a.salary
  from salaries a, employees b
 where a.emp_no = b.emp_no
   and a.to_date = '9999-01-01'
   and a.salary>='50000';

-- 방법2: in
select first_name
from employees
where emp_no in (select emp_no, salary
				   from salaries
							   where to_date ='9999-01-01'
                                 and salary>='50000');


-- 2) 각 부서별로 최고의 월급을 받는 직원의 이름과 월급 출력
-- dept_no, max_salary, first_name
-- 섭 부서별 max

-- 서브쿼리
  select c.dept_no, max(b.salary) as max_salary
    from employees a, salaries b, dept_emp c
   where a.emp_no = b.emp_no
     and a.emp_no = c.emp_no
     and b.to_date = '9999-01-01'
     and c.to_date = '9999-01-01'
group by c. dept_no;

-- 방법 1 : where절에 서브쿼리를 사용
  select concat(a.first_name,' ', a.last_name), c.dept_no, b.salary
    from employees a, salaries b, dept_emp c
   where a.emp_no = b.emp_no
     and a.emp_no = c.emp_no
     and b.to_date = '9999-01-01'
     and c.to_date = '9999-01-01'
     and (c.dept_no, b.salary) = any(select c.dept_no, max(b.salary) as max_salary
								       from employees a, salaries b, dept_emp c
									  where a.emp_no = b.emp_no
                                        and a.emp_no = c.emp_no
                                        and b.to_date = '9999-01-01'
										and c.to_date = '9999-01-01'
								   group by c. dept_no);
                                   
-- 방법2) from 절에서 subquery 사용
  select concat(a.first_name,' ', a.last_name), c.dept_no, b.salary
    from employees a,
         salaries b,
         dept_emp c,
		 (select c.dept_no, max(b.salary) as max_salary
			from employees a, salaries b, dept_emp c
		   where a.emp_no = b.emp_no
             and a.emp_no = c.emp_no
             and b.to_date = '9999-01-01'
			 and c.to_date = '9999-01-01'
	    group by c. dept_no) as d
   where a.emp_no = b.emp_no
     and a.emp_no = c.emp_no
     and c.dept_no = d.dept_no
     and b.salary = d.max_salary
     and b.to_date = '9999-01-01'
     and c.to_date = '9999-01-01';

-- join 으로 했으나 잘못된 방법.......
select concat(b.first_name,' ', b.last_name), max(a.salary), d.dept_name
from salaries a, employees b, dept_emp c, departments d
where a.emp_no = b.emp_no
and a.emp_no = c.emp_no
and c.dept_no = d.dept_no
group by c.dept_no
order by salary desc;

