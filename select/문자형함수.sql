-- ucase
-- 1. 자바 upperCase 보다 DB의 upper() 함수가 훨씬 빠르다.
-- 2. 웬만하면 DB에서 문자열 처리뿐만 아니라 포맷팅 처리등을 다 해주고
-- 		자바에서 출력만 해결한다.
-- 3. 자바 코드가 간결해서 좋다.
select ucase('SeouL'), ucase('seoul');
select ucase(first_name) from employees;

select first_name from employees;

-- lcase
select lcase('SEouL'), lcase('SEOUL');

-- subString()
select subString('Happy Day', 3, 2); -- 3번째부터 2개를 가져와라

select first_name as '이름',
subString(hire_date, 1, 4) as '입사년도'
from employees;

-- lpad, rpad
select lpad('1234', 10, '-');
select rpad('1234', 10, '-');

-- salaries 테이블에서 2001년 급여가 70000불 이하의 직원만 사번, 급여로 출력하되 급여는 10자리로 부족한 자리수는 *로 표시

select emp_no as 사번, lpad(cast(salary as char), 10, '*') as 급여
-- select emp_no as 사번, lpad(salary, 10, '*') as 급여
from salaries
where from_date like '2001%'
and salary <= 70000;

-- ltrim, rtrim, trim
select concat('-----', ltrim('            hello        '), '-----') as 'LTRIM',
concat('-----', rtrim('            hello        '), '-----') as 'RTRIM',
concat('-----', trim('            hello        '), '-----') as 'TRIM',
concat('-----', trim(both 'x' from 'xxxxxhelloxxxxx'), '-----') as 'TRIM',
concat('-----', trim(leading 'x' from 'xxxxxhelloxxxxx'), '-----') as 'TRIM',
concat('-----', trim(trailing 'x' from 'xxxxxhelloxxxxx'), '-----') as 'TRIM';
