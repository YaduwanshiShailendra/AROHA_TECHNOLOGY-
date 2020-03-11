show user;

select * from tab;

CREATE TABLE cust
(
cust_id INT PRIMARY KEY,
cust_name VARCHAR(15) NOT NULL,
cust_phone NUMBER(10) CHECK(LENGTH(cust_phone)=10),
cust_add VARCHAR(25),
cust_gender VARCHAR2(1) CHECK (cust_gender IN ('M','F')),
cust_city_name VARCHAR(10) NOT NULL,
cust_dob DATE NOT NULL CHECK(cust_dob<'31-DEC-2000')
);

drop table shailendra_cust;


INSERT INTO CUST VALUES(1, 'SHAILENDRA', 8770065751, 'BTM', 'M', 'BHOPAL', '01-JUL-1996');
INSERT INTO CUST VALUES(2, 'NAMITA', 8770999751, 'BTM 2ND STAGE', 'F', 'RAISEN', '19-AUG-1994');
INSERT INTO CUST VALUES(3, 'SHAILI', 7900065751, 'SOBHAGYA NAGAR', 'M', 'CHANDIGARH', '16-JUL-1992', 'UM');
INSERT INTO CUST VALUES(4, 'PRINC', 9780065751, 'JAYNAGAR', 'M', 'MYSORE', '28-OCT-1994');
SELECT * FROM CUST;

commit;

CREATE TABLE emp(
emp_id INT PRIMARY KEY,
emp_name VARCHAR(15) NOT NULL,
emp_phone NUMBER(10)
);


drop table emp;