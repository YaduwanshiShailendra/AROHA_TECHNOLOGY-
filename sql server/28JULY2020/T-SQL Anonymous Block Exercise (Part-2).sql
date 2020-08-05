/*
##################################################
 Objective                : To solve T-SQL Anonymous Block Exercise (Part-2)
 Author(Creator) Name     : Shailendra Yadav
 Developed / Created Date : 28-July-2020
##################################################
*/

--21. Write a program to display first 10 Odd numbers
DECLARE @I INT =0,
@CNT INT=0
BEGIN
	WHILE @CNT<10
	BEGIN
	IF @I%2<>0 
		BEGIN
			PRINT @I
			SET @CNT=@CNT+1;
		END
			SET @I=@I+1;
	END
END	

--22. Write a program to reverse of a the string without using reverse function

DECLARE
@STR VARCHAR(20)='SHAILENDRA',
@V_A INT,
@STR1 VARCHAR(20)=''
BEGIN
SET @V_A=LEN(@STR)
	WHILE 0<=@V_A
		BEGIN
		SET @STR1=CONCAT(@STR1,SUBSTRING(@STR,@V_A,1))
		SET @V_A=@V_A-1
		END
	PRINT @STR1
END


--23. Write a program to check whether the number is perfect or not
	
	--		perfect number(sum of divisor should be equal to the number)
	--		example 28 = 1+2+4+7+14
DECLARE
@NO INT=28,
@V_A INT=1,
@SUM INT=0
BEGIN
	WHILE @V_A<@NO
		BEGIN
			IF @NO%@V_A=0
				BEGIN
					SET @SUM=@SUM+@V_A
					SET @V_A=@V_A+1
				END
			ELSE
				BEGIN
					SET @V_A=@V_A+1
				END
		END
IF @SUM=@NO
	BEGIN
		PRINT 'Perfect numbetr'
	END
ELSE
	BEGIN
		PRINT 'Not a perfect number'
	END
END


--24. Write a program to check whether the 3 digit number is armsstrong number or not
		--		Armstrong Number (sum of cube of all digits should be equal to the number)
		--		1*1*1 + 5*5*5 + 3*3*3 = 153
DECLARE
@NUM INT =153,
@SUM INT = 0,
@REM INT=0,
@ORIGINAL_NUM INT
BEGIN
SET @ORIGINAL_NUM=@NUM
	WHILE @NUM<>0
		BEGIN
		SET @REM=@NUM%10
		SET @SUM=@SUM + POWER(@REM,3)
		SET @NUM=@NUM/10
		END
		IF  @SUM = @ORIGINAL_NUM
			BEGIN
			PRINT 'Number is armstrong'
		END

		ELSE
			BEGIN
			PRINT 'Number is not armstrong'
		END
END


--25. Find the sum of all multiples of 3 and 5 below 1000.
	-- ans is 33165
			
DECLARE @SUM INT, @NUM INT
SET @SUM=0
SET @NUM=3*5
WHILE @NUM<1000
	BEGIN
		IF @NUM%3=0 AND @NUM%5=0
			BEGIN 
			SET @SUM=@SUM+@NUM
			END
		SET @NUM=@NUM+1
	END
PRINT @SUM



--26. Write a program to find the sum of the first 15 numbers of fibonacci series

DECLARE @I INT =0,
@CNT INT=0,
@SUM INT=0
 BEGIN
	WHILE @CNT<=15
	BEGIN
		IF @I%2= 0 
			BEGIN
				SET @SUM=@SUM+@I;
				SET @CNT=@CNT+1;
			END
		SET @I=@I+1;			
	END
	PRINT @SUM
END


--27. Write a program to find the sum digit of factorial of a number.
		
DECLARE @SUM INT, @NUM INT
SET @NUM=6
SET @SUM=1
BEGIN
WHILE @NUM>0
BEGIN
SET @SUM=@SUM*@NUM
SET @NUM=@NUM-1
END
PRINT @SUM
END


/*28. The sum of the square of the first ten natural numbers is. 
	12 + 22+ ... + 102 = 385
	The square of the sum of the first ten natural number is,
	(1 + 2 + ... + 10)2 = 552 = 3025
	Hence the difference between the sum of the squares of the first ten natural
	numbers and the sqare of the sum is 3025 - 385 = 2640.
	Find the difference between the sum of the square of the first 100 
	number and square of the sum of the 100 numbers and the square of the sum
*/




--29. Write a program to find the sum of the digits of 2 raise to the power 15.	
DECLARE
 @NUM INT =2, @SUM INT = 0, @N INT, @P INT = 15, @R INT
 BEGIN
 SET @N= POWER(@NUM,@P)
	WHILE @N<>0
	BEGIN
		SET @R= @N%10
		SET @SUM+=@R
		SET @N=@N/10
	END
	PRINT @SUM
END


/*30. There are only three numbers that can be written as the sum of fourth power of their digits.
1634  = 1 raise to 4 + 6 raise to 4 + 3 raise to 4 + 4 raise to 4.
8208  = 8 raise to 4 + 2 raise to 4 + 0 raise to 4 + 8 raise to 4.
9474  = 9 raise to 4 + 4 raise to 4 + 7 raise to 4 + 4 raise to 4.

Write a program to find these numbers between 1000 and 10000 and sum of these numbers
that is  1643+8208+9474=19316.
*/ 
BEGIN
DECLARE @NUM INT ,@NUMC INT,@SUM INT,@RES INT ,@POW INT
SET @NUM=1000
SET @NUMC=0
SET @RES=0
SET @SUM=0
--SET @POW=0
WHILE @NUM<10000
BEGIN
SET @NUMC=@NUM
--SET @POW=4
WHILE @NUM!=0
BEGIN
		SET @RES=@RES+POWER(@NUM%10,4)
		SET @NUM=@NUM/10
END
			
IF @RES=@NUMC
BEGIN 
	SET @SUM=@SUM+@RES
	PRINT @RES
END
SET @NUM=@NUM+1
END
PRINT @SUM
END

--31. Write a program to find the largest palindrome made from the multiplication of of two digit numbers.



--32. Pass 3 no to T-SQL block and find the sum of 3 numbers.
DECLARE @A INT ,@B INT ,@C INT
SET @A=10 SET @B=20 SET @C=30
BEGIN
PRINT @A+@B+@C
END


--33. Pass DEPTNO, DNAME, LOC into T-SQL & insert into the record DEPT table.
DECLARE @DN INT, @D VARCHAR(30), @L VARCHAR(30)
SET @DN=50 SET @D='HR' SET @L='BHOPAL'
BEGIN
INSERT INTO DEPT (DEPTNO,DNAME ,LOC)VALUES (@DN,@D,@L);
END

SELECT * FROM DEPT


--34. Pass EMPNO and new SALARY into T-SQL and update the salary in the EMP in EMP table.
DECLARE @ENO INT
SET @ENO =7369
UPDATE EMP 
SET SAL=12000 
WHERE EMPNO=@ENO;

SELECT * FROM EMP


--35. Pass EMPNO into T-SQL code & print the EMPNAME & SALARY.
			
DECLARE @ENO INT, @ENM VARCHAR(40), @SAL INT
SET @ENO=7566
SELECT @ENM=ENAME, @SAL=SAL FROM EMP WHERE EMPNO=@ENO;
PRINT 'ENAME is '+@ENM
PRINT 'SALARY is'+CAST(@SAL AS VARCHAR(300))

--36. Write a code which takes cust_id and displays whether he is from metro city or not.		
DECLARE @F INT ,@CID INT 
SET @CID=1234
SET @F=0
SELECT @F=COUNT(*) 
FROM CITY 
WHERE CITY_ID =(SELECT CITY_ID 
				FROM CUSTOMER 
				WHERE CUS_ID =@CID) AND METRO_FLAG='Y'
IF @F=0
PRINT 'NOT METRO'
ELSE
PRINT ' METRO'

