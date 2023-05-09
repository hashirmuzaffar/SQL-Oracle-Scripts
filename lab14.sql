CREATE TABLE suppliers (
    sid     INT PRIMARY KEY,
    sname   VARCHAR2(50),
    address VARCHAR2(50)
);

CREATE TABLE parts (
    pid   INT PRIMARY KEY,
    pname VARCHAR2(50),
    color VARCHAR2(50)
);

CREATE TABLE catalog (
    sid  INT,
    pid  INT,
    cost Float,
    FOREIGN KEY ( sid )
        REFERENCES suppliers ( sid ),
    FOREIGN KEY ( pid )
        REFERENCES parts ( pid ),
    PRIMARY KEY ( sid,
                  pid )
);

drop table catalog;

INSERT INTO suppliers
values(1234,'Jhon','104th Street newland, London');
INSERT INTO suppliers
values(2233,'Marry','Street 6 foundersland, Canada');
INSERT INTO suppliers
values(2281,'ALi','Ku road 556, Karachi');
INSERT INTO suppliers
values(2345,'Hopkins','House 11122 Street 67 joyLand, London');
INSERT INTO suppliers
values(9034,'Alvi','Comission 5, 45th street, India');
INSERT INTO suppliers
values(3498,'Habib','USS, 687 into you house, Riyad');
INSERT INTO suppliers
values(1111,'Habib','USS, 687 into you house, Riyad');

INSERT into parts
values(80,'pedal','pink');
INSERT into parts
values(23,'pedal','red');
INSERT into parts
values(24,'pedal','green');
INSERT into parts
values(25,'pedal','black');
INSERT into parts
values(30,'chair','red');
INSERT into parts
values(31,'Mouse','Brown');
INSERT into parts
values(32,'Chair','Pink');
INSERT into parts
values(33,'Table','orange');
INSERT into parts
values(35,'hammer','red');
INSERT into parts
values(36,'table','Brown');
INSERT into parts
values(37,'bottle','white');
INSERT into parts
values(38,'Table','grey');

INSERT into catalog
values(1234,23,34.56);
INSERT into catalog
values(1234,24,56.89);
INSERT into catalog
values(1234,38,34);
INSERT into catalog
values(1234,25,54.56);
INSERT into catalog
values(2281,23,34.00);
INSERT into catalog
values(2281,37,90.50);
INSERT into catalog
values(2281,38,67.59);
INSERT into catalog
values(2345,30,67.92);
INSERT into catalog
values(2345,31,50.90);
INSERT into catalog
values(2345,32,87.67);
INSERT into catalog
values(9034,23,89.00);
INSERT into catalog
values(9034,37,23.50);
INSERT into catalog
values(3498,25,44.40);
INSERT into catalog
values(3498,33,19.50);
INSERT into catalog
values(3498,30,36.59);
INSERT into catalog
values(2233,25,92.54);
INSERT into catalog
values(2233,35,98.89);
INSERT into catalog
values(2233,24,78.89);
INSERT into catalog
values(2233,36,32.12);
INSERT into catalog
values(1111,80,328.12);
INSERT into catalog
values(1111,23,328.12);
INSERT into catalog
values(1111,24,328.12);
INSERT into catalog
values(1111,25,328.12);
INSERT into catalog
values(1111,30,328.12);
INSERT into catalog
values(1111,31,328.12);
INSERT into catalog
values(1111,32,328.12);
INSERT into catalog
values(1111,33,328.12);
INSERT into catalog
values(1111,35,328.12);
INSERT into catalog
values(1111,36,328.12);
INSERT into catalog
values(1111,37,328.12);
INSERT into catalog
values(1111,38,328.12);
INSERT into catalog
values(3498,23,44.40);
INSERT into catalog
values(3498,35,44.40);
INSERT into catalog
values(3498,32,444.40);
--Find the names of suppliers who supply some red part.
SELECT
    suppliers.sname
FROM
    suppliers
    INNER JOIN catalog ON suppliers.sid = catalog.sid
    INNER JOIN parts ON parts.pid = catalog.pid
WHERE
    parts.color = 'red';

--Find the sids of suppliers who supply some grey part or are at USS, 687 into you house, Riyad.
SELECT DISTINCT
    suppliers.sid
FROM
    suppliers
    INNER JOIN catalog ON suppliers.sid = catalog.sid
    INNER JOIN parts ON parts.pid = catalog.pid
WHERE
    parts.color = 'grey'
    OR suppliers.address = 'USS, 687 into you house, Riyad';

--Find the sids of suppliers who supply some red part and some green part.    
SELECT
    distinct suppliers.sid
FROM
    suppliers
    INNER JOIN catalog ON suppliers.sid = catalog.sid
    INNER JOIN parts ON parts.pid = catalog.pid
WHERE
    parts.color = 'green'
    OR parts.color = 'red';

-- Find the sids of suppliers who supply every part.
SELECT
    suppliers.sid
FROM
    suppliers
MINUS
SELECT
    sid
FROM
    (
        SELECT
            suppliers.sid,
            parts.pid
        FROM
            suppliers
            NATURAL JOIN parts
        MINUS
        SELECT
            sid,
            pid
        FROM
            catalog
    );
    
--Find the sids of suppliers who supply every red part.    
SELECT
    suppliers.sid
FROM
    suppliers
MINUS
SELECT
    sid
FROM
    (
        SELECT
            suppliers.sid,
            parts.pid,
            parts.color
        FROM
            suppliers
            NATURAL JOIN parts
        MINUS
        SELECT
            catalog.sid,
            catalog.pid,
            parts.color
        FROM
            catalog
            INNER JOIN parts ON parts.pid = catalog.pid
    )
WHERE
    color = 'red';

--Find the sids of suppliers who supply every red part or every green part.    
SELECT
    suppliers.sid
FROM
    suppliers
MINUS
SELECT
    sid
FROM
    (
        SELECT
            suppliers.sid,
            parts.pid,
            parts.color
        FROM
            suppliers
            NATURAL JOIN parts
        MINUS
        SELECT
            catalog.sid,
            catalog.pid,
            parts.color
        FROM
            catalog
            INNER JOIN parts ON parts.pid = catalog.pid
    )
WHERE
    color = 'red'
    OR color = 'green';

--Find the pids of parts supplied by at least two different suppliers.
SELECT
    pid
FROM
    (
        SELECT
            pid,
            COUNT(*) count
        FROM
            catalog
        GROUP BY
            pid
    )
WHERE
    count >= 2;

-- Find the pids of the most expensive parts supplied by suppliers named Habib
SELECT
    pid     
FROM
    catalog
    INNER JOIN suppliers ON catalog.sid = suppliers.sid
WHERE
    suppliers.sname = 'Habib'
                   AND Catalog.cost= 
                        (SELECT
                            max(cost)  
                        FROM
                            catalog
                            INNER JOIN suppliers ON catalog.sid = suppliers.sid
                        WHERE
                            suppliers.sname = 'Habib'); 












    
    
    
    
    
    
