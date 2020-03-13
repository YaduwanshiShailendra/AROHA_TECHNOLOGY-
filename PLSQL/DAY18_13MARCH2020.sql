
--###########################################################################--
--                        	   DAY17_12-MARCH-2020
--                            ----------------------
--                         PL/SQL Loops..(24 Questions)
--###########################################################################--

SET SERVEROUTPUT ON;

--PLSQL
--
--Loops..(24 Questions)
--
--1. Write a Plsql block to print numbers from 1 …10.
--
BEGIN
FOR I IN 1..10 LOOP
DBMS_OUTPUT.PUT_LINE(I);
END LOOP;
END;

--2. Write a Plsql block to find the circumference and area of a circle.(2*pi*r, pi*r*r).
DECLARE
V_R NUMBER :='&R';
V_PI NUMBER :=22/7;
BEGIN
DBMS_OUTPUT.PUT_LINE('The circumference of a circle is : ' ||2*V_PI*V_R);
DBMS_OUTPUT.PUT_LINE('The circumference of a circle is : ' ||V_PI*V_R*V_R);
END;


--3. Write a plsql block by passing 3 numbers and find the largest no. in that 3 numbers.
DECLARE 
    V_A INT :=10;
    V_B INT :=20;
    V_C INT :=30;
BEGIN
    IF
    (V_A > V_B) AND (V_A > V_C) THEN DBMS_OUTPUT.PUT_LINE(V_A||' is the largest one');
    ELSIF
    (V_B > V_A) AND (V_B > V_C) THEN DBMS_OUTPUT.PUT_LINE(V_B||' is the largest one');
    ELSE
    DBMS_OUTPUT.PUT_LINE(V_C||' is the largest one');
    END IF;
END;

--4. Write a plsql block to print ‘*’ as
--   *****
--   ****
--   ***
--   **                                                                           
--   *

declare
n number := '&n'; 
i number; 
j number; 

begin
for i in 1..n loop 
for j in reverse i..n loop 
dbms_output.put('*'); 
end loop; 
dbms_output.new_line; 
end loop; 
end;

--5. Write a plsql block to print all the dates from first date till last date by passing year at run time.
--
DECLARE
v_date date :='01-07-1990';
v_start date := trunc(v_date, 'yy');
v_end date := add_months(v_start,12)-1; 
BEGIN
while v_start <= v_end loop
dbms_output.put_line(v_start);
v_start := v_start+1;
end loop;
END;


--6. Write a plsql block by passing empno and ename, insert the passed empno and ename to the table but before inserting validate it whether it is already present or not.
--
create table emp_temp1( empno number, name varchar(20));
ALTER TABLE emp_temp1 ADD SAL NUMBER(15);
DECLARE
v_empno number :='&empno';
v_ename varchar(20) := '&ename';
BEGIN
insert into emp_temp1 values(v_empno, v_ename);
END;

SELECT * FROM EMP_TEMP1;
COMMIT;

--7. Write a plsql block to display the odd numbers from 1 to 50.
BEGIN
FOR I IN 1..50 LOOP
IF MOD(I,2)=1 THEN
DBMS_OUTPUT.PUT_LINE(I);
END IF;
END LOOP;
END;

--8. Write a plsql block to print the employee details whose name starts with s or t or j or c.
--
BEGIN
DBMS_OUTPUT.PUT_LINE(
select * from emp where substr(ename,1,1) in ('S','T','J','C');
);
END;


--9. Write a plsql block to update the salary of an employee by giving an increment of 1000 and passing the empno at runtime.

DECLARE
v_empno number :='&empno';
BEGIN
update emp_temp1 SET SAL=SAL+1000 WHERE EMPNO='&N';
END;


--10. Write a block to print the given string vertically. Eg:Aroha
--A
--R
--O
--H
--A

DECLARE
    V_A VARCHAR(20) :='AROHA';
    V_TEMP VARCHAR(1);
    V_J  INT :=1;
BEGIN
    FOR I IN 1..LENGTH(V_A) LOOP
    V_TEMP := SUBSTR(V_A,V_J,1);
    DBMS_OUTPUT.PUT_LINE(V_TEMP);
    V_J := I+1;
    END LOOP;
END;

--11. Write a plsql block to print ‘AROHA’ as AARAROAROHAROHA
DECLARE
    V_A VARCHAR(20) :='AROHA';
    V_TEMP VARCHAR(50):='';
BEGIN
    FOR I IN 1..LENGTH(V_A) LOOP
    V_TEMP :=V_TEMP|| SUBSTR(V_A,1,I);
    
    END LOOP;
    dbms_output.put_line(V_TEMP);
END;

--or

DECLARE
    V_A VARCHAR(20) :='AROHA';
    V_TEMP VARCHAR(80);
BEGIN
    FOR I IN 1..LENGTH(V_A) LOOP
    V_TEMP := SUBSTR(V_A,1,I);
    dbms_output.put_(V_TEMP);
    END LOOP;
END;




set serveroutput on;
--12. Write a block by passing a string and return the no. of vowels and consonants in that string.
--Eg:stationary  no.of vowels:4 no.of consonents:6
declare
str varchar(20) :='stationary';
v number :=0;
c number:=0;
begin
v :=REGEXP_COUNT(str,'[aeiou]');
c :=REGEXP_COUNT(str,'[bcdfghjklmnpqrstvwxyz]');
DBMS_OUTPUT.PUT_LINE(v ||'           ' || c);
end;

declare
str varchar(20) :='stationary';
v number :=0;
c number:=0;
begin
if REGEXP_COUNT(str,'[aeiou]')>0  then
v :=REGEXP_COUNT(str,'[aeiou]');
end if;
c :=length(str)-v;
DBMS_OUTPUT.PUT_LINE(v ||'           ' || c);
end;

--or

declare
str varchar(20) :='stationary';
v number :=0;
c number:=0;
begin
if REGEXP_COUNT(str,'[aeiou]')=0  then
v:=0;
elsif REGEXP_COUNT(str,'[aeiou]')>0 then
v :=REGEXP_COUNT(str,'[aeiou]');
end if;
c :=length(str)-v;
DBMS_OUTPUT.PUT_LINE(v ||'           ' || c);
end;

--13. Write a procedure to print the given string is a palindrome or not without using reverse function.
--Eg:madam is a palindrome


--14.Write a procedure to pass a string separated by comma like ab,abc,abcd,x,y and print the o/p as
--ab
--abc
--abcd
--x
--y


--15. Write a plsql block to print the number of alphabets in a given string. Eg;=abcba
--a=2
--b=2
--c=1

declare
str varchar2(20) :='ab,abc,abcd,x,y';
begin
for i in 1..regexp_count(str<',') loop
dbms_output.put_line(substr(str,i,instr(str,',')-1));
str := substr(str,instr(str,',')+1);
end loop;
dbms_output.put_line(str);
end;

--16. Write a plsql block to print the Fibonacci series from 1 to 50. v_a=0,v_b=1

--17. Write a plsql block by passing month-yy and display the no. of Saturdays in that month and year.
DECLARE
v_date date :='01-07-1990';
v_start date := trunc(v_date, 'mm');
v_end date := add_months(trunc(v_date, 'yy'),12)-1; 
BEGIN
while v_start <= v_end loop
dbms_output.put_line(v_start);
v_start := v_start+1;
end loop;
END;

select NEXT_DAY(trunc(ADD_MONTHS(TRUNC (SYSDATE ,'YEAR'),12)-1), 'saturday')-7 from dual;

--18. Write a plsql block by passing a empno so that the salary of the prior employee should incremented by 1000 and next employee salary should be decremented by 1000.

--19. Write a block to swap 2 numbers.

DECLARE 
    V_a VARCHAR(20) :='90';
    V_b VARCHAR(20) :='10';
BEGIN
    DBMS_OUTPUT.PUT_LINE('Befor swaping a=' || V_a || ' b='|| V_b );
    V_a := V_a + V_b;
    V_b := V_a - V_b;
    V_a := V_a - V_b;
    DBMS_OUTPUT.PUT_LINE('Befor swaping a=' || V_a || ' b='|| V_b );
END;

--20.Write a PLSQL block to display the given number is prime or not.
i='&no';
j=2;
ch=0

if i<1 then ch=1;
end if;

while i<=i/2 loop
if(mod(i,j)=0 then


--21. Find the sum of all the multiples of 3 or 5 below 1000.

declare
v_a number (5) := 3;
v-b number(5) := 5;
v_sum_a number(8);
v_sum_b number(8);
begin
for i in 1..100 loop
v_sum_a := v_a*i;
v_sum_b := v_b*i;
if v_sum_a <1000 and v_sum_b <1000 then
dbms_output.put_line(v_sum_a || '  ' || v_sum_a);
end if;
end loop;
end;

--22. Pass a string and display whether the first letter of the string is character or number.

DECLARE 
    V_STR VARCHAR(20) :='90';
BEGIN
    IF REGEXP_COUNT(V_STR,'^[0-9]')=0 THEN
    DBMS_OUTPUT.PUT_LINE(V_STR||' is a string');
    ELSE
    DBMS_OUTPUT.PUT_LINE(V_STR||' is a number');
    END IF;
END;

--23.Print the last Friday dates of current year of all the months.
begin
for i in 1..12 loop

v_q :=(select NEXT_DAY(trunc(ADD_MONTHS(TRUNC (SYSDATE ,'YEAR'),i)-1), '&Day')-7 
from dual);)
DBMS_OUTPUT.PUT_LINE(v_q);

end loop;
end;

SELECT ADD_MONTHS(TRUNC (SYSDATE ,'YEAR'),12)-1 FROM DUAL;

select NEXT_DAY(trunc(ADD_MONTHS(TRUNC (SYSDATE ,'YEAR'),12)-1), '&Day')-7 from dual;
--24.Write a block to print the numbers from 1 to 10 but skip 5 and 7.
BEGIN
FOR I IN 1..10 LOOP
IF I not in(5,7) THEN
DBMS_OUTPUT.PUT_LINE(I);
END IF;
END LOOP;
END;


--or

BEGIN
FOR I IN 1..10 LOOP
IF I!=5 and I!=7 THEN
DBMS_OUTPUT.PUT_LINE(I);
END IF;
END LOOP;
END;
