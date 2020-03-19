/*
################################################
Objective                : Cursor and Exception
Author(Creator) Name     : Shailendra Yadav
Developed / Created Date : 19-March-2020
################################################
*/


SET SERVEROUTPUT ON;

/*
%FOUND	
Its return value is TRUE if DML statements like INSERT, DELETE and UPDATE affect at least one row or more rows 
or a SELECT INTO statement returned one or more rows. 
Otherwise it returns FALSE.

%NOTFOUND	
Its return value is TRUE if DML statements like INSERT, DELETE and UPDATE affect no row, or a SELECT INTO statement return no rows. 
Otherwise it returns FALSE. 
It is a just opposite of %FOUND.

%ISOPEN	
It always returns FALSE for implicit cursors, because the SQL cursor is automatically closed after executing its associated SQL statements.

%ROWCOUNT	
It returns the number of rows affected by DML statements like INSERT, DELETE, and UPDATE or returned by a SELECT INTO statement.

*/

DECLARE   
   total_rows number(2);  
BEGIN  
   UPDATE  emp_temp1  
   SET sal = sal + 5000;  
   IF sql%notfound THEN  
      dbms_output.put_line('no emp sal updated');  
   ELSIF sql%found THEN  
      total_rows := sql%rowcount;  
      dbms_output.put_line( total_rows || ' emp sal updated ');  
   END IF;   
END;  



--g.      Cursor already open

DECLARE
    CURSOR c IS
    SELECT
        *
    FROM
        emp;

    v_rec emp%rowtype;
BEGIN
    LOOP
        FETCH c INTO v_rec;
        EXIT WHEN c%notfound;
        dbms_output.put_line(rec.ename);
    END LOOP;

    CLOSE c;
END;


