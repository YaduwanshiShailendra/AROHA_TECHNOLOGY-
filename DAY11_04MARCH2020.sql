--display the date, week days

select to_char(trunc(sysdate,'mon')+level-1, 'day') from dual connect by level <=7;

select to_char(add_months(trunc(sysdate,'year'),level)-1, 'month') from dual connect by level <=12;

select to_date('&datett','ddmmyy'), (case when to_char(to_date('&datett','ddmmyy'), 'd') in (1,7)
            then 'weekend'
            else 'week days' 
            end) as days
from dual;



--############################################################################
--                  SQL Questions
--############################################################################

--1.Display the employees who joined the company in the last year.
SELECT ENAME
FROM EMP
WHERE TO_CHAR(HIREDATE,'YYYY')=TO_CHAR(SYSDATE,'YYYY')-1;

--2.Display the employees whose age >30.Assume there is a DOB column in employee table.
SELECT ENAME
FROM EMP
WHERE MONTHS_BETWEEN(SYSDATE,DOB)/12 >30;

--3.Display the employees whose salary is greater than John�s salary.
SELECT ENAME
FROM EMP
WHERE SAL>(SELECT SAL
          FROM EMP
          WHERE ENAME='JOHN');

--4.Display the oldest employee based on experience in each department.
SELECT DEPTNO,ENAME
FROM EMP E1
WHERE HIREDATE=(SELECT MIN(HIREDATE)
                FROM EMP E1
                WHERE E1.DEPTNO=E2.DEPTNO);

--5.Display the latest 3 employees who joined the company very recently.
SELECT ENAME 
      FROM (SELECT DENSE_RANK() OVER(ORDER BY HIREDATE DESC) AS RN, EMP.*
            FROM EMP)
WHERE RN<4;


SELECT ENAME 
FROM (SELECT ROWNUM SLNO, ENAME, HIREDATE
      FROM (SELECT DISTINCT HIREDATE, ENAME
            FROM EMP
            ORDER BY HIREDATE DESC))
WHERE SLNO<4;



--6.Display the dname which has highest no. of employees.
SELECT DNAME,COUNT(EMPNO) 
FROM DEPT D,EMP E
WHERE E.DEPTNO=D.DEPTNO
GROUP BY DNAME
HAVING COUNT(EMPNO)=(SELECT MAX(COUNT(EMPNO))
                 FROM EMP
                 GROUP BY DEPTNO);

--7.Display the dname whose having atleast 5 employees.
SELECT DNAME,COUNT(EMPNO)
FROM DEPT D,EMP E
WHERE D.DEPTNO=E.DEPTNO
GROUP BY DNAME
HAVING COUNT(EMPNO)>=5;

--8.Display the top 3 employees based on their salary.
SELECT ENAME
           FROM (  SELECT ENAME,DENSE_RANK() OVER(ORDER BY SAL DESC)RN
          FROM EMP)
          WHERE RN<4;

--9.Display Nth highest salary.
SELECT SAL
FROM (SELECT ROWNUM SNO,SAL
      FROM (SELECT DISTINCT SAL
            FROM EMP
            ORDER BY SAL DESC))
WHERE SNO='&Nth input'; 

--10.Display the employees whose salary is greater than the average salary in its department.
SELECT ENAME
FROM EMP E
WHERE SAL>(SELECT AVG(SAL)
            FROM EMP R
            WHERE E.DEPTNO=R.DEPTNO);

--11.Display the employees whose getting the highest salary in each dept.
SELECT ENAME
FROM EMP E
WHERE SAL=(SELECT MAX(SAL)
            FROM EMP R
            WHERE E.DEPTNO=R.DEPTNO);

--12.Display deptwise no. of employees without using group by.
SELECT  D.DNAME,(SELECT COUNT(EMPNO)
FROM EMP E1
WHERE E1.DEPTNO=D.DEPTNO) AS COUNT
FROM DEPT D;

--13.Display the employees whose joined the company from last 2 years.
SELECT ENAME 
FROM EMP 
WHERE TO_CHAR(HIREDATE,'YY')=TO_CHAR(ADD_MONTHS(TRUNC(SYSDATE,'YY'),-24),'YY'));

--14.Display the employees who joined the company in the 3rd quarter of last year.
SELECT ENAME 
FROM EMP
WHERE TO_CHAR(HIREDATE,'Q')=3
AND TO_CHAR(HIREDATE,'YY')=TO_CHAR(SYSDATE,'YY')-1;

--15.Display the employees who joined the company this week in this month.
SELECT ENAME
FROM EMP
WHERE TO_CHAR(HIREDATE,'WMMYY')=TO_CHAR(SYSDATE,'WMMYY');

--16.Display the employees who joined the company in the first quarter of 1 to 10 days.
SELECT ENAME
 FROM EMP
 WHERE
 TO_CHAR(HIREDATE,'Q')=1
 AND TO_CHAR(HIREDATE,'D') BETWEEN '1' AND '10';

--17.Display the employees who joined the company in the Friday date of last 2 years.
SELECT ENAME 
FROM EMP
WHERE TO_CHAR(HIREDATE,'fmday')='friday'
AND HIREDATE BETWEEN TRUNC(ADD_MONTHS(SYSDATE,-24),'yy') AND SYSDATE;

--18.Display the employees whose salary is greater than manager�s salary.
SELECT ENAME, SAL
FROM EMP E
WHERE SAL > (SELECT SAL
            FROM EMP E2
            WHERE E2.EMPNO=E.MGR);

--19.Display the youngest employee in each department.
SELECT ENAME, DNAME
FROM EMP E, DEPT D
WHERE E.DEPTNO=D.DEPTNO
AND (EMPNO, DOB)= (SELECT EMPNO, MAX(DOB)
                    FROM EMP
                    GROUP BY DEPTNO);

--20.Display the department whose number of employees is more than the number of employees in a department �HR�.
SELECT DNAME
        FROM DEPT D, EMP E
        WHERE D.DEPTNO=E.DEPTNO
        GROUP BY DNAME
        HAVING COUNT(E.EMPNO)>(SELECT COUNT(EMPNO)
                                FROM EMP NATURAL JOIN DEPT
                                WHERE DNAME='HR');
                                
--21.Display the departments whose average salary is more than the average sal of department �sales�.

SELECT DNAME
FROM DEPT D, EMP E
WHERE D.DEPTNO=E.DEPTNO
GROUP BY DNAME
HAVING AVG(E.SAL)>(SELECT AVG(E.SAL)
                    FROM EMP E,DEPT D
                    WHERE E.DEPTNO=D.DEPTNO
                    AND DNAME='sales');
                                
--22.Display the number of employees present in a department of �Peter�.
SELECT COUNT(*)
FROM EMP
WHERE DEPTNO=(SELECT DEPTNO
              FROM EMP
              WHERE ENAME='peter');

--23.Display the departments whose total salary is more than 50000.
SELECT DNAME
FROM DEPT D NATURAL JOIN EMP E
GROUP BY DNAME
HAVING SUM(SAL)>10000;

--24.Display output as:
--Using Case or Derived table.
--O/P
--Deptno	 emp_count	emp_clerk_count

select deptno,count(empno) as emp_count,count(case when job='CLERK' then 1 else null end) as emp_clerk_count
from emp
group by deptno;


--25. Display gradewise No of employees by joining emp and salgrade table.
SELECT GRADE,count(empno) as no_of_emp
FROM EMP E , SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
GROUP BY GRADE;

--26.Display deptno and gradewise no. of employees
--O/p  Add a column as Salary_range in SalGrade table.
--Deptno  1201-1400	 1401-2000   2001-3000   3000and above
ALTER TABEL SALGRADE ADD SALARY_RANGE

--27.Display the employees whose salary between 3000 and 4000.;
SELECT ENAME 
FROM EMP
WHERE BETWEEN 3000 AND 4000;

--28.Display the year where maximum number of employees hired.
SELECT TO_CHAR(HIREDATE, 'YYYY') AS YEAR, COUNT(*) AS COUNT
FROM EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY')
HAVING COUNT(*)=(SELECT MAX(COUNT(*))
FROM EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY'));

--29.Display the job which has highest number of employees.
SELECT JOB, COUNT(EMPNO)
FROM EMP
GROUP BY JOB
HAVING COUNT(EMPNO)=(SELECT MAX(COUNT(EMPNO))
                    FROM EMP
                    GROUP BY JOB );

--30. Alter table emp by adding exp column with number datatype.
--Write a query to update the exp column in years by using hiredate column. (Use correlated Update.)
ALTER TABLE EMP ADD EXP NUMBER;
UPDATE EMP E 
SET EXP = (SELECT ROUND(MONTHS_BETWEEN(SYSDATE,HIREDATE)/12,2)
            FROM EMP E1
            WHERE E1.EMPNO=E.EMPNO);


--31.Display employees who are not managers.
SELECT ENAME
FROM EMP
WHERE EMPNO NOT IN (SELECT MGR
                FROM EMP);
