
--Task 1: Display details of first 5 highly paid employees using cursors.

DECLARE 
   details employee%rowtype;
   CURSOR highly_paid is 
      SELECT * FROM employee order by ANNUALSALARY desc; 
BEGIN 
--open cursor
   OPEN highly_paid;
   LOOP 
--fetch cursor
   FETCH highly_paid into details; 
      dbms_output.put_line(details.eeid || ' ' || details.fullname || ' ' || details.jobtitle || ' ' || details.gender || ' ' || details.age || ' ' || details.city || ' ' || details.annualsalary); 
      EXIT WHEN highly_paid%rowcount = 5; 
   END LOOP; 
--close cursor
   CLOSE highly_paid;
END; 

--Task 2: Write a query to find the details of those employee who have same job using cursor
DECLARE
    details employee%rowtype;
    CURSOR job_cursor (job employee.jobtitle%type)
    IS
        SELECT *
        FROM employee
        WHERE jobtitle=job;
BEGIN
    OPEN job_cursor('Manager');
    LOOP
        FETCH job_cursor INTO details;
        EXIT WHEN job_cursor%notfound;
        dbms_output.put_line(details.eeid || ' ' || details.fullname || ' ' || details.jobtitle || ' ' || details.gender || ' ' || details.age || ' ' || details.city || ' ' || details.annualsalary); 
    END LOOP;
    CLOSE job_cursor;
END;
