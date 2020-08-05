/*
##################################################
 Objective                : To solve T-SQL Anonymous Block Exercise (Part-1)
 Author(Creator) Name     : Shailendra Yadav
 Developed / Created Date : 27-July-2020
##################################################
*/

--Q1. Print 'Hello world'
PRINT 'Hello World';

--Q2. Pass two numbers and print the largest number.
DECLARE @A INT, @B INT
SET @A = 40
SET @B = 80
PRINT 'First number is '  + CAST(@A AS VARCHAR(2))
PRINT 'Second number is ' + CAST(@B AS VARCHAR(2))
IF @A>@B
PRINT 'First number "' + CAST(@A AS VARCHAR(2))+'" is greater number'
ELSE IF @B>@A
PRINT 'Second number "' + CAST(@B AS VARCHAR(2)) + '" is greater number'
ELSE PRINT 'Both number are EQUAL'


--3. Print 1 to 10
DECLARE @A INT
SET @A = 1
WHILE @A<=10
BEGIN
PRINT @A
SET @A = @A+1
END


--4. Print the given year is leap year or not
DECLARE @Y INT
SET @Y=2020
IF @Y%4 =0 AND @Y%100 != 0 
PRINT CAST(@Y AS VARCHAR(4)) + ' is a Leap year'
ELSE 
PRINT CAST(@Y AS VARCHAR(4)) + ' is not a Leap year'


--5. Pass the string and check given string is palindrome or not
DECLARE @STR VARCHAR(15), @REV VARCHAR(15), @LPP INT
SET @STR='RADAR'
SET @LPP=LEN(@STR)
SET @REV=''
WHILE  @LPP>=1
BEGIN
SET @REV = @REV + SUBSTRING(@STR, @LPP, 1)
SET @LPP = @LPP - 1
END
IF @STR = @REV
PRINT 'Its a palindrome string'
ELSE 
PRINT 'It''s not a not palindrome'


--6. Display the no of vowels and constraints in a given string.
DECLARE @STR VARCHAR(15) ,@LP INT,@V INT,@C INT
SET @STR = 'CONSTRAINTS'
SET @V = 0
SET @C = 0;
SET @LP = 1
WHILE @LP < LEN(@STR)
BEGIN
IF SUBSTRING(@STR,@LP,1) IN ('A','E','I','O','U')
SET @V = @V + 1
ELSE
SET @C = @C + 1
SET @LP = @LP + 1
END
PRINT 'Vowels in the string : ' +CAST(@V AS VARCHAR(2))
PRINT 'Consonents in the string : ' +CAST(@C AS VARCHAR(2))


--7. Print first 10 fibonacci series
DECLARE @A INT,@B INT ,@C INT ,@I INT
SET @A=0 
SET @B=1 
SET @I=2
PRINT @A 
PRINT @B
WHILE (@I <= 10)
BEGIN
SET @C = @A + @B
SET @A = @B 
SET @B=@C 
SET @I+=1
PRINT @C
END

--8. Count the given character in a given string
DECLARE @STR VARCHAR(20), @CNT INT, @CHR CHAR(1)
SET @STR='SHAILENDRA YADAV'
SET @CHR='A'
SET @CNT=LEN(@STR)-LEN(REPLACE(@STR,@CHR,''))
PRINT 'The number of occurance of '+ @CHR + ' in the string is ' +CAST(@CNT AS VARCHAR(2))

--9. Multiplication of two numbers	
DECLARE @A INT , @B INT,@R INT
SET @A = 7
SET @B = 8
SET @R = @A * @B
PRINT CAST(@A AS VARCHAR(2)) + ' * ' + CAST(@B AS VARCHAR(2)) + ' = ' + CAST(@R AS VARCHAR(3))
		
--10. Pass 3 no and find the greatest numbe
DECLARE @A1 INT=30;
DECLARE @A2 INT=50;
DECLARE @A3 INT=80;
BEGIN
IF @A1 IS NOT NULL AND  @A2 IS NOT NULL AND @A3 IS NOT NULL
BEGIN
IF @A1>@A2 AND @A1>@A2
	BEGIN
	PRINT 'IS GREATER='+CAST(@A1 AS VARCHAR(20));
END
ELSE IF @A2>@A1 AND @A2>@A3
	BEGIN
		PRINT 'IS GREATER='+CAST(@A2 AS VARCHAR(20));
END

ELSE 
	BEGIN
		PRINT 'IS GREATER='+CAST(@A3 AS VARCHAR(20));
END
END
END;

--11. Pass an email to code and print user name , domain and extension
DECLARE
 @STR VARCHAR(50)='shailendran70@gmail.com',
 @V_A VARCHAR(50),
 @V_B VARCHAR(50),
 @V_C VARCHAR(50)
BEGIN
 SET @V_A=SUBSTRING(@STR,1,CHARINDEX('@',@STR,1)-1)
 SET @V_B=SUBSTRING(SUBSTRING(@STR,CHARINDEX('@',@STR,1)+1,LEN(@STR)),1,CHARINDEX('.',SUBSTRING(@STR,CHARINDEX('@',@STR,1)+1,
LEN(@STR)),1)-1)
 SET @V_C=SUBSTRING(SUBSTRING(@STR,CHARINDEX('@',@STR,1)+1,LEN(@STR)),CHARINDEX('.',SUBSTRING(@STR,CHARINDEX('@',@STR,1)+1,LEN(@STR)))+1,
LEN(@STR))
   PRINT 'USER NAME : '+ CAST(@V_A AS VARCHAR(10));
   PRINT 'DOMAIN NAME : '+ CAST(@V_B AS VARCHAR(10));
   PRINT 'EXTENSION : '+ CAST(@V_C AS VARCHAR(10));
END



--12. Write a code which takes empno and print grade A if salary more than 5000 else grade B
DECLARE @ENO INT 
SET @ENO =7844
SELECT ENAME, SAL, CASE  WHEN SAL > 5000 THEN 'GRADE A'
ELSE 'GRADE B' END GRADE
FROM EMP
WHERE EMPNO = @ENO




--13.	Pass string and check if the first alphabet of string is character or not
DECLARE @STR VARCHAR(20)
SET @STR='7ADKJ'
IF UNICODE(@STR) BETWEEN 65 AND 90 OR UNICODE(@STR) BETWEEN 97 AND 122
PRINT 'First letter of the string is a Character '
ELSE 
PRINT 'First letter of the string is not a Character'

--14. Write a code which takes product name and print message if it made sales today or not
DECLARE
 @PNAME VARCHAR(10)= 'PHONE'
 --@V_A INT
BEGIN
    SELECT PROD_NAME FROM 
    PRODUCT_1 P JOIN SALES S
    ON P.PROD_ID=S.PROD_ID
    WHERE PROD_NAME=@PNAME 
    AND SALE_DT=GETDATE()
IF @PNAME  IN (SELECT PROD_NAME FROM PRODUCT_1)
	BEGIN
		PRINT 'Product made sales today'
	END
	ELSE
	BEGIN
		PRINT 'Product does not made any sale today'
    END
END

--15. Write a code which takes product name and prints the numbers of sales it made in current year and previous year
DECLARE
  @PNAME VARCHAR(50)='PHONE',
  @V_A INT,
  @V_B INT,
  @V_C INT
BEGIN
IF @PNAME IN (SELECT PROD_NAME FROM PRODUCT_1)
  BEGIN

SELECT @V_A=COUNT(SALE_ID) FROM 
PRODUCT_1 P JOIN SALES S
ON P.PROD_ID=S.PROD_ID
WHERE PROD_NAME=@PNAME 
AND YEAR(SALE_DT)=YEAR(GETDATE())

          SELECT @V_B=COUNT(SALE_ID) FROM 
          PRODUCT_1 P JOIN SALES S
		  ON P.PROD_ID=S.PROD_ID
          WHERE PROD_NAME=@PNAME 
          AND YEAR(SALE_DT)=YEAR(GETDATE())-1

SET @V_C=@V_A+@V_B
    PRINT 'Number of sale='+ CAST(@V_C AS VARCHAR(10))
  END
END


--16. Display whether the given number is prime or not
BEGIN
DECLARE @NUM INT ,@N1 INT,@CN INT,@FLAG INT
SET @FLAG=0
SET @NUM=13
SET @N1=@NUM/2
SET @CN=2
PRINT @NUM
WHILE @CN<=@N1
BEGIN
IF (@NUM%@CN) =0
BEGIN
	SET @FLAG=@FLAG+1
END 
IF @FLAG>1
BEGIN
	PRINT 'Its not a prime'
	BREAK
END 
SET @CN=@CN+1
END
IF (@FLAG=0)
PRINT 'Its a prime number'
END

		
--17. Take array of strings as 'CHENNAI,MUMBAI,DELHI,BANGLORE' and display it vertically.		
DECLARE @STR VARCHAR(50)='BANGLORE,CHENNAI,DELHI,KOLKATA',
@I INT= 1,
@CHAR VARCHAR(30)
BEGIN
WHILE @I<=LEN(@STR)
BEGIN
	IF SUBSTRING(@STR,@I,1)=','
		BEGIN
		PRINT @CHAR
		SET @CHAR = ''
	END     
ELSE
BEGIN
    SET @CHAR= CONCAT (@CHAR ,SUBSTRING(@STR,@I,1))
END 
SET @I=@I+1
END 
PRINT @CHAR
END


--18. Write a code which take any date as input and display 1st date of the year to last date of that year.
DECLARE @START_DATE DATE, @END_DATE DATE, @INPUT_DATE DATE, @DD INT
SET @INPUT_DATE = '07-27-2020'
SET @START_DATE = DATEADD(DD,1-DATEPART(DY,@INPUT_DATE),@INPUT_DATE)
SET @END_DATE = DATEADD(DD,-1,DATEADD(YEAR,1,@START_DATE))
SET @DD = 0
WHILE @DD <= DATEDIFF(DD,@START_DATE,@END_DATE)
BEGIN 
PRINT DATEADD(DD,@DD,@START_DATE)
SET @DD = @DD+1
END
		
--19. Write a code to check whether the given numebr has perfect square or not
DECLARE @NUM INT, @SR INT
SET @NUM = 121
SET @SR = SQRT(@NUM)	
IF @SR * @SR = @NUM
PRINT 'It''s a perfect square'
ELSE 
PRINT 'It''s not a perfect square'


--20. Write a program to check whether a given number  is ODD or EVEN without using MOD operator.
DECLARE @N INT, @RES INT
SET @N = 39
SET @RES = @N / 2
IF @RES * 2 = @N
PRINT 'It''s a even number.'
ELSE
PRINT 'It''s a odd number.'


