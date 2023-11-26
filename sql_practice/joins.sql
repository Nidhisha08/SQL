#prctice 4-- joins

 /* From the following tables write a SQL query to find the salesperson
 and customer who reside in the same city. Return Salesman, cust_name and city */

select s.salesman_id,c.cust_name,c.city from salesmen as s, grade as c where s.city=c.city;

#or

select s.name,c.cust_name,c.city,s.city from salesmen as s inner join grade as c on s.city=c.city;

/* From the following tables write a SQL query to find those orders where the order amount 
exists between 500 and 2000. Return ord_no, purch_amt, cust_name, city.   */

select o.ord_no,o.purch_amt,c.cust_name,c.city from  grade as c,orderss as o
where purch_amt between 500 and 2000 and o.customer_id=c.cust_id;

/*From the following tables write a SQL query to find the salesperson(s)
 and the customer(s) he represents. Return Customer Name, city, Salesman, commission. */
select c.cust_name,c.city,s.name,s.commission from grade as c 
inner join
salesmen as s on s.salesman_id=c.sales_id;

/*From the following tables write a SQL query to 
find salespeople who received commissions of more than 12 percent from the company. 
Return Customer Name, customer city, Salesman, commission.   */

select s.name,s.commission,c.cust_name,c.city from salesmen as s,grade as c
 where commission>0.12 and c.sales_id=s.salesman_id;
 
 #using the join function
 select s.name,s.commission,c.cust_name,c.city from salesmen as s
 inner join
 grade as c on c.sales_id=s.salesman_id where commission>0.12;
 
 /* From the following tables write a SQL query to find the details of an order.
 Return ord_no, ord_date, purch_amt, Customer Name, grade, Salesman, commission.  */
 
select o.ord_no,o.purch_amt,c.cust_name,c.grade,s.name,s.commission from orderss as o
inner join grade as c  on o.customer_id=c.cust_id
inner join salesmen as s on s.salesman_id=c.sales_id;

#or
select  o.ord_no,o.purch_amt,c.cust_name,c.grade,s.name,s.commission 
from orderss as o,grade as c,salesmen as s 
where c.cust_id=o.customer_id and s.salesman_id=c.sales_id;

#pratice-4
select * from salesmen;
select * from grade;
select * from orderss;

/*Write a SQL statement to join the tables salesman, customer and orders
 so that the same column of each table appears once and only the relational rows are returned.  */

select * from orderss natural join grade natural join salesmen;

/* From the following tables write a SQL query to display the customer name, customer city, 
grade, salesman, salesman city. The results should be sorted by ascending customer_id.*/

select s.name,s.city,c.cust_name,c.city,c.grade from salesmen as s,grade as c
 where s.salesman_id=c.sales_id 
 order by c.cust_id asc;
 
 #or using left join
 select s.name,s.city,c.cust_name,c.city,c.grade from salesmen as s left join grade as c
 on s.salesman_id=c.sales_id
 order by cust_id;
 
/* From the following tables write a SQL query to find those customers with 
a grade less than 300. Return cust_name, customer city, 
grade, Salesman, salesmancity. The result should be ordered by ascending customer_id.*/

select c.cust_name,c.city,c.grade,s.name,s.city from salesmen as s, grade as c 
where grade<300 and c.sales_id=s.salesman_id order by cust_id ;

#or

select  c.cust_name,c.city,c.grade,s.name,s.city from salesmen as s left join grade as c
on c.sales_id=s.salesman_id where c.grade<300 order by cust_id;

/*Write a SQL statement to make a report with customer name, city, order number, order date, and order amount in ascending order 
according to the order date to determine whether any of the existing customers have placed an order or not.*/

select c.cust_id,c.cust_name,c.city,o.ord_no,o.ord_date,o.purch_amt from grade as c left join orderss as o
on c.cust_id=o.customer_id
order by o.ord_date asc,c.cust_id asc;

/*SQL statement to generate a report with customer name, city, order number, order date, 
order amount, salesperson name, and commission to determine if any of the existing customers
 have not placed orders or if they have placed orders through their salesman or by themselves.*/
 
select c.cust_name,c.city,o.ord_no,o.ord_date,o.purch_amt,s.name,s.commission from salesmen as s
left outer join grade as c on s.salesman_id=c.sales_id
left outer join orderss as o on o.customer_id=c.cust_id;

/* Write a SQL statement to generate a list in ascending order of salespersons who work
 either for one or more customers or have not yet joined any of the customers.*/
 
 select s.name,c.cust_name,c.city,c.grade from salesmen as s left join grade as c on c.sales_id=s.salesman_id
 order by s.name;
 
 /*Write a SQL statement to make a list for the salesmen who either work 
 for one or more customers or yet to join any of the customer. The customer 
 may have placed, either one or more orders on or above order amount 2000 and must
 have a grade, or he may not have placed any order to the associated supplier.*/

select s.name,s.salesman_id,s.city,c.cust_name,c.city,c.grade,o.ord_no,purch_amt 
from salesmen as s 
left outer join grade as c on c.sales_id=s.salesman_id 
left outer join orderss as o on c.cust_id=o.customer_id
where  o.purch_amt>=2000 and c.grade is not null;

/*For those customers from the existing list who put one or more orders, or which orders have been placed by the customer who
 is not on the list, create a report containing the customer name, city, order number, order date, and purchase amount*/
 
 select c.cust_name,c.city,o.ord_no,o.ord_date,o.purch_amt from orderss as o
 right outer join grade as c on c.cust_id=o.customer_id;

/*Write a SQL statement to generate a report with the customer name, city, order no. order date,
 purchase amount for only those customers on the list who must have a grade and placed one or more
 orders or which order(s) have been placed by the customer who neither is on the list nor has a grade.*/
 
 select c.cust_name,c.city,o.ord_no,o.ord_date,o.purch_amt from grade as c 
left join orderss as o on c.cust_id=o.customer_id
 where c.grade is not null;
 
 /*Write a SQL query to combine each row of the salesman table with each row of the customer table.*/
SELECT * FROM salesmen a CROSS JOIN grade b;

 
select * from salesmen as s left join grade as c on s.salesman_id=c.sales_id
union 
select * from salesmen as s right join grade as c on s.salesman_id=c.sales_id;
# outer join does not support

/*Write a SQL statement to create a Cartesian product between salesperson and customer, 
i.e. each salesperson will appear for every customer and vice versa for those salesmen 
who belong to a city and customers who require a grade.*/

select * from salesmen  cross join grade where
grade is not null and grade.city is not null;



select * from company_mast;
select * from item_mast;

/* From the following tables write a SQL query to select all rows
 from both participating tables as long as there is a match between pro_com and com_id.*/
 
 select * from company_mast as c
 inner join 
 item_mast as i on i.pro_com=c.com_id;
 
 /*Write a SQL query to display the item name, price, and company name of all the products.*/
 
 select com_name,pro_name,pro_price from company_mast as c , item_mast as i where c.com_id=i.pro_com;
 
 /*From the following tables write a SQL query to calculate the average
 price of items of each company. Return average value and company name.*/
 
 select round(avg(pro_price),2) as avg_price, com_name from company_mast as c, item_mast as i 
 where c.com_id=i.pro_com
 group by com_name;
 
 #or
 
  select round(avg(pro_price),2) as avg_price, com_name from company_mast as c
  inner join item_mast as i  on c.com_id=i.pro_com group by com_name ;
  
  /*From the following tables write a SQL query to calculate and find the average price of
  items of each company higher than or equal to Rs. 350. Return average value and company name.*/
  
  select com_name ,round(avg(pro_price),2) as avg_price from company_mast as c inner join
  item_mast as i on c.com_id=i.pro_com  group by com_name having avg_price>=350;
  
  /* From the following tables write a SQL query to find the most 
  expensive product of each company. Return pro_name, pro_price and com_name.*/


SELECT i.pro_name, i.pro_price, c.com_name FROM
item_mast AS i,company_mast AS c WHERE
c.com_id = i.pro_com AND i.pro_price = (SELECT  MAX(i.pro_price)
FROM _mast AS i WHERE i.pro_com = c.com_id);



#or

SELECT A.pro_name, A.pro_price, F.com_name
   FROM item_mast A INNER JOIN company_mast F
   ON A.pro_com = F.com_id
     AND A.pro_price =
     (
       SELECT MAX(A.pro_price)
         FROM item_mast A
         WHERE A.pro_com = F.com_id
     );  

# here we do not add non aggregated column.
SELECT MAX(pro_price), com_name FROM item_mast INNER JOIN  comany_mast WHERE com_id = pro_com GROUP BY com_name;

use db1;
select * from orderss;
select * from commission;
