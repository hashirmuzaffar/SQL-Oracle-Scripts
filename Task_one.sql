select * from sales;

select item_type, unit_price from sales;

select distinct item_type from sales;

select * from sales order by ship_date ASC;

select * from sales order by ship_date DESC;

select * from sales order by ship_date ASC, order_date DESC;

select * from sales where item_type='Snacks';

select * from sales where order_priority='H';

select * from sales order by item_type,order_date ASC;

select DISTINCT region from sales;

select * from sales where units_sold >=5000 AND units_sold <=10000;

ALTER TABLE sales 
ADD profito number(7) as (total_revenue-total_cost);

select * from sales order by profito asc;

select Name, City from employee order by Name ASC, City ASC; 

Create table books
(isbn int primary key,
title varchar(50),
price float,
qty int not null);

Create table author
(authorID int primary key,
Author_name varchar(30), email varchar(30) UNIQUE);

Create table Books_Author
(authorID int foreign key,
isbn int foreign key);

