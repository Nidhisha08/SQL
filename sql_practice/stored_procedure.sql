use data2;
#stored procedure
#syntax
/*
delimiter //
create procedure procedure_name([in/out/inout][parameter name][datatypes])
	begin
    sql statment;
    end //
*/
use data2;

delimiter ##
create procedure sales_detail()
	begin
    select distinct `year` from sales_data;
	end ##
    
call sales_detail();

delimiter //
create procedure sp_cust_details()
	begin
    select cust_id,cust_name,country,city,state,postal_code
    region from sales_data;
    end //
    
CALL sp_cust_details;

#using the in operator

delimiter //
create procedure sp_getyear(in year_value int)
	begin
    select count(cust_id) from sales_data
    where `year`=year_value;
    end //

call sp_getyear(2013);

#we can not alter the procedure insted of that we have to drop the procedure

delimiter //
create procedure get_yearprofit(in year_value int,in region_value varchar(200))
	begin
    select sum(profit) from sales_data where year=year_value
    and region=region_value;
    end //

call get_yearprofit(2013,"east");

#using the out parameter

delimiter //
create procedure sp_avg( out avarage decimal(5,2))
	begin
    select avg(profit) into avarage from sales_data;
    end //
    
call sp_avg(@avg_mark);
select @avg_marks;

#if we want to call parameter in that same  again we can call by using select statment
#also we can use it anywhere in the sql statement

#output values get from stored procedure the are used in the update statement
select * from nidhi;
update nidhi set sal=sal+@avg_marks where roll_no=214006;


delimiter //
create procedure sp_avg_value()
	begin
    select avg(profit) as average from sales_data;
    end //

call sp_avg_value();
#without using the out parameter we can not call anywhere.

#using the inout parameter

select * from nidhi;
alter table nidhi add column sal float;

delimiter //
create procedure sp_update_sal(inout sal float, in per float)
	begin
    set sal=sal+(per*sal);
    end //
  
set @sal=20000;
call sp_update_sal(@sal,0.3);
select @sal;

#if want to give the input from one side and returning to same parameter ourside use inout 
#operator.


#want to declare the variable inside the stored
#procedure then the syntax
/*
declare {variable_name} datatypes [default value];
*/

#i want details of greater than the avg_profit value
select * from sales_data;

delimiter //
create procedure sp_avg_profit(out total float)
	begin
    declare average float default 0;                             #here just we are declaring the use with other sql statement 
    select avg(profit) into average from sales_data;              #(average parameter the hold the avg val) 
    select count(*) into total from sales_data where profit>average;
    end //

call sp_avg_profit(@total);
select @total;


#also can be done using the local variable
delimiter //
create procedure sp_avg_profit_local(out totals float,in avg_val float)
	begin
    select count(*) into totals from sales_data where profit>avg_val;
    end //
 
set @avg_val=30.5;
call sp_avg_profit_local(@tot,@avg_val);

select @tot;

/*
select count(*) from sales_data where profit>(select avg(profit) from sales_data);
*/

#to see the procedure
show procedure status where name like 'sp%';

#can find the stored procedure using db
show procedure status where db='data2';


# nested stored procedure

delimiter //
create procedure sp_avg_marks(out result int, in id int)
	begin
    declare avg_marks float default 0;
    declare marks_stud varchar(20) default 0;
    select avg(marks) into avg_marks from nidhi;
    select marks into marks_stud from nidhi where roll_no=id;
    if marks_stud>avg_marks then
		set result=True;
	else
		set result=False;
	end if;
    end //

delimiter //
create procedure result_student(out final_result varchar(20), in id int)
	begin
    call sp_avg_marks(@result,id);
    if @result =0 then 
		set  final_result="fail";
	else
		set final_result="pass";
	end if;
    end //

call result_student(@final_result,214006);
select @final_result;

call result_student(@final_result_1,214001);
select @final_result_1;

# the value of the result which will store in the variable @final_result_1
select *,@final_result_1 from nidhi where roll_no=214001;

#using the conditional method

delimiter //
create procedure sp_final_result(out result varchar(20),in id int)
	begin
    declare stud_marks float default 0;
    select marks into stud_marks from nidhi where roll_no=id;
    if  stud_marks>80 then
		set result="first class";
	elseif stud_marks between 50 and 79 then
		set result="second class";
	else
		set result= "fails";
    end if;
    end //
 
call sp_final_result(@result_1,214006);
select @result_1;


delimiter //
 create procedure profit_report
 (in state_name varchar(20),out result varchar(40),out avg_profit float,out avg_state float)
	begin
    declare avg_profit float default 0;
    declare avg_state float default 0;
    select avg(profit) into avg_profit from sales_data ;
    select avg(profit) into avg_state from sales_data where state=state_name;
    if avg_state>avg_profit then
		set result="good profit";
	else
		set result="not good profit";
	end if;
    end //
 drop procedure profit_report;
 

call profit_report("Iowa",@result);
select @result;
