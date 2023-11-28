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