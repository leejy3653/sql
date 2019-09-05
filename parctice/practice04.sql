-- 문제1.
-- 현재 평균 연봉보다 많은 월급을 받는 직원은 몇 명이나 있습니까?
select count(a.emp_no) as '현재 평균 연봉보다 많은 월급을 받는 직원수'
from employees a, salaries b
where a. emp_no = b. emp_no
and b.to_date='9999-01-01'
and b.salary>(select avg(salary)
                from salaries
			   where to_date='9999-01-01');

-- 문제2. 
-- 현재, 각 부서별로 최고의 급여를 받는 사원의 사번, 이름, 부서, 연봉을 조회하세요. 단 조회결과는 연봉의 내림차순으로 정렬되어 나타나야 합니다. 
  select a.emp_no as 사번, concat(a.first_name, ' ', a.last_name) as 이름, d.dept_name as 부서, b.salary as 연봉
    from employees a, salaries b, dept_emp c, departments d
   where a.emp_no = b.emp_no
     and a.emp_no = c.emp_no
     and c.dept_no = d.dept_no
     and b.to_date = '9999-01-01'
     and c.to_date = '9999-01-01'
     and (c.dept_no, b.salary) = any(select c.dept_no, max(b.salary) as max_salary
								       from employees a, salaries b, dept_emp c
									  where a.emp_no = b.emp_no
                                        and a.emp_no = c.emp_no
                                        and b.to_date = '9999-01-01'
										and c.to_date = '9999-01-01'
								   group by c. dept_no)
	order by b.salary desc;
    
-- 문제3.
-- 현재, 자신의 부서 평균 급여보다 연봉(salary)이 많은 사원의 사번, 이름과 연봉을 조회하세요 
select a.emp_no as 사번, concat (a.first_name,' ', a.last_name)as 이름, b.salary as 연봉
    from employees a, salaries b, dept_emp c, departments d
   where a.emp_no = b.emp_no
     and a.emp_no = c.emp_no
     and c.dept_no = d.dept_no
     and b.to_date = '9999-01-01'
     and c.to_date = '9999-01-01'
     and b.salary > any (select avg(b.salary)
						   from employees a, salaries b, dept_emp c
						  where a.emp_no =c.emp_no
                            and a.emp_no = b.emp_no
                            and c.to_date = '9999-01-01'
                            and b.to_date = '9999-01-01'
					   group by c.dept_no)
order by a.emp_no asc;

-- 문제4.
-- 현재, 사원들의 사번, 이름, 매니저 이름, 부서 이름으로 출력해 보세요.


select a.emp_no as '사번', concat(a.first_name, ' ', a.last_name) as '이름', manager.mname as '매니저 이름', c.dept_name as '부서'
from employees a, dept_emp b, departments c, (select concat(a.first_name, ' ', a.last_name) as mname, c.dept_name as md
												from employees a, dept_manager b, departments c
											   where a.emp_no = b.emp_no
												 and b.dept_no = c.dept_no
												 and b.to_date = '9999-01-01'
										    group by c.dept_name) as manager
where a.emp_no = b.emp_no
and b.dept_no = c.dept_no
and c.dept_name = manager.md
and b.to_date = '9999-01-01';



-- 문제5.
-- 현재, 평균연봉이 가장 높은 부서의 사원들의 사번, 이름, 직책, 연봉을 조회하고 연봉 순으로 출력하세요. subquery = 평균연봉이 가장 높은 부서
select a.emp_no as 사번, concat(a.first_name, ' ', a.last_name) as 이름, b.title as 직책, c.salary as 연봉 
 from employees a, titles b, salaries c, dept_emp d
where a.emp_no = b.emp_no
  and a.emp_no = c.emp_no
  and a.emp_no = d.emp_no
  and b.to_date = '9999-01-01'
  and c.to_date = '9999-01-01'
  and d.to_date = '9999-01-01'
  and d.dept_no = (select dept_no
                     from employees a, salaries b, dept_emp c
					where a.emp_no = b.emp_no
                      and a.emp_no = c.emp_no
                      and b.to_date = '9999-01-01'
                      and c.to_date = '9999-01-01'
                 group by c.dept_no
                 order by avg(b.salary) desc
					limit 1)
order by 연봉 desc;



-- 문제6.
-- 평균 연봉이 가장 높은 부서는? 
select distinct(c.dept_name)as '연봉이 가장 높은 부서'
from salaries a, dept_emp b, departments c
where a.emp_no = b.emp_no
and b.dept_no = c.dept_no
and c.dept_no = (select dept_no
                     from employees a, salaries b, dept_emp c
					where a.emp_no = b.emp_no
                      and a.emp_no = c.emp_no
					  and b.to_date = '9999-01-01'
                      and c.to_date = '9999-01-01'
                 group by c.dept_no
                 order by avg(b.salary) desc
					limit 1);


-- 문제7.
-- 평균 연봉이 가장 높은 직책? 
select b.title
from employees a , titles b, salaries c
where a.emp_no = b.emp_no
and a.emp_no = c.emp_no
and b.to_date = '9999-01-01'
and c.to_date = '9999-01-01'
group by b.title
order by avg(c.salary) desc limit 1;

-- 문제8.
-- 현재 자신의 매니저보다 높은 연봉을 받고 있는 직원은?
-- 부서이름, 사원이름, 연봉, 매니저 이름, 메니저 연봉 순으로 출력합니다.


select a.emp_no as '사번', concat(a.first_name, ' ', a.last_name) as '이름', d.salary as '직원 연봉', manager.매니저이름 as '매니저 이름', c.dept_name as '부서'
from employees a, dept_emp b, departments c, salaries d , (select concat(a.first_name, ' ', a.last_name) as '매니저이름', c.dept_name as '매니저부서', d.salary as '매니저연봉'
												from employees a, dept_manager b, departments c, salaries d
											   where a.emp_no = b.emp_no
                                               and a.emp_no =d.emp_no
												 and b.dept_no = c.dept_no
                                                 and d.to_date = '9999-01-01'
												 and b.to_date = '9999-01-01'
                                                  group by c.dept_name
                                                 )as manager
                                                 
where a.emp_no = b.emp_no
and a.emp_no = d.emp_no
and b.dept_no = c.dept_no
and c.dept_name = manager.매니저부서
and d.to_date = '9999-01-01'
and b.to_date = '9999-01-01'
and d.salary>manager.매니저연봉
order by a.emp_no;


