
CREATE TABLE salesmen (
    salesman_id INT PRIMARY KEY,
    name VARCHAR(255),
    city VARCHAR(255),
    commission DECIMAL(5, 2)
);

INSERT INTO salesmen (salesman_id, name, city, commission)
VALUES
    (5001, 'James Hoog', 'New York', 0.15),
    (5002, 'Nail Knite', 'Paris', 0.13),
    (5005, 'Pit Alex', 'London', 0.11),
    (5006, 'Mc Lyon', 'Paris', 0.14),
    (5007, 'Paul Adam', 'Rome', 0.13),
    (5003, 'Lauson Hen', 'San Jose', 0.12);


CREATE TABLE orderss (
    ord_no INT PRIMARY KEY,
    purch_amt DECIMAL(8, 2),
    ord_date DATE,
    customer_id INT,
    salesman_id INT
);

INSERT INTO orderss (ord_no, purch_amt, ord_date, customer_id, salesman_id)
VALUES
    (70001, 150.5, '2012-10-05', 3005, 5002),
    (70009, 270.65, '2012-09-10', 3001, 5005),
    (70002, 65.26, '2012-10-05', 3002, 5001),
    (70004, 110.5, '2012-08-17', 3009, 5003),
    (70007, 948.5, '2012-09-10', 3005, 5002),
    (70005, 2400.6, '2012-07-27', 3007, 5001),
    (70008, 5760, '2012-09-10', 3002, 5001),
    (70010, 1983.43, '2012-10-10', 3004, 5006),
    (70003, 2480.4, '2012-10-10', 3009, 5003),
    (70012, 250.45, '2012-06-27', 3008, 5002),
    (70011, 75.29, '2012-08-17', 3003, 5007),
    (70013, 3045.6, '2012-04-25', 3002, 5001);


create table grade(
cust_id int primary key,
cust_name varchar(20),
city varchar(30),
grade int ,
sales_id int
);

INSERT INTO grade (cust_id, cust_name, city, grade, sales_id)
VALUES
    (3002, 'Nick Rimando', 'New York', 100, 5001),
    (3007, 'Brad Davis', 'New York', 200, 5001),
    (3005, 'Graham Zusi', 'California', 200, 5002),
    (3008, 'Julian Green', 'London', 300, 5002),
    (3004, 'Fabian Johnson', 'Paris', 300, 5006),
    (3009, 'Geoff Cameron', 'Berlin', 100, 5003),
    (3003, 'Jozy Altidor', 'Moscow', 200, 5007),
    (3001, 'Brad Guzan', 'London', NULL, 5005);
    

select * from salesmen;
#salespeople who come from the 'Paris' City or 'Rome' City. Return salesman_id, name, city, commission.
    
select salesman_id,city,commission from salesmen where city in ("Paris","Rome");
    
#other than Rome or paris
select salesman_id,city,commission from salesmen where city not in("Paris","Rome");
    
#salespeople who receive commissions between 0.12 and 0.14 
select * from salesmen where commission between 0.12 and 0.14;

# name start from P or L
select * from salesmen where name like "L%" or name like "P%" ;

# name who not start with P and L
select * from salesmen where name not like"L%" and name not like "P%";

# select * from salesmen where name not like ("L%", "P%"); Like function works with single value not a multiple values

# name start with N and 4th charcter is L
select * from salesmen where name like "N__L%" ;

# whos name end with n
select * from salesmen where name like "%n";

CREATE TABLE testtable (
    col1 VARCHAR(255) 
);

INSERT INTO testtable (col1)
VALUES
    ('A001/DJ-402\44_/100/2015'),
    ('A001_\\DJ-402\\44_/100/2015'),
    ('A001_DJ-402-2014-2015'),
    ('A002_DJ-401-2014-2015'),
    ('A001/DJ_401'),
    ('A001/DJ_402\\44'),
    ('A001/DJ_402\\44\\2015'),
    ('A001/DJ-402%45\\2015/200');

select * from testtable;
# % : represent the charcter   and _ actually a single char if we want find the string contain _ char
# then have to use /(escape char)

select * from testtable where col1 like "%/_%" escape "/" ;

# contian forward slash(/)
select * from testtable where col1 like "%/%" ;
#contain percentile (%)
select * from testtable where col1 like "%/%%"  escape '/' ;

select * from orderss;

select * from orderss where (purch_amt between 400 and 4000) and not purch_amt in(948.50, 1983.43);

SELECT * FROM orderss WHERE (purch_amt BETWEEN 400 AND 4000) AND (purch_amt NOT IN (948.50, 1983.43));

# calculate the total purch_amt
select sum(purch_amt) as total_purch_amt from orderss;

# avg
select round(avg(purch_amt),1) as avg_purch_amt from orderss;

# count the unique number of sales people
select count(distinct(salesman_id)) as count_people from orderss;

#maximum purchase amount
select max(purch_amt) as max_amt from orderss;

# minimum
select min(purch_amt) as min_amt from orderss;

#maximum purch_amt of each customer
select customer_id, max(purch_amt) as max_purch from orderss group by customer_id;

# maximum purch_amt of each cust in perticular date
select customer_id,ord_date, max(purch_amt) from orderss group by ord_date,customer_id;

#highest purch_amt on date '2012-08-17 of each person
select customer_id, max(purch_amt) as max_amt from orderss where ord_date="2012-08-17" group by customer_id;

# highest purch_amy by each customer with particular date and having puch_amt is more than 2000
select customer_id,ord_date, max(purch_amt) as max_amt from orderss group by customer_id,ord_date having max(purch_amt)>2000 ;

select customer_id,ord_date,max(purch_amt) from orderss group by customer_id,ord_date
 having max(purch_amt) between 2000 and 6000;

select customer_id,ord_date,max(purch_amt) from orderss group by customer_id,ord_date
 having max(purch_amt) in (2000 ,3000, 5760,6000);
 
 select customer_id,max(purch_amt) from orderss where customer_id between 3002 and 3007 
 group by customer_id having max(purch_amt)>1000;
 
 select salesman_id,max(purch_amt) from orderss where salesman_id between 5003 and 5008 group by
 salesman_id;
 
 select * from orderss;
 
 # count the no of orders on '2012-08-17'.
 use db1;
 select count(ord_no) from orderss where ord_date='2012-08-17';
 
 select * from grade;

#number of customer who recivied atleast one grade
select count(All grade) from grade;

#highest grade of the customer in each city
select city ,max(grade) "high_grade" from grade group by city;


# is the column grade contain null value 
SELECT * FROM customer WHERE grade IS NULL;

# is teh column grade not null values
select * from customer where age is not null;

#practice 3
use db1;
select * from salesmen;
select * from grade;
select * from orderss;

select s.name,s.city,c.cust_name from salesmen as s,grade as c where c.city=s.city;

#. From the following tables, write a SQL query to locate all the customers and the salesperson who works for them
#Return customer name, and salesperson name.

 
 /*From the following tables, write a SQL query to find those salespeople who 
 generated orders for their customers but are not located in the same city. 
 Return ord_no, cust_name, customer_id (orders table), salesman_id (orders table). */
 
 select o.ord_no,c.cust_id,s.salesman_id,c.cust_name from orderss as o, salesmen as s,grade as c where s.salesman_id=c.sales_id 
 and s.city!=c.city and c.cust_id=o.customer_id;
 
select c.cust_name as name,c.grade,o.ord_no from grade as c ,orderss as o ,salesmen as s
where c.grade is not null  and c.cust_id=o.customer_id and  c.sales_id =s.salesman_id;

/*rom the following table, write a SQL query to find those customers who are served by
 a salesperson and the salesperson earns commission in the range of 12% to 14%
 (Begin and end values are included.). Return cust_name AS "Customer", city AS "City". */
 
select c.cust_name, c.city, s.name ,s.commission from grade as c,salesmen as s 
where c.sales_id=s.salesman_id and s.commission between 0.12 and 0.14;

select c.cust_name,s.commission,o.purch_amt*s.commission "comission%" from orderss as o,grade as c,salesmen as s
where s.salesman_id=o.salesman_id and c.grade>=200 and c.cust_id=o.customer_id ;

/* From the following table, write a SQL query to find those customers who placed orders on October 5, 2012.
 Return customer_id, cust_name, city, grade, salesman_id, ord_no, purch_amt, ord_date, customer_id and salesman_id.*/
 
select c.cust_id, c.cust_name,c.city,c.grade,c.sales_id,o.ord_no,o.purch_amt,o.ord_date,s.salesman_id,s.commission
from orderss as o,grade as c ,salesmen as s where o.ord_date="2012-10-05" and o.customer_id=c.cust_id and c.sales_id=s.salesman_id;

 select salesman_id ,ord_date,count(salesman_id) as count from orderss group by salesman_id, ord_date;
 
 select count(customer_id) from orderss where purch_amt>2000;
 
 # sort thr purchase amount in ascending order
 select * from orderss;
 select * from orderss order by purch_amt asc;
 
 select * from orderss order by ord_date,purch_amt desc;
 
 /*From the following table, write a SQL query that calculates the 
 maximum purchase amount generated by each salesperson for each order date. Sort the 
 result-set by salesperson id and order date in ascending order. Return salesperson id, 
 order date and maximum purchase amount. */
 
 select salesman_id,ord_date,max(purch_amt) from orderss group by salesman_id,ord_date 
 order by salesman_id,ord_date asc;
 
 select salesman_id,ord_date,purch_amt from orderss order by 3 asc; #it will sort the based on 3 field that is purch_amt
 
 /* From the following table, write a SQL query that counts the unique orders and the
 highest purchase amount for each customer. Sort the result-set in descending order on 
 2nd field. Return customer ID, number of distinct orders and highest purchase amount by each customer */
 
 select * from orderss;
 
 select customer_id, count(customer_id), max(purch_amt) from orderss group by customer_id order by 2 desc;
 
 SELECT ord_date, SUM(purch_amt), SUM(purch_amt)*.15 FROM orders GROUP BY ord_date ORDER BY ord_date;
