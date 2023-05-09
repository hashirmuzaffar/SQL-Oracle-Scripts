CREATE TABLE Customer (
    Customer_No int NOT NULL,
    Customer_Name varchar(255) NOT NULL,
    Customer_Address varchar(255),
    Customer_Cat CHAR CHECK (Customer_Cat = 'S' OR Customer_Cat= 'B' OR Customer_Cat= 'G' OR Customer_Cat= 'P'),
    Customer_Description varchar(255),
    Customer_Discount int,
    Primary key(Customer_no)
);

CREATE TABLE Painting (
    Painting_No int NOT NULL,
    Painting_Title varchar(255) NOT NULL,
    Painting_Theme varchar(255),
    Primary key(Painting_no)
);

CREATE TABLE Rental_Report (
    Customer_No int NOT NULL,
    Painting_No int NOT NULL,
    Date_of_Hire DATE NOT NULL,
    Date_due_back DATE NOT NULL, 
    Returned CHAR CHECK (Returned= 'Y' OR Returned= 'N'),
    Foreign key(Customer_No) REFERENCES Customer(Customer_No),
    Foreign key(Painting_No) REFERENCES Painting(Painting_No),
    Primary key(Customer_No,Painting_No)
);

CREATE TABLE Artist (
    Artist_No int NOT NULL,
    Artist_Name varchar(255) NOT NULL,
    Country_of_birth varchar(255),
    Year_of_birth int,
    Year_of_death int,
    Age int,
    Primary key(Artist_no)
);

CREATE TABLE Owner (
    Owner_No int NOT NULL,
    Owner_Name varchar(255) NOT NULL,
    Owner_Address varchar(555),
    Onwer_telephone int,
    Primary key(Owner_no)
);

CREATE TABLE Artist_report (
    Painting_No int NOT NULL,
    Artist_No int NOT NULL,
    Owner_No int NOT NULL,
    Price int NOT NULL,
    Foreign key(Owner_No) REFERENCES Owner(Owner_No),
    Foreign key(Artist_No) REFERENCES Artist(Artist_No),
    Foreign key(Painting_No) REFERENCES Painting(Painting_No),
    Primary key(Artist_No,Painting_No)
);

CREATE TABLE Return_owner (
    Painting_No int NOT NULL,
    Owner_No int NOT NULL,
    Return_date DATE NOT NULL,
    Foreign key(Owner_No) REFERENCES Owner(Owner_No),
    Foreign key(Painting_No) REFERENCES Painting(Painting_No),
    Primary key(Owner_No,Painting_No)
);

CREATE TABLE Owner_report(
    Painting_No int NOT NULL,
    Owner_No int NOT NULL,
    Foreign key(Owner_No) REFERENCES Owner(Owner_No),
    Foreign key(Painting_No) REFERENCES Painting(Painting_No),
    Primary key(Owner_No,Painting_No)
);

CREATE TABLE painting_price(
Painting_No int NOT NULL,
Price int NOT NULL,
Foreign key(Painting_No) REFERENCES Painting(Painting_No)
);

DROP TABLE painting_rented;

CREATE TABLE painting_rented(
Painting_No int NOT NULL,
available char NOT NULL,
Foreign key(Painting_No) REFERENCES Painting(Painting_No)
);

CREATE TABLE last_rented(
Painting_No int NOT NULL,
rent_date DATE NOT NULL,
Foreign key(Painting_No) REFERENCES Painting(Painting_No)
);

INSERT INTO Painting VALUES(22816,'One Life','Animal');
INSERT INTO Painting VALUES(22817,'Hell Fire','Still-life');
INSERT INTO Painting VALUES(22818,'Dark Horse','Naval');
INSERT INTO Painting VALUES(22819,'Friday Night','Animal');
INSERT INTO Painting VALUES(22820,'Blank Space','Landscape');
INSERT INTO Painting VALUES(22821,'Bad Blood','potrait');
INSERT INTO Painting VALUES(22822,'Talash','potrait');
INSERT INTO Painting VALUES(22823,'Weekending','seascape');
INSERT INTO Painting VALUES(22824,'Boom Clap','Landscape');

INSERT INTO Artist VALUES(31205,'Katty Perry','Canada',1956,2000,44);
INSERT INTO Artist VALUES(41205,'HassanRoshaan','Iraq',1890,1990,100);
INSERT INTO Artist VALUES(51205,'Drake','Italy',1900,1956,56);
INSERT INTO Artist VALUES(61205,'Tailor Swift','France',1920,1985,65);


INSERT INTO Owner VALUES(1001,'Hashir','104/A Bahawalpur',03004567890);
INSERT INTO Owner VALUES(1002,'Sadia','5th avenue Aladin',03334767790);
INSERT INTO Owner VALUES(1003,'Bilal','800 800 Baheria ISB',03001264564);
INSERT INTO Owner VALUES(1004,'Arham','48th Street Bakers England',03450089760);
INSERT INTO Owner VALUES(1005,'Muhsham','Lovers lane, 890, floor 5, KSA',0389676780);
INSERT INTO Owner VALUES(1006,'Dua','New Kape Town, Hulahoop',03229078563);

INSERT INTO artist_report VALUES(22816,31205,1001,299);
INSERT INTO artist_report VALUES(22817,31205,1002,199);

INSERT INTO Customer VALUES(123,'David James','She Street 5th Apartment','S','XYZ',5);

INSERT INTO rental_report VALUES(123,22816,'12-may-2022','12-dec-2022','N');
INSERT INTO rental_report VALUES(123,22817,'11-may-2022','11-dec-2022','N');

INSERT INTO Return_owner VALUES(22820,1006,'22-dec-2022');

CREATE OR REPLACE PROCEDURE artist_report_show(num int) IS
    Cursor simple_cursor is 
        SELECT * FROM artist_report
        WHERE Artist_No = num;
    paint Painting%ROWTYPE;
    own Owner%ROWTYPE;
    art Artist%ROWTYPE;
    temp artist_report%ROWTYPE;
Begin
    SELECT * INTO art
    FROM Artist
    WHERE Artist_No = num;
    dbms_output.put_line('Artist No: '|| art.Artist_No || ' Year of Birth: '|| art.Year_of_birth || ' Artist Age: '|| art.age);  
    dbms_output.put_line('Artist Name: '|| art.Artist_Name ||  ' Year of Death: '|| art.Year_of_death );  
    dbms_output.put_line('Country of Birth: '|| art.Country_of_Birth);
    dbms_output.put_line('Painting No '||'Painting Title '||'Theme '||'Rental Price '||'Owner no '||'Owner Name '||'Owner Tel' );  
    Open simple_cursor;
    Loop
        Fetch simple_cursor into temp;
        Exit when simple_cursor%NOTFOUND;
         SELECT *  INTO paint
         FROM Painting
         WHERE Painting_No = temp.Painting_No;
         SELECT * INTO own
         FROM Owner
         WHERE Owner_No = temp.Owner_No;
        dbms_output.put_line(paint.Painting_No ||' '|| paint.Painting_Title||' '||paint.Painting_Theme ||' '|| temp.price ||'$ '|| own.Owner_No ||' '|| own.Owner_Name ||' '||own.Onwer_telephone);    
    END LOOP;
    Close simple_cursor;
END;

CREATE OR REPLACE FUNCTION display_artist_details(num int) RETURN VARCHAR IS
    output  VARCHAR(32767);
    art Artist%ROWTYPE;
    begin
SELECT * INTO art
    FROM Artist
    WHERE Artist_No = num;
    output:=   'Artist No: '|| art.Artist_No
               ||'_Artist Name: '|| art.Artist_Name
               ||'_Country of Birth: '|| art.Country_of_Birth
                || '_Year of Birth: '|| art.Year_of_birth
                ||  '_Year of Death: '|| art.Year_of_death 
                ||'_Artist Age: '|| art.age;
                return output;
                end;

CREATE OR REPLACE FUNCTION artist_report_view(num int) RETURN VARCHAR IS
    output  VARCHAR(32767);
    Cursor simple_cursor is 
        SELECT * FROM artist_report
        WHERE Artist_No = num;
    paint Painting%ROWTYPE;
    own Owner%ROWTYPE;
    temp artist_report%ROWTYPE;
Begin     
   -- dbms_output.put_line('Painting No '||'Painting Title '||'Theme '||'Rental Price '||'Owner no '||'Owner Name '||'Owner Tel' );  
    Open simple_cursor;
    Loop
        Fetch simple_cursor into temp;
        Exit when simple_cursor%NOTFOUND;
         SELECT *  INTO paint
         FROM Painting
         WHERE Painting_No = temp.Painting_No;
         SELECT * INTO own
         FROM Owner
         WHERE Owner_No = temp.Owner_No;
        output:= output||'_'||paint.Painting_No ||' '|| paint.Painting_Title||' '||paint.Painting_Theme ||' '|| temp.price ||'$ '|| own.Owner_No ||' '|| own.Owner_Name ||' '||own.Onwer_telephone;    
    END LOOP;
    Close simple_cursor;
    return output;
END;


CREATE OR REPLACE PROCEDURE customer_report_show(num int) IS
    Cursor simple_cursor_2 is 
        SELECT * FROM rental_report
        WHERE Customer_No = num;
    paint Painting%ROWTYPE;
    cust Customer%ROWTYPE;
    temp rental_report%ROWTYPE;
Begin
    SELECT * INTO cust
    FROM Customer
    WHERE Customer_No = num;
    dbms_output.put_line('Customer No: '|| cust.Customer_No || ' Customer Category: '|| cust.Customer_cat); 
    dbms_output.put_line('Customer Name: '|| cust.Customer_Name ||  ' Category Description: '|| cust.Customer_Description);  
    dbms_output.put_line('Customer Address: '|| cust.Customer_Address || 'Category Discount '||cust.Customer_Discount);
    dbms_output.put_line('Painting No '||'Painting Title '||'Painting Theme '||'Date of Hire '||'Due Date '||'Returned' );  
    Open simple_cursor_2;
    Loop
        Fetch simple_cursor_2 into temp;
        Exit when simple_cursor_2%NOTFOUND;
         SELECT *  INTO paint
         FROM Painting
         WHERE Painting_No = temp.Painting_No;
        dbms_output.put_line(paint.Painting_No ||' '|| paint.Painting_Title||' '||paint.Painting_Theme ||' '|| temp.Date_of_hire ||' '|| temp.Date_due_back ||' '|| temp.Returned);    
    END LOOP;
    Close simple_cursor_2;
END;

CREATE OR REPLACE PROCEDURE return_to_owner(n1 int, n2 int, d date) IS
BEGIN
INSERT INTO return_owner VALUES(n1,n2,d);
END;

CREATE OR REPLACE TYPE output  IS
    VARRAY(50) OF VARCHAR(32766);

CREATE OR REPLACE FUNCTION display_customer_details(num int) RETURN varchar IS
   cust Customer%ROWTYPE;
   output varchar(32767);
    Begin
    SELECT * INTO cust
    FROM Customer
    WHERE Customer_No = num;
    output := '..Customer No: '|| cust.Customer_No
    || '....Customer Category: '|| cust.Customer_cat
     || '....Customer Name: '|| cust.Customer_Name 
      ||'....Category Description: '|| cust.Customer_Description
     ||'....Customer Address: '|| cust.Customer_Address
     ||'....Category Discount '||cust.Customer_Discount;
    return output;
    END;

CREATE OR REPLACE FUNCTION customer_report_view(num int) RETURN String IS
output STRING(32767);
    Cursor simple_cursor_2 is 
        SELECT * FROM rental_report
        WHERE Customer_No = num;
    paint Painting%ROWTYPE;
    cust Customer%ROWTYPE;
    temp rental_report%ROWTYPE;
Begin
--out_(7):= 'Painting No '||' Painting Title '||' Painting Theme '||' Date of Hire '||' Due Date '||' Returned ';  
    Open simple_cursor_2;
    Loop
        Fetch simple_cursor_2 into temp;
        Exit when simple_cursor_2%NOTFOUND;
         SELECT *  INTO paint
         FROM Painting
         WHERE Painting_No = temp.Painting_No;
        output:= output||'_'||+paint.Painting_No ||' '|| paint.Painting_Title||' '||paint.Painting_Theme ||' '|| temp.Date_of_hire ||' '|| temp.Date_due_back ||' '|| temp.Returned; 
        --c:=c+1;
    END LOOP;
    Close simple_cursor_2;
    return output;
END;

CREATE OR REPLACE PROCEDURE return_to_owner(n1 int, n2 int) IS
BEGIN
INSERT INTO return_owner VALUES(n1,n2,SYSDATE);
END;

CREATE OR REPLACE PROCEDURE del_return_to_owner(n1 int, n2 int) IS
BEGIN
DELETE 
FROM return_owner
WHERE painting_no=n1 AND owner_no=n2;
END;

CREATE OR REPLACE FUNCTION display_owner_details(num int) RETURN VARCHAR IS
own Owner%ROWTYPE;
output varchar(32767);
BEGIN
SELECT * INTO own
FROM Owner
WHERE Owner_No=num;
output := '_Owner No '|| own.Owner_No ||'_Owner_Name '|| own.Owner_Name 
 || '_Owner Address '|| own.Owner_Address;
--'Painting No'||'Painting Title'||'Return Date';
return output;
END;

CREATE OR REPLACE FUNCTION owner_return_view(num int) RETURN VARCHAR IS
output varchar(32767);
Cursor simple_cursor_3 is
    SELECT * FROM return_owner
    WHERE Owner_No=num;
temp Return_owner%ROWTYPE;
paint Painting%ROWTYPE;
BEGIN
LOOP
OPEN simple_cursor_3;
FETCH simple_cursor_3 into temp;
        Exit when simple_cursor_3%NOTFOUND;
         SELECT *  INTO paint
         FROM Painting
         WHERE Painting_No = temp.Painting_No;
        output := output ||'_'|| paint.Painting_No ||' '|| paint.Painting_Title||' '||temp.Return_date;
END LOOP;
CLOSE simple_cursor_3;
return output;
END;


CREATE OR REPLACE PROCEDURE add_artist(no int,name artist.Artist_Name%TYPE,country artist.Country_of_birth%TYPE,YOB artist.year_of_birth%TYPE, YOD varchar) IS
BEGIN
IF YOD IS NULL THEN
INSERT INTO Artist VALUES(no,name,country,YOB,CAST((YOD)AS INT),CAST(((EXTRACT(YEAR FROM SYSDATE)-YOB)) AS INT));
ELSE
INSERT INTO Artist VALUES(no,name,country,YOB,YOD,CAST(((YOD-YOB)) AS INT));
END IF;
END;

CREATE OR REPLACE PROCEDURE add_owner(no int,name Owner.Owner_Name%TYPE,address Owner.Owner_Address%TYPE,age Owner.Onwer_telephone%TYPE) IS
BEGIN
INSERT INTO OWNER VALUES(no,name,address,age);
END;

CREATE OR REPLACE PROCEDURE add_painting(n1 int,no int,title painting.Painting_Title%TYPE,theme painting.Painting_Theme%TYPE, price painting_price.price%TYPE, own int) IS
BEGIN
INSERT INTO Painting VALUES(no,title,theme);
INSERT INTO painting_price VALUES(no,price);
INSERT INTO Owner_report VALUES(no,own);
INSERT INTO painting_rented VALUES(no,'Y');
INSERT INTO artist_report VALUES(no,n1,own,price);--painting artist owner price
END;



CREATE OR REPLACE PROCEDURE return_painting(n1 int, n2 int) IS
BEGIN 
    UPDATE painting_rented 
    SET available ='Y'
    WHERE Painting_No = n2;
    UPDATE rental_report 
    SET returned ='Y'
    WHERE Painting_No = n2;
END;

CREATE OR REPLACE PROCEDURE add_owner(no int,name Owner.Owner_Name%TYPE,address Owner.Owner_address%TYPE,tel Owner.Onwer_telephone%TYPE) IS
BEGIN
INSERT INTO Owner VALUES(no,name,address,tel);
END;

CREATE OR REPLACE PROCEDURE add_customer(no int,name CUstomer.customer_Name%TYPE,address customer.customer_address%TYPE,cat Customer.Customer_Cat%TYPE) IS
BEGIN
IF cat = 'B' THEN
INSERT INTO Customer VALUES(no,name,address,cat,'BRONZE',0);
ELSIF cat = 'S' THEN
INSERT INTO Customer VALUES(no,name,address,cat,'SILVER',5);
ELSIF cat = 'G' THEN
INSERT INTO Customer VALUES(no,name,address,cat,'GOLD',25);
ELSIF cat = 'P' THEN
INSERT INTO Customer VALUES(no,name,address,cat,'PLATINIUM',50);
END IF;
END;

CREATE OR REPLACE PROCEDURE add_artist_report(n1 int, n2 int,n3 int) IS
pp int;
BEGIN
SELECT Price INTO pp
FROM Painting_price
WHERE Painting_No = n1;
INSERT INTO artist_report VALUES(n1,n2,n3,pp);
END;

CREATE OR REPLACE FUNCTION IsReturned (
    p_no INT
) RETURN CHAR IS
    pp CHAR := 'N';
    c  INT:=0;
BEGIN
    SELECT
        COUNT(*)
    INTO c
    FROM
        return_owner
    WHERE
        painting_no = p_no;

    IF c >= 1 THEN
    pp := 'Y';
    return pp;
    ELSE
    pp := 'N';
    return pp;
    END IF;
END;

CREATE OR REPLACE FUNCTION eligble_to_ReHire (
    p_no INT
) RETURN CHAR IS
ppp CHAR;
pp CHAR := 'K';
temp return_owner%ROWTYPE;
BEGIN
ppp:= IsReturned(p_no);
if ppp='Y' then
SELECT *
INTO temp
FROM return_owner
WHERE painting_no = p_no;
pp := sol2(temp.return_date);
END IF;
return pp;
END;




CREATE OR REPLACE FUNCTION check_avail (
    p_no INT
) RETURN CHAR IS
    pp CHAR := 'Y';
    c  INT;
BEGIN
    SELECT
        COUNT(*)
    INTO c
    FROM
        painting_rented
    WHERE
        painting_no = p_no;

    IF c >= 1 THEN
        SELECT
            available
        INTO pp
        FROM
            painting_rented
        WHERE
            painting_no = p_no;

    ELSE
        INSERT INTO painting_rented VALUES (
            p_no,
            'N'
        );

    END IF;

    RETURN pp;
END;

CREATE OR REPLACE PROCEDURE rent_painting(n1 int, n2 int, d2 date) IS
BEGIN
    INSERT INTO rental_report VALUES(n1,n2,SYSDATE,d2,'N');
    UPDATE painting_rented 
    SET available ='N'
    WHERE Painting_No = n2;
    last_date(n2,SYSDATE);
END;

CREATE OR REPLACE PROCEDURE last_date(i int, d date) IS
CURSOR sc IS
SELECT * 
FROM last_rented
WHERE Painting_No = i;
BEGIN
OPEN sc;
IF sc%NOTFOUND then
    INSERT INTO last_rented VALUES(i,d);
ELSIF sc%FOUND then
    UPDATE last_rented
    SET rent_date = d
    WHERE painting_No = i;
END IF;
CLOSE sc;
END;


CREATE OR REPLACE FUNCTION sol2(d date) 
RETURN CHAR
IS
i int;
BEGIN
i := ((sysdate-d)/30);
IF i>3 THEN
    return 'K';
ELSE 
    return 'R';
END IF;
END;

CREATE OR REPLACE FUNCTION sol(d date) 
RETURN CHAR
IS
i int;
BEGIN
i := ((sysdate-d)/30);
IF i>6 THEN
    return 'D';
ELSE 
    return 'K';
END IF;
END;

--CREATE OR REPLACE TRIGGER availability_null
--AFTER INSERT on rental_report
--REFERENCING NEW AS NEWER
--FOR each row
--BEGIN
--    UPDATE painting_rented 
--    SET available ='N'
--    WHERE Painting_No = NEWER.Painting_no;
--END;







--TODO
--get painting--done
--return paiting--done

--return to owner report
DECLARE
c CHAR;
--temp output := output();
BEGIN
--add_artist(91205,'Jhoon Rahim','Pakistan',1950,null);
--add_owner(1009,'Maliha','Gulshan e iqbal',03004567829);
--add_painting(71205,22851,'Hallow Area','landscape',250,1003);
--add_customer(421,'David beckman','haha street 5 and 6','G');
--rent_painting(321,22816,SYSDATE,'21-jan-23');
--c:=check_avail(22817);
--IF c='Y' THEN
--rent_painting(908,22817,'21-jan-23');
--ELSE
--temp := customer_report_view(908);
dbms_output.put_line(OWNER_RETURN_VIEW(1006));
--dbms_output.put_line('hashir'||'\n'||'muzaffar');
--END IF;
--return_painting(321,22850);
--customer_report_show(321);
--artist_report_show(31205);
--return_to_owner(22817,1002,SYSDATE);
--owner_return_show(1002);
END;






