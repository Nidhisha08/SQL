#sysntax
/*
DELIMITER //
CREATE FUNCTION FUNCTION_NAME(paramter_name1 datatypes,paramter2 dattypes....)
RETURNS RETURNED_DTYPES
DETERMINISTIC
	BEGIN
     ENTER THE CODE HERE.....
    END //
*/

use db1;
select * from emp;

delimiter //
create function get_bonus_status
(salary float)
returns varchar(30)
deterministic
begin
	if salary>30000 then
    return ("eligible for bonus");
    else
    return ("not eligible for bonus");
end if;
end //


select get_bonus_status(50000.0);
select get_bonus_status(23000);

select emp_no,name,last_name,sal,get_bonus_status(sal) from emp;

#updating the salary

delimiter //
create function get_updated_sal
(sal float)
returns float
deterministic
begin
	declare up_sal float default 0;
	if sal<20000 then 
    return sal+(0.1*sal);
    elseif sal<30000 then
    return sal+(0.2*sal);
    else 
    return sal+(0.4*sal);
end if;
end //
select get_updated_sal(40000);

select *,get_updated_sal(sal) from emp;


select * from student;
# student result

delimiter //
create function get_student_grade
(average decimal(10,2))
returns varchar(40)
deterministic
begin
declare top_student varchar(200) default 0;
	if average=top_student then
    return "top student";
    elseif average>80 then
    return "passed with distinction";
    elseif average>60 then
    return "passed with 1st class";
    elseif average>40 then
    return "passed with 2nd class";
    else
    return "fail";
    end if;
end //
select *,get_student_grade(average) from student;


select * from employees;
select * from offices;

delimiter //
create function avg_sal(jobs varchar(200))
returns varchar(200)
deterministic
begin
 declare avg_sal decimal(10,2) default 0;
 select avg(officeCode) into avg_sal from employees where jobTitle=jobs
 group by jobTitle;
 return avg_sal;
end //

drop function avg_sal;
select avg_sal("Sales Rep");


select concat(m.firstName,' ',m.lastName) as manegar,
 concat(e.firstName,' ',e.lastName) as employee 
 from employees as e inner join employees as m
 on m.employeeNumber=e.reportsTo;


