/*
################################################
Objective                : Exception Handling
Author(Creator) Name     : Shailendra Yadav
Developed / Created Date : 18-March-2020
################################################
*/
SET SERVEROUTPUT ON;

exceptions ( 6 questions)

 

--1.      Write a plsql block with your own scenario for

--a.       'No data Found'

--Pass the empno and get ename and salary of that employee.

--declaring variables
DECLARE
    v_eno     NUMBER(8) := '&empno';    --variable for employee no.
    v_ename   VARCHAR(30);              --variable for employee name.
    v_sal     NUMBER(12, 2);            --variable for employee salary.
BEGIN
    SELECT
        ename,
        sal
    INTO
        v_ename,
        v_sal
    FROM
        emp
    WHERE
        empno = v_eno;

    dbms_output.put_line(v_ename
                         || ' '
                         || v_sal);

------exception block starts from here-----
EXCEPTION                               
    WHEN no_data_found THEN
        dbms_output.put_line('No emp with empno :' || v_eno);
    WHEN OTHERS THEN
        dbms_output.put_line('Please try again');
------exception block ends here-----
END;


--b.      'Invalid number'

--Pass the empno and get ename and salary of that employee.

--declaring variables
DECLARE
    v_eno     NUMBER(8)     := '&empno';    --variable for employee no.
    v_ename   VARCHAR(30);              --variable for employee name.
    v_sal     NUMBER(12, 2);            --variable for employee salary.
    invalid_number exception;
BEGIN
    SELECT
        ename,
        sal
    INTO
        v_ename,
        v_sal
    FROM
        emp
    WHERE
        empno = v_eno;

    dbms_output.put_line(v_ename
                         || ' '
                         || v_sal);

------exception block starts from here-----
EXCEPTION                               
    WHEN no_data_found THEN
        dbms_output.put_line('No emp with empno :' || v_eno);

    WHEN invalid_number THEN
        dbms_output.put_line('invalid no :' || v_eno);

    WHEN OTHERS THEN
        dbms_output.put_line('Please try again');
------exception block ends here-----
END;


--c.       'Value error'



--d.      'Dup val on index'

-- Write a code to insert deptno,dname and loc into dept table.

--declaring variables
DECLARE 
    v_deptno   NUMBER(10) := '&dno';
    v_dname    VARCHAR(20) := '&dname';v_loc
varchar(30) := '&loc';

BEGIN
    INSERT INTO dept VALUES (
        v_deptno,
        v_dname,
        v_loc
    );

    COMMIT;
    dbms_output.put_line('Record inserted');
EXCEPTION
    WHEN dup_val_on_index THEN
        dbms_output.put_line('Deptno already exists');
    WHEN OTHERS THEN
        dbms_output.put_line('Please Try Again');
END;


--e.      'too_many_rows'

DECLARE
    v_emp emp.ename%TYPE;
BEGIN
    SELECT
        ename
    INTO v_emp
    FROM
        emp
    WHERE
        empno > 1000;

EXCEPTION
    WHEN too_many_rows THEN
        dbms_output.put_line(' ');
        dbms_output.put_line('Exception handler for too many rows.');
        dbms_output.put_line('blocks'' exception handler worked!');
END;

--f.      Invalid Cursor



--g.      Cursor already open


--h.      Zero divide

DECLARE
    v_a INT;
BEGIN
    v_a := 8 / 0;
EXCEPTION
    WHEN zero_divide THEN
        dbms_output.put_line(' ');
        dbms_output.put_line('Exception handler for zero divide.');
        dbms_output.put_line('blocks'' exception handler worked!');
END;

--i.   Case not found



--j.   When others then


--2.   Write a plsql block by passing the account no, if it doesn't start from s or u or p then raise an exception and handle it, also include when others then exception.

DECLARE
    v_ac_no VARCHAR(20);
    invalid_accno EXCEPTION;
BEGIN
    SELECT
        accno
    INTO v_ac_no
    FROM
        acc
    WHERE
        v_ac_no NOT LIKE '%s'
        OR v_ac_no NOT LIKE '%u'
           OR v_ac_no NOT LIKE '%p';

    IF v_ac_no NOT LIKE '%s' OR v_ac_no NOT LIKE '%u'
                                OR v_ac_no NOT LIKE '%p' THEN
        RAISE invalid_accno;
    END IF;

EXCEPTION
    WHEN invalid_accno THEN
        dbms_output.put_line('accno doesnot exist');
    WHEN OTHERS THEN
        dbms_output.put_line('try later');
END;


--3.   Write a plsql block to handle 'Child records found' related non predefined exception which has the error no -2292, also include when others then exception.

DECLARE
    child_ex EXCEPTION;
    PRAGMA exception_init ( child_ex, -2292 );
BEGIN
    DELETE FROM country
    WHERE
        country_id = 2;

EXCEPTION
    WHEN child_ex THEN
        dbms_output.put_line('child records found');
END;


--4.   Write a procedure to print ename and dname by passing empno and deptno. If u pass invalid empno and valid deptno, it has to print 'Invalid empno' and print dname. If u pass valid empno and invalid deptno, it has to print ename and  'invalid deptno'. If u pass both valid then it has to print ename and dname. If u pass both invalid then print 'invalid empno' and 'invalid deptno', also include when others then exception.

DECLARE
v_eno emp.empno%TYPE :=&empno;
v_dno emp.deptno%TYPE :=&deptno;
v_ename emp.ename%TYPE;
v_dname dept.dname%TYPE;

BEGIN
SELECT e.ename, d.dname INTO v_ename, v_dname
FROM emp e, dept d
WHERE e.deptno=d.deptno
AND e.deptno =v_dno
AND e.empno =v_eno

if v_ename is not null AND v_dname is not null
THEN




END;


--5.   Write a procedure to divide the salary of all employees by its commission and handle zero divide exception and also insert the divided value into a table, also include when others then exception.

--6.   Write a procedure by passing empno, the empno passed should be in the range 1000 to 5000, also include when others then exception. If it violates this rule create a user defined exception and handle it.

--7.   Pass the empno and update the job of that employee to SSE. If the empno passed does not exist, and the update did not happen handle the no data found exception by raising it and print the error number and err message using SQLCODE and SQLERRM, also include when others then exception.

--8.   Pass a string of numbers as 10,20,80,70,60 and display the number which is maximum in it.

--9.   Pass a empno and display the grade of the salary of passed employee. If sal>30000 print 'Grade A', salary>20000 then 'Grade B' Sal>10000 then 'Grade C' else 'no grade' using case in PLSQL, also include when others then exception.

--10.  Pass a string, if the string contains 2 words display each word in new line else raise the error and handle the exception


