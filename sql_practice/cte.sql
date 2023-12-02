/* with temp_table_name as (
writing the sql squery); 
select * from  temp_table_name */

# cte used to create the temporary set that exist within execution scope f the particular statement

use db1;

select * from emp;

with details_of_ds as
(select * from emp where dept="datascience")
select * from details_of_ds;

select * from grade;
select * from orderss;
select * from salesmen;


with ordered_cust as
(select cust_name,city,ord_no,purch_amt,ord_date 
from grade as c
inner join
orderss as o
on c.sales_id=o.salesman_id )
select * from ordered_cust where ordered_cust.ord_date="2012-10-05";


#want the customers ,order details who done the greater the purchase_amt the avg

with avg_amt as(
select c.cust_name,c.cust_id,avg(purch_amt) as avg_val from orderss as o
inner join
grade as c
on c.cust_id=o.customer_id
group by customer_id
having avg(purch_amt)>(select avg(purch_amt) from orderss))
select * from avg_amt;

use bank;
select * from bsnk_churn;

#Let us mainly focus of country germany. Now how many no of customer male or female.

WITH churned_customer AS
	(SELECT gender, COUNT(customer_id)  as churned_cust FROM
	bank_churn where country="Germany" and churn="yes"
	GROUP BY gender),
number_customer AS
	(SELECT gender, COUNT(customer_id) as no_cust FROM
    bank_churn WHERE country="Germany"
    GROUP BY gender)
SELECT 
	cc.gender, churned_cust, (churned_cust/no_cust)*100 "churn rate(%)"
	FROM churned_customer as cc
LEFT JOIN
	number_customer as nc ON cc.gender=nc.gender;


