
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
SELECT OBJECT_NAME,OBJECT_TYPE FROM USER_OBJECTS WHERE OBJECT_NAME IN (SELECT TRIM(SUBSTR('SELECT * FROM EMP',INSTR('SELECT * FROM EMP','FROM')+LENGTH('FROM'))) FROM DUAL);



##############################################################################################################

Database Objects
--1. Suppose we created a synonym for Customer table, if we drop a synonym a table is dropped or not?
No it doesnt effect the TABLE

--2. Suppose we created a complex view by joining 2 tables named Customer and Sales. Can we perform DML on complex view. Will it affect the base tables?
No it doesnt effect the base TABLES.
--3. What are the restrictions for the non updatable views?
Read only.

--4.  Suppose if we drop a table, the view created on that table will be dropped or not?
That time we cannot use view table, because base table is not there.
Hence it become unavailable.

--5. Can we create index on Views?
No we cannot create index on views.
 
--6. Write an example for check option view.
CREATE VIEW V1
AS
    SELECT ENAME,SAL
    FROM EMP
    WHERE SAL<5000
    WITH CHECK OPTION CONSTRAINT SAL.

--7. Can we create index on Materialized Views?
Yes we can create index on Materialized Views.

--8. Create a public synonym and Display all the public synonyms which you have created in the database?
CREATE PUBLIC SYNONYM SYN1 FOR EMP;

CREATE PUBLIC SYNONYM SYNPB FOR ILAVARASU@CLOUDB

--9. We created a sequence and the current sequence is 5. Suppose if we log off and log in again will the sequence continue Or it will be lost?
It will be present.

--10. What is the difference between Currval and Nextval?
curval gives the curretn value of the sequence
whereas
nextval gives the next value of the sequence.

--11. Difference between Rownum and rowid?
ROWNUM is sequenc of no reffering to that record in te TABLE.
ROWID reffers to the physical address of the TABLE in database.

--12. Why rownum will not work for Rownum=2 and Rownum>=2? Please tell the reason.
Because it will start executing and checking the rownum,
Every time it will start with 1 and will be in infinite loop hence you will not get output.

--13. Can we delete the record from parent table. If it is not, what kind of error you will get? How to overcome that error?
No we cannot delete the record from parent table, it will throw error child record exist.
We can over come this by using either 'on delete set null' or 'on delet set cascade' in the child table foreign key while creating the table.

--14. What is Cache and Cycle in Sequence?
CYCLE: 
        It use to generate values after reaching either its maximum or minimum value and continues the sequence.
        It generates its minimum value after ascending sequence reaches its maximum value, 
        It generates its maximum value after descending sequence reaches its minimum value.

CACHE: 
        It specify how many values of the sequence the database preallocates and keeps in memory for faster access. 
        This integer value can have 28 or fewer digits. 
        The minimum value for this parameter is 2. 
        For sequences that cycle, this value must be less than the number of values in the cycle. 
        You cannot cache more values than will fit in a given cycle of sequence numbers. 
        Therefore, the maximum value allowed for CACHE must be less than the value determined by the following formula:
            (CEIL (MAXVALUE - MINVALUE)) / ABS (INCREMENT)

        If a system failure occurs, all cached sequence values that have not been used in committed DML statements are lost. 
        The potential number of lost values is equal to the value of the CACHE parameter.


--15. Diffrence between Start with and Minvalue in Sequence?
START WITH:
        We use this clause to start an ascending sequence at a value greater than its minimum or to start a descending sequence at a value less than its maximum.
        For ascending sequences, the default value is the minimum value of the sequence.
        For descending sequences,the default value is the maximum value of the sequence.
        This integer value can have 28 or fewer digits.

MINVALUE: 
        Specify the minimum value of the sequence. This integer value can have 28 or fewer digits.
        MINVALUE must be less than or equal to "START WITH" and must be less than "MAXCALUE".


--    16. What is the difference between Union and Union all in Set operators?
UNION: 
        Union Operator combines the result of 2 or more tables and fetches the results of two select statements.
        Union operator eliminates the duplicates from the table and fetches the result.
        For each duplicate row in table only one row is displayed in the result.
        By considering the performance of SQL using union is not preferable option but if there is situation where user wants to remove the duplicate data from two or more table the use of Union is preferable.
 
Syntax Of Union:
        SELECT COLUMN1…COLUMN N FROM TABLE1;
        UNION
        SELECT COLUMN1…COLUMN N FROM TABLE2;

UNION ALL OPERATOR:
        Union ALL Operator combines the result of 2 or more tables and fetches the results of two or more select statements.
        Union all operator does not eliminate duplicate values.
        It shows duplicate records also.
        By considering the performance of SQL using union all is preferable option because it does not check the duplicate values so no sorting required at the time of fetching the records.
        Union all operator is most 
        widely used operator in reporting purpose where user needs to fetch the records from different tables.

Syntax:
        SELECT COLUMN1…COLUMN N FROM TABLE1;
        UNION ALL
        SELECT COLUMN1…COLUMN N FROM TABLE2;


--    17. Difference between Joins and Set operators?
_____________________________________________________________________________________________________________________
            JOINS                               |                                          SET
_____________________________________________________________________________________________________________________
IN JOINS WE CAN HAVE N NUMBER OF COLUMNS        |         IN SET OPERATOR THE NO OF COLUMN OF BOTH TABLES ARE SAME.
FROM ONE TABLE ND ONE COLUMN FROM ANOTHER.      |
                                                |
WE CAN HAVE DIFFERENT ALIAS NAME                |         THE ALIAS NAME OF FIRST TABLE IS TAKEN ALWAYS.
FROM DIFFERENT TABLE.                           |
_____________________________________________________________________________________________________________________


--    18. Difference between Subquery and Co-related query ?
SUBQUERY
1. The inner query is executed only once.
2. The inner query will get executed first and the outer of the inner query used by the outer query. 
3. The inner query is not dependent on outer query.
example-
        select Ename, deptno
        from emp
        where ename in (select ename from cust);

CORRELATED SUBQUERY
1. The outer query will get executed first and for every row of outer query, inner query will get executed.
2. So the inner query will get executed as many times as number of rows in result of the outer query.
3. The outer query output can use the inner query output for comparison. This means inner query and outer query dependent on each other.
example-
        select ename, deptno
        from emp
        where ename in (select ename from dept where emp.deptno=dept.deptno);

--    19. Difference between User_ and All_ in data dictionary?
User_tables data dictionary contains all the tables created by the users under that schema.
whereas 
All_tables stores all the tables created in different schema. 
If any user id have the Grants for access table of different schema then he can see that table through this dictionary.

--20. What is Private and Public Synonym? What is the data dictionary for public synonym? Display all the public synonyms which you have created in the database?
PUBLIC SYNONYM:
        A public synonym is owned by the special user group named PUBLIC and is accessible to every user in a database. 
        Public synonym are the sysnoym which can be used by all the user.
PRIVATE SYNONYM:
        A private synonym is contained in the schema of a specific user and available only to the user and to grantees for the underlying object.
        Private synonym is only valid for the user who created it and not to anyone else

The data dictionary for public synonym is ALL_SYNONYMS
        select * from all_synonyms;
        

           
            
