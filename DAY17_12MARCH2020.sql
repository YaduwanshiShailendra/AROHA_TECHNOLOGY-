--its a db link
select * from tab@dblink_1;

--to connect testuser cloud server.
conn testuser/testuser@clouddb;

explain plan for
create materialized view mv_emp 
build immediate
refresh force
on demand
start with sysdate next sysdate+2
with primary key
as select empno,ename, sal*12 from emp;

show user;


conn testuser/testuser@clouddb;

select * from mv_emp;

exec dbms_mview.refresh('mv_emp');

---------------------------------------------------------------------------
--to connect testuser cloud server.
conn testuser/testuser@clouddb;

--'explain plan for' use for plan
explain plan for 
select dname, d.deptno, count(empno),sum(sal)
from dept d, emp e
where d.deptno=e.deptno(+)
group by dname, d.deptno
having count(empno)=(select max(count(empno)) from emp group by deptno);

select * from table (dbms_xplan.display);

-------------------------------------------------------------------------
conn scott/tiger;
explain plan for
select * from mv_emp1;

select * from table (dbms_xplan.display);

--------------------------------------------------------------------------

create materialized view mv_emp1 
build immediate
refresh force
on demand
start with sysdate next sysdate+2
with primary key
as select dname, d.deptno, count(empno),sum(sal)
from dept d, emp e
where d.deptno=e.deptno(+)
group by dname, d.deptno;

---------------------------------------------------------------------------

collect statistics on emp; 



show user;

set autotrace on;
set autotrace on explain;
set autotrace on statistics;
set autotrace traceonly;


select * from emp;

--------------------------------------------------------------------------

create role aroha_dev_level1;

drop role aroha_dev_level;

grant create view, create session, create sequence to aroha_dev_level1;

create role aroha_dev_level2;

grant aroha_dev_level1 to aroha_dev_level2;

conn;