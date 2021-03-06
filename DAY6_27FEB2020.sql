--1. Display the customer names who are from Bangalore.

SELECT CUST_NAME
FROM CUSTOMER_DETAIL
WHERE CITY_ID=(SELECT CITY_ID
			FROM CITY
			WHERE CITY_NAME='Bangalore');
SELECT * FROM CUSTOMER_DETAIL;
SELECT * FROM CITY;

--2. Display the state wise no of cities and no of customers

SELECT S.STATE_NAME, COUNT(CT.CITY_ID) No_of_Cities, COUNT(C.CUST_ID) No_of_Customers
FROM STATE S,CITY CT, CUSTOMER_DETAIL C
WHERE S.STATE_ID=CT.STATE_ID
AND CT.CITY_ID=C.CITY_ID
GROUP BY S.STATE_NAME;

SELECT * FROM CITY;
SELECT * FROM STATE;


--3. Display the customer name wise no of sales

SELECT C.CUST_NAME, COUNT(S.SALES_ID)
FROM CUSTOMER_DETAIL C, SALES S
WHERE C.CUST_ID = S.CUST_ID
GROUP BY C.CUST_NAME;

--4. Display the products that were never sold

SELECT P.PRODUCT_NAME
FROM PRODUCT P
WHERE PRODUCT_ID NOT IN (SELECT PRODUCT_ID
                    FROM SALES S
                    WHERE S.PRODUCT_ID=P.PRODUCT_ID); 

--5. Display the city names that have more than 10 customers

SELECT CT.CITY_NAME
FROM CITY CT,CUSTOMER_DETAIL C
WHERE CT.CITY_ID = C.CITY_ID
GROUP BY CT.CITY_NAME
HAVING COUNT(CUST_ID)>10;

--6. Display the youngest customer name 

SELECT CUST_NAME, CUST_DOB
FROM CUSTOMER_DETAIL
WHERE CUST_DOB=(SELECT MAX(CUST_DOB)
                FROM CUSTOMER_DETAIL);

--7. Display the oldest customer in each city.

SELECT CT.CITY_NAME , (SELECT C.CUST_NAME
                        FROM CUSTOMER_DETAIL C
                        WHERE C.CITY_ID=CT.CITY_ID
                        AND C.CUST_DOB=(SELECT MIN(C.CUST_DOB)
                                        FROM CUSTOMER_DETAIL C
                                        WHERE C.CITY_ID=CT.CITY_ID)) CUST_NAME
FROM CITY CT;

--8. Display the product names whose price is more than 4000 and less than 6000

SELECT PRODUCT_NAME
FROM PRODUCT
WHERE PRODUCT_PRICE >4000
AND PRODUCT_PRICE <6000;

--9. Display the state name wise no. of male and female customers

SELECT STATE_NAME,COUNT(CASE WHEN CUST_GENDER='MALE' THEN 1 END),
COUNT(CASE WHEN CUST_GENDER='FEMALE' THEN 1 END)
FROM STATE S,CITY C,CUSTOMER_DETAIL CUST
WHERE S.STATE_ID=C.STATE_ID
AND C.CITY_ID=CUST.CITY_ID
GROUP BY S.STATE_NAME;


--10. Display the states that have more than 5 cities and more than 30 customers.

SELECT S.STATE_NAME,COUNT(CT.CITY_ID),COUNT(C.CUST_ID)
FROM STATE S,CITY CT,CUSTOMER_DETAIL C
WHERE S.STATE_ID = CT.STATE_ID
AND CT.CITY_ID = C.CITY_ID
GROUP BY S.STATE_NAME
HAVING COUNT(S.STATE_ID)>2
AND COUNT(C.CUST_ID)>3;


--11. Display the products that were not sold in the previous year.

SELECT P.PRODUCT_NAME
FROM PRODUCT
WHERE PRODUCT_ID NOT IN (SELECT PRODUCT_ID
                    FROM SALES
                    WHERE TO_CHAR(S.TX_DATE,'YYYY')=TO_CHAR(SYSDATE,'YYYY')-1); 

--USING CORELATED

SELECT P.PRODUCT_NAME
FROM PRODUCT P
WHERE PRODUCT_ID NOT IN (SELECT PRODUCT_ID
                    FROM SALES S
                    WHERE S.PRODUCT_ID=P.PRODUCT_ID
                    AND TO_CHAR(S.TX_DATE,'YYYY')=TO_CHAR(SYSDATE,'YYYY')-1); 


--12. Display the city name which have more female customer.
-----------------------------------------------
SELECT CT.CITY_NAME, COUNT(CUST_ID)
FROM CITY CT, CUSTOMER_DETAIL C
WHERE CT.CITY_ID= C.CITY_ID
AND C.CUST_GENDER='FEMALE'
GROUP BY CT.CITY_NAME
HAVING COUNT(C.CUST_ID)=(SELECT MAX(COUNT(C.CUST_ID))
                        FROM CITY CT, CUSTOMER_DETAIL C
                        WHERE CT.CITY_ID=C.CITY_ID
                        AND C.CUST_GENDER='FEMALE'
                        GROUP BY CT.CITY_NAME);
-------------------------------------------

SELECT CITY_NAME 
FROM CITY
WHERE CITY_ID IN (SELECT CITY_ID
                    FROM CUSTOMER_DETAIL
                    GROUP BY CITY_ID
                    HAVING CUST_ID=(SELECT MAX(COUNT(CUST_ID))
                                    FROM CUSTOMER_DETAIL
                                    WHERE CUST_GENDER='FEMALE'));


--13. Extract the Domain name from eamil.

SELECT SUBSTR(cust_email,INSTR(cust_email,'@')+1,INSTR(cust_email,'.')-INSTR(cust_email,'@')-1) AS DOMAIN_NAME
FROM CUSTOMER_DETAIL;

--14. Display state name wise yongest customer.

SELECT A.STATE_NAME, C.CUST_NAME
FROM STATE A , CITY B, CUSTOMER_DETAIL C
WHERE A.STATE_ID=B.STATE_ID
AND B.CITY_ID= C.CITY_ID
AND CUST_DOB=(
SELECT MAX(C.CUST_DOB)
FROM CUSTOMER_DETAIL D
WHERE A.STATE_ID=B.STATE_ID
AND B.CITY_ID= D.CITY_ID);

--15. Difference between Delete and Truncate.

DELETE: is a DML Statement
        can perform rollback after performing delete
        can use where clause
        delete removes conditionally according to where clause

TRUNCATE:   is a DDL statement
            cannot perform rollback after performing delete clause
            cannot use where clause
            it always removes all the rows from the table
 