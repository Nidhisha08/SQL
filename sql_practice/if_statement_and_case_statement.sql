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
  
