/*
##################################################
 Objective                : To solve T-SQL Functions Exercise
 Author(Creator) Name     : Shailendra Yadav
 Developed / Created Date : 30-July-2020
##################################################
*/

/*
Function:-
Function is defined as "self contained or predefined program which returns max of 1 value".
Returned value can be of int, text, datetime.

User defined functions are classified into two types:
 1. Scalar Valued Functions (which returns 1 value)
 2. Table Valued Functions (which returns multiple rows)
 
Function 
1. DB object which gets stored inside a db
2. It should return a value

Difference between procedure and functions
Procedure-
1. May or maynot return a value	
2. It is used for data processing  and appling logics
3. Cannot be called in select statement

Function-
1. Must return a vaule
2. Calculations
3. we can call in select statement.

 
-- to delete a function - 
	drop function (schema.funcction_name)
-- to view the coide of the function   
	sp_helptext function_name

-- to view information about the columns used in the function	
	sp_help function_name
*/

DROP FUNCTION factorial

SP_HELPTEXT factorial

SP_HELP factorial
 
--QUERY TO POPULATE LIST OF FUNCTION
select * from sys.objects where type='FN'


--------------------------------------------------------------------------------------------

--1.Write a function to print the factorial of a number.

CREATE FUNCTION FACTORIAL(@NUM INT)
RETURNS INT
AS 
BEGIN
	DECLARE @FACT INT
	SET @FACT = 1
	WHILE @NUM > 0
		BEGIN
			SET @FACT = @FACT * @NUM
			SET @NUM = @NUM - 1
		END
		RETURN @FACT
END

SELECT DBO.FACTORIAL(4)


--------------------------------------------------------------------------------------------
--2. Write a plsql function by passing age and gender, if age <18 then return 0 otherwise 
--return the no. of employees who are in that age and gender.

select * from emp;
DROP FUNCTION FUN_AGE;
CREATE FUNCTION FUN_AGE(@AGE INT, @GENDER VARCHAR(6))
RETURNS INT
AS
BEGIN
DECLARE @COUNTEMP INT = 0
	IF @AGE >= 18
	BEGIN
	    SELECT @COUNTEMP=COUNT(EMPNO) FROM EMPLOYEE_TBL WHERE DATEDIFF(YY, DOB, GETDATE())=@AGE AND GENDER = @GENDER
	END
	ELSE
	BEGIN
		RETURN 0
	END
	RETURN @COUNTEMP
END


SELECT DBO.FUN_AGE(28,'MALE')

--3. Write a function that takes P, R, T as inputs and returns SI. SI=P*R*T/100

CREATE FUNCTION SI(@P INT,@R INT,@T INT)
RETURNS FLOAT
AS 
BEGIN
	DECLARE @SI FLOAT
	SET @SI =(@P*@R*@T)/100
	RETURN @SI
END

SELECT DBO.SI(2000,10,2)

-------------------------------------------------------------------------------------------------------

--5.Write a function which takes Email as input and display whether it is a valid email id or not. 
--The rules for finding out validity of email is –
--o   It should contain at least one ‘@’ symbol.
--o   It should not contain more than one @ symbol.
--o   Email id should not start and end with @
--o   After @ there should be at least 2 tokens.  



-------------------------------------------------------------------------------------------------------

--6.Write a function to print the numbers from 1 to 10 without using loop (Hint:Use recursive function)

create function recursive_func()
returns table
as
return
	with CTE as
   (
		select count=1
		union all
		select count=count+1
		from CTE where count<10
    )
	select * from CTE

select * from DBO.recursive_func()


-------------------------------------------------------------------------
--7. Write a function which takes a value from the user and check whether the given values is a number or not. If it is a number, 
--return ‘ valid Number’ otherwise ‘invalid number’.
--Phone Number- should have 10 digits, all should be numbers and phno should start with 9 or 8 or 7.

CREATE FUNCTION CHK_VALIDNO(@VAL VARCHAR(25))
RETURNS VARCHAR(25)
AS
BEGIN
	DECLARE @MSG VARCHAR(25)
	IF LEN(@VAL)=10 AND ISNUMERIC(@VAL)=1 AND SUBSTRING(@VAL,1,1)IN(9,8,7)
		SET @MSG='Valid number'
	ELSE
	    SET @MSG= 'Invalid number'
	RETURN @MSG
END

SELECT DBO.CHK_VALIDNO('8770065751')

SELECT DBO.CHK_VALIDNO('6736765751')


-------------------------------------------------------------------------------------------------
--8.Write  a function by passing 2 dates and return the no. of Saturdays between two dates.

CREATE FUNCTION COUNT_SATUDAYS(@STARTDATE DATETIME, @ENDDATE DATETIME)
RETURNS INT
AS
BEGIN
DECLARE @COUNT INT
SET @COUNT=0
WHILE @STARTDATE < @ENDDATE
BEGIN
	IF DATENAME(DW,@STARTDATE)='SATURDAY'
	BEGIN
		SET @COUNT=@COUNT + 1
	END
	SET @STARTDATE = DATEADD(DD,1,@STARTDATE)
END
	RETURN @COUNT
END

SELECT DBO.COUNT_SATUDAYS('2020-05-01','2020-07-30')


-----------------------------------------------------------------------------------------------------
--10.Create a function by passing to  2 strings, if it is a number print the sum of 2 numbers else 
--print the concatenation of 2 strings.

CREATE FUNCTION SUM_FN(@STR1 VARCHAR(30),@STR2 VARCHAR(30))
RETURNS VARCHAR(30)
AS
BEGIN 
DECLARE 
	@SUM VARCHAR(30)
    IF ISNUMERIC(@STR1)=1 AND ISNUMERIC(@STR2)=1
		SET @SUM=CAST(@STR1 AS INT)+CAST(@STR2 AS INT)
	ELSE 
		SET @SUM=@STR1+@STR2
	RETURN @SUM
END

SELECT DBO.SUM_FN('10','22')

SELECT DBO.SUM_FN('10','22A')



-------------------------------------------------------------------------------------------------
--Q) Create a function that takes two values as input and returns Product of two values.

CREATE FUNCTION PROD(@A INT,@B INT)
RETURNS INT
AS
BEGIN
	DECLARE @C INT
	SET @C = @A*@B
	RETURN @C
END

SELECT DBO.PROD(12,12)

-------------------------------------------------------------------------------------------------
--Q) Create a function called Fact that takes one number as input to a function and returns factorial of a given number.

CREATE FUNCTION FACT(@N INT)
RETURNS INT
AS
BEGIN
	DECLARE @F INT
	SET @F = 1
	WHILE @N > 0
	BEGIN
		SET @F = @F * @N
		SET @N = @N - 1
	END
	RETURN @F
END
SELECT DBO.FACT(5)

-------------------------------------------------------------------------------------------------
--Q) Create a function that takes empno as an argument and returns employee name.

CREATE FUNCTION FIND_EMP(@ENO INT)
RETURNS VARCHAR(12)
AS
BEGIN
	DECLARE @EN VARCHAR(12)
	SELECT @EN = ENAME FROM EMP WHERE EMPNO = @ENO
	RETURN @EN
END

SELECT DBO.FIND_EMP(7566)

-------------------------------------------------------------------------------------------------
--Q) Create a function called EMPRET that retrieves the rows of those employees who are working in deptno 20.

CREATE FUNCTION EMPRET(@DNO INT)
RETURNS TABLE
AS
RETURN (SELECT * FROM EMP WHERE DEPTNO=@DNO)

SELECT * FROM DBO.EMPRET(20)

-------------------------------------------------------------------------------------------------


-------------------------------------------------------------------------------------------------


-------------------------------------------------------------------------------------------------




