#subquerries
use db1;
select * from salesmen;
select * from grade;
select * from orderss;

/* From the following table, write a SQL query to select all the salespeople.
 Return salesman_id, name, city, commission with the percent sign (%).*/
 
 select salesman_id,name,city,"%",commission*100 from salesmen;
 
 /* From the following table, write a SQL query to find the number of orders booked for each day.
 Return the result in a format like "For 2001-10-10 there are 15 orders".".*/
 
 select "For", ord_date ,"there are" ,count(ord_date), "orders" from orderss group by ord_date;

/*From the following tables, write a SQL query to find all the orders issued by the salesman 'Paul Adam'. 
Return ord_no, purch_amt, ord_date, customer_id and salesman_id.*/

 select ord_no, purch_amt, ord_date, customer_id, orderss.salesman_id as id from orderss 
 inner join salesmen on orderss.salesman_id=salesmen.salesman_id
 where name="Paul Adam";
 #or subquery
 select * from orderss where salesman_id =
 (select salesman_id from salesmen where name="Paul Adam");
 
 /*From the following tables write a SQL query to find all orders generated by 
 London-based salespeople. Return ord_no, purch_amt, ord_date, customer_id, salesman_id.*/
 
select * from orderss where salesman_id in
 (select salesman_id from salesmen where city="London");
 
 /*From the following tables write a SQL query to find all orders generated by the salespeople
 who may work for customers whose id is 3007. Return ord_no, purch_amt, ord_date, customer_id, salesman_id.*/
 
select * from orderss where salesman_id in(
select sales_id from grade where cust_id=3007);

/*From the following tables write a SQL query to find the order values greater than the average order 
value of 10th October 2012. Return ord_no, purch_amt, ord_date, customer_id, salesman_id.*/

select * from orderss where purch_amt>
(select avg(purch_amt) from orderss where ord_date="2012-10-10");

/*From the following tables, write a SQL query to find all the orders generated in New York city.
 Return ord_no, purch_amt, ord_date, customer_id and salesman_id.*/
 
 select * from orderss where salesman_id in
 (select salesman_id from salesmen where city="New York");
 
 /* From the following tables write a SQL query to determine the commission of the salespeople in Paris. Return commission.*/
 
 select commission from salesmen where salesman_id in
 (select sales_id from grade where city="Paris");


/* Write a query to display all the customers whose ID is 2001 below the salesperson ID of Mc Lyon.*/

select * from grade where cust_id=(
select salesman_id-2001 from salesmen where name="Mc Lyon");

/*From the following tables write a SQL query to count the number of customers 
with grades above the average in New York City. Return grade and count. */

select grade,count(cust_id) counts from grade where grade>
(select avg(grade) from grade where city="New York")group by grade;

/*From the following tables, write a SQL query to find those salespeople who 
earned the maximum commission. Return ord_no, purch_amt, ord_date, and salesman_id*/


select * from orderss where salesman_id =(
 select salesman_id from salesmen group by salesman_id 
 having max(commission)
 order by commission desc limit 1); 

select * from orderss where salesman_id in(
select salesman_id from salesmen where
commission =(select max(commission) from salesmen));


  /*From the following tables write SQL query to find the customers who placed orders on 17th August 2012. 
  Return ord_no, purch_amt, ord_date, customer_id, salesman_id and cust_name*/
  
select ord_no,purch_amt,ord_date,customer_id,o.salesman_id,cust_name from orderss as o,grade as c
where c.sales_id=o.salesman_id and ord_date="2012-08-17";

 /*From the following tables write a SQL query to find salespeople who had more than one customer. Return salesman_id and name.*/
 
 select salesman_id,name from salesmen where salesman_id in(
 select sales_id from grade group by sales_id having count(cust_id)>1);  #subquery
 
 select s.salesman_id, s.name from salesmen as s, grade as c where 
 s.salesman_id=c.sales_id group by sales_id having count(cust_id)>1;   # join method

select salesman_id,name from salesmen as s where 1<
(select count(*) from grade where sales_id=s.salesman_id);     # other method in subquery

/*From the following tables write a SQL query to find those orders, which are higher than the average 
amount of the orders. Return ord_no, purch_amt, ord_date, customer_id and salesman_id.*/

select * from orderss as a where purch_amt >
(select avg(purch_amt) from orderss as b );

select avg(purch_amt) from orderss;

SELECT * 
FROM orderss a
WHERE purch_amt >
    (SELECT AVG(purch_amt) FROM orderss b 
     WHERE b.customer_id = a.customer_id);

/*Write a query to find the sums of the amounts from the orders table, grouped by date, 
and eliminate all dates where the sum was not at least 1000.00 above the maximum order amount for that date. */

select ord_date,sum(purch_amt) from orderss group by ord_date having sum(purch_amt)>1000+max(purch_amt);

SELECT ord_date, sum(purch_amt)
FROM orderss a
GROUP BY ord_date
HAVING SUM(purch_amt) >
    (SELECT 1000.00 + MAX(purch_amt) 
     FROM orderss b 
     WHERE a.ord_date = b.ord_date);

/*Write a query to extract all data from the customer table if and 
only if one or more of the customers in the customer table are located in London.*/
 
 select * from grade where cust_id in
 (select cust_id from grade where city="London");
 
 /*From the following tables write a SQL query to find salespeople who deal 
 with multiple customers. Return salesman_id, name, city and commission.*/
 
 select * from salesmen where salesman_id in 
 (select sales_id from  grade group by sales_id having count(cust_id)>1);
 
SELECT * 
FROM salesman 
WHERE salesman_id IN (
   SELECT DISTINCT salesman_id 
   FROM grade a 
   WHERE EXISTS (
      SELECT * 
      FROM grade b 
      WHERE b.sales_id=a.sales_id 
      AND b.cust_name<>a.cust_name));

 # select sales_id,count(cust_id) from grade group by sales_id having count(cust_id);
 
 /*From the following tables write a SQL query to find salespeople who deal with
 a single customer. Return salesman_id, name, city and commission.*/
 
 
 
 select * from salesmen where salesman_id in
 (select sales_id from grade group by sales_id having count(cust_id)=1);
 
/*From the following tables, write a SQL query to find the salespeople who deal the 
customers with more than one order. Return salesman_id, name, city and commission.*/

select * from salesmen where salesman_id in
(select sales_id from grade where cust_id in
(select customer_id from orderss group by customer_id having count(ord_no)>1));
 
#or
select * from salesmen as a where exists
(select * from grade as b where a.salesman_id=b.sales_id and
1<(select count(*) from orderss as o where o.customer_id=b.cust_id));

/*From the following tables write a SQL query to find the salespeople who deal with those customers
 who live in the same city. Return salesman_id, name, city and commission.*/
 
 select s.salesman_id, s.name, s.city,c.city,c.cust_name,c.sales_id from 
 salesmen as s ,grade as c where s.salesman_id=c.sales_id and s.city=c.city;    #using the join

 
SELECT * FROM salesmen  WHERE city=ANY
(SELECT city  FROM grade);                       #using subquery
 
/*From the following tables write a SQL query to find salespeople whose place of residence matches 
any city where customers live. Return salesman_id, name, city and commission.*/

select  distinct s.salesman_id,s.city,c.city,commission,s.name from salesmen as s
 inner join grade as c where s.city=c.city;

select * from salesmen where city in
(select city from grade);

/* From the following tables write a SQL query to find all those salespeople whose names appear alphabetically 
lower than the customer’s name. Return salesman_id, name, city, commission.*/

select * from salesmen as a where exists
(select * from grade as b where  a.name<b.cust_name) order by name;

/*From the following table write a SQL query to find all those customers with a higher grade
 than all the customers alphabetically below the city of New York. Return customer_id, cust_name, city, grade, salesman_id.*/
 
 select * from grade where grade>any
 (select grade from grade where city<"New York");

select * from grade where city<"New York"; 

# want a details of salesmen whose number of customers  should be greater than 1

select * from salesmen where salesman_id in
(select salesman_id from orderss group by salesman_id having count(salesman_id)>1);
 
 create table sales(
	sales_id int not null,
    city varchar(10) not null);
    
create table cust_table(
	sales_id int,
    city varchar(10) not null,
    cust_name varchar(10) not null,
    foreign key(sales_id) references sales(sales_id)
	);

alter table sales modify sales_id int primary key;

insert into sales (sales_id,city) values
	(1,"A"),
	(2,"B"),
	(3,"C"),
	(4,"D");
insert into cust_table values
	(4,"A","ll"),
    (3,"E","ww"),
    (2,"B","ss"),
    (2,"B","AA"),
    (1,"C","qq"),
    (1,"D","jj");
    
select * from sales;
select * from cust_table;

select * from sales where sales_id in
	(select sales_id from cust_table group by sales_id,city
    having count(sales_id)>1);

select * from cust_table where city in
	(select  city from sales where city="A");

insert into sales values(5,"A");
insert into sales values(6,"B");

delete  from sales where sales_id=6;

select * from cust_table where city =any
	(select  city from sales where city="B");


    

