    
SELECT
    ORDER_ID
FROM
    SALES
WHERE
    SHIP_DATE-ORDER_DATE <= 31;
    
SELECT
    ORDER_ID, ROUND(TOTAL_REVENUE-TOTAL_COST,-2) Profit
FROM
    SALES;

SELECT
    ORDER_ID, ROUND((SYSDATE-SHIP_DATE),0) no_of_days
FROM
    SALES;
    
SELECT 
    *
FROM 
    SALES
WHERE
    TO_CHAR(ORDER_DATE,'YYYY')>='2017';
    
SELECT
    ('THE ORDER ID ' || ORDER_ID || ' HAS ' || ORDER_PRIORITY || ' PRIORITY AND ' || SALES_CHANNEL ||  ' SALES CHANNEL.') FORMAT
FROM 
    SALES;
    
UPDATE
    SALES 
SET 
    UNIT_PRICE =  UNIT_PRICE*1.10
WHERE
    ITEM_TYPE = 'Fruits';  
    
SELECT
    ORDER_ID, (GREATEST((TOTAL_REVENUE-TOTAL_COST)*0.20, 50000))Charity
FROM
    SALES;
    
SELECT
    *
FROM 
    SALES
WHERE 
    ORDER_PRIORITY='H' AND SHIP_DATE-ORDER_DATE>15;S



SELECT
    item_type
FROM 
    SALES
WHERE
    ASCII(SUBSTR(ITEM_TYPE,1,1))=83;
    
    
SELECT
    ORDER_ID, REPLACE( REPLACE( REPLACE(ORDER_PRIORITY,'H','urgent'),'C','medium'),'L','low')
FROM
    SALES;
    