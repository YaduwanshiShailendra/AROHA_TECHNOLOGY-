/*
##################################################
 Objective                : DYNAMIC SQL
 Author(Creator) Name     : Shailendra Yadav
 Developed / Created Date : 06-April-2020
##################################################
*/

set serveroutput on;


--WAP by passing the table name and print all the column names and the no of records in each column.

--1. Pass the table_name in a procedure and display the no. of records and no. of columns in that table using dynamic sql.

CREATE OR REPLACE PROCEDURE SP_COLUMNS_DYN (
    p_tbl_nm VARCHAR
) AS
    v_str   VARCHAR(500);
    TYPE t_tab IS
        TABLE OF VARCHAR(20);
    v_t     t_tab;
BEGIN
    v_str := 'select column_name from user_tab_columns where table_name='
             || 'upper('
             || ''''
             || p_tbl_nm
             || ''''
             || ')';

    dbms_output.put_line(v_str);
    EXECUTE IMMEDIATE v_str BULK COLLECT
    INTO v_t;
--dbms_output.put_line(v_t(i));
END loop;
end;

/


exec sp_columns('emp')
 

2. Pass the month and year and create the transaction table as txn_month_year with the columns txnid, cid, pid, sales_dt, qty and amt.

 
3. Pass the month and year and display the total sales of current month and previous month sales.

 
4. Write a procedure by passing the table name and check the table exists or not, if exists display all the column names in that table otherwise handle the exception.

 
5. Write a procedure by passing the table name and display all the column_names in the table what we pass if it exists, if it does not exist, create the table.

 
6.Write a procedure by passing the location at run time and create ‘office_<location>’ table

 
7. Write a procedure by passing tablename and return all the column names in that table and no of records in each column and load into tbl variables.(collections)

 
8. WAP by passing tablename, column names and datatypes as 3 parameters and create a table dynamically.


9.Write a procedure to add columns to the existing customer table by passing column name and datatype.
 

10. Can we use dynamic sql inside function. If yes, Write a code to return the number of records by passing table name at runtime. if no, print the error.
 

1.      Pass the table_name , if the table passed is parent display the child table names of that table and if the table passed is child display the parent table names and handle the exception if there no child or parent.





Using Dynamic SQL

WAP by passing the table name and print all the column names and the no of records in each column.

create or replace procedure sp_columns_dyn(p_tbl_nm varchar) as
v_str varchar(500);
type t_tab is table of varchar(20);
v_t t_tab;
begin
v_str:='select column_name from user_tab_columns where table_name='||'upper('||''''||p_tbl_nm||''''||')';
dbms_output.put_line(v_str);
execute immediate v_str bulk collect into v_t;
--dbms_output.put_line(v_t(i));
end loop;
end;

exec sp_columns('emp')
---------------------------------------------------------------
Using Collection

create or replace procedure sp_columns_coll(p_tbl_nm varchar) as
v_str varchar(500);
type t_tab is table of varchar(20);
v_t t_tab;
begin
select column_name bulk collect into v_t from user_tab_columns where table_name=upper(p_tbl_nm);
for i in 1..v_t.last loop
dbms_output.put_line(v_t(i));
end loop;
end;