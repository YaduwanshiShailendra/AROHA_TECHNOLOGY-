--###########################################################################--
--                        	   DAY2_16-MARCH-2020
--                            ----------------------
--                                    PL/SQL
--###########################################################################--

SET SERVEROUTPUT ON;

--1. Write a pl/sql code which takes a string as an input & its prints the no. of 'A' in the string.

DECLARE
    v_str     VARCHAR(25) := '&str';
    v_count   INT := 0;
BEGIN
    IF length(v_str) > 1 AND regexp_count(v_str, '[0-9]') = 0 THEN
        v_count := v_count + regexp_count(lower(v_str), '[a]');
        dbms_output.put_line(v_count);
    ELSE
        dbms_output.put_line('not a vlaid data');
    END IF;
END;

DECLARE
    v_str     VARCHAR(25) := '';
    v_count   INT := 0;
BEGIN
    << input >> v_str := '&str';
    IF length(v_str) > 1 AND regexp_count(v_str, '[0-9]') = 0 THEN
        v_count := v_count + regexp_count(lower(v_str), '[a]');
        dbms_output.put_line(v_count);
    ELSE
        GOTO input;
        dbms_output.put_line('not a vlaid data');
    END IF;

END;

SELECT
    regexp_count('shailendra', '[0-9]')
FROM
    dual;

SELECT
    length('shailendra')
FROM
    dual;

SELECT
    regexp_count(lower('shailendra'), '[a]')
FROM
    dual;


--2. Write a pl/sql code which takes dept name , dept no. & location and insert in deptartment table.

DECLARE
    v_dno     NUMBER(2) := &dno;
    v_dname   VARCHAR(25) := '&dname';
    v_dloc    VARCHAR(30) := '&dloc';
BEGIN
    INSERT INTO dept VALUES (
        v_dno,
        v_dname,
        v_dloc
    );

    COMMIT;
    dbms_output.put_line('Inserted successfully.');
END;


--3. Write a pl/sql code which takes empno & increment percentage & insert the salaary of that emp by that percentage.

DECLARE
    v_eno   NUMBER(4) := &eno;
    v_per   NUMBER(3) := &per;
BEGIN
    UPDATE emp
    SET
        sal = sal + ( sal * v_per / 100 )
    WHERE
        empno = v_eno;

    COMMIT;
    dbms_output.put_line('Updated successfully.');
END;


--4. Write a pl/sql code which passing the empno & getting the enpname & salary.

DECLARE
    v_eno     NUMBER(4) := &eno;
    v_ename   VARCHAR(30);
    v_sal     NUMBER(20);
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
                         || '			'
                         || v_sal);
END;







--##############################################################

DECLARE
v_sid int;
v_cid NUMBER :=&cid;
v_pid NUMBER :=&pid;
v_qty NUMBER :=&qty;
v_amt NUMBER :=&amt;
BEGIN
SELECT max(sid)+1 INTO v_sid
from sales;
if v_qty>6
THEN
rais invalid_qty
ELSE
insert into sales VALUES(v_sid, v_cid, v_pid, v_qty, v_amt, sysdate);
endif;

exception
when invalid_qty THEN
dbms_output.put_line('Qty to be less then 6.');
when invalid_qty THEN
dbms_output.put_line('Try later.');
END;
















