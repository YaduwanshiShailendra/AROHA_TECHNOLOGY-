--1. Product Model

create table product1
(p_id number(4) primary key,
p_name varchar2(20) not null,
p_family varchar2(20),
price number(5) not null,
cost number(5) not null,
launch_date date);

insert all
into product1 values(100,'Marker','stationary',25,22,'15-jan-14')
into product1 values(101,'Mouse','computer',450,350,'16-apr-14')
into product1 values(102,'Whiteboard','stationary',450,375,'20-aug-13')
into product1 values(103,'sonyvaio','computer',35000,42000,'21-sep-13')
into product1 values(104,'Pendrive','computer',400,350,'18-jan-19')
select * from dual;
select * from product1;


--------------------------------------------------------------------------

--City_branch

create table city1
(city_id number(2) primary key,
city_name varchar2(20) not null,
city_population varchar2(20));

insert all
into city1 values(10,'Bangalore',2367890)
into city1 values(20,'Chennai',6474854)
into city1 values(30,'Mumbai',783983736)
select * from dual;

select * from city1;

create table branch
(b_id number(4) primary key,
b_name varchar2(20) not null,
b_address varchar2(20),
b_phone number(10),
city_id number(2) references city1(city_id));
 
insert all
into branch values(500,'BTM Layout','185, ring road',789056,10)
into branch values(501,'Jayanagar','44, 15th main',578934,10)
into branch values(502,'Ashok nagar','south end circle',2856726,20)
into branch values(503,'Mount road','ashoka pillar',774589,20)
into branch values(504,'JP nagar','Nandanam',9986253,10)
select * from dual;
select * from branch;
---------------------------------------------------------------------
--Day3

create table doctor
(doc_id varchar2(4) primary key,
fname varchar2(20),
lname varchar2(20),
specialty varchar2(20),
phone number(10)
)

create table patient
(pat_id varchar2(4) primary key,
fname varchar2(20),
lname varchar2(20),
ins_comp varchar2(20),
phone number(10)
)


create table case
(admission_date date,
pat_id varchar2(4),
doc_id varchar2(4),
diagnosis varchar2(20),
constraint con_cpk primary key(admission_date,pat_id)
)


insert all
into doctor values('d1','arun','patel','ortho',9675093453)
into doctor values('d2','tim','patil','general',9675093453)
into doctor values('d3','abhay','sharma','heart',9675093453)
select * from dual;

insert all
into patient values('p1','akul','shankar','y',9148752347)
into patient values('p2','aman','shetty','y',9512896317)
into patient values('p3','ajay','shetty','n',9987321564)
into patient values('p4','akshay','pandit','y',9112255889)
into patient values('p5','adi','shankar','n',9177788821)
select * from dual;


insert all
into case values('10-jun-16','p1','d1','fracture')
into case values('03-may-16','p2','d1','bone cancer')
into case values('17-apr-16','p2','d2','fever')
into case values('28-oct-15','p3','d2','cough')
into case values('10-jun-16','p3','d1','fracture')
into case values('1-jan-16','p3','d1','bone marrow')
into case values('11-sep-15','p3','d3','heart attack')
into case values('30-nov-15','p4','d3','heart hole')
into case values('10-nov-15','p4','d3','angioplasty')
into case values('1-jan-16','p5','d3','heart attack')
select * from dual;
---------------------



--1. WAQT list the cities which have more population than banglore.

    select city_name 
    from city1
    where city_population > ( select city_population
                    from city1
                    where city_name ='Bangalore');

--2. Display all the branch name form chennai.

SELECT B_NAME 
FROM BRANCH
WHERE CITY_ID =
(SELECT CITY_ID
FROM CITY1
WHERE CITY_NAME ='Chennai');

--3. Display city name which does not have any branch.

SELECT CITY_NAME
FROM CITY1 C , BRANCH B
WHERE C.CITY_ID=B.CITY_ID(+)
GROUP BY CITY_NAME
HAVING COUNT(B_NAME)=0;

--4 Display branch name, address , phoneno of all branches where the 
--name starts with either b or m and the

SELECT B_NAME, B_ADDRESS,B_PHONE
FROM CITY1 C, BRANCH B
WHERE C.CITY_ID=B.CITY_ID
AND B_NAME LIKE 'B%' OR B_NAME LIKE 'M%'
AND CITY_NAME LIKE 'B%' OR CITY_NAME LIKE 'M%';

--5. How many branches we have in bangalore

SELECT COUNT(B_NAME)
FROM BRANCH
WHERE CITY_ID IN (SELECT CITY_ID
               FROM CITY1
               WHERE CITY_NAME='Bangalore');

--6. Display the branches which are in the Ring road of any city

SELECT B_NAME
FROM BRANCH B, CITY1 C
WHERE B.CITY_ID = C.CITY_ID
AND B_ADDRESS LIKE '%ring road%';


--7. Display the city name , branch name , order the database on the city name

SELECT CITY_NAME, B_NAME
FROM CITY1 C, BRANCH B
WHERE C.CITY_ID = B.CITY_ID
ORDER BY C.CITY_NAME;

--8. Display the city name & no of branches in each city

SELECT CITY_NAME, COUNT(B_NAME)
FROM CITY1 C, BRANCH B
WHERE C.CITY_ID = B.CITY_ID
GROUP BY CITY_NAME;

--9. Display the city name which has most no. of branches

SELECT C.CITY_NAME, COUNT(B.B_NAME)
FROM CITY1 C, BRANCH B
WHERE C.CITY_ID = B.CITY_ID
GROUP BY C.CITY_NAME
ORDER BY COUNT(B.B_NAME) DESC;

--10. Display the city name population no. of branches in each city.

SELECT * FROM CITY1;

SELECT C.CITY_NAME, SUM(C.CITY_POPULATION), COUNT(B.B_NAME)
FROM CITY1 C, BRANCH B
WHERE C.CITY_ID = B.CITY_ID
GROUP BY C.CITY_NAME;

--###############################################################################################--
--                              PRODUCT MODEL
--###############################################################################################--


--1. Write the select statement which gives all the products which costs more than Rs 250.

SELECT *
FROM PRODUCT1 
WHERE COST > 250;

--2. Write the select statement which gives product name, cost, price and profit. (profit formula is price – cost)

SELECT P_NAME, COST, PRICE, (PRICE - COST)*100.00/cost PROFIT 
FROM PRODUCT1;

--3. Find the products which give more profit than product Mouse

SELECT * 
FROM PRODUCT1 
WHERE (PRICE - COST) > (SELECT (PRICE - COST) 
                        FROM PRODUCT1 
                        WHERE P_NAME = 'Mouse');

--4. Display the products which give the profit greater than 100 Rs.

SELECT * 
FROM PRODUCT1 
WHERE (PRICE - COST) >100; 

--5. Display the products which are not from Stationary and Computer family.

SELECT * 
FROM PRODUCT1
WHERE P_FAMILY NOT IN ('stationary', 'computer');

--6. Display the products which give more profit than the p_id 102.

SELECT * 
FROM PRODUCT1 
WHERE (PRICE - COST) > (SELECT (PRICE - COST) 
                        FROM PRODUCT1 
                        WHERE P_ID =102);

--7. Display products which are launched in the year of 2010.

SELECT * 
FROM PRODUCT1 
WHERE TO_CHAR(LAUNCH_DATE, 'YYYY') = '2010';

--8. Display the products which name starts with either ‘S’ or ‘W’ and which belongs to Stationary and cost more than 300 Rs

SELECT P_NAME 
FROM PRODUCT1 
WHERE SUBSTR(P_NAME,1,1) = 'S' 
OR SUBSTR(P_NAME,1,1)='W' 
AND P_FAMILY = 'stationary' 
AND COST >300;

--9. Display the products which are launching next month.

SELECT P_NAME 
FROM PRODUCT1 
WHERE TO_CHAR(LAUNCH_DATE, 'MM') = TO_CHAR(ADD_MONTHS(SYSDATE,1), 'MM');

--10. Display product name which has the maximum price in the entire product table.

SELECT P_NAME 
FROM PRODUCT1
WHERE PRICE =(SELECT MAX(PRICE)
FROM PRODUCT1);

--11. List the product name, cost, price, profit and percentage of profit we get in each product.

SELECT P_NAME, COST, PRICE,(PRICE-COST) PROFIT, (PRICE-COST)*100/COST PROFIT_PERCENTAGE
FROM PRODUCT1;

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
              WHERE TRUNC(ADMISSION_DATE,'DD') = TRUNC(SYSDATE+7, 'DD'));

--2. Find all the doctors who have more than 3 admissions today

SELECT FNAME
FROM DOCTOR
WHERE DOC_ID IN(SELECT DOC_ID
                FROM CASE
                WHERE ADMISSION_DATE=SYSDATE
                GROUP BY DOC_ID
                HAVING COUNT(PAT_ID)>2);

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
                WHERE FNAME='tim') AND FNAME NOT IN ('tim');

--6. Find out the number of cases monthly wise for the current year

SELECT COUNT(PAT_ID), TO_CHAR(ADMISSION_DATE,'mon') FROM CASE
WHERE TO_CHAR(ADMISSION_DATE,'yyyy')= TO_CHAR(SYSDATE,'yyyy') 
GROUP BY TO_CHAR(ADMISSION_DATE,'mon');

--7. Display the doctors who don’t have any cases registered this week

SELECT FNAME
FROM DOCTOR
WHERE DOC_ID NOT IN(SELECT DOC_ID
                    FROM CASE
                    WHERE ADMISSION_DATE
                    BETWEEN SYSDATE AND SYSDATE+7);

--8. Display Doctor Name, Patient Name, Diagnosis for all the admissions which happened on 1st of Jan this year

SELECT D.FNAME AS DOC_NAME, P.FNAME AS PAT_NAME, C.DIAGNOSIS
FROM CASE C INNER JOIN PATIENT P
ON P.PAT_ID=C.PAT_ID JOIN DOCTOR D
ON D.DOC_ID=C.DOC_ID
WHERE TRUNC( ADMISSION_DATE,'yyyy')=TRUNC(SYSDATE,'yyyy');

--9.	Display Doctor Name, patient count based on the cases registered in the hospital.

SELECT D.FNAME, COUNT(C.PAT_ID)
FROM DOCTOR D INNER JOIN CASE C
ON D.DOC_ID=C.DOC_ID
GROUP BY D.FNAME
ORDER BY D.FNAME DESC;

--10.	Display the Patient_name, phone, insurance company, insurance code (first 3 characters of insurance company)

SELECT FNAME, PHONE, INS_COMP, SUBSTR(INS_COMP,1,3) INSURANCE_CODE
FROM PATIENT;

