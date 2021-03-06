/*
################################################
Objective                : Exception Handling
Author(Creator) Name     : Shailendra Yadav
Developed / Created Date : 17-mar-2020
################################################
*/


SET SERVEROUTPUT ON; 

--1.Write a code to insert deptno,dname and loc into dept table.
--declaring variables
DECLARE 
    v_deptno   NUMBER(10) := '&dno';
    v_dname    VARCHAR(20) := '&dname';
    v_loc      VARCHAR(30) := '&loc';
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

--delete all record except deptno 10,20,30,40. and commit;

DELETE FROM dept
WHERE
    deptno NOT IN (
        10,
        20,
        30,
        40
    );

COMMIT;


--2.Write a code which takes empno and increment percentage and increment the salary of that percentage.

--declaring variables
DECLARE
    v_empno       NUMBER := &empno;
    v_increment   NUMBER := &increment;
BEGIN
    UPDATE emp
    SET
        sal = sal + sal * v_increment / 100
    WHERE
        empno = v_empno;

    COMMIT;
    dbms_output.put_line('Records updated');
END;

--3.Pass the empno and get ename and salary of that employee.

--declaring variables
DECLARE
    v_eno     NUMBER(8) := '&empno';
    v_ename   VARCHAR(30);
    v_sal     NUMBER(12, 2);
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
EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('No emp with empno :' || v_eno);
    WHEN OTHERS THEN
        dbms_output.put_line('Please try again');
END;


--4. Write a pl/sql code which take input of sales table and insert data but insert when qty should be less than 6.



DECLARE              --declaring variables
    v_sid    sales.sales_id%TYPE;
    v_cid    sales.cust_id%TYPE := &cid;
    v_stid   sales.store_id%TYPE := &stid;
    v_pid    sales.product_id%TYPE := &pid;
    v_qty    sales.sales_qty%TYPE := &qty;
    v_mode   sales.pay_mode%TYPE := '&mode';
    invalid_qty EXCEPTION;
BEGIN
    SELECT
        MAX(sales_id) + 1
    INTO v_sid
    FROM
        sales;

    IF v_qty > 6 THEN
    -- expectily raising exception
        RAISE invalid_qty;
    ELSE
        INSERT INTO sales VALUES (
            v_sid,
            v_cid,
            v_stid,
            v_pid,
            v_qty,
            v_mode,
            sysdate
        );

        COMMIT;
    END IF;

EXCEPTION
    WHEN invalid_qty THEN
        dbms_output.put_line('Qty to be less then 6.');
    WHEN OTHERS THEN
        dbms_output.put_line('Try later.');
END;




--display dept table records.

SELECT
    *
FROM
    dept;

--delete all record except deptno 10,20,30,40. and commit;

DELETE FROM dept
WHERE
    deptno NOT IN (
        10,
        20,
        30,
        40
    );

COMMIT;


--############################################################
                ---ASSIGNMENT QUESTION----
--############################################################

--1. Write a pl/sql code which takes dept name , dept no. & location and insert in deptartment table, if dno exist then increment 1 for 10 times and try to insert the data .

-- declaring variable
DECLARE
    v_dno     dept.deptno%TYPE := &dno;
    v_dname   dept.dname%TYPE := '&dname';
    v_loc     dept.loc%TYPE := '&loc';
    v_inc     INT := 0;
BEGIN
--    dbms_output.put_line('BASIC LOOP CONDITION BEGIN V_INC  : ' || v_inc);
    
    -- basic loop starts here
    LOOP
        --check deptno exist or not.
        SELECT
            deptno
        INTO v_dno
        FROM
            dept
        WHERE
            deptno = v_dno;
--        dbms_output.put_line('v_dno : '||v_dno);

        IF v_dno IS NOT NULL THEN
            v_dno := v_dno + 1;
--            dbms_output.put_line('AFTER IF CONDITION  v_dno : ' || v_dno);
        ELSE
            v_inc := 11;
        END IF;

        v_inc := v_inc + 1;
--        dbms_output.put_line('BEFORE ENDING BASIC LOOP CONDITION V_INC  :  ' || v_inc);
        EXIT WHEN v_inc > 10;
    END LOOP;
    -- basic loop ends here

    dbms_output.put_line('TRY AGAIN, LIMIT EXCEED');
    
    --exception handling block starts
EXCEPTION
    -- no data found exception handling
    WHEN no_data_found THEN
--        dbms_output.put_line('AFTER EXCEPTION CONDITION : ' || v_dno);
        INSERT INTO dept VALUES (
            v_dno,
            v_dname,
            v_loc
        );

        dbms_output.put_line('Inserted successfully');
    -- others exception handling
    WHEN OTHERS THEN
        dbms_output.put_line('TRY AGAIN');
END;



