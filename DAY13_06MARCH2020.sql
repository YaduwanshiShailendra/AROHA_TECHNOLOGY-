
--###########################################################################--
--                       	DAY13_06-MARCH-2020
--###########################################################################--

--SQL Questions_Test3(1-27)
-- 
--1.Display the first day of current week.
SELECT to_char(TRUNC(sysdate, 'w'), 'day') FROM dual;

--2.Write a query to print the given string as ‘Oracle’s’.(Oracle with apostrophe)
SELECT 'oracle''s' FROM DUAL;

--3.Display syadate in the format ‘1st-jan-18’ and also first-feb-twenty eighteen.
SELECT TO_CHAR(SYSDATE, 'RM-mon-yy') FROM DUAL;

--4.Display the next year first Tuesday date.
SELECT NEXT_DAY(ADD_MONTHS(TRUNC(SYSDATE, 'yy'),12)-1,'tuesday') FROM DUAL;

--5.Display all the month names using level and CTE
SELECT TO_CHAR(ADD_MONTHS(TRUNC(SYSDATE,'year'),LEVEL)-1, 'month') FROM DUAL CONNECT BY LEVEL <=12;

--6.Display all the weekday names using level and CTE
SELECT TO_CHAR(TRUNC(SYSDATE,'DAY')+LEVEL, 'DAY') FROM DUAL
CONNECT BY LEVEL BETWEEN 1 AND 5;

--7. Display the Quarterwise number of employees.
SELECT to_char(HIREDATE, 'q') AS Quarters, COUNT(ENAME) as no_of_emp
FROM EMP
GROUP BY to_char(HIREDATE, 'q');

--8. Display the numbers which r multiples of 5 using level and CTE
SELECT Level*5 AS Sequence 
FROM Dual 
CONNECT BY Level <= 5;

--9. To display the string ‘Aroha’ vertically using level and CTE
SELECT SUBSTR('Aroha', LEVEL, 1) AS  X
    FROM   dual
    CONNECT BY LEVEL <= LENGTH('Aroha');

--10. To display the dates of dec
SELECT to_char(TRUNC(TO_DATE('12', 'mm'))+LEVEL-1, 'dd-mm-yy') 
FROM dual
CONNECT BY LEVEL <=31;

--11. To display the dates from 2012 to present date using level and CTE.
SELECT to_char(TO_DATE('01-01-12', 'dd-mm-yy')+LEVEL, 'dd-mm-yy') 
FROM dual 
CONNECT BY LEVEL<=30*months_between(sysdate,TO_DATE('01-01-12', 'dd-mm-yy'));

--12. To display the dates of particular month using level and CTE.
SELECT to_char(TRUNC(TO_DATE('&MONTH_NO', 'mm'))+LEVEL-1, 'dd-mm-yy') 
FROM dual
CONNECT BY LEVEL <=LAST_DAY(TO_DATE('&MONTH_NO', 'mm'))-TRUNC(TO_DATE('&MONTH_NO', 'mm'))+1 ;

--OR

SELECT TO_DATE(MON)+LEVEL-1
FROM (SELECT TO_DATE('&ENTER_MONTH_NO','MM') MON
      FROM DUAL)
CONNECT BY LEVEL<=((ADD_MONTHS(TO_DATE(MON),1))-TO_DATE(MON));

--13. To Display all the Friday dates of this year
SELECT NEXT_DAY(ADD_MONTHS(TRUNC(SYSDATE, 'yy'),12)-1,'tuesday') FROM DUAL;

--14. Display string 'AROHA' as 'AARAROAROHAROHA'.
SELECT REPLACE(WM_CONCAT(SUBSTR('AROHA', 1, LEVEL)),',','') AS  X
FROM   dual
CONNECT BY LEVEL <= LENGTH('AROHA');


SELECT WM_CONCAT(SUBSTR('AROHA', 1, LEVEL)) AS  X
FROM   dual
CONNECT BY LEVEL <= LENGTH('AROHA');

--15.Pass the empno, if the employee exist in the table print ‘Exist’ else ‘Not Exist’.
SELECT CASE WHEN COUNT(EMPNO)=1 THEN 'emp exists' ELSE 'emp not exists' END 
FROM EMP
WHERE EMPNO='&ENTER_EMPNO';


--16. If the exp>20years print ‘old employees’
--                Exp>10years print ‘mid employees’
--                 Else ‘new employees’
--
SELECT CASE WHEN EXP>20 THEN 'old employees'
            WHEN EXP BETWEEN 11 AND 20 THEN 'mid employees'
            ELSE 'new employees'
            END
FROM EMP;

--17.  tbl1			  !  tbl2
--       Col1	col2  !	col1	col2
--       1		2	  !	1	    9
--       2		5	  !	1	    5
--       1		7	  !	3	    8
--       4		8	  !	4	    3 
--      Null	5	  !	null	null
--How many records for inner join.
--Left outer join, right outer join, full outer join and cross join by joining col1 of table1 and col1 of table2.
--TOTAL RECORDS =5        5



           


--18. Display the monthwise no. of employees, if any employee is not hired in any month, display no emp in this month’.
SELECT monno,mon, C, CASE WHEN COUNT(C)=1 THEN 'emp exists' ELSE 'no exists' END 
FROM (select to_char(hiredate,'month') H_month, count(empno) C
        from emp
        group by to_char(hiredate,'month')) A,
     (select to_char(add_months(trunc(sysdate,'year'),level)-1, 'month') MON ,
     to_char(add_months(trunc(sysdate,'year'),level)-1, 'mm') MONno 
      from dual 
      connect by level <=12) B
WHERE A.H_month(+)=B.MON
group by MON, C,monno
order by monno;




--19.Write a query to extract ‘gmail’  and ‘yahoo’from email column (abc@gmail.com,abcd@yahoo.co.in) in a table.
SELECT SUBSTR('shailendran70@gmail.com',1,INSTR('shailendran70@gmail.com','@')-1) AS USER_NAME
FROM DUAL;

--20. Display the monthwise no. of employees and the order of month should be jan, feb,mar,apr…
select to_char(hiredate, 'month'), count(empno)
from emp 
where to_char(hiredate, 'year')=to_char(sysdate, 'year')
group by to_char(hiredate, 'month');

--21.Display the enames and managers whom atleast 3 employees are reporting to him.
select e.ename, m.ename

select * from emp;
--22.Display the deptwise no. of employees in each job using case or decode or inline view.
--DEPTNO      CLERK   SALESMAN    MANAGER
-------- ---------- ---------- ----------
--    10          1          0          1
--    20          2          0          1
--    30          1          4          1
--


--23.
--T1			T2
--Id	nm		Id	nm
--1	A		null	A
--2	B		null	B
--3	C		null	C
--4	D		null	D
--Update the id’s of T2 table to the Id of T1 table.(Use Correlated update)
--


--24.
--   T1		      T1_history
--Id	nm  		Id	nm
--1	    A	    	1	A
--2	    B		    2	B
--3	    C		    5	G
--4	    D		    6	F
--
--Delete the records from T1 table which are already there in t1_history table(Use Correlated delete).


--25. 
--create table tgt_data_feb14
--st_id	st_namemarks
--100	RAM	45
--101	TIM	85
--102	BALA	95
--
--create table tgt_data_feb14
--O/P:Display the output as:
--st_id   st_name marks   	top_marks	 least_marks 	varience_first_lowest 	varience_first_highest
--100	     RAM	45	        95	       		45	         0				        -50
--101	     TIM	85	        95	      		45	        40				        -10
--102	     BALA	95	        95	       		45	        50				          0
--

create table source_data_feb14(st_id number,st_name varchar(20),marks number);
insert all
into source_data_feb14 values(100,'RAM',45)
into source_data_feb14 values(101,'TIM',85)
into source_data_feb14 values(102,'BALA',95)
SELECT * FROM DUAL;
COMMIT;

create table tgt_data_feb14(st_id number,st_name varchar(20),marks number,TOP_MARKS NUMBER,LEAST_MARKS NUMBER,VAR_F_LOWEST NUMBER,VAR_F_HIGHEST NUMBER);


--26.Find the hours and minutes of current date and time.
SELECT TO_CHAR(SYSDATE, 'HH:MI') FROM DUAL;


--27. Update the order completion date in Orders table.
--Condition:If order_date is between Monday to Thursday then completion_date is Friday.
--If order_date is Friday,Saturday then completion_date is next Monday date.
--
--Orders
--Order_date		Order_completion_date
--1-Feb-19			4-Feb-19
--5-Feb-19			8-Feb-19
--7-feb-19			8-Feb-19
--9-Feb-19			11-Feb-19
--
