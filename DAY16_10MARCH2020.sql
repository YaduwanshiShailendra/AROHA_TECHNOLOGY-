
--###########################################################################--
--                       	DAY16_11-MARCH-2020
--###########################################################################--


--Queries on Data Dictionary

--
--SELECT OBJECT_NAME
--FROM USER_OBJECTS
--WHERE OBJECT_TYPE='VIEWS'

--OBJECT_TYPE CAN BE VIEWS, SEQUENCES, INDEXES, synonym

--1. Select table names created by SCOTT.

--it will display the current user's table
SELECT * FROM USER_TABLES;

--or

-- for particular table;
SELECT * FROM ALL_TABLES WHERE OWNER = 'SCOTT';
    
--2. Select view names created by SCOTT.
SELECT * FROM ALL_VIEWS WHERE OWNER = 'SCOTT';

--3. Display the Constraint name, constraint type of all the constraints in EMP table.
SELECT *
FROM user_constraints
WHERE table_name = 'EMP';


--4. Display all indexes on DEPT table.

SELECT * FROM ALL_INDEXES WHERE TABLE_NAME='DEPT';


--5. Display all the user names from oracle database.

SELECT * FROM ALL_USERS;


--6. Select table owner, names created by SCOTT or John

SELECT * FROM ALL_TABLES WHERE OWNER IN ('SCOTT','JOHN');

--7. Select all the sequences created by current user.

SELECT * FROM ALL_SEQUENCES;


--8. Display all the data dictionary objects which starts with ‘USER’.
select * FROM DICT WHERE TABLE_NAME LIKE 'USER%';


--9. Display all the roles available in the database.
SELECT * FROM DBA_ROLES;

--OR

SELECT * FROM ROLE_TAB_PRIVS;


--10. Display synonyms created by SCOTT.

SELECT * FROM USER_SYNONYMS;

--OR
--IT WILL USE FOR ALL USERS
SELECT * FROM ALL_SYNONYMS;

--11. Display all the constraint_name and type defined for employee table.
SELECT *
FROM user_constraints
WHERE table_name = 'EMP';


--12. Display all the check constraints defined for employee table.
SELECT *
FROM user_constraints
WHERE table_name = 'EMP'
AND constraint_name = 'CHECK';
   
   
--13. Display Sequences created by SCOTT.
SELECT * FROM ALL_SEQUENCES;


--14. Display different Tablespaces available in the database.

SELECT TABLESPACE_NAME, STATUS, CONTENTS
FROM USER_TABLESPACES;

--or 

SELECT *
FROM USER_TABLESPACES;

--15. Display tables in 'USER_DATA' tablespace.
select * from user_data;


--16. Display all the table_names which contain the column as SAL.
SELECT * 
FROM USER_OBJECTS
WHERE OBJECT_TYPE='TABLE'
AND OBJECT_NAME IN (SELECT TABLE_NAME FROM all_tab_columns WHERE column_name='SAL');

--OR

--DRIVED JOIN
SELECT U.OBJECT_NAME,COLUMN_NAME 
FROM USER_OBJECTS U,(SELECT TABLE_NAME,COLUMN_NAME FROM all_tab_columns WHERE column_name='SAL') C
WHERE U.OBJECT_TYPE='TABLE' AND U.OBJECT_NAME=C.TABLE_NAME;

--It will show columns of user's tables, views and clusters 
SELECT * FROM all_tab_columns WHERE column_name='SAL';

--it will show table_name
SELECT * FROM DICT WHERE  TABLE_NAME LIKE '%ALL_TAB_%';


--17. Write a query to know all the database objects which got created by user "TIM" yesterday?
SELECT *
FROM ALL_OBJECTS
WHERE OWNER='SCOTT'
AND TO_CHAR(CREATED, 'dd')=TO_CHAR(SYSDATE, 'dd')-1;

--18. What are the Data dictionary views for Materialized Views?
SELECT * FROM USER_MVIEWS;


--19. Display the username by writing a query?
SHOW USER;
    
--20. How to check the given query is normal view or materialized View?
select * from user_objects ;

select * from v1;
select * from mv_1;
select
VIEW
MATERIALIZED VIEW

##############################################################################################################

Database Objects
--    1. Suppose we created a synonym for Customer table, if we drop a synonym a table is dropped or not?

--    2. Suppose we created a complex view by joining 2 tables named Customer and Sales. Can we perform DML on complex view. Will it affect the base tables?

--    3. What are the restrictions for the non updatable views?

--    4.  Suppose if we drop a table, the view created on that table will be dropped or not?

--    5. Can we create index on Views?

--    6. Write an example for check option view.

--    7. Can we create index on Materialized Views?

--    8. Create a public synonym and Display all the public synonyms which you have created in the database?

--    9. We created a sequence and the current sequence is 5. Suppose if we log off and log in again will the sequence continue Or it will be lost?

--    10. What is the difference between Currval and Nextval?

--    11. Difference between Rownum and rowid?

--    12. Why rownum will not work for Rownum=2 and Rownum>=2? Please tell the reason.


--    13. Can we delete the record from parent table. If it is not, what kind of error you will get? How to overcome that error?

--    14. What is Cache and Cycle in Sequence?

--    15. Diffrence between Start with and Minvalue in Sequence?

--    16. What is the difference between Union and Union all in Set operators?

--    17. Difference between Joins and Set operators?


--    18. Difference between Subquery and Co-related query ?

--    19. Difference between User_ and All_ in data dictionary?
User_tables data dictionary contains all the tables created by the users under that schema.
whereas 
All_tables stores all the tables created in different schema. 
If any user id have the Grants for access table of different schema then he can see that table through this dictionary.

--20. What is Private and Public Synonym? What is the data dictionary for public synonym? Display all the public synonyms which you have created in the database?
PUBLIC SYNONYM:
A public synonym is owned by the special user group named PUBLIC and is accessible to every user in a database. 
PRIVATE SYNONYM:
A private synonym is contained in the schema of a specific user and available only to the user and to grantees for the underlying object.

The data dictionary for public synonym is ALL_SYNONYM
select * from all_synonyms;
