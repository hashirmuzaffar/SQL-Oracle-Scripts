CREATE table books
(isbn int primary key,
title varchar(50),
price float,
qty int not null);

Create table Authors
(authorID INT primary key,
name varchar(30),
email varchar(30) UNIQUE);

create table books_authors
(authorID int
,isbn int
,foreign key (authorID) references Authors(authorid),
foreign key (isbn) references books(isbn));

alter table books
drop CONSTRAINT SYS_c008340;

alter table authors
drop CONSTRAINT SYS_c008343;

