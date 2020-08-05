/*
##################################################
 Objective                : To solve SQL server Product Model Exercise
 Author(Creator) Name     : Shailendra Yadav
 Developed / Created Date : 31-July-2020
##################################################
*/

use aroha;

--create product table
create table product_1
(p_id int not null primary key,p_name varchar(40) not null,p_family varchar(40) not null,
price int not null, cost int not null,launch_date date not null)

-- insert values
insert into product_1 values ('100','marker','stationary','25','22','2017-02-12')
insert into product_1 values ('101','mouse','computer','450','350','2016-01-20')
insert into product_1 values ('102','white board','stationary','450','375','2018-01-29')
insert into product_1 values ('103','sony vaio','computer','35000','42000','2017-12-29')
insert into product_1 values ('104','keyboard','computer','2000','3000','2017-12-29')
insert into product_1 values ('105','Fitbit','digital','12000','11000','2018-03-29')
insert into product_1 values ('106', 'screen', 'digital', '5000', '4000', '2020-08-17')


--1.Write the select statement which gives all the products which costs more than Rs 250.

select p_name as 'Product Name'
from product_1
where cost>250;


--2. Write the select statement which gives product name, cost, price and profit. 
--   (profit formula is price – cost)

select p_name,
		cost,
		price,
		(price-cost) as profit
from product_1;
	 
	 
--3. Find the products which give more profit than product Mouse

select p_name
from product_1
where (price-cost) > (select (price-cost) as profit
					  from product_1
					  where p_name='MOUSE');

					  
--4. Display the products which give the profit greater than 100 Rs.

select p_name
from product_1
where (price-cost)>100;


--5.	Display the products which are not from Stationary and Computer family.

select p_name
from product_1
where p_family not in('STATIONARY','COMPUTER');


--6.	Display the products which give more profit than the p_id 102.

select p_name
from product_1
where (price-cost) > (select (price-cost) as profit
					  from product_1
					  where p_id=102);


--7.Display products which are launched in the year of 2010.

select p_name
from product_1 
where year(launch_date)=2010;


--8.  Display the products which name starts with either ‘S’ or ‘W’ 
--	  and which belongs to Stationary and cost more than 300 Rs

select p_name
from product_1
where( p_name like 'S%'
			  or p_name like 'W%')
			  and p_family = 'STATIONARY'
			  and cost>300;

			 
--9. Display the products which are launching next month.

select p_name
from product_1
where month(launch_date)=month(DATEADD(month,1,getdate()));

--10. Display product name which has the maximum price in the entire product table.

select p_name
from product_1
where price = (select max(price)
			   from product_1); 

--11. List the product name, cost, price, profit and percentage of profit we get in each product.

select p_name,
	   cost,
	   price,
	   (price-cost) as profit,
	   (((price-cost)*100)/cost) as 'Profit %age'
from product_1
group by p_name, cost, price;


--12.  Display how many products we have in Computer family which has the price range between 2000 and 50000.

select count(p_name)
from product_1
where p_family = 'COMPUTER'
and price between 2000 and 50000;
