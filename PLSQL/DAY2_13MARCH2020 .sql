
--###########################################################################--
--                        	   DAY2_13-MARCH-2020
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
DECLARE
ENO INT:=7499;
ENM VARCHAR(20):='EMP_NAME';
VALIDATIONS INT:=  MAX(SAL) FROM EMP
WHERE EMPNO=ENO;
BEGIN
DBMS_OUTPUT.PUT_LINE(VALIDATIONS);
END;



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

select * from emp_temp1;
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
DBMS_OUTPUT.PUT_LINE('NO OF VOWELS '||v);
DBMS_OUTPUT.PUT_LINE('NO OF CONSONENTS '||c);
end;

--or


declare
str varchar(20) :='stationary';
v number :=0;
c number:=0;
begin
if REGEXP_COUNT(str,'[aeiou]')>0  then
v :=REGEXP_COUNT(str,'[aeiou]');
end if;
c :=length(str)-v;
DBMS_OUTPUT.PUT_LINE('NO OF VOWELS '||v);
DBMS_OUTPUT.PUT_LINE('NO OF CONSONENTS '||c);
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
DBMS_OUTPUT.PUT_LINE('NO OF VOWELS '||v);
DBMS_OUTPUT.PUT_LINE('NO OF CONSONENTS '||c);
end;

--or

DECLARE
V_STR VARCHAR(15):='STATIONARY';
V_VOW INT :=0;
V_CON INT :=0;
BEGIN
FOR I IN 1..LENGTH(V_STR)
LOOP
IF SUBSTR(V_STR,I,1) IN('A','E','I','O','U')
THEN
V_VOW:=V_VOW+1;
ELSE
V_CON:=V_CON+1;
END IF;
END LOOP;
DBMS_OUTPUT.PUT_LINE('NO OF VOWELS '||V_VOW);
DBMS_OUTPUT.PUT_LINE('NO OF CONSONENTS '||V_CON);
END;

--13. Write a procedure to print the given string is a palindrome or not without using reverse function.
--Eg:madam is a palindrome

DECLARE
V_STR VARCHAR(20):='&ENTER_STRING';
V_PAL VARCHAR(20):='';
BEGIN
    FOR I IN 1..LENGTH(V_STR)
    LOOP
        V_PAL:=V_PAL||SUBSTR(V_STR,-I,1);
        --DBMS_OUTPUT.PUT_LINE(SUBSTR(V_STR,-I,1)); WHAT IS ADDED TO V_PAL AT THAT TIME OF INTERATION.
        
    END LOOP;
          --  DBMS_OUTPUT.PUT_LINE(V_PAL); TO SEE WHAT V_PAL CONTAIN.
    IF V_STR=V_PAL
    THEN 
        dbms_output.put_line(V_STR ||' is palaidrome string');
    ELSE
        dbms_output.put_line(V_STR||' is not palindorme');
    END IF;
END;


--14.Write a procedure to pass a string separated by comma like ab,abc,abcd,x,y and print the o/p as
--ab
--abc
--abcd
--x
--y

declare
str varchar2(20) :='ab,abc,abcd,x,y';
begin
for i in 1..regexp_count(str,',') loop
dbms_output.put_line(substr(str,1,instr(str,',')-1));
str := substr(str,instr(str,',')+1);
end loop;
dbms_output.put_line(str);
end;

--or

declare 
v_str varchar(100):='ab,abc,abcd,x,y';        
begin
for i in 1..regexp_count(v_str,',') loop
    if i=1
    then    
        dbms_output.put_line(substr(v_str,1,instr(v_str,',',1,1)-1));
    else
        dbms_output.put_line(substr(v_str,instr(v_str,',',1,i)+1,instr(v_str,',',1,i+1)-instr(v_str,',',1,i)-1));
    end if;            
end loop;
end;

--15. Write a plsql block to print the number of alphabets in a given string. Eg;=abcba
--a=2
--b=2
--c=1

declare
    v_str varchar(20) :='abcbaa';
    v_cop varchar(20):= v_str;
    v_ch varchar(1):='';
begin
while length(v_cop)>0            
loop
    v_ch:=substr(v_cop,1,1);
    dbms_output.put_line(v_ch|| ' occurs ' || regexp_count(v_cop,v_ch) || ' times in ' || v_str);
    v_cop:=replace(v_cop,v_ch,'');
    
end loop;
end ;


--16. Write a plsql block to print the Fibonacci series from 1 to 50. v_a=0,v_b=1

declare
v_first int:=&firstno;
v_second int :=&secondmo;
v_sum int;
v_count int:=&totnumber;
begin
for i in 1..v_count
loop
    dbms_output.put_line(v_first);
    v_sum:=v_first+v_second;
    v_first:=v_second;
    v_second:=v_sum;
end loop;
end;


--17. Write a plsql block by passing month-yy and display the no. of Saturdays in that month and year.

declare
v_date  date :='01-'||'&INPUT';
v_st    date :=trunc(v_date,'YYYY');
v_end   date :=add_months(v_st,12)-1;
v_mend  date :=last_day(v_date);
v_mc    int:=0;
v_yc    int:=0;
begin
while v_st <=v_end
loop
if to_char(v_st,'FMDY') ='SAT'
then
if v_st between v_date and v_mend
then
v_mc:=v_mc+1;
end if;
v_yc:=v_yc+1;
end if;
v_st:=v_st+1;
end loop;
dbms_output.put_line('NO OF SATURDAYS IN MONTH '|| v_mc);
dbms_output.put_line('NO OF SATURDAYS IN YEAR '|| v_yc);
end;

select NEXT_DAY(trunc(ADD_MONTHS(TRUNC (SYSDATE ,'YEAR'),12)-1), 'saturday')-7 from dual;

--18. Write a plsql block by passing a empno so that the salary of the prior employee should incremented by 1000 and next employee salary should be decremented by 1000.


savepoint a;
declare
    ENO int:=&EMPNO;
begin
    update EMP
    set SAL=case when EMPNO=EMPNO-1 then SAL+1000 when EMPNO=EMPNO+1 then  SAL-1000 else SAL end 
    where EMPNO=ENO;
end;

rollback to a;
select * from EMP;

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

DECLARE
V_N INT:=&NUMBER;
VM INT :=0;
BEGIN
FOR I IN 2..V_N/2
LOOP
IF MOD(V_N,I)=0 AND VM<1 THEN
dbms_output.put_line('Not Prime');
VM:=1;
END IF;
END LOOP;
IF VM=0
THEN
dbms_output.put_line(' Prime');
END IF;
END;

--21. Find the sum of all the multiples of 3 or 5 below 1000.

declare
v_sum int:=0;
begin
for  i in 1..999 loop
if mod(i,3)=0 or mod(i,5)=0 then
v_sum:=v_sum+i;
end if;   
end loop;
dbms_output.put_line(v_sum);
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

declare
v_date date:=sysdate;
v_sdate date:=trunc(v_date,'YY');
v_ext date:=add_months(v_sdate,12)-1;
begin
while v_sdate<=v_ext loop
if to_char(v_sdate,'FMDY')='FRI' and to_char(v_sdate,'W')='4'
then
    dbms_output.put_line(v_sdate);        
end if;
v_sdate:=v_sdate+1;
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




--#############################################################################
--                          Scenarios_programming
--#############################################################################

--1 . Write a code to find maximum between two numbers
declare
a number :=5;
b number :=10;
begin
if a > b then
dbms_output.put_line(a || ' is Maximum between ' || a || ' & ' || b);
else
dbms_output.put_line(b || ' is Maximum between ' || a || ' & ' || b);
end if;
end;

--2. Write a code to find maximum between three numbers
declare 
    v_a int :=10;
    v_b int :=20;
    v_c int :=30;
begin
    if
    (v_a > v_b) and (v_a > v_c) then dbms_output.put_line(v_a||' is the maximum number.');
    elsif
    (v_b > v_a) and (v_b > v_c) then dbms_output.put_line(v_b||' is the maximum number.');
    else
    dbms_output.put_line(v_c||' is the maximum number.');
    end if;
end;


--3. write a code to check whether a number is negative, possitive or not
declare
no number:='&n';
begin
if no >0 then
dbms_output.put_line(no || ' is positive.');
elsif no <0 then
dbms_output.put_line(no || ' is negative.');
else
dbms_output.put_line(no || ' is zero.');
end if;
end;

--4. write a program to check whether a number is divisable by 5 and 11 or not
declare
no number:='&n';
begin
if mod(no,5)=0 and mod(no,11)=0 then
dbms_output.put_line(no || ' is divisable by 5 and 11.');
else
dbms_output.put_line(no || ' is not divisable by 5 and 11.');
end if;
end;

--5. WAC to check whether a number is even or odd
declare
no number:='&n';
begin
if mod(no,2)=0 then
DBMS_OUTPUT.PUT_LINE(no||' is even.');
else
DBMS_OUTPUT.PUT_LINE(no||' is odd.');
end if;
end;

--6. WAC to check whether a given alphabet is vowel or consonant

declare
str varchar(20) :='&char';
begin
if REGEXP_COUNT(lower(str),'[aeiou]')>0  then
DBMS_OUTPUT.PUT_LINE(str||' is vowel.');
else
DBMS_OUTPUT.PUT_LINE(str||' is consonant.');
end if;
end;

--7. WAC to check whether a given character is alphabet, digit or special character
declare
str varchar(1) :='&char';
begin
if REGEXP_COUNT(str,'[0-9]')>0  then
DBMS_OUTPUT.PUT_LINE(str||' is a number.');
elsif REGEXP_COUNT(lower(str),'[a-z]')>0  then
DBMS_OUTPUT.PUT_LINE(str||' is a alphabet.');
else
DBMS_OUTPUT.PUT_LINE(str||' is a special character.');
end if;
end;

--8. input month number and print number of days in that month
declare
no number:='&month';
a number;
begin
if no = 02 then 
dbms_output.put_line('Number of days in '|| to_char(to_date(no,'mm'),'fmMonth') || ' is 28 or 29');
else
a :=to_char(last_day(trunc(to_date(no,'mm'),'mm')), 'dd');
dbms_output.put_line('Number of days in '|| to_char(to_date(no,'mm'),'fmMonth') || ' is ' ||a);
end if;
end;


--9. Input angles of a triangle and check whether triangle is valid or not
declare
a number:='&a';
b number:='&b';
c number:='&c';
begin
if a+b+c=180 then 
dbms_output.put_line('It is a triangle.');
else
dbms_output.put_line('It is not a triangle.');
end if;
end;


--10. Input all sides of a triangle and check whether triangle is valid or not
declare
a number :='&s1';
b number :='&s2';
c number :='&s3';
begin
if a+b>c or a+c>b or b+c>a then
dbms_output.put_line('It is a triangle.');
else
dbms_output.put_line('It is not a triangle.');
end if;
end;

--11. check whether the triangle is equilateral, isosceles or scalene triangle
declare
    a number :='&s1';
    b number :='&s2';
    c number :='&s3';
begin
    if a=b and b=c and c=a then
        dbms_output.put_line('It is an equilateral triangle.');
    elsif c=a or b=c or a=b then
        dbms_output.put_line('It is an isosceles triangle.');
    else
        dbms_output.put_line('It is an scalene triangle.');
    end if;
end;

--12. find all roots of quadratic equation
declare
    a number :='&s1';
    b number :='&s2';
    c number :='&s3';
    r1 varchar(25);
    r2 varchar(25);
    d number;
begin
        d := b*b-(4*a*c);
    if d < 0 then
        r1 := -b/2|| ' + ' || sqrt(d)/2 ||'i';
        r2 := -b/2|| ' - ' || sqrt(d)/2 ||'i';
    else
        r1 := (-b+sqrt(d));
        r2 := -b-sqrt(d);
    end if
        dbms_output.put_line('The roots of quadratic equation are '|| r1 ||'   '||r2);
end;


--13. calculating profit or loss after inputting the CP and SP of the item
declare
    cp number :='&cp';
    sp number :='&sp';
    pl number ;
begin
    if sp>cp then
    pl := sp-cp;
    dbms_output.put_line('Profit is :'|| pl);
    else
    pl := cp-sp;
    dbms_output.put_line('Loss is :'|| pl);
    end if;
end;

--14. input marks of five subjects Physics, Chemistry, Biology, Mathematics and Computer
--If percentage >= 90% : Grade A
--If percentage >= 80% : Grade B
--If percentage >= 70% : Grade C
--If percentage >= 60% : Grade D
--If percentage >= 40% : Grade E
--If percentage < 40% : Grade F   */
--
declare
    v_phy number:='80';
    v_che number:='50';
    v_bio number:='90';
    v_mat number:='70';
    v_com number:='88';
    v_perc number;
begin
    v_perc :=(v_phy+v_che+v_bio+v_mat+v_com)*100/5;
    if v_perc >=90 then 
    dbms_output.put_line('Grade A');
    elsif v_perc >=80 then 
    dbms_output.put_line('Grade B');
    elsif v_perc >=70 then 
    dbms_output.put_line('Grade C');
    elsif v_perc >=60 then 
    dbms_output.put_line('Grade D');
    elsif v_perc >=40 then 
    dbms_output.put_line('Grade E');
    else 
    dbms_output.put_line('Grade F');
    end if; 
end;

--15. input basic salary of an employee and calculate gross salary according to given follwing.
--Basic Salary <= 10000 : HRA = 20%, DA = 80%
--Basic Salary <=20000 : HRA = 25%, DA = 90%
--Basic Salary >= 20001 : HRA = 30%, DA = 95% */
--
declare
    v_sal number(10) :='&sal';
begin
    if v_sal <=10000 then
        v_sal := v_sal+v_sal*.2+v_sal*.8;
        dbms_output.put_line('Gross salary is '|| v_sal);
    elsif v_sal <=20000 then
        v_sal := v_sal+v_sal*.25+v_sal*.9;
        dbms_output.put_line('Gross salary is '|| v_sal);
    else
        v_sal := v_sal+v_sal*.3+v_sal*.95;
        dbms_output.put_line('############################');
        dbms_output.put_line('#  Gross salary is '|| v_sal );
        dbms_output.put_line('############################');
    end if;
end;


--16.input electricity unit charge and calculate the total electricity bill according to the given following:
--For first 50 units Rs. 0.50/unit
--For next 100 units Rs. 0.75/unit
--For next 100 units Rs. 1.20/unit
--For unit above 250 Rs. 1.50/unit
--An additional surcharge of 20% is added to the bill.

declare
        unit number :='&n';
        amt number :=0;
begin
    if unit <=50 then
        amt := unit*.5;
    elsif unit <=150 then
        unit:= unit-50;
        amt := amt + unit*.75;
    elsif unit <=250 then
        unit:= unit-100;
        amt := amt + unit*1.2;
    elsif unit >250 then
        unit:= unit-100;
        amt := amt + unit*1.5;
    end if;
        amt := amt + amt*.2;
        dbms_output.put_line('Total amount electricity bill : '||amt);
end;

set serveroutput on;
