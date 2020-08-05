/*
##################################################
 Objective                : PL/SQL stored procedure-
                             1. Write a stored procedure to populate the target tables.
                               
 Author(Creator) Name     : Shailendra Yadav
 Developed / Created Date : 04-June-2020
 
 
 SOURCE_DATA:	 
st_id	st_name	   marks
100	     RAM	    45
101	     TIM	    85
102	    BALA	    95


TARGET_DATA:	 	 	 	 	 	 
st_id  st_name	marks	top_mark	least_mark	Variance from lowest	Variance from highest
100    	RAM 	 45	      95	          45	            0	                -50
101	    TIM  	 85	      95	          45	            40	                -10
102	    BALA	 95	      95	          45	            50	                  0
##################################################
*/

--If you run the program again, you should ignore the records which are already exists in the target.
--Write a stored procedure to populate the target tables.

CREATE TABLE source_data (
    st_id     NUMBER(5),
    st_name   VARCHAR2(20),
    marks     NUMBER(5)
);
/

insert into source_data values(100,'ram',45);
insert into source_data values(101,'tim',85);
insert into source_data values(102,'bala',95);
/

CREATE TABLE target_data (
    st_id                   NUMBER(5),
    st_name                 VARCHAR2(20),
    marks                   NUMBER(5),
    top_marks               NUMBER(5),
    least_marks             NUMBER(5),
    variance_from_lowest    NUMBER(5),
    variance_from_highest   NUMBER(5)
);
/

SELECT * FROM source_data;
/

SELECT * FROM target_data;
/

CREATE OR REPLACE PROCEDURE sp_st_tgt AS
BEGIN
    MERGE INTO target_data y
    USING (
              SELECT
                  st_id,
                  st_name,
                  marks,
                  MAX(marks) OVER() v_top_marks,
                  MIN(marks) OVER() v_least_marks
              FROM
                  source_data
          )
    z ON ( y.st_id = z.st_id )
    WHEN MATCHED THEN UPDATE
    SET y.marks = z.marks,
        y.top_marks = v_top_marks,
        y.least_marks = v_least_marks
    WHEN NOT MATCHED THEN
    INSERT (
        y.st_id,
        y.st_name,
        y.marks,
        y.top_marks,
        y.least_marks,
        y.variance_from_lowest,
        y.variance_from_highest )
    VALUES
        ( z.st_id,
          z.st_name,
          z.marks,
          v_top_marks,
          v_least_marks,
        z.marks - v_least_marks,
        z.marks - v_top_marks );

END;
/

EXEC sp_st_tgt;
/

SELECT * FROM target_data;
/