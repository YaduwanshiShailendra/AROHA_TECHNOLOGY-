/*
##################################################
 Objective                : PL/SQL Table Details Procedure 
 Author(Creator) Name     : Shailendra Yadav
 Developed / Created Date : 19-May-2020
##################################################
*/

/*__________________________________________________________
Create a procedure which accepts a table name as an input and prints the below mentioned details.

- Structure details
1. Column names and its data types
2. Column names that have constraints defined on them and also the constraint type 

- Data details
1. Display total no of records in the table
2. Display the distinct values in every column of the table 

- Dependency details
1. Display all trigger names, procedure names, function names and the package names that use this table in their script.
2. Display the table names that are master or detail table to this table.
__________________________________________________________
*/

--create procedure
CREATE OR REPLACE PROCEDURE table_details (
    v_tab_name VARCHAR2
) AS

    CURSOR c1 IS
    SELECT
        num_rows
    FROM
        all_tables
    WHERE
        table_name = v_tab_name;

    CURSOR c2 IS
    SELECT
        column_name,
        data_type
    FROM
        user_tab_columns
    WHERE
        table_name = v_tab_name;

    CURSOR c3 IS
    SELECT
        constraint_name,
        column_name
    FROM
        user_cons_columns
    WHERE
        table_name = v_tab_name;

    CURSOR c4 IS
    SELECT
        column_name,
        num_distinct
    FROM
        user_tab_columns
    WHERE
        table_name = v_tab_name;

    CURSOR c5 IS
    SELECT
        name,
        type
    FROM
        user_dependencies
    WHERE
        referenced_name = v_tab_name;

    CURSOR c6 IS
    SELECT
        table_name AS child_table,
        ltrim(r_constraint_name, 'PK_') AS parent_table
    FROM
        all_constraints
    WHERE
        table_name = v_tab_name
        AND r_constraint_name IS NOT NULL;

BEGIN
    dbms_output.put_line('---------Column names and its data types---------');
    dbms_output.put_line('1. Column names and its data types');
    
    FOR data IN c2 LOOP dbms_output.put_line('COLUMN NAME IS "'
                                                 || data.column_name
                                                 || '"	DATA TYPE IS "'
                                                 || data.data_type||'"');
    END LOOP;

    dbms_output.put_line('');
    dbms_output.put_line('2. Column names that have constraints defined on them and also the constraint type');

    FOR const IN c3 LOOP dbms_output.put_line('CONSTRAINT NAME IS "'
                                                 || const.constraint_name
                                                 || '"	COLUMN NAME IS "'
                                                 || const.column_name||'"');
    END LOOP;
    dbms_output.put_line('');
    dbms_output.put_line('');
    dbms_output.put_line('------------------DATA DETAILS------------------');
    dbms_output.put_line('1. Display total no of records in the table');
    FOR count1 IN c1 LOOP dbms_output.put_line('NO OF RECORDS IS "' || count1.num_rows||'"');
    END LOOP;
    
    dbms_output.put_line('');
    dbms_output.put_line('2. Display the distinct values in every column of the table');
    FOR tab IN c4 LOOP dbms_output.put_line('COLUMN NAME IS "'
                                                || tab.column_name
                                                || '"	DISTINCT COUNT IS "'
                                                || tab.num_distinct||'"');
    END LOOP;

    dbms_output.put_line('');
    dbms_output.put_line('');
    dbms_output.put_line('---------DEPENDENCY DETAILS---------');
    dbms_output.put_line('1. Display all trigger names, procedure names, function names and the package names that use this table in their script.');    
    FOR type IN c5 LOOP dbms_output.put_line('DEPENDANCY NAME IS "'
                                                 || type.name
                                                 || '"		TYPE IS "'
                                                 || type.type||'"');
    END LOOP;
    dbms_output.put_line('');
    dbms_output.put_line('2. Display the table names that are master or detail table to this table.');
    FOR master_child IN c6 LOOP dbms_output.put_line('PARENT TABLE NAME IS "'
                                                 || master_child.parent_table
                                                 || '"		CHILD TABLE NAME IS "'
                                                 || master_child.child_table||'"');
    END LOOP;

END;
/

--to execute procedure
BEGIN
    table_details('EMP');
END;
/
