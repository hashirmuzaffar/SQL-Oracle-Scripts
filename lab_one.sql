--hashir muzaffar
--22816
create user c##hashirmuz identified by hashir;
grant connect, resource, dba to c##hashirmuz;

create table employee
(EID NUMBER(2),
Name VARCHAR2(10),
City VARCHAR2(10)
);

insert into employee
values(11,'Maria','Karachi');
insert into employee
values(12,'Ali','Islamabad');
insert into employee
values(13,'Sarah','Lahore');
insert into employee
values(14,'Samreen','Karachi');

select *from employee;

ALTER TABLE employee
  MODIFY( EID NUMBER(5),
         Name      VARCHAR2(20),
         City        VARCHAR2(40) );

select *from employee;

select name, city from employee order by name;
