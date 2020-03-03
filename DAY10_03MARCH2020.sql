
--##################################################################################--
--                       Manufacturing and Products Model
--##################################################################################--

create table manufacturers (m_code number(10),m_name varchar(30));
alter table manufacturers add(constraint pk_m_code primary key(m_code));


insert all
    into manufacturers(m_code,m_name) values (10,'sony')
    into manufacturers(m_code,m_name) values(20,'nokia')
    into manufacturers(m_code,m_name) values(30,'itc')
    into manufacturers(m_code,m_name) values(40,'pepsi')
    into manufacturers(m_code,m_name) values(50,'vipco')
    into manufacturers(m_code,m_name) values(60,'samsung')
    into manufacturers(m_code,m_name) values(70,'lg')
SELECT * FROM dual;
 

create table products(p_code number(10),p_name varchar(30),price number(10),m_code number(10));
alter table products add(constraint pk_p_code primary key(p_code));
alter table products add(constraint fk_m_code foreign key(m_code) references manufacturers(m_code));

insert into products(p_code,p_name,price,m_code)values(1,'mobile',100,20);
insert into products(p_code,p_name,price,m_code)values(2,'laptop',42000,10);
insert into products(p_code,p_name,price,m_code)values(3,'notebook',50,30);
insert into products(p_code,p_name,price,m_code)values(4,'mobile',12000,10);
insert into products(p_code,p_name,price,m_code)values(5,'7up',12,40);
insert into products(p_code,p_name,price,m_code)values(6,'bag',850,50);
insert into products(p_code,p_name,price,m_code)values(7,'suitcase',1200,50);
insert into products(p_code,p_name,price,m_code)values(8,'tv',18000,10);
insert into products(p_code,p_name,price,m_code)values(9,'tv',16000,60);
insert into products(p_code,p_name,price,m_code)values(10,'tv',12000,70);
insert into products(p_code,p_name,price,m_code)values(11,'fridge',19000,70);


DESC MANUFACTURERS;
DESC PRODUCTS;

SELECT * FROM MANUFACTURERS;
SELECT * FROM PRODUCTS;

--##################################################################################--
--                                      Answers
--##################################################################################--


--1.	Select the names of all the products in the store.
SELECT P_NAME AS Prod_Name
FROM PRODUCTS;

--2.	Select the names and the prices of all the products in the store.
SELECT P_NAME, PRICE 
FROM PRODUCTS;

--4.	Select the name of the products with a price less than or equal to $200.
SELECT P_NAME, PRICE 
FROM PRODUCTS
WHERE PRICE <=200;

--5.	Select all the products with a price between $60 and $120.
SELECT P_NAME, PRICE 
FROM PRODUCTS
WHERE PRICE >60 AND PRICE <120;

--6.	Select the name and price in cents (i.e., the price must be multiplied by 100).
SELECT P_NAME, PRICE*100
FROM PRODUCTS;

--7.	Compute the average price of all the products.
SELECT AVG(PRICE) AS Avg_price_of_all
FROM PRODUCTS;

--8.	Compute the average price of all products with manufacturer name is Unilever.
SELECT AVG(PRICE)
FROM PRODUCTS
WHERE M_CODE=(SELECT M_CODE
                FROM MANUFACTURERS
                WHERE M_NAME='Unilever');

--9.	Compute the number of products with a price larger than or equal to $180.
SELECT COUNT(P_NAME) as N0_of_products
FROM PRODUCTS
WHERE PRICE>=180;

--10.	Select the name and price of all products with a price larger than or equal to $180, and sort first by price (in descending order), and then by name (in ascending order).
SELECT P_NAME, PRICE
FROM PRODUCTS
WHERE PRICE >=180
ORDER BY PRICE DESC, P_NAME;

--11.	Select all the data from the products, including all the data for each product's manufacturer.
SELECT P.*, M.M_NAME
FROM MANUFACTURERS M, PRODUCTS P
WHERE M.M_CODE=M.M_CODE;

--12.	Select the product name, price, and manufacturer name of all the products.
SELECT P.P_NAME, P.PRICE, M.M_NAME
FROM PRODUCTS P, MANUFACTURERS M
WHERE P.M_CODE=M.M_CODE;

--13.	Select the average price of each manufacturer's products, showing only the manufacturer's code.
SELECT M_CODE, AVG(PRICE)
FROM PRODUCTS
GROUP BY M_CODE;

--14.	Select the average price of each manufacturer's products, showing the manufacturer's name.
SELECT M.M_NAME, P.P_NAME, AVG(P.PRICE)
FROM MANUFACTURERS M, PRODUCTS P
WHERE M.M_CODE=P.P_CODE
GROUP BY M.M_NAME,P.P_NAME;

--15.	Select the names of manufacturer whose products have an average price larger than or equal to $150.
SELECT M_NAME
FROM MANUFACTURERS
WHERE M_CODE IN (SELECT M_CODE
                    FROM PRODUCTS
                    GROUP BY M_CODE
                    HAVING AVG(PRICE)>150);

--16.	Select the name and price of the cheapest product.
SELECT P_NAME, PRICE
FROM PRODUCTS
WHERE PRICE = (SELECT MIN(PRICE)
                FROM PRODUCTS);

--17.	Select the name of each manufacturer along with the name and price of its most expensive product.
SELECT M.M_NAME AS MANUF_NAME, P.P_NAME AS PROD_NAME, P.PRICE
FROM PRODUCTS P, MANUFACTURERS M
WHERE PRICE = (SELECT MAX(PRICE)
                FROM PRODUCTS P
                WHERE P.M_CODE=M.M_CODE);

--18.	Add a new product: Loudspeakers, $70, PHILIPS 
INSERT ALL
INTO MANUFACTURERS VALUES(12,'PHILIPS')
INTO PRODUCTS VALUES(104, 'Loudspeaker',70,12)
SELECT * FROM DUAL;

--19.	Update the name of product code 8 to "Laser Printer".
UPDATE PRODUCTS 
SET P_NAME='Laser printer'
WHERE M_CODE=8;

--20.	Apply a 10% discount to all products.
UPDATE PRODUCTS
SET PRICE=PRICE*.90;

--21. Apply a 10% discount to all products with a price larger than or equal to $120
UPDATE PRODUCTS
SET PRICE=PRICE*.90
WHERE PRICE>120;
