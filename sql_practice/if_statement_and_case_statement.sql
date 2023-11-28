#if statement
use db1;
select * from emp;

delimiter //
create procedure get_bonus(in sal decimal(10,2),out result varchar(50))
begin
if sal>40000 then
set result="bonus provided";
else
set result="not bouns provide";
end if;
end //

call get_bonus(60000,@result);

select @result;

select *,
 if(gender="m","male","female") as gender
 from student;
 
select * from employees;
select * from offices;

select 
	sum(if(state is null,1,0)) as missing_value_state
from offices;





#case statement

UPDATE emp
SET sal = 
  CASE 
    WHEN sal < 20000 THEN sal + (sal * 0.1)
    WHEN sal < 30000 THEN sal + (sal * 0.2)
    ELSE sal + (sal * 0.3)
  END;
  
  select *,
  case 
	when average>80 then "passed with distinction"
    when average>60 then "passed with first class"
    when average>40 then "passed with second class"
    else "fail"
    end as result
  from student;
  
  select emp_no,name,last_name,sal,
  max(sal)-min(sal) as diff_sal,
  case 
	when max(sal)-min(sal)>30000 then "salary incresed by 30000"
    when max(sal)-min(sal) between 30000 and 20000 then "salary incresed by 20000"
    else "salary incresed by 10000"
    end as result
from emp group by emp_no;

select * from employees;
select * from offices;

select 
	count(case when addressLine2 is null then 1 end) as missing_value_adress,
    count(case when state is null then 1 end) as missing_value_state
from offices;


select o.officeCode,count(e.officeCode) as total_no_customer,
case 
	when count(e.officeCode)>5 then "high number of employee"
    when count(e.officeCode) between 3 and 5 then "medium number of employee"
    else "less number of employee"
    end as result
from employees as e
right join
offices as o on o.officeCode=e.officeCode
group by officeCode;