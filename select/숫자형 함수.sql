-- 절대값
select abs(2), abs(-2);

-- mod(x, y) : x를 y로 나눈 나머지
select mod(7,2), mod(15,4);

-- floor(x) : 보다 작거나 같은 가장 큰 정수
select floor(3.14), floor(-3.14);

-- ceiling
select ceiling(3.14), ceiling(-3.14);

-- round(x) : x에 가장 근접한 정수 반환
select round(1.298), round(1.5111);

-- round (x,d): d자리에 가장 근접한 실수 반환
select round(1.298,1), round(1.5111,0);

-- 제곱승
select pow(2, 10), power(10, 5);

-- sing(x) : x가 음수이면 -1, 양수이면 1, 0이면 0 return
select sign(-2), sign(2), sign(0);

-- 가장 큰값, 가장 작은 값
select greatest(10, 2, 4, 9),
	   least(10, 2, 4, 9),
       greatest('Abc', 'Abc1', 'ABcd');