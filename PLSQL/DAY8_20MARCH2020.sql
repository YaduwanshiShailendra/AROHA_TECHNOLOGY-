/*
##################################################
 Objective                : Cursor
 Author(Creator) Name     : Shailendra Yadav
 Developed / Created Date : 19-March-2020
##################################################
*/

SET SERVEROUTPUT ON;

cursors ( 9 questions)
1. Write a procedure to display the records of employees whose salary is greater than 10000.

DECLARE
    CURSOR cus IS
    SELECT
        *
    FROM
        emp
    WHERE
        sal > 3000;

    v_empdetail cus%TYPE;
BEGIN
    OPEN cus;
    LOOP
    FETCH cus INTO v_empdetail;
    EXIT WHEN cus%notfound;
    dbms_output.put_line(v_empdetail);
END loop;

CLOSE cus;

end;

2. Write a procedure to increment the salary of an employee based on his salary

If salary>20000 increment by 1500

If salary>10000 increment by 1000

If salary>5000 increment by 500

Else ‘no increment’

DECLARE
    v_sal emp.sal%TYPE;
    CURSOR c_emp IS
    SELECT
        sal
    FROM
        emp
    FOR UPDATE OF sal;

BEGIN OPEN c_emp;
LOOP SELECT
                         c_emp
                     INTO v_sal
                     FROM
                         emp
                             exit
    WHEN c_emp%notfound;
    IF v_sal > 5000 THEN
        v_sal := v_sal + 1500;
    ELSIF v_sal BETWEEN 3000 AND 5000 THEN
        v_sal := v_sal + 1000;
    ELSIF v_sal BETWEEN 2000 AND 3000 THEN
        v_sal := v_sal + 800;
    ELSE
        v_sal := v_sal;
    END IF;

    UPDATE emp
    SET
        sal = v_sal
    WHERE
        CURRENT OF cemp;

END LOOP;
CLOSE c_emp;
END;


3. Write a procedure to print total salary with respect to department.(deptwise total sal)

DECLARE
    v_sum   INT;
    CURSOR cdept IS
    SELECT
        deptno
    FROM
        dept;

    v_dno   NUMBER;
    CURSOR cemp (
        v_dno NUMBER
    ) IS
    SELECT
        SUM(sal)
    FROM
        emp
    WHERE
        deptno = v_dno;

BEGIN
    OPEN cdept;
    LOOP
        FETCH cdept INTO v_dno;
        EXIT WHEN cdept%notfound;
        dbms_output.put_line('TOTAL salary of deptno ' || v_dno);
        OPEN cemp(v_dno);
        LOOP
            FETCH cemp INTO v_sum;
            EXIT WHEN cemp%notfound;
            dbms_output.put_line(v_sum);
        END LOOP;

        CLOSE cemp;
    END LOOP;

    CLOSE cdept;
END;

4. Write a procedure to print ename, job, mgr and deptno using record type by passing the empno at runtime.

DECLARE
    v_empno       emp.empno%TYPE := &enter_empno;
    CURSOR cemp (
        v_empno NUMBER
    ) IS
    SELECT
        ename,
        job,
        mgr
    FROM
        emp
    WHERE
        empno = v_empno;

    v_empdetail   cemp%rowtype;
BEGIN
    OPEN cemp(v_empno);
    LOOP
        FETCH cemp INTO v_empdetail;
        EXIT WHEN cemp%notfound;
        dbms_output.put_line(v_empdetail.ename
                             || ' '
                             || v_empdetail.job
                             || ' '
                             || v_empdetail.mgr);

    END LOOP;

    CLOSE cemp;
END;

5. Write a procedure to delete the duplicate records using cursor.



6. Write a procedure to print top 5 employees based on the salary in each dept using cursor.

DECLARE
    v_dno     dept.deptno%TYPE;
    v_ename   emp.ename%TYPE;
    CURSOR cdept IS
    SELECT
        deptno
    FROM
        dept;

    CURSOR cemp (
        v_dno NUMBER
    ) IS
    SELECT
        ename
    FROM
        (
            SELECT
                ROWNUM AS rn,
                ename
            FROM
                (
                    SELECT
                        ename
                    FROM
                        emp
                    WHERE
                        deptno = v_dno
                    ORDER BY
                        sal DESC
                )
        )
    WHERE
        rn <= 5;

BEGIN
    OPEN cdept;
    LOOP
        FETCH cdept INTO v_dno;
        EXIT WHEN cdept%notfound;
        dbms_output.put_line('TOP 5 EMPLOYEE OF DEPT NO ' || v_dno);
        OPEN cemp(v_dno);
        LOOP
            FETCH cemp INTO v_ename;
            EXIT WHEN cemp%notfound;
            dbms_output.put_line(v_ename);
        END LOOP;

        CLOSE cemp;
    END LOOP;

    CLOSE cdept;
END;

7.Write a procedure to print the Output as

Deptname :Accounts

John

Smith

Deptname: Hr

Clark

Miller


DECLARE
    v_dno     emp.deptno%TYPE;
    v_dname   dept.dname%TYPE;
    v_ename   emp.ename%TYPE;
    CURSOR cemp (
        v_dno NUMBER
    ) IS
    SELECT
        ename
    FROM
        emp
    WHERE
        deptno = v_dno;

    CURSOR cdept IS
    SELECT
        deptno,
        dname
    FROM
        dept;

BEGIN
    OPEN cdept;
    LOOP
        FETCH cdept INTO
            v_dno,
            v_dname;
        EXIT WHEN cdept%notfound;
        dbms_output.put_line('DEPTNAME ' || v_dname);
        OPEN cemp(v_dno);
        LOOP
            FETCH cemp INTO v_ename;
            EXIT WHEN cemp%notfound;
            dbms_output.put_line(v_ename);
        END LOOP;

        CLOSE cemp;
    END LOOP;

    CLOSE cdept;
END;

8.Write a procedure to update the salary of employees by giving an increment of 2000 which 0belongs to dept10 and display how many rows updated.


DECLARE
    rows     INT := 0;
    up_sal   emp.sal%TYPE;
    CURSOR cs IS
    SELECT
        sal
    FROM
        emp
    WHERE
        deptno = 10
    FOR UPDATE OF sal;

BEGIN
    OPEN cs;
    LOOP
        FETCH cs INTO up_sal;
        EXIT WHEN cs%notfound;
        UPDATE emp
        SET
            sal = up_sal + 2000
        WHERE
            CURRENT OF cs;

        rows := rows + SQL%rowcount;
    END LOOP;

    dbms_output.put_line(rows || ' updated');
    CLOSE cs;
END;


9.Write a plsql program using SQL%Found,SQL%Notfound and sql%rowcount.

DECLARE
    total_rows NUMBER(2);
BEGIN
    UPDATE emp
    SET
        comm = nvl(comm, 0) + 50;

    IF SQL%notfound THEN
        dbms_output.put_line('NO EMP FOUND');
    ELSIF SQL%found THEN
        total_rows := SQL%rowcount;
        dbms_output.put_line(total_rows || '  NO OF EMPLOYEE UPDATE  ');
    END IF;

END;