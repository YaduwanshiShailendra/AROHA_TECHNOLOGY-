
--TABLE SCRIPTS

CREATE TABLE USER1
( 	USER_ID		NUMBER(3) PRIMARY KEY,
  	U_NAME 		VARCHAR(20) NOT NULL, 
	U_ADDRESS	VARCHAR(20),
	EMAIL 		VARCHAR(20) UNIQUE,
	PHONE 		NUMBER(15),
	DOB 		DATE,
	COUNTRY		VARCHAR(20) NOT NULL
);

INSERT INTO USER1 VALUES(100,'ILA','DELHI','ILA@GMAIL.COM',917829961666,'22-02-1995','INDIA');
INSERT INTO USER1 VALUES(101,'SHELLY','DELHI','SHELLY@GMAIL.COM',918505497895,'12-01-1996','INDIA');
INSERT INTO USER1 VALUES(102,'SHAILENDRA','BHOPAL','SHAILENDRA@GMAIL.COM',918806997895,'12-03-1994','INDIA');
INSERT INTO USER1 VALUES(103,'SHRIDHAR','NOIDA','SHRIDHAR@GMAIL.COM',918516997895,'18-04-1997','INDIA');
INSERT INTO USER1 VALUES(104,'NAVEEN','CHENNAI','NAVEN@GMAIL.COM',918706997895,'23-05-1996','INDIA');
INSERT INTO USER1 VALUES(105,'MIKE','DALLAS’','MIKE@GMAIL.COM',118506997235,'12-02-1990','USA');
INSERT INTO USER1 VALUES(106,'VOLGA','TEXAS','VOLGA@YAHOO.COM',118436997895,'26-07-1999','USA');
INSERT INTO USER1 VALUES(107,'ILA','DELHI','ILA@GMAIL.COM',918506997895,'12-02-1995','INDIA');
INSERT INTO USER1 VALUES(108,'BILL','NEWYORK','BILL@GMAIL.COM',91857866995,'30-08-1994','USA');
INSERT INTO USER1 VALUES(109,'SHAHBAZ','BANGALORE','SIDDESH@HOTMAIL.COM',918506997895,'20-02-1992','INDIA');
INSERT INTO USER1 VALUES(110,'SIDDHESH','BANGALORE','SIDDHESH@GMAIL.COM',918506997895,'12-11-1992','INDIA');
INSERT INTO USER1 VALUES(111,'MADHURI','TELANGANA','MADHURI@GMAIL.COM',918506997895,'12-02-1995','INDIA');

CREATE TABLE BOOK_LOAN
(
	BL_ID			NUMBER(3) PRIMARY KEY,
	BOOKISUUE_DATE 	DATE DEFAULT(SYSDATE),
    BOOK_DDATE	    DATE,
	BOOK_RDATE	    DATE	
);

INSERT INTO BOOK_LOAN  VALUES(201,'20-MAR-2019','19-APR-2019','11-APR-2019');
INSERT INTO BOOK_LOAN  VALUES(202,'02-OCT-2019','01-NOV-2018','01-NOV-2018');
INSERT INTO BOOK_LOAN  VALUES(203,'15-JUN-2019','14-JUL-2019','20-MAR-2019');
INSERT INTO BOOK_LOAN  VALUES(204,'25-APR-2019','24-MAY-2019','20-MAY-2019');
INSERT INTO BOOK_LOAN  VALUES(205,'03-JUL-2019','02-AUG-2019','02-AUG-2019');
INSERT INTO BOOK_LOAN  VALUES(206,'20-MAR-2017','20-MAR-2017','20-MAR-2017');
INSERT INTO BOOK_LOAN  VALUES(207,'20-MAR-2018','20-MAR-2018','20-MAR-2018');
INSERT INTO BOOK_LOAN  VALUES(208,'20-JAN-2017','26-MAR-2017','20-MAR-2017');
INSERT INTO BOOK_LOAN  VALUES(209,'08-JAN-2018','04-MAR-2018','28-FEB-2017');
INSERT INTO BOOK_LOAN  VALUES(210,'08-JAN-2018','04-MAR-2018','28-FEB-2017');
INSERT INTO BOOK_LOAN  VALUES(211,'20-MAR-2016','19-APR-2016','11-APR-2016');
INSERT INTO BOOK_LOAN  VALUES(212,'02-OCT-2014','01-NOV-2014','01-NOV-2014');
INSERT INTO BOOK_LOAN  VALUES(213,'15-JUN-2012','14-JUL-2012','20-MAR-2012');
INSERT INTO BOOK_LOAN  VALUES(214,'25-APR-2015','24-MAY-2015','20-MAY-2015');
INSERT INTO BOOK_LOAN  VALUES(215,'03-JUL-2015','02-AUG-2015','02-AUG-2015');

CREATE TABLE BOOK
(
  BOOK_ID 		        NUMBER(3) PRIMARY KEY,
  BOOK_TITLE 	        VARCHAR2(30) NOT NULL,
  DATE_OF_PUBLICATION  DATE,
  NO_COPIES             NUMBER(3)
  );
  
  
INSERT ALL
    INTO BOOK  VALUES(100,'REVOLUTION 2020','20-MAR-2018',10)
    INTO BOOK  VALUES(101,'HIT REFRESH','23-DEC-2016',20)
    INTO BOOK  VALUES(102,'EXAM WARRIORS','30-MAR-2017',15)
    INTO BOOK  VALUES(103,'DREAMS FROM MY FATHER','17-JAN-2006',25)
    INTO BOOK  VALUES(104,'HALF-GIRLFRIEND','19-FEB-2015',25)
    INTO BOOK  VALUES(105,'UNIVERSE IN NUTSHELL','20-MAR-2015',10)
    INTO BOOK  VALUES(106,'THEORY OF RELATIVITY','20-MAR-2014',10)
    INTO BOOK  VALUES(107,'FILORY','04-MAR-2001',01)
    INTO BOOK  VALUES(108,'ESCAPE PLAN','20-SEP-2005',10)
    INTO BOOK  VALUES(109,'CODED LANGUAGE','15-JAN-2004',10)
    INTO BOOK  VALUES(110,'THE FUTURE','01-FEB-2010',10)
    INTO BOOK  VALUES(111,'BIBLE','',30)
    INTO BOOK  VALUES(112,'GEETA','',40)
    INTO BOOK  VALUES(113,'KURAN','',9)
SELECT * FROM DUAL;
  
CREATE TABLE AUTHOR (
AU_ID NUMBER(4) PRIMARY KEY,
AU_NAME VARCHAR2(20) );
  
INSERT ALL
    INTO AUTHOR VALUES(1000,'CHETAN BHAGAT')
    INTO AUTHOR VALUES(1001,'NARENDRA MODI')
    INTO AUTHOR VALUES(1002,'SATYA NADELLA')
    INTO AUTHOR VALUES(1003,'BARACK OBAMA')
    INTO AUTHOR VALUES(1004,'JK ROWLING')
    INTO AUTHOR VALUES(1005,'SHASHI THAROOR')
    INTO AUTHOR VALUES(1006,'STEPHEN HAWKING')
SELECT * FROM DUAL;


CREATE TABLE CATEGORIES
(
CATEGORY_ID		NUMBER(3) PRIMARY KEY,
CATEGORY_NAME	VARCHAR(20)
);

INSERT ALL
    INTO CATEGORIES VALUES(111,'Paranormal Romance')
    INTO CATEGORIES VALUES(112,'Prayer')
    INTO CATEGORIES VALUES(113,'Mystery')
    INTO CATEGORIES VALUES(114,'Memoir')
    INTO CATEGORIES VALUES(115,'Horror')
    INTO CATEGORIES VALUES(116,'Motivation')
    INTO CATEGORIES VALUES(117,'Biography')
    INTO CATEGORIES VALUES(118,'Fantasy')
SELECT * FROM DUAL;


CREATE TABLE BOOK_DETAILS(
BD_ID NUMBER(3) PRIMARY KEY,
BOOK_ID NUMBER(3) REFERENCES BOOK(BOOK_ID),
AU_ID NUMBER(4) REFERENCES AUTHOR(AU_ID) ,
CATEGORY_ID NUMBER(3) REFERENCES CATEGORIES(CATEGORY_ID));
  
INSERT ALL
    INTO BOOK_DETAILS VALUES(1,100,1000,116)
    INTO BOOK_DETAILS VALUES(2,101,1002,117)
    INTO BOOK_DETAILS VALUES(3,102,1001,116)
    INTO BOOK_DETAILS VALUES(4,103,1003,117)
    INTO BOOK_DETAILS VALUES(5,104,1000,111)
    INTO BOOK_DETAILS VALUES(6,105,1000,113)
    INTO BOOK_DETAILS VALUES(7,106,1000,113)
    INTO BOOK_DETAILS VALUES(8,107,1000,115)
    INTO BOOK_DETAILS VALUES(9,108,1000,118)
    INTO BOOK_DETAILS VALUES(10,109,1000,118)
    INTO BOOK_DETAILS VALUES(11,110,1000,114)
    INTO BOOK_DETAILS VALUES(12,111,1000,112)
    INTO BOOK_DETAILS VALUES(13,112,1000,112)
    INTO BOOK_DETAILS VALUES(14,113,1000,112)
SELECT * FROM DUAL;


CREATE TABLE BOOK_ISSUE
(
	BI_ID 		NUMBER(3) PRIMARY KEY,
	USER_ID 	NUMBER(3) REFERENCES USER1(USER_ID),
	BL_ID		NUMBER(3) REFERENCES BOOK_LOAN(BL_ID),
	BD_ID		NUMBER(3) REFERENCES BOOK_DETAILS(BD_ID)
);

INSERT ALL
    INTO BOOK_ISSUE VALUES(500,100,201,5)
    INTO BOOK_ISSUE VALUES(501,100,202,12)
    INTO BOOK_ISSUE VALUES(502,100,203,6)
    INTO BOOK_ISSUE VALUES(503,100,204,11)
    INTO BOOK_ISSUE VALUES(504,100,205,8)
    INTO BOOK_ISSUE VALUES(505,100,206,1)
    INTO BOOK_ISSUE VALUES(506,100,207,2)
    INTO BOOK_ISSUE VALUES(507,100,208,10)
    INTO BOOK_ISSUE VALUES(508,102,209,3)
    INTO BOOK_ISSUE VALUES(509,103,210,4)
    INTO BOOK_ISSUE VALUES(510,104,211,5)
    INTO BOOK_ISSUE VALUES(511,105,212,7)
--    INTO BOOK_ISSUE VALUES(512,107,213,9)
    INTO BOOK_ISSUE VALUES(513,109,214,12)
    INTO BOOK_ISSUE VALUES(514,110,215,14)
SELECT * FROM DUAL;

COMMIT;
  





drop table BOOK_ISSUE;
drop table BOOK_DETAILS;
drop table AUTHOR;
drop table BOOK;
drop table BOOK_LOAN;
drop table USER1;


--Questions

Questions

1. Write a query to display users who have books under category fantasy and author is not chetan bhagat.
  SELECT U_NAME 
  FROM USER1
  WHERE USER_ID =(SELECT USER_ID
                  FROM BOOK_ISSUE
				  WHERE BD_ID IN (SELECT BD_ID
				                   FROM BOOK_DETAILS
								   WHERE CATEGORY_ID=(SELECT CATEGORY_ID
								                      FROM CATEGORIES
													  WHERE CATEGORY_NAME='FANTASY')
													  
													  AND
													  
													  AU_ID<>(SELECT AU_ID
															  FROM AUTHOR		
															  WHERE AU_NAME='CHETAN BHAGAT')));
															  
  

2. Write a query to modify the column name user_address to user_city.
 ALTER TABLE USER1 
RENAME U_ADDRESS TO U_CITY; 

3. Write a query to display user name and number of books in each category.

SELECT U.U_NAME,COUNT(BD.BD_ID)
FROM USER1 U INNER JOIN BOOK_ISSUE BI
ON U.USER_ID=BI.USER_ID INNER JOIN BOOK_DETAIL BD
ON BI.BD_ID=BD.BD_ID
GROUP BY U.U_NAME,BD.CATEGORY_ID;

4. Write a query to display the youngest user who has books from the horror category.
 SELECT U_NAME 
 FROM USER1 ,BOOK_ISSUE BI,BOOK_DETAILS BD
 WHERE 	U.USER_ID=BI.USER_ID 
 AND 	BI.BD_ID=BD.BD_ID
 AND 	U.DOB IN (SELECT MAX(DOB) 
				  FROM USER1)
 AND	BD.CATEGORY_ID=(SELECT CATEGORY_ID 
						FROM CATEGORIES
						WHERE CATEGORY_NAME='HORROR'));
 

5. Write a query to display the user who returned jk rowling's book last year.

 SELECT U_NAME 
 FROM USER1 U,BOOK_ISSUE BI,BOOK_DETAILS BD
 WHERE U.USER_ID=BI.USER_ID
 
 AND	 BI.BD_ID=BD.BD_ID
 
 AND	 BL_ID IN (SELECT BL_ID
					FROM BOOK_LOAN
					WHERE TO_CHAR(BOOK_RDATE,'YY')=TO_CHAR(ADD_MONTHS(SYSDATE,-12),'YY'))
					
 AND 

 BD_ID IN (SELECT BD_ID
		  FROM BOOK_DETAILS
		  WHERE AU_ID=(SELECT AU_ID
						FROM AUTHOR	
						WHERE AU_NAME='JK ROWLING'));



6. Write a query to display the book name which was issued in the previous month, but not in the current month.

SELECT BOOK_TITLE 
FROM BOOK B,BOOK_ISSUE BI,BOOK_DETAILS BD
WHERE B.BOOK_ID=BI.BOOK_ID 
AND 	BI.BD_ID=BD.BD_ID

AND
BL_ID IN (SELECT BL_ID
           FROM BOOK_LOAN
		    WHERE TO_CHAR(BOOKISUUE_DATE,'MM-YY')=TO_CHAR(ADD_MONTHS(SYSDATE,-1),'MM-YY')
			
			AND
			
			BL_ID NOT IN(SELECT BL_ID
			             FROM BOOK_LOAN
						 WHERE TO_CHAR(BOOKISUUE_DATE,'MM-YY')=TO_CHAR(SYSDATE,'MM-YY'));

	
7. Write a query to update the phone no. Whose having 91 from the phone no in starting

8. Write a query to display user name author wise.
 select u.u_name 
from user1 u,book_issue bi,book_details bd  ,author a
where u.user_id=bi.user_id

and     bi.bd_id=bd.bd_id

and bd.au_id=a.au_id

group by  bd.bd_id,u.u_name;


9. Write a query to display books name category wise which is more than 3.
	select book_name 
from book b, book_details bd,book_issue bi
where b.book_id=bd.book_id
and bd.bd_id=bi.bd_id
and group by(book_id)
having count(bi_id)>3;


10. Write a query to display books which are issued in the month before previous month and issued at least twice.
	select book_name
from book b
where book_id in (select book_id        
              from book_detail
              where bd_id in(select bd_id
                             from book_issue
                             where bl_id in(select bl_id
                                            from book_load
                                            where to_char(bookissue_date)=tochar(add_months(sysdate,-2),'mm-yy'))))
                                            
group by book_id
having count(book_id)>=2;


11. Write a query to update username whose name and user_name of email_id doesn't match and replace the name with user_name from email.
update table user u2
set u_name=( select substr(email,1,instr(email,'@')-1)
             from user u1
             where u1.user_id=(select user_id
                               from user
                               where u_name<> substr(email,1,instr(email,'@')-1))
                               
             and u1.user_id=u2.user_id);

12. Write a query to display all the users who have a birthday in the 4th week of month and the issued book category is ’horror’.
select user_name
from user1 u,book_issue bi,book_detail bd
where u.user_id=bi.user_id 
and  bi.bd_id=bd.bd_detail
and
bd.catogery_id=(select category_id
                from category
                where category_name='horror')
and
to_char(dob,'w')=4;



13. Write a query to display users who have similar interests but it should be in sorted interest wise.

14. Write a query to display books whose publish date is within the previous 2 years and author name is 'BARACK OBAMA'.

15. Write a query to display books which were published before ‘THE FUTURE’ and after ‘ESCAPE PLAN’.

SELECT  BOOK_TITLE 
FROM BOOK B1
WHERE DATE_OF_PUBLICATION<(SELECT DATE_OF_PUBLICATION
                            FROM BOOK B2
							WHERE BOOK_TITLE='THE FUTURE')
	AND
	DATE_OF_PUBLICATION>(SELECT DATE_OF_PUBLICATION
                            FROM BOOK B3
							WHERE BOOK_TITLE='ESCAPE PLAN');



16. Write a query to display user name and number of books in category.

17. Display the author_name who has his books present in more than one category.


18. Write a query to update the age column in the user table and update age of all.
SELECT * FROM USER1;
ALTER TABLE USER1
ADD AGE NUMBER(3);

UPDATE USER1 U1 SET AGE =(SELECT MONTHS_BETWEEN(SYSDATE,DOB)/12 
                        FROM USER1 U2
                        WHERE U1.USER_ID=U2.USER_ID);



19. Write a query to display book names who were published year before last year and have the users present in both USA  or INDIA and have the author ‘STEPHEN HAWKING’ or ‘CHETAN BHAGAT’.

SELECT B.BOOK_TITLE
FROM BOOK B,BOOK_ISSUE BI,BOOK_DETAILS BD
WHERE BI.BD_ID=BD.BD_ID
AND	 BI.BD_ID=BD.BD_ID

AND BI.BD_ID IN (SELECT BD_ID
              FROM BOOK_DETAILS
			  WHERE AU_ID IN (SELECT AU_ID
			                  FROM AUTHOR
							  WHERE AU_NAME IN ('STEPHEN HAWKING','CHETAN BHAGAT')
	AND
BI.USER_ID IN (SELECT USER_ID
               FROM USER1
               WHERE COUNTRY IN ('INDIA','USA')
AND
BD.BOOK_ID IN (SELECT BOOK_ID
            FROM BOOK
            WHERE TO_CHAR(DATE_OF_PUBLICATION,'YY')=TO_CHAR(ADD_MONTHS(SYSDATE,-24),'YY')))));			




--20. Write a query to display user names who have more than two vowels in their name as well as book names.
SELECT DISTINCT U.U_NAME
FROM USER1 U,BOOK_ISSUE BI,BOOK_DETAILS BD
WHERE U.USER_ID=BI.USER_ID
AND  BI.BD_ID=BD.BD_ID
AND BD.BD_ID IN(SELECT BD_ID
              FROM BOOK_DETAILS
			  WHERE BOOK_ID IN (SELECT BOOK_ID
                                FROM BOOK
                                WHERE BOOK_TITLE));
                                
                                 
                                instr(BOOK_TITLE,(lower(substr(BOOK_TITLE,1,length(BOOK_TITLE)) in ('a','e','i','o','u')),2)>0;
                                

--21.WQTD the user name who has studied from all categories of books.
SELECT DISTINCT U.U_NAME
FROM USER1 U,BOOK_ISSUE BI,BOOK_DETAILS BD
WHERE U.USER_ID=BI.USER_ID
AND  BI.BD_ID=BD.BD_ID
AND BD.BD_ID IN(SELECT BD_ID
              FROM BOOK_DETAILS
			  WHERE CATEGORY_ID IN (SELECT CATEGORY_ID
			                           FROM CATEGORIES));



--22. Write a query to display the category name which book does not have a publication date.
SELECT DISTINCT CATEGORY_NAME 
FROM CATEGORIES C,BOOK_DETAILS BD
WHERE C.CATEGORY_ID=BD.CATEGORY_ID
AND	BOOK_ID IN (SELECT BOOK_ID
                FROM BOOK
				WHERE DATE_OF_PUBLICATION IS NULL);




