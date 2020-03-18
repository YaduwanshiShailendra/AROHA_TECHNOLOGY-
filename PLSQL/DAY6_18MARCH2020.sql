/*
################################################
Objective                : Exception Handling
Author(Creator) Name     : Shailendra Yadav
Developed / Created Date : 17-mar-2020
################################################
*/


SET SERVEROUTPUT ON; 


Exceptions(6 questions)

 

1.      Write a plsql block with your own scenario for

a.       ‘No data Found’

b.      ’Invalid number’

c.       ’Value error’

d.      ’Dup val on index’

e.      ’too_many_rows’,’

f.        Invalid Cursor

g.      Cursor already open

h.      Zero divide

i.        Case not found

j.        When others then

 

2.      Write a plsql block by passing the account no, if it doesn’t start from s or u or p then raise an exception and handle it, also include when others then exception.

3.      Write a plsql block to handle ‘Child records found’ related non predefined exception which has the error no -2292, also include when others then exception.

4.      Write a procedure to print ename and dname by passing empno and deptno. If u pass invalid empno and valid deptno, it has to print ‘Invalid empno’ and print dname. If u pass valid empno and invalid deptno, it has to print ename and  ‘invalid deptno’. If u pass both valid then it has to print ename and dname. If u pass both invalid then print ‘invalid empno’ and ‘invalid deptno’, also include when others then exception.

5.      Write a procedure to divide the salary of all employees by its commission and handle zero divide exception and also insert the divided value into a table, also include when others then exception.

6.      Write a procedure by passing empno, the empno passed should be in the range 1000 to 5000, also include when others then exception.
       If it violates this rule create a user defined exception and handle it.

7.      Pass the empno and update the job of that employee to SSE. If the empno passed does not exist, and the update did not happen handle the no data found exception by raising it and print the error number and err message using SQLCODE and SQLERRM, also include when others then exception.

8.      Pass a string of numbers as 10,20,80,70,60 and display the number which is maximum in it.

9.      Pass a empno and display the grade of the salary of passed employee. If sal>30000 print ‘Grade A’, salary>20000 then ‘Grade B’ Sal>10000 then ‘Grade C’ else ‘no grade’ using case in PLSQL, also include when others then exception.

10.  Pass a string, if the string contains 2 words display each word in new line else raise the error and handle the exception
