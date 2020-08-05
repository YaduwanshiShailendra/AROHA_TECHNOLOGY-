###########################################################################################################################
Objective:- TO SOLVE COMMODITY SCENARIO
Created by:- Shridhar Bhardwaj
Created date:- 10-06-2020
###########################################################################################################################

Assumptions:
- The data comes in as a csv file everyday.
- There are two files as source, where one is the transaction file and the other is a exchange file containing the 
exchange rates.

Necessary solutions:
- Design a normalized table structure to load data from the csv source
- Create scripts to load data from the csv into the normalized tables



---------------------------------------------------------------------------------------------------------


CREATE TABLE TRANSACTIONS
(txn_id int primary key,
txn_type varchar2(30),
fund_type varchar2(30),
txn_dt date,
units number);

drop table transactions;

CREATE TABLE INVESTOR
(investor_id int primary key,
investor_f_name varchar2(30),
investor_m_name varchar2(30),
investor_l_name varchar2(30),
investor_addr varchar2(70),
investor_email varchar2(50),
investor_phone number(12));


CREATE TABLE EXCHANGE
(exchange_id int primary key,
exchange_rate float,
exchange_dt date);

drop table exchange;
--------------------------------------------------------------------------------------------------------------------------
set serveroutput on;
     
-------------------------------------------------------------------------------------------------------------------------
--POPULATE DATA FROM SOURCE CSV FILE INTO EXCHANGE TABLE:

declare
v1 varchar2(20000);
v2 varchar2(20000);
sqlstmt varchar2(20000);
   exchange_file utl_file.file_type;
   
    begin
    exchange_file := utl_file.fopen('ABC','exch.csv','r');
   loop
   begin
    utl_file.get_line(exchange_file,v1); 
   dbms_output.put_line(v1);
   select replace(v1,',',''',''') into v2 from dual;
   sqlstmt := ' insert into EXCHANGE values('''||v2||''')';
 execute immediate sqlstmt;
 dbms_output.put_line(sqlstmt);
  exception 
  when no_data_found then exit;
   end;
     end loop;
      utl_file.fclose(exchange_file);
      end;
     
  
  select * from exchange;    
----------------------------------------------------------------------------------------------------------------------
 --POPULATE DATA FROM SOURCE CSV FILE INTO INVESTOR TABLE:
 
  declare
v1 varchar2(20000);
v2 varchar2(20000);
sqlstmt varchar2(20000);
   investor_file utl_file.file_type;
   
    begin
    investor_file := utl_file.fopen('ABC','investor.csv','r');
   loop
   begin
    utl_file.get_line(investor_file,v1); 
   dbms_output.put_line(v1);
   select replace(v1,',',''',''') into v2 from dual;
   sqlstmt := ' insert into INVESTOR values('''||v2||''')';
 execute immediate sqlstmt;
 dbms_output.put_line(sqlstmt);
  exception 
  when no_data_found then exit;
   end;
     end loop;
      utl_file.fclose(investor_file);
      end;
     
  
  select * from INVESTOR;   
  

------------------------------------------------------------------------------------------------------------------------  
     
  --POPULATE  TRANSACTIONS DATA FROM SOURCE CSV FILE INTO TRANSACTIONS TABLE:
 
  declare
v1 varchar2(20000);
v2 varchar2(20000);
sqlstmt varchar2(20000);
   txn_file utl_file.file_type;
   
    begin
    txn_file := utl_file.fopen('ABC','txn.csv','r');
   loop
   begin
    utl_file.get_line(txn_file,v1); 
   dbms_output.put_line(v1);
   select replace(v1,',',''',''') into v2 from dual;
   sqlstmt := ' insert into TRANSACTIONS values('''||v2||''')';
 execute immediate sqlstmt;
 dbms_output.put_line(sqlstmt);
  exception 
  when no_data_found then exit;
   end;
     end loop;
      utl_file.fclose(txn_file);
      end;
     
  
  select * from TRANSACTIONS;
  
----------------------------------------------------------------------------------------------------------------------
 