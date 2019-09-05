drop table user;

create table user(
	no int unsigned not null auto_increment,
    email varchar(100) not null default 'NO EMAIL',
    passwd varchar(64) not null,
    name varchar(25),
    dept_name varchar(25),
    
    primary key(no)
);

select * from user;
desc user;
-- insert
insert into user values(null, 'leejy3653@naver.com', password('1234'), '이종윤', '개발팀');

select * from user where passwd=password('1234');

insert into user(email, passwd) values('ljy31043@naver.com', password('1234'));
insert into user (passwd) values(password('1234'));
insert into user(passwd, email) values( password('1234'), 'ljy31043(2)@naver.com');


-- alter table
alter table user add juminbunho char(13) not null after no;
alter table user drop juminbunho;
alter table user add join_date datetime default now();
alter table user change email email varchar(200) not null default 'no email';
alter table user change dept_name department_name varchar(25);
alter table user rename users;
drop table users;

create table user(
	no int unsigned not null auto_increment,
    email varchar(100) not null default 'NO EMAIL',
    passwd varchar(64) not null,
    name varchar(25),
    dept_name varchar(25),
    
    primary key(no)
);

desc user;

select * from user;

-- update(DML)
update user
   set email = 'leejy36531@naver.com',
   name ='이종윤2'
   where no = 3;
   
select * from user;
-- delete(DML)
delete 
from user
where no = 3;
select * from user;
