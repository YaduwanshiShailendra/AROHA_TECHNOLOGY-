/*
##################################################
 Objective                : PL/SQL Trigger
 Author(Creator) Name     : Shailendra Yadav
 Developed / Created Date : 30-March-2020
##################################################
*/

Triggers: It is a db object which fires automatically when an event occurs.
Event:DML, DDL, Log on log off or start up,shut down
Timing: before , after

Statement level Trigger:fires only once
Row level Trigger: Fires for each row

Advantages
Auditing
Security
Impose Complex constraints

create or replace trigger trg_emp
after insert or update or delete on emp
--for each row
declare
v_cnt int;
begin
select count(*) into v_cnt from dept;
dbms_output.put_line('the no of departments '||v_cnt);
end;

alter trigger trg_emp disable;
select * from emp

update emp set sal=sal+1000 where deptno=10;
delete from emp where deptno=10
rollback

set serveroutput on
Example for Auditing
tracking the operations on a table

create or replace trigger trg_audit 
after insert or update or delete on emp
declare
v_evt varchar(20);
begin
if inserting then
v_evt:='INSERTION';
elsif updating then
v_evt:='UPDATION';
else
v_evt:='DELETION'
end if;
insert into emp_audit values(seq_audit.nextval,v_evt,sysdate,user);
end;


Example for Security
Performing Dml operations on non business hours

create or replace trigger trg_sec
before insert or update or delete on dept
begin
if to_char(sysdate,'hh24') not between 9 and 18 or 
to_char(sysdate,'dy') in('sat','sun') then
raise_application_error(-20010,'not business hours');
end if;
end;


Example for imposing Complex constraints

(no FK on the child table, but still you need to impose the 
constraint rule)

create or replace trigger trg_FK 
before insert on emp
for each row
declare
v_cnt int;
begin
select count(*) into v_cnt
from dept
where deptno=:new.deptno;
if v_cnt=0 then
raise_application_error(-20001,'cannot insert as deptno doesnt exist in 
parent table');
end if;
end;

select * from emp
desc emp

insert into emp(empno,ename,sal,deptno) values(1212,'abc',20000,50)

select * from user_constraints where table_name='EMP'


Qualifiers(row level triggers)
insert :new
update :new and :old
delete :old


WAT to update the salary of the employees but the condition is updated 
salary should be more than the old salary.

create or replace trigger trg_update
before update of sal on emp
for each row
begin
if(:new.sal<:old.sal) then
raise_application_error(-20001,'the salary updated should be greater');
end if;
end;

Write a trigger to insert a record in the sales table if there is suffient 
stock else raise an error. Also update the Quantity on hand(QOH) in the inventory table.

create or replace trigger trg_sales
before insert on sales
for each row
declare
v_qty int;
begin
select qty into v_qty
from inventory
where p_id=:new.p_id;

if v_qty<:new.qty then
raise_application_error(-20002,'insufficient stock');
else
update inventory set QOH=QOH-:new.qty
where p_id=:new.p_id;
end if;
end;

insert into sales values(seq_sales.nextval,1101,20,100000,sysdate);

Customer--Sales--Inventory--Product

Mutating error

create or replace trigger trg_mutate
after insert or update or delete on dept
for each row
declare
v_cnt int;
pragma autonomous_transaction;
begin
select count(*) into v_cnt
from dept;
dbms_output.put_line(v_cnt);
end;

insert into dept values(50,'Sales','Denmark')

Data Dictionary to find the trigger related information
select * from user_triggers


---#########################################


--Triggers(11 questions)
--
-- 
--
--1.Write a plsql trigger on emp table by validating empno, while inserting a record in emp table, 
--if it exist it should not allow u to insert otherwise it should insert.

    
CREATE OR REPLACE TRIGGER udt_empno_validation BEFORE
    INSERT ON emp
    FOR EACH ROW
DECLARE
    v_count INT;
BEGIN
    SELECT
        COUNT(1)
    INTO v_count
    FROM
        emp
    WHERE
        empno = :new.empno;

    IF v_count = 1 THEN
        raise_application_error(-20656, 'employee number already exist');
    END IF;
END;



INSERT INTO emp VALUES (
    8134,
    'LILY',
    'HR',
    7788,
    sysdate,
    2000,
    30,
    50,
    NULL,
    NULL,
    NULL
);

p VALUES (
    8134,
    'LILY',
    'HR',
    7788,
    sysdate,
    2000,
    30,
    50,
    NULL,
    NULL,
    NULL
);

p VALUES (
    8134,
    'LILY',
    'HR',
    7788,
    sysdate,
    2000,
    30,
    50,
    NULL,
    NULL,
    NULL
); 

--2. Write a plsql trigger on emp table so that it should allow to do dml’s only during business hours 
--i.e only between 9 to 6 and only in the weekdays.

CREATE OR REPLACE TRIGGER udt_businesshours BEFORE
    INSERT OR UPDATE OR DELETE ON emp
    FOR EACH ROW
BEGIN
    IF to_char(sysdate, 'hh24') NOT BETWEEN 9 AND 18 OR to_char(sysdate, 'FMDY') IN (
        'SAT',
        'SUN'
    ) THEN
        raise_application_error(-20121, 'DML OPERATION CAN BE ONLY PERFORMED I BUSINESS HOURS');
    END IF;
END;



--3. Write a plsql trigger so that whatever is done on emp like insert, update or delete that should be tracked in audit table.
--Emp_Audit
--
--Aud_id             event               dt                     user


--4. Write a plsql trigger on emp table so that inserted date,inserted_by and updated date,
--updated_by should be automatically inserted whenever a dml is happened on emp table.
--
--Add inserted_dt, inserted_by, updated_dt and updated_by columns to the existing  emp table using Alter table command.


--5. Write a trigger to insert a record into employee table, before inserting check whether the deptno exists in the dept table or not. 
--If exists the trigger should allow to insert that record in emp table otherwise no.


--6. Write a  trigger to  update the salary of an employee, the condition is the updated salary should be greater than the old sal. 
--If the updated sal is less compared to the old sal then it should not allow you to update.


--7. Create a complex view by joining emp and dept tables.select empno,ename, dname and deptno in the view.  
--It is illegal to do the operations in the view. So create an instead of trigger so that any DML happens on the View it has to be reflected in both the tables. If I do insert on view, it has to insert both the tables, similarly update and delete also.


--8.Write a trigger which does not allow update on salary column during first five days of the month.


--9.Write a trigger which does not allow the update of salary if the updated salary is more than his respective manager salary.


--10.Write  a trigger which will not allow to do an update if the hike is more than 30%.


--11. Write a trigger to impose the rule that foreign key should not allow nulls.
