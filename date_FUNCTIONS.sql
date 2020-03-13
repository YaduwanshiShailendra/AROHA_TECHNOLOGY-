First Day of Current Year:

SELECT TRUNC (SYSDATE , 'year') FROM DUAL;

–> Last Day of Current Year:

SELECT ADD_MONTHS(TRUNC (SYSDATE ,'YEAR'),12)-1 FROM DUAL;

–> First Day of Previous Year:

SELECT ADD_MONTHS (TRUNC (SYSDATE,'YEAR'), -12) FROM DUAL;

–> Last Day of Previous Year:

SELECT ADD_MONTHS (TRUNC (SYSDATE, 'YEAR'), -1 ) +30 FROM DUAL;

-->last day of current month
SELECT last_day(TRUNC(SYSDATE, 'mon')) FROM DUAL;

SELECT to_char(SYSDATE, 'mm') FROM DUAL;


select to_char(last_day(trunc(to_date(03,'mm'),'mm')), 'dd') from dual;

-----------------------------------------------------------------------------------------------------



SQL> select
  2    extract(year from sysdate) y1,
  3    extract(year from add_months(sysdate,-12)) y2,
  4    extract(year from add_months(sysdate,-3)) y3
  5  from dual;

        Y1         Y2         Y3
---------- ---------- ----------
      2017       2016       2016
	  
	  
	  
	  
------------------------------------------------------------------------------------------------------------
	  
	  
	  
	  
	  
	  SELECT add_months(TRUNC(sysdate,'YEAR'),0) "First Day",
       add_months(TRUNC(sysdate,'YEAR')-1,12) "Last Day"
         FROM dual;


----------------------------------------------------------------------------------------------------

select sysdate from dual;

select add_months(last_day(sysdate),-1)+1 firt_day ,last_day(sysdate) lastday from dual;

select NEXT_DAY(trunc(SYSDATE), '&Day') from dual;

select to_char(SYSDATE,'dd-mm-yy hh:mi:ss') from dual;

select (last_day(add_months(trunc(SYSDATE),-to_char(trunc(sysdate),'MM')))+1) first_day ,
last_day(add_months(trunc(SYSDATE),-to_char(trunc(sysdate),'MM')))+1 last_day
from dual;

select trunc(sysdate) from dual;
select trunc(sysdate,'MON') First_day_of_month from dual;
select trunc(sysdate,'YEAR') First_day_of_year from dual;
SELECT TRUNC (SYSDATE , 'YEAR') FROM DUAL;

SELECT ADD_MONTHS(TRUNC (SYSDATE , 'YEAR'),12)-1 FROM DUAL;

select trunc(sysdate,'MON') from dual;

SELECT ADD_MONTHS (TRUNC (SYSDATE,'YEAR'), -12) FROM DUAL;

SELECT add_months(TRUNC(sysdate,'YEAR'),0) “First Day”,
add_months(TRUNC(sysdate,'YEAR')-1,12) as Lasst_Day
FROM dual;

DESC EMP;
DESC DEPT;