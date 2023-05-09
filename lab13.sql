/* Delete the tables if they already exist */
--drop table Person;
--drop table Frequents;
--drop table Eats;
--drop table Serves;

/* Create the schema for our tables */
CREATE TABLE person (
    name   VARCHAR(20) NOT NULL,
    age    INTEGER NOT NULL,
    gender VARCHAR(20) NOT NULL CHECK ( gender = 'male'
                                        OR gender = 'female' )
);

CREATE TABLE frequents (
    name     VARCHAR(20),
    pizzeria VARCHAR(20) CHECK ( pizzeria = 'Pizza Hut'
                                 OR pizzeria = 'Straw Hat'
                                 OR pizzeria = 'New York Pizza'
                                 OR pizzeria = 'Chicago Pizza'
                                 OR pizzeria = 'Dominos'
                                 OR pizzeria = 'Little Caesars' )
);

CREATE TABLE eats (
    name  VARCHAR(20),
    pizza VARCHAR(20) CHECK ( pizza = 'pepperoni'
                              OR pizza = 'mushroom'
                              OR pizza = 'cheese'
                              OR pizza = 'sausage' )
);

CREATE TABLE serves (
    pizzeria VARCHAR(20) CHECK ( pizzeria = 'Pizza Hut'
                                 OR pizzeria = 'Straw Hat'
                                 OR pizzeria = 'New York Pizza'
                                 OR pizzeria = 'Chicago Pizza'
                                 OR pizzeria = 'Dominos'
                                 OR pizzeria = 'Little Caesars' ),
    pizza    VARCHAR(20) CHECK ( pizza = 'pepperoni'
                              OR pizza = 'mushroom'
                              OR pizza = 'cheese'
                              OR pizza = 'sausage' ),
    price    DECIMAL
);

--List the name, gender of the customer along with the pizza they eat
SELECT
    name,
    gender,
    pizza
FROM
    person
    NATURAL JOIN eats;


--List the name and age of all the people who eat sausage pizza
SELECT
    name,
    gender
FROM
    person
    NATURAL JOIN eats
WHERE
    pizza = 'sausage';

--. Find the names and gender of all people who eat mushroom pizza.
SELECT
    name,
    gender
FROM
    person
    NATURAL JOIN eats
WHERE
    pizza = 'mushroom';

--Find all pizzerias frequented by at least one person under the age of 18.
SELECT
    pizzeria
FROM
    frequents
    NATURAL JOIN person
WHERE
    ( age < 18 );


--List the details of a person and the pizza they ate
SELECT
    person.*,
    eats.pizza
FROM
    person
    FULL OUTER JOIN eats ON person.name = eats.name;

--List the details of a customer and the pizza they ate
SELECT
    person.*,
    eats.pizza
FROM
    person
    INNER JOIN eats ON person.name = eats.name;

--7 List the names of pizzeria and its customer which have at least one customer 
SELECT
    distinct frequents.name,
    serves.pizzeria
FROM
    frequents
    INNER JOIN serves ON frequents.pizzeria = serves.pizzeria;

--8 List the names of all pizzeria including those who have no customer
SELECT
    distinct serves.pizzeria
FROM
    frequents
    RIGHT OUTER JOIN serves ON  frequents.pizzeria = serves.pizzeria;

--List the name of all people and pizzeria they go to if any
SELECT
   distinct  person.name,
    frequents.pizzeria
FROM
    person
    FULL OUTER JOIN frequents ON person.name = frequents.name;

--Display the details of the person, frequents, eats and servers using Equii join. 
SELECT
    person.*,
    eats.pizza,
    frequents.pizzeria,
    serves.price
FROM
    person,
    eats,
    frequents,
    serves
WHERE
    person.name = eats.name
    AND person.name = frequents.name
    AND eats.pizza = serves.pizza
    AND frequents.pizzeria = serves.pizzeria;
/* Populate the tables with our data */
INSERT INTO person VALUES (
    'Amy',
    16,
    'female'
);

INSERT INTO person VALUES (
    'Ben',
    21,
    'male'
);

INSERT INTO person VALUES (
    'Cal',
    33,
    'male'
);

INSERT INTO person VALUES (
    'Dan',
    13,
    'male'
);

INSERT INTO person VALUES (
    'Eli',
    45,
    'male'
);

INSERT INTO person VALUES (
    'Fay',
    21,
    'female'
);

INSERT INTO person VALUES (
    'Gus',
    24,
    'male'
);

INSERT INTO person VALUES (
    'Hil',
    30,
    'female'
);

INSERT INTO person VALUES (
    'Ian',
    18,
    'male'
);

INSERT INTO person VALUES (
    'Ian',
    18,
    'male'
);

INSERT INTO person VALUES (
    'John',
    18,
    'male'
);

INSERT INTO frequents VALUES (
    'Amy',
    'Pizza Hut'
);

INSERT INTO frequents VALUES (
    'Ben',
    'Pizza Hut'
);

INSERT INTO frequents VALUES (
    'Ben',
    'Chicago Pizza'
);

INSERT INTO frequents VALUES (
    'Cal',
    'Straw Hat'
);

INSERT INTO frequents VALUES (
    'Cal',
    'New York Pizza'
);

INSERT INTO frequents VALUES (
    'Dan',
    'Straw Hat'
);

INSERT INTO frequents VALUES (
    'Dan',
    'New York Pizza'
);

INSERT INTO frequents VALUES (
    'Eli',
    'Straw Hat'
);

INSERT INTO frequents VALUES (
    'Eli',
    'Chicago Pizza'
);

INSERT INTO frequents VALUES (
    'Fay',
    'Dominos'
);

INSERT INTO frequents VALUES (
    'Fay',
    'Little Caesars'
);

INSERT INTO frequents VALUES (
    'Gus',
    'Chicago Pizza'
);

INSERT INTO frequents VALUES (
    'Gus',
    'Pizza Hut'
);

INSERT INTO frequents VALUES (
    'Hil',
    'Dominos'
);

INSERT INTO frequents VALUES (
    'Hil',
    'Straw Hat'
);

INSERT INTO frequents VALUES (
    'Hil',
    'Pizza Hut'
);

INSERT INTO frequents VALUES (
    'Ian',
    'New York Pizza'
);

INSERT INTO frequents VALUES (
    'Ian',
    'Straw Hat'
);

INSERT INTO frequents VALUES (
    'Ian',
    'Dominos'
);

INSERT INTO eats VALUES (
    'Amy',
    'pepperoni'
);

INSERT INTO eats VALUES (
    'Amy',
    'mushroom'
);

INSERT INTO eats VALUES (
    'Ben',
    'pepperoni'
);

INSERT INTO eats VALUES (
    'Ben',
    'cheese'
);

INSERT INTO eats VALUES (
    'Cal',
    'supreme'
);

INSERT INTO eats VALUES (
    'Dan',
    'pepperoni'
);

INSERT INTO eats VALUES (
    'Dan',
    'cheese'
);

INSERT INTO eats VALUES (
    'Dan',
    'sausage'
);

INSERT INTO eats VALUES (
    'Dan',
    'supreme'
);

INSERT INTO eats VALUES (
    'Dan',
    'mushroom'
);

INSERT INTO eats VALUES (
    'Eli',
    'supreme'
);

INSERT INTO eats VALUES (
    'Eli',
    'cheese'
);

INSERT INTO eats VALUES (
    'Fay',
    'mushroom'
);

INSERT INTO eats VALUES (
    'Gus',
    'mushroom'
);

INSERT INTO eats VALUES (
    'Gus',
    'supreme'
);

INSERT INTO eats VALUES (
    'Gus',
    'cheese'
);

INSERT INTO eats VALUES (
    'Hil',
    'supreme'
);

INSERT INTO eats VALUES (
    'Hil',
    'cheese'
);

INSERT INTO eats VALUES (
    'Ian',
    'supreme'
);

INSERT INTO eats VALUES (
    'Ian',
    'pepperoni'
);

INSERT INTO serves VALUES (
    'Pizza Hut',
    'pepperoni',
    12
);

INSERT INTO serves VALUES (
    'Pizza Hut',
    'sausage',
    12
);

INSERT INTO serves VALUES (
    'Pizza Hut',
    'cheese',
    9
);

INSERT INTO serves VALUES (
    'Pizza Hut',
    'supreme',
    12
);

INSERT INTO serves VALUES (
    'Little Caesars',
    'pepperoni',
    9.75
);

INSERT INTO serves VALUES (
    'Little Caesars',
    'sausage',
    9.5
);

INSERT INTO serves VALUES (
    'Little Caesars',
    'cheese',
    7
);

INSERT INTO serves VALUES (
    'Little Caesars',
    'mushroom',
    9.25
);

INSERT INTO serves VALUES (
    'Dominos',
    'cheese',
    9.75
);

INSERT INTO serves VALUES (
    'Dominos',
    'mushroom',
    11
);

INSERT INTO serves VALUES (
    'Straw Hat',
    'pepperoni',
    8
);

INSERT INTO serves VALUES (
    'Straw Hat',
    'cheese',
    9.25
);

INSERT INTO serves VALUES (
    'Straw Hat',
    'sausage',
    9.75
);

INSERT INTO serves VALUES (
    'New York Pizza',
    'pepperoni',
    8
);

INSERT INTO serves VALUES (
    'New York Pizza',
    'cheese',
    7
);

INSERT INTO serves VALUES (
    'New York Pizza',
    'supreme',
    8.5
);

INSERT INTO serves VALUES (
    'Chicago Pizza',
    'cheese',
    7.75
);

INSERT INTO serves VALUES (
    'Chicago Pizza',
    'supreme',
    8.5
);

INSERT INTO serves ( pizzeria ) VALUES ( 'xyz' );