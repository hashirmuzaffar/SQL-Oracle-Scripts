--Hashir Muzaffar
--22816
Create table MOVIE(
mID int primary key,
title varchar(50),
year int,
director varchar(50)
);

alter table MOVIE
add check (year >= 1900);  

Create table Reviewer(
rID int primary key,
name varchar(50) not null
);

Create table Rating(
mID int,
rID int,
stars int not null,
ratingDate date,
FOREIGN KEY (mID) REFERENCES MOVIE(mID),
FOREIGN KEY (rID) REFERENCES REVIEWER(rID),
Primary key (mID,rID,ratingDate)
);

Alter table Rating
add constraint stars check(stars>=1 and stars<= 5);

Alter table Rating
add constraint ratingDate check(EXTRACT(Year from ratingDate)>2000);

insert into movie
values(22816,'The wardasources and the prince', 2002,'Hashir');
insert into movie
values(22800,'Warda the people eating monster', 2012,'Madia');
insert into movie
values(22810,'Warda the never ending hunger', 2022,'Shahzeib');
insert into movie--wrong input
values(22816,'The wardasources and the prince', 1890,'Hashir');

insert into Reviewer
values(22836,'Dua');

insert into Reviewer
values(22822,'Hashir');

insert into Reviewer--wrong input
values(22836,null);

insert into rating
values(22816,22836,5,sysdate);

insert into rating
values(22800,22822,3,sysdate);


