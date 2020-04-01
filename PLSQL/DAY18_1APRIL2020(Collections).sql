
Arrays

Datatypes in Oracle:Scalar and Composite
Scalar: Single value: int, number, varchar,date
Composite: Multiple values
Records: Single row(%rowtype)
Collections(table variables):Multiple rows
Index by table
Nested Table 
Varrays

Bulk Collect:

create or replace procedure sp_coll as
type t_tbl is table of number(10);
v_tab t_tbl;
begin
select sal bulk collect into v_tab from emp;
for i in 1..v_tab.last loop
dbms_output.put_line(v_tab(i));
end loop;
end;

exec sp_coll
set serveroutput on

declare
cursor c is select * from emp;
type t is table of number;
v_tab t;
begin
open c;
fetch c bulk collect into v_tab;
exit when c%notfound;
close c;
end;

Bulk Bind:

create or replace procedure sp_bind as
type t is table of number(5);
v_t t:=t(1101,1105,1106,1108);
begin
forall i in 1..v_t.last
update emp set sal=sal+1000 where empno=v_t(i);
end;

WAP to fetch the custnames and load into the collection at one time.

create or replace procedure sp_coll_1 as
type t_rec is record(ename varchar(20),sal number(5));
type t is table of t_rec;
v_tab t;
begin
select ename,sal bulk collect into v_tab from emp;
for i in 1..v_tab.last loop
dbms_output.put_line(v_tab(i).ename||','||v_tab(i).sal);
end loop;
end;

exec sp_coll_1


create or replace procedure sp_coll as
type t_tbl is table of emp%rowtype;
v_tab t_tbl;
begin
select * bulk collect into v_tab from emp;
for i in 1..v_tab.last loop
dbms_output.put_line(v_tab(i).sal||','||v_tab(i).job);
end loop;
end;

exec sp_coll
----------------------------------------------
Collection as a parameter in Stored procedure
create or replace type t_emp is table of number(20);

create or replace procedure sp_coll_para(p_tab out t_emp) as
begin
select sal bulk collect into p_tab from emp;
end;


declare
v_t t_emp;
begin
sp_coll_para(v_t);
for i in 1..v_t.last loop
dbms_output.put_line(v_t(i));
end loop;
end;
----------------------------------------------
Collection as return type in Stored function

create or replace function fn_ref_para return sys_refcursor as
v_ref sys_refcursor;
begin
open v_ref for select sum(amount),cust_id previous_YTD from sales_day6
               where sales_date between add_months(trunc(sales_date,'yy'),-12) 
               and add_months(sysdate,-12)
               group by cust_id;
               
return v_ref;
end;

create or replace function fn_coll return t_emp as
v_tab t_emp;
begin
select sum(amount) bulk collect into v_tab from sales_day6
               where sales_date between add_months(trunc(sales_date,'yy'),-12) 
               and add_months(sysdate,-12)
               group by cust_id;
return v_tab;
end;

select fn_coll from dual
select * from table(fn_coll)

declare
v_t t_emp;
begin
v_t:=fn_coll;
for i in 1..v_t.last loop
dbms_output.put_line(v_t(i));
end loop;
end;






Procedures Using ref cursor as OUT parameter

 

1. Write a procedure to display all the details of employees and all the records in department table using ref cursor.

2.  Write a procedure by passing id. If id=1 then fetch all the records from employee

Otherwise fetch all the records from dept using ref cursor.Use the ref cursor as OUT parameter.

3. Write a procedure by passing the select statement as string and print its output using ref cursor.

4. Write a function to return all the empnames whose experience is greater than 20 yrs using ref cursor .

5.Write a function by passing deptno and return all the details of the employees who belongs to that dept using ref cursor.
