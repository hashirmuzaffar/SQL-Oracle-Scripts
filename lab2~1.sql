create table books_authors
(authorID int
,isbn int
,foreign key (authorID) references Author(authorid),
foreign key (isbn) references books(isbn));

alter table books
MODIFY title varchar(50) unique;

alter table books
MODIFY price float not null;

alter table books
MODIFY price float check (price>=0.0);

alter table books
MODIFY price qty not null;


alter table books
modify qty int;

alter table books
MODIFY qty float DEFAULT 0;

alter table author
modify email varchar2(30);

alter table author
add D_O_B date not null;

select * from sale where region='Europe' and country ='Spain';

select * from sale where units_sold between 5000 and 10000; 

select * from sale where order_priority='H';


 select country,item_type, order_date,(total_revenue-total_cost) as profit from sale order by order_date ASC ;
 
 select  distinct region from sale;
 
 select order_id, (total_revenue-total_cost) as profit  from sale; 
 
 select * from sale order by (total_revenue-total_cost) ASC;
 
UPDATE sale
SET order_priority='H'
WHERE order_id = '341417157';