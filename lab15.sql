CREATE TABLE courses (
    ccode        VARCHAR2(5)
        CONSTRAINT courses_pk PRIMARY KEY,
    name         VARCHAR2(30)
        CONSTRAINT courses_name_u UNIQUE,
    duration     NUMBER(3)
        CONSTRAINT courses_duration_chk CHECK ( duration >= 1 ),
    fee          NUMBER(5)
        CONSTRAINT courses_fee_chk CHECK ( fee >= 0 ),
    prerequisite VARCHAR2(100)
);

CREATE TABLE faculty (
    fcode VARCHAR2(5)
        CONSTRAINT faculty_pk PRIMARY KEY,
    name  VARCHAR2(30),
    qual  VARCHAR2(30),
    exp   VARCHAR2(100)
);

CREATE TABLE course_faculty (
    fcode VARCHAR2(5)
        CONSTRAINT course_faculty_fcode_fk
            REFERENCES faculty ( fcode ),
    ccode VARCHAR2(5)
        CONSTRAINT course_faculty_ccode_fk
            REFERENCES courses ( ccode ),
    grade CHAR(1)
        CONSTRAINT course_faculty_grade_chk CHECK ( upper(grade) IN ( 'A', 'B', 'C' ) ),
    CONSTRAINT course_faculty_pk PRIMARY KEY ( ccode,
                                               fcode )
);

CREATE TABLE batches (
    bcode   VARCHAR2(5)
        CONSTRAINT batches_pk PRIMARY KEY,
    ccode   VARCHAR2(5)
        CONSTRAINT batches_ccode_fk
            REFERENCES courses ( ccode ),
    fcode   VARCHAR2(5)
        CONSTRAINT baches_fcode_fk
            REFERENCES faculty ( fcode ),
    stdate  DATE
        CONSTRAINT batches_stdate_nn NOT NULL,
    enddate DATE,
    timing  NUMBER(1)
        CONSTRAINT batches_timing_chk CHECK ( timing IN ( 1, 2, 3 ) ),
    CONSTRAINT batches_dates_chk CHECK ( stdate <= enddate )
);

CREATE TABLE students (
    rollno NUMBER(5)
        CONSTRAINT students_pk PRIMARY KEY,
    bcode  VARCHAR2(5)
        CONSTRAINT students_bcode_fk
            REFERENCES batches ( bcode ),
    name   VARCHAR2(30),
    gender CHAR(1)
        CONSTRAINT students_gender_chk CHECK ( upper(gender) IN ( 'M', 'F' ) ),
    dj     DATE,
    phone  VARCHAR2(10),
    email  VARCHAR2(30)
);

CREATE TABLE payments (
    rollno NUMBER(5)
        CONSTRAINT payments_rollno_fk
            REFERENCES students ( rollno ),
    dp     DATE
        CONSTRAINT payments_dp_nn NOT NULL,
    amount NUMBER(5)
        CONSTRAINT payments_amount_chk CHECK ( amount > 0 ),
    CONSTRAINT payments_pk PRIMARY KEY ( rollno,
                                         dp )
);
insert into courses values('ora','Oracle database',25,4500,'Windows'); 
insert into courses values('vbnet','VB.NET',30,5500,'Windows and  programming'); 
insert into courses values('c','C programming',20,3500,'Computer Awareness'); 
insert into courses values('asp','ASP.NET',25,5000,'Internet and programming'); 
insert into courses values('java','Java Language',25,4500,'C language'); 
insert into courses values('xml','XML Programming', 15, 4000, 'HTML,Scripting, ASP/JSP'); 
insert into faculty values('gk','George Koch','MS Computer Science','15 years with databases');
insert into faculty values('da','Dan Appleman','CS and EE graduate', 'Extensively worked with COM'); 
insert into faculty values('hs','Herbert Schildt','MS Computer Science', 'Author of several books'); 
insert into faculty values('dh','David Hunter','MS Electronics', 'Extensively worked with Internet Tehnologees'); 
insert into faculty values('sw','Stephen Walther','Ph.D. in Philosophy', 'Extensively worked with Internet Tehnologees'); 
insert into faculty values('kl','Kevin Loney', 'MS Eletronics', 'Specialized in Oracle DBA'); 
insert into faculty values('jj','Jamie Jaworski','Bachlors of Electrical' ,'Developed programs for US defense department'); 
insert into faculty values('jc','Jason Couchman','OCP DBA','Published articles on Oracle'); 
 insert into course_faculty values('gk','ora','A'); 
insert into course_faculty values('kl','ora','A'); 
insert into course_faculty values('jc','ora','A'); 
insert into course_faculty values('da','vbnet','A'); 
insert into course_faculty values('sw','asp','A'); 
insert into course_faculty values('da','asp','B'); 
insert into course_faculty values('hs','c','A'); 
insert into course_faculty values('dh','xml','A'); 
insert into course_faculty values('jj','java','A'); 
insert into course_faculty values('hs','java','B'); 
insert into course_faculty values('jj','c','A'); 
insert into course_faculty values('jj','vbnet','B');
insert into batches values('b1','ora','gk','12-jan-2001','20-feb-2001', 1); 
insert into batches values('b2','asp','da','15-jan-2001','5-mar-2001', 2); 
insert into batches values ('b3','c','hs','20-jan-2001','27-feb-2001',3); 
insert into batches values ('b4','xml','dh','2-mar-2001','30-mar-2001', 3); 
insert into batches values ('b5','java','hs','5-apr-2001','10-may-2001', 1); 
insert into batches values ('b6','vbnet','da','12-july-2001',null,1); 
insert into batches values ('b7','ora','jc','15-aug-2001',null,2); 
insert into students values (1,'b1','George Micheal','m','10-jan-2001', '488333','gm@yahoo.com'); 
insert into students values (2,'b1','Micheal Douglas','m','11-jan-2001', '334333','md@hotmail.com'); 
insert into students values (3,'b2','Andy Roberts','m','11-jan-2001', '433554','ar@yahoo.com'); 
insert into students values (4,'b2','Malcom Marshall','m','16-jan-2001', '653345','mm@usa.net'); 
insert into students values (5,'b2','Vivan Richards','m','16-jan-2001', '641238','vr@yahoo.com'); 
insert into students values (6,'b3','Chirs Evert','f','14-jan-2001', null,'ce@yahoo.com'); 
insert into students values (7,'b3','Ivan Lendal','m','15-jan-2001', '431212','il@hotmail.com'); 
insert into students values (8,'b4','George Micheal','m','1-mar-2001', '488333','gm@hotmail.com');
insert into students values (9,'b5','Richard Marx','m','6-apr-2001', '876567','rm@hotmail.com'); 
insert into students values (10,'b5','Tina Turner','f','6-apr-2001', '565678','tinat@hotmail.com'); 
insert into students values (11,'b5','Jody Foster','f','7-apr-2001', '234344','jody@hotmail.com'); 
insert into payments values (1,'10-jan-2001',4500); 
insert into payments values (2,'11-jan-2001',3500);
 insert into payments values (2,'17-jan-2001',1000); 
insert into payments values (3,'13-jan-2001',2000); 
insert into payments values (3,'20-jan-2001',3000); 
insert into payments values (4,'16-jan-2001',3000); 
insert into payments values (4,'30-jan-2001',2000); 
insert into payments values (5,'16-jan-2001',5000); 
insert into payments values (6,'14-jan-2001',3500); 
insert into payments values (7,'15-jan-2001',3500); 
insert into payments values (8,'1-mar-2001',2000);
 insert into payments values (8,'2-mar-2001',2000); 
insert into payments values (9,'7-apr-2001',3000); 
insert into payments values (10,'10-apr-2001',4500); 
insert into payments values (11,'7-apr-2001',1000); 
insert into payments values (11,'10-apr-2001',3500); 
  
commit;


SELECT * from students;

SELECT Name from courses;

--dummy data
insert into faculty values('pa','Dua Qadeer','BS and MS graduate', 'Extensively worked with DBMS'); 
-- facult code 'pa' won't show in data
SELECT *
FROM batches
natural join faculty;

--dummy data
insert into batches values ('b8','java',null,'5-apr-2011','10-may-2011', 3);
--this batch does not exist
SELECT *
FROM faculty
natural join batches;

Select bcode
from batches
inner join faculty 
on batches.fcode = faculty.fcode
where faculty.name ='David Hunter';

select bcode
from batches
where ccode='c';

select distinct students.name,faculty.name
from students,faculty; 

insert into faculty values('WS','warda syed','MS Computer Science','23 years with databases');
insert into students values (12,'b8','warda syed','f','7-may-2000', '123456','hash@hotmail.com');
SELECT DISTINCT
    students.name
FROM
    students,
    faculty
WHERE
    students.name = faculty.name;


SELECT DISTINCT
    faculty.name
FROM
    faculty
MINUS
SELECT DISTINCT
    students.name
FROM
    students,
    faculty
WHERE
    students.name = faculty.name;
   
SELECT
    faculty.fcode
FROM
    faculty 
    minus
Select fcode
from(
        SELECT
            faculty.fcode,
            courses.ccode
        FROM
            courses
            CROSS JOIN faculty
        MINUS
        (SELECT
            fcode,
            ccode
        FROM
            course_faculty)
    );
    
select name from students where dj>'1 march 2001'; 


select bcode from batches where enddate is null;



select students.name
from students
minus
select faculty.name
from faculty;

select students.name
from students
union
select faculty.name
from faculty;

select *
from batches
full outer join students
on students.bcode=batches.bcode;

select rollno, name
from students
where bcode='b2';

--??_bcode (??_(Timing=1) (Batches)) ? ?_(Rollno,Name) (Students) 
select batches.bcode, students.rollno, students.name
from
batches
inner join students on students.bcode=batches.bcode
AND batches.timing =1;

select batches.bcode, students.rollno, students.name
from
batches
left outer join students on students.bcode=batches.bcode
AND batches.timing =1;

select batches.bcode, students.rollno, students.name
from
batches
full outer join students on students.bcode=batches.bcode
AND batches.timing =1;








