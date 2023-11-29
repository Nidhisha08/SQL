use classicmodels;
show tables;
select * from customers;
 
 create view state_ca as 
 select customerName,phone,city,state,creditLimit from customers where state="CA";
 
 # using the join function
 select * from orderdetails;
 select * from orders;
 
 create view order_details as
 select quantityOrdered,priceEach,orderDate,requiredDate,shippedDate,status from orders 
 as o inner join orderdetails as od on o.orderNumber=od.orderNumber;
 
 select * from order_details;
 
 create view cancle_orders as 
 select quantityOrdered,priceEach,orderDate,requiredDate,shippedDate,status from orders as o,orderdetails as od
 where status="cancelled" and o.orderNumber=od.orderNumber;
 
 select * from cancle_orders;
 
 select * from customers;
select * from orderdetails;
select * from orders;
select * from payments;

#both query behave the same

select c.customerNumber,customerName,orderNumber,orderDate 
from customers as c,orders as o
where c.customerNumber=o.customerNumber;

select c.customerNumber,customerName,orderNumber,orderDate 
from customers as c inner join orders as o
on c.customerNumber=o.customerNumber;

/*
Both queries, when corrected, essentially perform the same task of retrieving
 data where the "customerNumber" matches in all three tables. However, 
 the first query uses the modern and preferred syntax for joining tables,
 making it more readable and maintainable. The second query uses an older 
 syntax that is less common in modern SQL.
*/

SELECT o.customerNumber, customerName, o.orderNumber, orderDate, paymentDate, amount
FROM customers AS c, orders AS o, payments AS p
WHERE o.customerNumber = c.customerNumber
AND c.customerNumber = p.customerNumber;

SELECT o.customerNumber, customerName, o.orderNumber, orderDate, paymentDate
FROM customers AS c
INNER JOIN orders AS o ON o.customerNumber = c.customerNumber
INNER JOIN payments AS p ON c.customerNumber = p.customerNumber;



create  view  all_details_customer as
select o.customerNumber,customerName,o.orderNumber,orderDate,paymentDate
from customers as c inner join orders as o
on o.customerNumber=c.customerNumber
inner join payments as p on
c.customerNumber=p.customerNumber;

select * from all_details_customer;
