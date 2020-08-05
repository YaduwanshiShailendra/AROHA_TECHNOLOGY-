/*
##################################################
 Objective                : Recruiter scenario
                               
 Author(Creator) Name     : Shailendra Yadav
 Developed / Created Date : 09-June-2020
 
 
1.To calculate the average no. of employees recruited in a month.
2.To print the share of female(female count/(female count+Male count)) employees hired in the year of
2020.
3.To display the no. of employees who joined within a month of recruitment.
4.To display the recruiter who has recruited the most number of employees yearwise.
5.To determine the month in which maximum number of people were recruited.
##################################################
*/
SET SERVEROUTPUT ON;

--#######################################################################################################

CREATE TABLE employees (
    emp_id       INT PRIMARY KEY,
    ename        VARCHAR2(38),
    gender       VARCHAR2(10),
    joining_dt   DATE
);
/

CREATE TABLE recruiter (
    recr_id   INT PRIMARY KEY,
    recr_nm   VARCHAR2(38)
);
/

CREATE TABLE hiring_info (
    recr_id
        REFERENCES recruiter ( recr_id ),
    emp_id
        REFERENCES employees ( emp_id ),
    recr_dt DATE
);
/

--#######################################################################################################

INSERT INTO employees VALUES (
    1,
    'KARTIK',
    'MALE',
    '21-AUGUST-2020'
);

INSERT INTO employees VALUES (
    2,
    'ROMA',
    'FEMALE',
    '11-APRIL-2020'
);

INSERT INTO employees VALUES (
    3,
    'SHAIL',
    'MALE',
    '19-JULY-2020'
);

INSERT INTO employees VALUES (
    4,
    'SONY',
    'FEMALE',
    '13-MAY-2020'
);

INSERT INTO recruiter VALUES (
    100,
    'RAVI'
);

INSERT INTO recruiter VALUES (
    101,
    'MITHA'
);

INSERT INTO recruiter VALUES (
    102,
    'SHUBHAM'
);

INSERT INTO recruiter VALUES (
    103,
    'SURESH'
);

INSERT INTO recruiter VALUES (
    104,
    'ARUN'
);

INSERT INTO hiring_info VALUES (
    100,
    1,
    sysdate
);

INSERT INTO hiring_info VALUES (
    101,
    2,
    '18-06-2020'
);

INSERT INTO hiring_info VALUES (
    102,
    4,
    sysdate
);

INSERT INTO hiring_info VALUES (
    101,
    3,
    '25-06-2020'
);
/

select * from employees;
select * from recruiter;
select * from hiring_info;
/

--#######################################################################################################
--1)To calculate the average no. of employees recruited in a month.

CREATE OR REPLACE PROCEDURE usp_avg_emps AS
    v_avg_emps FLOAT;
BEGIN
    SELECT
        COUNT(emp_id) / 12
    INTO v_avg_emps
    FROM
        hiring_info;

    dbms_output.put_line('Average Employees Recruited Per Month = ' || v_avg_emps);
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('ERROR!! TRY AGAIN LATER');
END;
/

  EXEC usp_avg_emps;
/  


--2) To print the share of female(female count/(female count+Male count)) employees hired in the year of 2020.


CREATE OR REPLACE PROCEDURE sp_female_emps AS
    v_total_females   INT;
    v_total_emps      INT;
    v_female_share    FLOAT;
BEGIN
    SELECT
        COUNT(emp_id)
    INTO v_total_females
    FROM
        employees
    WHERE
        gender = 'FEMALE';

    SELECT
        COUNT(emp_id)
    INTO v_total_emps
    FROM
        employees;

    v_female_share := v_total_females / v_total_emps;
    dbms_output.put_line('Share of Female is = '
                         || v_female_share * 100
                         || '%');
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('ERROR !!!!!! TRY AGAIN LATER');
END;
/

   EXEC sp_female_emps;
/


  
--3) To display the no. of employees who joined within a month of recruitment.

SELECT
    COUNT(e.emp_id) AS no_of_emps
FROM
    employees     e,
    hiring_info   h
WHERE
    e.emp_id = h.emp_id
    AND months_between(e.joining_dt, h.recr_dt) <= 1;
/

--4) To display the recruiter who has recruited the most number of employees yearwise.

SELECT
    r.recr_nm AS recruiter_name
FROM
    recruiter     r,
    hiring_info   h
WHERE
    r.recr_id = h.recr_id
GROUP BY
    r.recr_nm,
    to_char(h.recr_dt, 'YYYY')
HAVING
    COUNT(emp_id) = (
        SELECT
            MAX(COUNT(recr_id))
        FROM
            hiring_info
        GROUP BY
            recr_id,
            to_char(recr_dt, 'YYYY')
    );
/


-- 5) To determine the month in which maximum number of people were recruited.

SELECT
    to_char(recr_dt, 'MONTH-YYYY') AS month_year,
    COUNT(emp_id) AS emps_recruited
FROM
    hiring_info
HAVING
    COUNT(emp_id) >= (
        SELECT
            MAX(COUNT(emp_id))
        FROM
            hiring_info
        GROUP BY
            to_char(recr_dt, 'MM-YYYY')
    )
     GROUP by
to_char(recr_dt, 'MONTH-YYYY');
/ 
 
 
     
    
 
 

 
 
 
 
 
 