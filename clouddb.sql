CREATE TABLE shailendra_cust
(
cust_id INT PRIMARY KEY,
cust_name VARCHAR(15) NOT NULL,
cust_phone NUMBER(10) CHECK(LENGTH(cust_phone)=10),
cust_add VARCHAR(25),
cust_gender VARCHAR2(1) CHECK (cust_gender IN ('M','F')),
cust_city_name VARCHAR(10) NOT NULL,
cust_dob DATE NOT NULL CHECK(cust_dob<'31-DEC-2000')
);



