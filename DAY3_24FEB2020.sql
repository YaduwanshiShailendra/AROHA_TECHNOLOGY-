
--1. WAQT list the cities which have more population than banglore.

select city_name 
from city1
where city_population > ( select city_population
                         from city1
                         where city_name ='Bangalore');

--2. Display all the branch name form chennai.

SELECT B_NAME 
FROM BRANCH
WHERE CITY_ID =(SELECT CITY_ID
                FROM CITY1
                WHERE CITY_NAME ='Chennai');

--3. Display city name which does not have any branch.

SELECT CITY_NAME
FROM CITY1
WHERE CITY_ID NOT IN (SELECT CITY_ID
                      FROM BRANCH);


SELECT CITY_NAME
FROM CITY1 C , BRANCH B
WHERE C.CITY_ID=B.CITY_ID(+)
GROUP BY CITY_NAME
HAVING COUNT(B_NAME)=0;

--4 Display branch name, address and phone number of all the branches where the name starts
--- with either B or M and the city name starts with either B or C.

SELECT B_NAME, B_ADDRESS,B_PHONE
FROM CITY1 C, BRANCH B
WHERE C.CITY_ID=B.CITY_ID
AND (B_NAME LIKE 'B%' OR B_NAME LIKE 'M%')
AND (CITY_NAME LIKE 'B%' OR CITY_NAME LIKE 'C%');

--5. How many branches we have in bangalore

SELECT COUNT(B_NAME)
FROM BRANCH
WHERE CITY_ID IN (SELECT CITY_ID
                  FROM CITY1
                  WHERE CITY_NAME='Bangalore');

--6. Display the branches which are in the Ring road of any city

SELECT B_NAME
FROM BRANCH B
WHERE B_ADDRESS LIKE '%ring road%';


SELECT B_NAME
FROM BRANCH B
WHERE INSTR(B_ADDRESS, 'ring road')>0;

--7. Display the city name , branch name , order the database on the city name

SELECT CITY_NAME, B_NAME
FROM CITY1 C, BRANCH B
WHERE C.CITY_ID = B.CITY_ID
ORDER BY C.CITY_NAME;

--8. Display the city name & no of branches in each city

SELECT CITY_NAME, COUNT(B_NAME)
FROM CITY1 C, BRANCH B
WHERE C.CITY_ID = B.CITY_ID(+)
GROUP BY CITY_NAME;

--9. Display the city name which has most no. of branches


SELECT CITY_NAME
FROM CITY1
WHERE CITY_ID IN (SELECT CITY_ID
                  FROM BRANCH
                  GROUP BY CITY_ID
                  HAVING COUNT(B_NAME) IN (SELECT MAX(COUNT(B_NAME))
                                           FROM BRANCH
                                           GROUP BY CITY_ID));
                                           
select city_name,count(b_id) from city1 c,branch b where c.city_id=b.city_id group by city_name
having count(b_id)=( select max(count(b_id)) from branch group by city_id )



select * from city;
select
--        OR

SELECT * FROM (
                SELECT ROWNUM AS SNO, T1.*
                FROM (SELECT C.CITY_NAME, COUNT(B.B_NAME)
                FROM CITY1 C, BRANCH B
                WHERE C.CITY_ID = B.CITY_ID
                GROUP BY C.CITY_NAME
                ORDER BY COUNT(B.B_NAME) DESC) T1)
WHERE SNO=1;

--OR

SELECT ROWNUM, T1.*
FROM (SELECT C.CITY_NAME, COUNT(B.B_NAME)
        FROM CITY1 C, BRANCH B
        WHERE C.CITY_ID = B.CITY_ID
        GROUP BY C.CITY_NAME
        ORDER BY COUNT(B.B_NAME) DESC) T1
WHERE ROWNUM=1;

--10. Display the city name population no. of branches in each city.


SELECT C.CITY_NAME, C.CITY_POPULATION, COUNT(B.CITY_ID) BRANCH_COUNT
FROM CITY1 C, BRANCH B
WHERE C.CITY_ID = B.CITY_ID(+)
GROUP BY C.CITY_NAME, C.CITY_POPULATION, B.CITY_ID
ORDER BY C.CITY_NAME DESC;



SELECT C.CITY_NAME, SUM(C.CITY_POPULATION), COUNT(B.B_NAME)
FROM CITY1 C, BRANCH B
WHERE C.CITY_ID = B.CITY_ID(+)
GROUP BY C.CITY_NAME;



--###############################################################################################--
--                              PRODUCT MODEL
--###############################################################################################--


--1. Write the select statement which gives all the products which costs more than Rs 250.

SELECT P_NAME
FROM PRODUCT1 
WHERE COST > 250;

--2. Write the select statement which gives product name, cost, price and profit. (profit formula is price – cost)

SELECT P_NAME, COST, PRICE, ROUND((PRICE - COST)*100.00/cost,2) PROFIT 
FROM PRODUCT1;


SELECT T1.* 
FROM (SELECT P_NAME, COST, PRICE, ROUND((PRICE - COST)*100.00/cost,2) PROFIT 
      FROM PRODUCT1) T1
WHERE PROFIT > 0;

--3. Find the products which give more profit than product Mouse

SELECT P_NAME 
FROM PRODUCT1 
WHERE (PRICE - COST) > (SELECT (PRICE - COST) 
                        FROM PRODUCT1 
                        WHERE P_NAME = 'Mouse');

--4. Display the products which give the profit greater than 100 Rs.

SELECT P_NAME 
FROM PRODUCT1 
WHERE (PRICE - COST) >100; 

--5. Display the products which are not from Stationary and Computer family.

SELECT P_NAME 
FROM PRODUCT1
WHERE P_FAMILY NOT IN ('stationary', 'computer');

--6. Display the products which give more profit than the p_id 102.

SELECT P_NAME 
FROM PRODUCT1 
WHERE (PRICE - COST) > (SELECT (PRICE - COST) 
                        FROM PRODUCT1 
                        WHERE P_ID =102);

--7. Display products which are launched in the year of 2010.

SELECT P_NAME 
FROM PRODUCT1 
WHERE TO_CHAR(LAUNCH_DATE, 'YYYY') = '2010';

--8. Display the products which name starts with either ‘S’ or ‘W’ and which belongs to Stationary and cost more than 300 Rs

SELECT P_NAME 
FROM PRODUCT1 
WHERE SUBSTR(P_NAME,1,1) IN ( 'S', 'W')
AND P_FAMILY = 'stationary' 
AND COST >300;


SELECT P_NAME 
FROM PRODUCT1 
WHERE INSTR(P_NAME,'S',1) >0 OR INSTR(P_NAME,'W',1)>0 
AND P_FAMILY = 'stationary' 
AND COST >300;


--9. Display the products which are launching next month.

SELECT P_NAME 
FROM PRODUCT1 
WHERE TO_CHAR(LAUNCH_DATE, 'MM-YY') = TO_CHAR(ADD_MONTHS(SYSDATE,1), 'MM-YY');

--10. Display product name which has the maximum price in the entire product table.

SELECT P_NAME 
FROM PRODUCT1
WHERE PRICE =(SELECT MAX(PRICE)
              FROM PRODUCT1);

--11. List the product name, cost, price, profit and percentage of profit we get in each product.

SELECT P_NAME, COST, PRICE,(PRICE-COST) PROFIT, (PRICE-COST)*100/COST PROFIT_PERCENTAGE
FROM PRODUCT1;

SELECT T1.*
FROM (SELECT P_NAME, COST, PRICE,(PRICE-COST) PROFIT, ROUND((PRICE-COST)*100/COST,2) PROFIT_PERCENTAGE
FROM PRODUCT1
) T1
WHERE PROFIT_PERCENTAGE > 0;

--12. Display how many products we have in Computer family which has the price range between 2000 and 50000.

SELECT COUNT(P_NAME) 
FROM PRODUCT1
WHERE P_FAMILY='computer' 
AND PRICE BETWEEN 2000 AND 50000;


--##########################################################################--
--                    HEALTH CARE MODEL
--##########################################################################--

--1. Find all the patients who are treated in the first week of this month.

SELECT FNAME 
FROM PATIENT
WHERE PAT_ID=(SELECT PAT_ID 
              FROM CASE 
              WHERE TO_CHAR(ADMISSION_DATE,'MM-YY') = TO_CHAR(SYSDATE, 'MM-YY') 
              AND TO_CHAR(ADMISSION_DATE, 'W')=1);

INSERT into case values('24-FEB-20','p5','d3','heart attack');
INSERT into case values('24-FEB-20','p2','d3','bp');
INSERT into case values('24-FEB-20','p4','d3','eye problem');
INSERT into case values('24-FEB-20','p3','d3','breath problem');
commit;
SELECT * FROM PATIENT;
SELECT * FROM CASE;

--2. Find all the doctors who have more than 3 admissions today

SELECT FNAME
FROM DOCTOR
WHERE DOC_ID IN(SELECT DOC_ID
                FROM CASE
                WHERE TO_CHAR(ADMISSION_DATE) = TO_CHAR(SYSDATE) 
                GROUP BY DOC_ID
                HAVING COUNT(PAT_ID)>3);

--3. Find the patient name (first,last) who got admitted today where the doctor is ‘TIM’

SELECT P.FNAME,P.LNAME
FROM PATIENT P,CASE C
WHERE P.PAT_ID=C.PAT_ID AND ADMISSION_DATE=SYSDATE 
AND DOC_ID=(SELECT DOC_ID 
            FROM DOCTOR
            WHERE FNAME='tim');

--4. Find the Doctors whose phone numbers were not update (phone number is null)

SELECT * 
FROM DOCTOR
WHERE PHONE IS NULL;

--5. Display the doctors whose specialty is same as Doctor ‘TIM’

SELECT *
FROM DOCTOR
WHERE SPECIALTY=(SELECT SPECIALTY
                FROM DOCTOR
                WHERE FNAME='tim') AND FNAME <> ('tim');

--6. Find out the number of cases monthly wise for the current year

SELECT COUNT(PAT_ID), TO_CHAR(ADMISSION_DATE,'mon') FROM CASE
WHERE TO_CHAR(ADMISSION_DATE,'yyyy')= TO_CHAR(SYSDATE,'yyyy') 
GROUP BY TO_CHAR(ADMISSION_DATE,'mon');

--7. Display the doctors who don’t have any cases registered this week

SELECT FNAME
FROM DOCTOR
WHERE DOC_ID NOT IN(SELECT DOC_ID
                    FROM CASE
                    WHERE TO_CHAR(ADMISSION_DATE, 'W-MON-YY') = TO_CHAR(SYSDATE, 'W-MON-YY'));

--8. Display Doctor Name, Patient Name, Diagnosis for all the admissions which happened on 1st of Jan this year

SELECT D.FNAME AS DOC_NAME, P.FNAME AS PAT_NAME, C.DIAGNOSIS
FROM CASE C INNER JOIN PATIENT P
ON P.PAT_ID=C.PAT_ID JOIN DOCTOR D
ON D.DOC_ID=C.DOC_ID
WHERE TRUNC(ADMISSION_DATE)=TRUNC(SYSDATE,'yyyy')
AND TO_CHAR(ADMISSION_DATE, 'mon')='Jan';



--9.	Display Doctor Name, patient count based on the cases registered in the hospital.

SELECT D.FNAME, COUNT(C.PAT_ID)
FROM DOCTOR D INNER JOIN CASE C
ON D.DOC_ID=C.DOC_ID
GROUP BY D.FNAME
ORDER BY D.FNAME DESC;

--10.	Display the Patient_name, phone, insurance company, insurance code (first 3 characters of insurance company)

SELECT FNAME, PHONE, INS_COMP, SUBSTR(INS_COMP,1,3) INSURANCE_CODE
FROM PATIENT;





--###########################################################################--
--                          TODYAS EXCERCISE
--###########################################################################--

--1. WAQTD CUSTOMER WHO DID NOT MAKE ANY SALES TODAY.

SELECT CUST_NAME
FROM CUSTOMER1
WHERE CUST_ID NOT IN (SELECT CUST_ID
                      FROM SALES
                      WHERE TRUNC(SALE_DATE) = TRANC(SYSDATE));

--2. WAQTD CITIES WHICH HAS CUSTOMER BUT NOT STORE.

SELECT CITY_NAME
FROM CITY1
WHERE CITY_ID IN (SELECT CITY_ID
                  FROM CUSTOMER1
                  AND CITY_ID NOT IN (SELECT CITY_ID
                                      FROM STORES);
                  

--3. WAQTD CUSTOMER WHO MADE SALES IN THE CURRENT MONTH.

SELECT CUST_NAME
FROM CUSTOMER1
WHERE CUST_ID IN (SELECT CUST_ID
                  FROM SALES
                  WHERE TO_CHAR(SALES_DATE, 'MM-YY') = TO_CHAR(SYSDATE, 'MM-YY');

--4. WAQTD CUSTOMER WHO PURCHASSE 'pen' ON friday OF CURRENT MONTH.

SELECT CUST_NAME
FROM CUSTOMER1 C INNER JOIN SALES S
ON C.CUST_ID = S.CUST_ID INNER JOIN PRODUCT1 P
ON S.PRODUCT_ID = P.PRODUCT_ID
WHERE P.P_NAME = 'pen'
AND TO_CHAR(SALES_DATE, 'DAY') = 'Friday'
AND TO_CHAR(SALES_DATE, 'MM-YY') = TO_CHAR(SYSDATE, 'MM-YY');

--5. WAQTD STORES WHICH DID NOT MAKE ANY SALES IN THE PREVIOUS MONTH.

SELECT STORE_NAME
FROM STORE
WHERE STORE_ID NOT IN (SELECT STORE_ID
                       FROM SALES
                       WHERE TO_CHAR(SALES_DATE,'MM-YY)= TO_CHAR(ADD_MONTHS(SYSDATE,-1),'MM-YY);
                       