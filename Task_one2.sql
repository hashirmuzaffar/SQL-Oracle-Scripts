create table customer_sales
(
Customer_ID int,
Order_ID int,
Order_date Date
);

insert into customer_sales
values(123,321,'1-may-2022');

insert into customer_sales
values(123,322,'1-jun-2022');

insert into customer_sales
values(123,323,'1-jul-2022');

insert into customer_sales
values(456,324,'1-dec-2022');

insert into customer_sales
values(789,325,'1-apr-2022');

insert into customer_sales
values(789,326,'1-jun-2022');

Select customer_ID,order_ID,Order_date
from customer_sales
order by customer_ID;


