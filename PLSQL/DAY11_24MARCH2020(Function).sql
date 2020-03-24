/*
##################################################
 Objective                : PL/SQL Function
 Author(Creator) Name     : Shailendra Yadav
 Developed / Created Date : 24-March-2020
##################################################
*/



insert into customer_tgt
select * from A
where rowid in (select max(rowid) from A
		 group by col1,clo2)


ans 8
merge is a dml command



Function 
1. DB object which gets stored inside a db
2. It should return a value

Difference between procedure and functions
procedure
1. May or maynot return a value	
2. It is used for data processing  and appling logics
3. Cannot be called in select statement

function
1. Must return a vaule
2. Calculations
3. U can call in select statement.



create or replace function fn_empcount return int as 
v_cnt int;
begin
select count(*) into v_cnt from emp;
return v_cnt;
end;


set serveroutput on

select fn_enpcount from dual;


variable b_no number
exec :b_no:=fn_empcount;
print :b_no


3rd method

declare
v_count int;
begin 
v_count :=fn_empcount;
dbms_output.put_line(v_count);



if i want to return total sal of emp


create or replace function fn_empcount(p_sumsal out number, p_avgsal number) return int as 
v_cnt int;
begin
select count(empno),sum(sal),Avg(sal) into v_cnt, p_sumsal, p_avgsal 
from emp;
return v_cnt;
end;


set serveroutput on
variable b_sum number
select fn_empcount from dual



variable b_no number
variable b_avg number
exec :b_no:=fn_empcount(:b_sum, :b_avg);
print :b_no :b_sum :b_avg




create or replace function fn_inout(p_in number) return int as

begin 
p_in:p_in+100;
return v_sal;
end;



write a function by passing age and gender, if age is more than18 return the no of employees who are in that age and gender elese return 0.

create or replace function fn_cust(p_gen char,p_age int) return 
int as
v_cnt int;
begin
if p_age>18 then
select count(*) into v_cnt form customers
where trunc(months_between(sysdate,dob)/12)=p_age and gender=p_gen;
return v_cnt;
else
return 0;
end if;
end;




--###########################################################################################

--1.Write a function to print the factorial of a number.

CREATE OR REPLACE FUNCTION FACT (
    V_NO INT
) RETURN INT IS
    NUM INT := 1;
BEGIN
    FOR I IN REVERSE 1..V_NO LOOP NUM := NUM * I;
    END LOOP;

    RETURN NUM;
END;

DECLARE
    C INT;
BEGIN
    C := FACT(5);
    DBMS_OUTPUT.PUT_LINE(C);
END;

SELECT
    FACT(5)
FROM
    DUAL;
                        
--2. Write a plsql function by passing age and gender, 
--  if age <18 then return 0 otherwise return the no. of employees who are in that age and gender.
      
CREATE OR REPLACE FUNCTION vcount (
    v_age      INT,
    v_gender   VARCHAR
) RETURN INT IS
    count INT := 0;
BEGIN
    IF v_age > 18 THEN
        SELECT
            COUNT(1)
        INTO count
        FROM
            customer_detail
        WHERE
            trunc(months_between(sysdate, dob) / 12) > v_age
            AND gender = v_gender;

    END IF;

    RETURN count;
END;

DECLARE
    cnt INT;
BEGIN
    cnt := vcount(20, 'male');
    dbms_output.put_line('no of customer are' || cnt);
END;

--3. Write a function that takes P,R,T as inputs and returns SI. SI=P*R*T/100

CREATE OR REPLACE FUNCTION simp (
    p   INT,
    r   INT,
    t   INT
) RETURN NUMBER IS
    si NUMBER;
BEGIN
    si := ( p * r * t ) / 100;
    RETURN si;
END;

SELECT
    simp(10, 20, 30)
FROM
    dual;
    
    
--4.Write a function which takes a date in string format and display whether it is a valid date or not.
        
CREATE OR REPLACE FUNCTION datefunc (
    sdate VARCHAR
) RETURN VARCHAR IS

    b       VARCHAR(35);
    v_mon    VARCHAR(3);
    v_mon2   INT;
    v_year   NUMBER(4);
    v_day    NUMBER(2);
BEGIN
    IF length(sdate) = 11 OR length(sdate) = 10 THEN
        IF length(sdate) = 11 THEN
            v_mon    := lower(substr(sdate, 4, 3));
     --01-jan-2020
            v_year   := to_number(substr(sdate, 8));
            v_day    := to_number(substr(sdate, 1, 2));
            IF v_mon IN (
                'jan',
                'feb',
                'mar',
                'apr',
                'may',
                'jun',
                'jul',
                'aug',
                'sep',
                'oct',
                'nov',
                'dec'
            ) AND v_day >= 1 AND v_day <= 31 AND length(v_year) = 4 AND v_year > 0 THEN
                b := sdate || ' IS A VALID DATE';
            ELSE
                b := sdate || ' IS NOT VALID DATE';
            END IF;

        END IF;

        IF length(sdate) = 10 THEN
            v_mon2   := to_number(substr(sdate, 4, 2));
      --  01-12-1995
            v_year   := to_number(substr(sdate, 7));
            v_day    := to_number(substr(sdate, 1, 2));
            IF v_mon BETWEEN 1 AND 12 AND v_day BETWEEN 1 AND 31 AND length(v_year) = 4 AND v_year > 0 THEN
                b := sdate || ' IS A VALID DATE';
            ELSE
                b := sdate || ' IS NOT VALID ';
            END IF;

        END IF;

    ELSE
        b := sdate || 'NOT VALID DATE';
    END IF;

    RETURN b;
END;

SELECT
    datefunc('asd')
FROM
    dual;

DECLARE
    vdate VARCHAR(45);
BEGIN
    vdate := datefunc('01-FEB-1995');
    dbms_output.put_line(vdate);
END;



--5.Write a function which takes Email as input and display whether it is a valid email id or not. 
--      The rules for finding out validity of email is –
--o   It should contain at least one ‘@’ symbol.
--o   It should not contain more than one @ symbol.
--o   Email id should not start and end with @
--o   After @ there should be at least 2 tokens.  (i.e .co.in but not .com)
            
CREATE OR REPLACE FUNCTION emailvalidator (
    email VARCHAR
) RETURN VARCHAR IS
    v_result   VARCHAR(30);
    dot       INT;
    v_ext     VARCHAR(20);
BEGIN
    IF regexp_count(email, '@') = 1 AND substr(email, 1, 1) <> '@' AND substr(email, -1, 1) <> '@' THEN
        dot := length(substr(email, 1, instr(email, '@') - 1)) - length(replace(substr(email, 1, instr(email, '@') - 1), '.', '')
        );

        IF length(substr(email, instr(email, '.', 1, dot + 1))) - length(replace(substr(email, instr(email, '.', 1, dot + 1)), '.'
        , '')) >= 2 THEN
            v_result := ' IS VALID EMAIL';
        ELSE
            v_result := 'NOT VALID EMAIL';
        END IF;

    ELSE
        v_result := ' IS NOT VALID EMAIL ID';
    END IF;

    RETURN v_result;
END;

DECLARE
    email      VARCHAR(30) := 'shailendran70@gmail.com';
    resultss   VARCHAR(30);
BEGIN
    resultss := emailvalidator(email);
    dbms_output.put_line(resultss);
END;  


--6.Write a function to print the factorial of a number without using loop(Hint:Use recursive function)
        

--7. Write a function which takes a value from the user and check whether the given values is a number or not. 
--If it is a number, return ‘ valid Number’ otherwise ‘invalid number’.
--Phone Number- should have 10 digits, all should be numbers and phno should start with 9 or 8 or 7.
            
                              
CREATE OR REPLACE FUNCTION checknumber (
    num VARCHAR
) RETURN VARCHAR IS
    v_result VARCHAR(100);
BEGIN
    IF regexp_count(num, '\d') = 10 AND substr(num, 1, 1) IN (
        '9',
        '8',
        '7'
    ) AND length(num) = 10 THEN
        v_result := 'VALID PHONE NUMBER';
    ELSE
        v_result := 'NOT VALID PHONE NUMBER';
    END IF;

    RETURN v_result;
END;

DECLARE
    ans VARCHAR(100);
BEGIN
    ans := checknumber('&ENTER_PHONE_NUMBER');
    dbms_output.put_line(ans);
END;


--8. Can we write DML inside a function? If yes, Write a plsql function to update the job of an employee by passing empno and 
--returning the updated job. 
--Can we execute in Select statement?Use returning clause to return the updated job.

Yes we can write dml statements inside the function.

CREATE OR REPLACE FUNCTION empupdate (
    empn   INT,
    v_job   VARCHAR
) RETURN VARCHAR IS
    res      VARCHAR(40);
    v_name   VARCHAR(20);
BEGIN
    UPDATE emp
    SET
        job = v_job
    WHERE
        empno = empn;


    SELECT
        ename,
        job
    INTO
        v_name,
        res
    FROM
        emp
    WHERE
        empno = empn;

    res := 'UPDATED JOB FOR EMP '
           || v_name
           || ' IS - '
           || v_job;
    RETURN res;
END;

DECLARE
    ress VARCHAR(40);
BEGIN
    ress := empupdate(7788, 'ANALYST');
    dbms_output.put_line(ress);
END;


--9.Create a function that takes date as input and return the no of customers who made sales in that year.


CREATE OR REPLACE FUNCTION f_cust_count (
    sdate DATE
) RETURN INT IS
    res INT;
BEGIN
    SELECT
        COUNT(cust_id)
    INTO res
    FROM
        sales
    WHERE
        cust_id IN (
            SELECT DISTINCT
                cust_id
            FROM
                sales
            WHERE
                to_char(sales_date, 'YYYY') = to_char(sdate, 'YYYY')
        );

    RETURN res;
END;

DECLARE rescnt int
begin
    rescnt := cust_count(sysdate);
    dbms_output.put_line('NO OF CUSTOMERS MADE SALES' || rescnt);
END;



10.Write  a function by passing 2 dates and return the no. of Saturdays between two dates.
                  
11.Write a function by passing  2 dates and display the months between 2 dates. Ex jan-15 and jul-15   o/p  Feb-15,Mar-15,Apr-15,May-15,Jun-15.

12.Create a function by passing to  2 strings, if it is a number print the sum of 2 numbers else print the concatenation of 2 strings.

13.Write a function to return all the column names by passing table_name at runtime.

14.Can we call a procedure inside function or can we call function inside a function? Write a code with your own scenario.

15.Write a function to return the YTD sales amount of current year and previous year.

16.Can we call procedure inside a procedure or function inside a procedure? Write a code with your own scenario.



























