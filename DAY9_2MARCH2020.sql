
create table country_2
(country_id number(2) primary key,
country_name varchar2(20));

insert all
into country_2 values(1,'US')
into country_2 values(2,'India')
into country_2 values(3,'Shrilanka')
into country_2 values(4,'Maldives')
select * from dual;

create table resort_2
(resort_id number(4) primary key,
resort_name varchar2(20),
country_id number(2) references country_2(country_id));


insert all
into resort_2 values(50,'Beach font',4)
into resort_2 values(51,'Oberai, Goa',2)
into resort_2 values(52,'Taj Maldives',4)
into resort_2 values(53,'Taj chennai',2)
select * from dual;



create table customer_2
(cust_id number(5) primary key,
cust_name varchar2(20),
phone number(10),
country_id number(2) references country_2(country_id));

insert all
into customer_2 values(1001,'tim downey',345231458,1)
into customer_2 values(1002,'ramesh k',89327648,2)
into customer_2 values(1003,'bill price',78326753,1)
into customer_2 values(1004,'malinga',98564231,3)
into customer_2 values(1005,'farooq',45893121,4)
select * from dual;

--1. Query to find out country wise resort count.
SELECT C.country_NAME, COUNT(R.country_id)
FROM COUNTRY_2 C, RESORT_2 R
WHERE C.COUNTRY_ID=R.COUNTRY_ID(+)
GROUP BY C.COUNTRY_NAME;

--2. Query to display country wise customer count.
SELECT c.COUNTRY_NAME, COUNT(cust.CUST_ID)
FROM COUNTRY_2 C, CUSTOMER_2 CUST
WHERE C.COUNTRY_ID=R.COUNTRY_ID
GROUP BY COUNTRY_NAME;


--3. Query to display country, resort count and customer count.
select a.country_name, a.resort_count, b.cust_count
from(select country_name, count(res_id) resort_count
from country_2 c, resort_2 r
where c.country_id=r.country_id(+)
group by country_name) a,

(select country_name, count(cust_id)
from country_2 c, customer_2 cust
where c.country_id=cust.country_id
group by country_name) b
where a.country_name=b.country_name;

--4. Display Resort country name, resort name, customer name and customer country name.

--5. Display countries in which we don’t have any resorts.
select country_name
from country_2
where county_id not in (select distinct (county_id)
from resort);

--6. Display countries in which we have minimum of 100 customers.
select C.country_name
from country_2 c, customer_2 cust
where c.country_id=cust.country_id
group by C.country_id
having count(CUST.cust_id)>100;

--7. Display how many resorts we have in the country where resort ‘Beach front’ is
SELECT COUNT(R.RESORT)
FROM RESORT_2 R, COUNTRY_2 C
WHERE R.COUNTRY_ID=C.COUNTRY_ID
AND R.RESORT_NAME='Beach font';

SELECT * FROM country_2;

--8. Display customers whose name starts with F or R and who are either from India or Srilanka.
SELECT CUST_NAME
FROM CUSTOMER_2 CUST, COUNTRY_2 C
WHERE CUST.COUNTRY_ID=C.COUNTRY_ID
AND SUBSTR(CUST_NAME,1,1) IN ('F','R')
AND COUNTRY_NAME IN ('India', 'Shrilanka');

--9. Display customer names who are from US and do not have any phone numbers.
SELECT CUST_NAME
FROM CUSTOMER_2
WHERE PHONE IS NULL
AND COUNTRY_ID = (SELECT COUNTRY_ID
                    FROM COUNTRY_2
                    WHERE COUNTRY_NAME='US');

--10. Display Country name, resort name. Display all the countries in the list whether we have resorts or not.

SELECT C.COUNTRY_NAME, R.RESORT_NAME (CASE WHEN RESORT_NAME IS NULL
                                    THEN 'DONT HAVE RESORT' 
                                    ELSE 'HAVE RESORTS' END)
AS RESORT FROM COUNTRY_2 C LEFT JOIN RESORT R
ON C.COUNTRY_ID=R.COUNTRY_ID;


--
--########################################################################################################
--                        PUBLISHER MODEL
--########################################################################################################

create table author1
(au_id number(5) primary key,au_f_name varchar2(20),au_l_name varchar2(20),au_dob date,au_address varchar2(20));
insert all
into author1 values(1,'raj','deshpande','22-jan-15','jpnagar,bang')
into author1 values(2,'arun','patil','03-mar-15','rrnagar,bang')
into author1 values(3,'ritesh','deshmukh','28-sep-15','kalyannagar,bang')
into author1 values(4,'arjun','janya','19-oct-15','jaynagar,bang')
into author1 values(5,'kiran','sharma','17-nov-15','tnagar,bang')
select * from dual;
/
create table publisher
(pub_id number(5) primary key,pub_nm varchar2(20), pub_address varchar2(20),pub_city varchar2(20),pub_state varchar2(20));
insert all
into publisher values(1101,'abc publications','ring road','bangalore','karnataka')
into publisher values(1102,'pqr publications','south end','bangalore','karnataka')
into publisher values(1103,'xyz publications','kr circle','bangalore','karnataka')
into publisher values(1104,'rrr publications','rr road','bangalore','karnataka')
into publisher values(1105,'lmn publications','dk circle','bangalore','karnataka')
into publisher values(1106,'zzz publications','kr puram','bangalore','karnataka')
select * from dual;
/
create table book1
(book_id number(5) primary key,book_nm varchar2(20),pub_id number(5) references publisher(pub_id));
insert all
into book1 values(11,'cartoon books',1101)
into book1 values(12,'story books',1101)
into book1 values(13,'adventures books',1102)
into book1 values(14,'novel books',1101)
into book1 values(15,'thriller books',1103)
into book1 values(16,'horror books',1102)
select * from dual;
/
create table book_author
(bk_au_id number(5) primary key,book_id number(5) references book1(book_id),au_id number(5) references author1(au_id));
insert all
into book_author values(111,14,1)
into book_author values(222,12,1)
into book_author values(333,11,2)
into book_author values(444,11,3)
into book_author values(555,11,2)
into book_author values(666,14,2)
into book_author values(777,15,4)
into book_author values(888,16,5)
select * from dual;


--1.	Identify the relationships between each table.



--2.	Query to get the number of books by each publisher.

SELECT P.PUB_NM, COUNT(BOOK_ID)
FROM PUBLISHER P,BOOK1 B
WHERE P.PUB_ID=B.PUB_ID
GROUP BY P.PUB_NM;

--3.	Write a query which gives book_name, author_name for publisher ‘XYZ’
SELECT B.BOOK_NM, A.AU_F_NAME AS AUTHOR_NAME
FROM BOOK1 B, BOOK_AUTHOR BA, AUTHOR1 A
WHERE B.BOOK_ID = BA.BOOK_ID
AND BA.AU_ID=A.AU_ID
AND B.PUB_ID=(SELECT PUB_ID
            FROM PUBLISHER
            WHERE PUB_NM='XYZ');

--4.	Which book was written by more than 3 authors?
SELECT BOOK_NM
FROM BOOK1
WHERE BOOK_ID IN (SELECT BOOK_ID
                    FROM BOOK_AUTHOR
                    GROUP BY BOOK_ID
                    HAVING COUNT(AU_ID)>3);


--5.	Want to include city and state information of author as well in the model. So, modifiy the model and show us the new model what you come up with.
ALTER TABLE AUTHOR
ADD CITY VARCHAR(10);

ALTER TABLE AUTHOR
ADD STATE VARCHAR(10);

--6.	Display publisher name, pub_city and metro flag of the city. If city is CHN or MUM or DEL or CAL then display the flag as ‘Y’ otherwise ‘N’
SELECT PUB_NM, PUB_CITY, (CASE WHEN PUB_CITY IN ('CHN','MUM','DEL','CAL') 
                                THEN 'Y' ELSE 'N' END) AS METRO_FLAG
FROM PUBLISHER;

--7.	Display the authors whose age is greater than the author ‘RAM KUMAR’
SELECT AU_F_NAME, AU_ID
FROM AUTHOR1
WHERE AU_DOB>(SELECT AU_DOB FROM AUTHOR
               WHERE AU_F_NAME ='RAM KUMAR');


SELECT AU_F_NAME, AU_ID
FROM AUTHOR1
WHERE MONTHS_BETWEEN(SYSDATE,AU_DOB)>(select MONTHS_BETWEEN(SYSDATE,AU_DOB) from author1 WHERE AU_F_NAME ='RAM KUMAR'); 


--8.	Display the publisher name, author_name and no of books they wrote.
select pub_nm
from (select p.pub_nm, a.au_f_name 
        from publisher p, book b, book_author ba, author1 a
        where p.pub_id=b.pub_id 
        and b.book_id=ba.book_id
        and ba.au_id=a.au_id) a,
        (selec a.au_f_name, count(bk_au_id)
        from author1 a, book_author ba
        where a.au_id=ba.au_id(+)
        group by au_f_name) b
where a.au_f_name=b.au_f_name;

--9.	Which author wrote the maximum number of books?
select a.au_f_name, max(count(b.book_id))
from author1 a, book_author ba, book1 b, publisher p
where a.au_id=ba.au_id
and ba.book_id=b.book_id
and b.pub_id=p.pub_id
group by a.au_f_name;


--10.	Create a stored procedure which returns book_name, author_full_name by taking publisher name as the input.

--11.	Take the publisher name as input and give the number of books which that publisher published where there are only one author.



