
--###########################################################################--
--                       	DAY14_09-MARCH-2020
--###########################################################################--

--SQL Questions_Test4(1-26)
--
--1. Display the count of ‘L’ in ‘Fintellix’ string.

select count(case when count>0 
                  then 1 end)-1
from(select instr('Fintellix', 'l',1,level), count(*) as count from dual connect by level<=length('Fintellix') group by instr('Fintellix', 'l',1,level));

--or

select length('Fintellix')-length(replace('Fintellix','l','')) from dual;


--2.Update the salary of employees 
--If sal>10000 then sal+1000
--Sal>5000 then sal+500
--Else sal
--Using case.
--


(select case when sal>10000 then sal+1000 
            when sal>5000  then sal+500
            else sal end
from emp)
;


--3.Display  Dnames and no of employees in it. 
--      ACCOUNTING            RESEARCH              SALES           OPERATIONS
---------------------       ------------         ----------        ----------
--         3                      5                   6                  1


--4.Display positive and negative nos using case.
--
--  I/p		O/p
--
--   No		pos	neg
--   1		1	-1
--  -1		2	-2
--   2		3	
--  -2
--   3									
--




--5. Waq to display the date and time of sysdate in 24hr format.
--6. Waq to display alternate records.
--7.  Find the highest runs scored by each criketer from following table:
--name 	score1	score2	score3	score4
--sachin	70	50	100	150
--Doni	25	55	60	66
--Rahul	10	200	15	76
--koli	  0	 0	 0	1
--
--8. I have a table A and B with single column in both tables. Show result for a union and union all.
--A	B
--1	2
--2	10
--3	7
--NULL	NULL
--4	5
--	6
--	9
--
--9.   We have a sequence for id column with increment 1.
-- Input: 1000
--            1001
--            1002
--            1004
--            1005
--            1006
--            1009
--            1010
--
-- I want to select the missing numbers in the sequence.
-- Output should be 
--                1003
--                1007
--                1008
--
--

--10.   t1	   	t2
--   
--   empid                empid
--   date                 empname
--   hour_of_work
-- 
--1.find which emp worked more than 30 hours in last seven days
--2.find the emp details of today
--

--11. How to print ‘oracle’s’ in the screen.(Oracle with apostrophe s)
SELECT 'ORACLE''S' FROM DUAL;
COMMIT;
--12. Suppose I inserted 2 records, deleted one record, alter the table and issued rollback. How many records will be there in the table.

--Answer:- IT WILL DISPLAY ONLY ONE RECORD IN THE TABLE.

CREATE TABLE TT1(ID INT, NAME VARCHAR(20));

INSERT ALL
INTO TT1 VALUES(1,'AA')
INTO TT1 VALUES(2,'BB')
SELECT * FROM DUAL;

DELETE FROM TT1 WHERE ID=2;

ALTER TABLE TT1 ADD CONSTRAINT P_IDE PRIMARY KEY(ID);

ROLLBACK;

SELECT * FROM TT1;

drop table tt1;
--13. I have deleted 5 records and created the table. V have to issue commit or not to make the change permanent?


--14.I have dropped the table accidentally. How to rollback it?
1. CHECK THE TABLE IN RECYCLE BIN USING SHOW RECYCLEBIN COMMAND.
SHOW RECYCLEBIN;
2. Retrieve the dropped table using the FLASHBACK TABLE <TABLE_NAME> TO BEFORE DROP command.
The following command performs a flashback of the SCOTT.TT1 table.

FLASHBACK TABLE SCOTT.TT1 TO BEFORE DROP;

--15. How to find the not matching records from both the table.
--  Tbl1					Tbl2
-- Col1	   col2			  col1	  col2
-- 2	    4				2	    5
-- 3	    9				9	    4
-- 2	    9				2	    6
-- 8	    7				2	    8
-- Null 	3				null	null

(SELECT * FROM TB11)
MINUS
(SELECT * FROM TB12)


CREATE TABLE TB11(COL1 NUMBER, COL2 NUMBER);
CREATE TABLE TB12(COL1 NUMBER, COL2 NUMBER);

INSERT ALL
INTO TB11 VALUES(2,4)
INTO TB11 VALUES(3,9)
INTO TB11 VALUES(2,9)
INTO TB11 VALUES(8,7)
INTO TB11 VALUES(NULL,3)
INTO TB12 VALUES(2,5)
INTO TB12 VALUES(9,4)
INTO TB12 VALUES(2,6)
INTO TB12 VALUES(2,8)
INTO TB12 VALUES(NULL,NULL)
SELECT * FROM DUAL;



--16.
--        City     		Gender
--        Bang		    M
--        Delhi		    M
--        Mum		    F
--        Bang		    F
--        Bang		    F
--        Delhi		    M
--        Delhi		    M
--        Mum		    F
--

--  o/p
--City		Males	  Females
--Bang		1		    2
--Delhi		3		    0
--Mum		0		    2
--


--17.
--Customer			Bid		Wid
--Vinod			40		10
--Ajay			50		20
--Arun			30		10
--Akshay			50		30
--Raj			20		50
--
--City_id		City_name
--10		Bang
--20		Hyd
--30		Delhi
--40		Mum
--50		Chn
--
--Waq to display customer name, birth city and work city.
--
--18. Display the result set as
--
--id	marks	subjects
--1	50	maths
--1	60	science
--1	70	social
--2	35	maths
--2	45	science
--2	55	social
--3	60	maths
--3	70	science
--3	80	social
--
--o/p
--id	maths		science		social
--1	50		60		70
--2	35		45		55
--3	60		70		80
--
--
--19.
--
--t1                   t2 log_table
--      id  nm                 nm     value
--      1   a                    a          10
--      2   b                    null     11
--      3   c                    null     12
--      4   d                    d        13
--Display the nm not present in t2(nm) column.
--
--20. Write a query to get the output as:
--Table A
--Col1			Output
--1			Positive		Negative
---2			10		-7
--3
---5
--6
--
--21.Display the employees who are not playing manager roles.
select ename
from emp 
where mgr is null;

--22.Display emp’s whose interview date and joining date is more than a week.

--23. What is count(*),count(null), count(empno), count(1).
count(*)
        1. The Oracle COUNT() function is an aggregate function that returns the number of items in a group. 
        2. COUNT(*) function returns the number of items in a group, including NULL and duplicate values. 
        3. COUNT(DISTINCT expression) function returns the number of unique and non-null items in a group.
count(null) 

count(empno) 
count(1)
--24. Display salaries as
--5000:4000:3000:2000:1000 in this format as well as in descending order.
--25. Display the top 2 salaries in each dept
--O/p
--       Deptno		sal
--	10		5000, 3000
--	20		10000, 8000
--	30		3000, 2000
--
--26.
--
--EMP							JOB
--Empno 	ename		sal			Grade	   low_sal	high_sal
--	1101		Arun		8000			A	    10000	15000
--	1102		Bharat		12000			B	    5000		10000		
--	1103		Charan		3000			C	    1000		5000
--	Display the grades of employees based on their salary.



--##########################################################################################
--                                MATERIALIZED VIEW
--##########################################################################################

--creating materialized view with default values
create materialized view mv_1 
as(select empno,ename, sal*12 from emp);


--creating materialized view with default values
create materialized view mv_2 
build immediate
refresh force
on demand
start with sysdate next sysdate+2
with primary key
as select empno,ename, sal*12 from emp;

conn scott/tiger;
conn sys as sysdba;
grant create materialized view to scott;
-- for refresh manually
select * from dbms_mview.refresh('mv_1');

--Data dictionary for materialized view
select * from user_mviews;

select * from mv_1;
select * from mv_2;


select * from emp;




_____________________________________________________________

CREATE MATERIALIZED VIEW MV_V1
AS(SELECT * FROM EMP);

SELECT * FROM MV_V1;


SELECT * FROM USER_MVIEWS;

-------------------
CREATE MATERILIZED VIEW MV_V2
BUILD IMMEDIATE
REFRESH COMPLETE
ON DEMAND
START WITH SYSDATE EXT SYSDATE+2
AS(SELECT CUST_ID,COUNT(CUST_ID) AS CUSTOMER_COUNT
FROM CUSTOMER
GROUP BY CUST_ID);


---------------------create default m-view--------------------------
CREATE MATERIALIZED VIEW MV_V3
AS(SELECT * FROM CUSTOMER);

SELECT * FROM MV_V3;


SELECT * FROM USER_MVIEWS; 


SAVEPOINT VIEW;

----------creating m-view manually----------------------

CREATE MATERIALIZED VIEW MV_V2
BUILD IMMEDIATE
REFRESH COMPLETE
ON DEMAND
START WITH SYSDATE NEXT SYSDATE+2
AS(SELECT CUST_ID,COUNT(CUST_ID) AS CUSTOMER_COUNT
FROM CUSTOMER
GROUP BY CUST_ID);

SELECT * FROM MV_V2;

SELECT * FROM CUSTOMER;

SELECT * FROM USER_MVIEWS;

INSERT INTO CUSTOMER VALUES(1012,'SHVNARSH',34567887,101,'','');




-----------------on demand refresh-----------------------
EXEC DBMS_MVIEW.REFRESH('mv_v2');



SELECT * FROM USER_MVIEWS;


ROLLBACK VIEW;


-----------------------------------------------------------
CREATE MATERIALIZED VIEW MV_V2
BUILD IMMEDIATE
REFRESH COMPLETE
ON DEMAND
START WITH SYSDATE NEXT SYSDATE+2
AS(SELECT CUST_ID,COUNT(CUST_ID) AS CUSTOMER_COUNT
FROM CUSTOMER
GROUP BY CUST_ID);

COMMIT;


ROLLBACK VIEW;
