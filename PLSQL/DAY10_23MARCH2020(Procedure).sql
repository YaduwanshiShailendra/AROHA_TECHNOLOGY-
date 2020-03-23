
What is a Procecure
procedure is a named block-Db object.


create or replace procedure sp_p1 as
begin 
dbms_output.put_line('Hello World')
end;

set serveroutput on;


exec sq_p1;

begin
sp_p1;
end;



customer
Account
Transaction

customer ---- Account --- Transaction
	1:M		1:M

	three modes of parameters
	IN: Default: passing a values to the procedure.
	OUT: getting the output 
	INOUT: works as both in as well as out

create or replace procedure sp_p2(p_empno in number,p_name out varchar) as 
--v_name varchar(20);
begin
select ename into v_name form emp
where empno=p-empno;
--dbms_output.put_line(v_name);
end;

variable b_nm varchar2(20)
exec sp_p2(7788, :b_nm)
print :b_nm


declare
v_nm varchar(20);
begin
sp_p2(7788,v_nm);






Write a procedure by passing an account id and txn amount for Deposit.
validate the acoount id
Insert a record in the txn table
update the balance in the account table.


create or replace procedure sp_acc(p_act_id number, p_txn_amount nummber) as
begin
select account_id into v_act_id
from accounts
if v_cnt=1 then
insert into transaction values(seq_txn.nextval,p_act_id,p_txn_amt,sysdate,'Deposit');
update accounts set bal=bal+p_txn_amount where account_id=p_act_id;
else
--dbms_output.put_line('invalid account no');
raise_application_error(-20010,'invalid account no');

end ;

exec sp_acc('A123456',5000);


-------------------------------------------
--record type
create s


--
declare
--v_rec emp%rowtype;
type t is record(ename varchar(20),
sal number(10),
comm number(5),
job varchar(20));
v_rec t;
begin
select ename, sal,comm, job into v_rec
from emp
where empno=7788;



declare 
v_val number;
type rec is record(no number, name varchar2(20), sal number, comm number);
v_rec rec;


create or replace procedure sp_inout(p_no inout number) as
begin
P_no:=p_no+100;


--###################################################################################


--1. Write a procedure by passing the date and display the whether the year is leap year or not.
--

CREATE OR REPLACE PROCEDURE leap_year (
    in_year DATE
) AS
    v_year INT;
BEGIN
    SELECT
        to_number(to_char(in_year, 'YYYY'))
    INTO v_year
    FROM
        dual;

    IF MOD(v_year, 4) = 0 AND MOD(v_year, 100) != 0 OR MOD(v_year, 400) = 0 THEN
        dbms_output.put_line(v_year || ' is a leap year ');
    ELSE
        dbms_output.put_line(v_year || ' is not a leap year.');
    END IF;

END;


EXEC LEAP_YEAR(SYSDATE);

BEGIN
LEAP_YEAR('&ENTER_DATE');
END;


--OR


CREATE OR REPLACE PROCEDURE leap_year (
    in_year DATE
) AS
    v_year INT;
BEGIN
    v_year := to_number(to_char(in_year, 'YYYY'));
    IF add_months(trunc(in_year, 'yyyy'), 12) - trunc(in_year, 'yyyy') > 365 THEN
        dbms_output.put_line('THE GIVEN YEAR '
                             || v_year
                             || ' IS LEAP YEAR');
    ELSE
        dbms_output.put_line('IT YEAR '
                             || v_year
                             || ' IS NOT LEAP YEAR');
    END IF;

END;

EXEC leap_year(sysdate);





--2. Write a procedure which takes product name and print a message if it made sales today or not?
--
CREATE OR REPLACE PROCEDURE SOLD_OR_NOT (
    PRODNAME VARCHAR
) AS
    P_INT INT;
BEGIN
    SELECT
        COUNT(1)
    INTO P_INT
    FROM
        SALES
    WHERE
        PRODUCT_ID = (SELECT PRODUCT_ID
                      FROM PRODUCT 
                      WHERE PRODUCT_NAME=PRODNAME)
        AND TO_CHAR(TX_DATE) = TO_CHAR(SYSDATE);

    IF P_INT > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Product is sold today');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Product '
                             || PRODNAME
                             || ' not sold today');
    END IF;

END;

EXEC SOLD_OR_NOT('SHOES');

--3. Write a procedure which takes product name and print the no. of sales it made in the current year and in previous year.
--

CREATE OR REPLACE PROCEDURE COUNT_OF_SALES (
    PRODNAME VARCHAR
) AS
    P_INT INT;
BEGIN
    SELECT
        SUM(SALES_QTY)
    INTO P_INT
    FROM
        SALES
    WHERE
        PRODUCT_ID IN (SELECT PRODUCT_ID
                      FROM PRODUCT 
                      WHERE PRODUCT_NAME=PRODNAME)
        AND TX_DATE >= ADD_MONTHS(TRUNC(SYSDATE, 'YY'), - 12)
        AND TX_DATE <= ADD_MONTHS(TRUNC(SYSDATE, 'YY'), + 12) - 1;
    --PRINT THE QTY SOLD IN TWO YEARS
    DBMS_OUTPUT.PUT_LINE('NO OF QTY SOLD OF PRODUCT'
                         || PRODNAME
                         || ' ='
                         || P_INT);
END;

EXEC COUNT_OF_SALES('SHOES');


--OR

CREATE OR REPLACE PROCEDURE COUNT_OF_SALES (
    PRODNAME VARCHAR
) AS
P_INT INT;
BEGIN
    SELECT
        COUNT(1)
    INTO P_INT
    FROM
        SALES
    WHERE
        PRODUCT_ID IN (SELECT PRODUCT_ID
                      FROM PRODUCT 
                      WHERE PRODUCT_NAME=PRODNAME)
        AND TX_DATE >= ADD_MONTHS(TRUNC(SYSDATE, 'YY'), - 12)
        AND TX_DATE <= ADD_MONTHS(TRUNC(SYSDATE, 'YY'), + 12) - 1;

    DBMS_OUTPUT.PUT_LINE('NO OF QTY SOLD OF PRODUCT'
                         || PRODNAME
                         || ' ='
                         || P_INT);
     --PRINTS NOT OF SALES MADE NOT QTY.
END;

EXEC COUNT_OF_SALES('SHOES');


--4.Write a code which takes cust_id and display whether he is from metro city or not.
--


--5.Write a procedure which accepts an email id as input and prints the domain name of that email id (Eg: I/p john@gmail.com. o/p: gmail)
--
--6. Write a procedure to populate all the records from cust_src to cust_tgt but the condition is there should not be any duplicate records.
--
--Cust_src
--
--Cust_id                 cust_name         cust_addr            cust_city
--
-- 
--
--Cust_tgt
--
--Cust_id                 Cust_name         cust_addr            Cust_city
--
-- 
--
--7.Write a block which takes deptno, dname and location as one string as input. For Ex: ’10,Sales,New York’ and  Check whether the first value in the argument  which supposed to be a value for deptno is a number or not.   If the value is a number, display it is a number, else It is not a Number.
--
-- 
--
--8. Write a procedure by passing empno and print ename as out parameter.
--
--9.Write a procedure to load all the records from emp_src to emp_tgt. If there is any change in src tables,
--
--the procedure should automatically reflect that change in the target table. Critical columns are Sal,Job,deptno which frequently changes using merge.
--
-- 
--
-- 
--
--Emp_src                                                                                               Emp_tgt
--
-- 
--
--
--Emp_id
--
--Ename
--
--Sal
--
--Job
--
--Hiredate
--
--Deptno
--
--Emp_id
--
--Ename
--
--Sal
--
--Job
--
--Hiredate
--
--deptno
--
-- 
--
-- 
-- 
--
-- 
--
-- 
--
-- 
--
--
--10. Write a procedure to load unique records in one table and duplicate records in another table.
--
--Customer
--
-- 
--
-- 
--
-- 
--
--cust_name
--
--cust_phone
--
--cust_city
--
--cust_since
--
--TIM
--
--12345678
--
--Chennai
--
--15-Jan-05
--
--BALA
--
--49595089
--
--Chennai
--
--16-Jan-06
--
--RAMESH
--
--345093450
--
--Mumbai
--
--17-Feb-07
--
--TIM
--
--12345678
--
--Chennai
--
--15-Jan-05
--
--BALA
--
--49595089
--
--Chennai
--
--16-Jan-06
--
-- 
--
--cust_target
--
-- 
--
-- 
--
-- 
--
--cust_name
--
--cust_phone
--
--cust_city
--
--cust_since
--
--TIM
--
--12345678
--
--Chennai
--
--15-Jan-05
--
--BALA
--
--49595089
--
--Chennai
--
--16-Jan-06
--
--RAMESH
--
--345093450
--
--Mumbai
--
--17-Feb-07
--
-- 
--
--cust_duplicate
--
-- 
--
-- 
--
-- 
--
-- 
--
--cust_name
--
--cust_phone
--
--cust_city
--
--cust_since
--
--no_of_instances
--
--TIM
--
--12345678
--
--Chennai
--
--15-Jan-05
--
--2
--
--BALA
--
--49595089
--
--Chennai
--
--16-Jan-06
--
--2
--
-- 
--
--11.Create a procedure which accepts an email id as input and prints if the id is valid or not.
--
-- Conditions to qualify for a mail id to be valid:
--- There should be only a single @.
--- ID not to start with @ or end with @
--- ID to end with only .com, .co.in, .biz, .org extensions
--- The user name in the ID not to be more than 64 in length
--- No numeric values after the @ in the ID


--12. Write a procedure to update the order completion date, the condition to populate that column is 
--If the order date is between Monday and Thursday then insert completion date as Friday of that week and 
--if theorder date is Friday,Saturday and Sunday then insert completion date as next Monday date.

--Orders
--                Order_date          Order_completion_date
--                01-jan-19            04-Jan-19               
--                10-jan-19            11-Jan-19
--                01-feb-19            04-Feb-19
--                20-feb-19            22-Feb-19
--                25-Feb-19            01-Mar-19


--13. Can we write return statement inside procedure, If no what type of error will you get?
Yes, You can give “Return” keyword inside procedure, however this cannot be used to return a value to calling unit, Instead this can be used to return out of the execution.

If you try to use return with an expression or value inside procedure, you will get compilation error.