/*
##################################################
 Objective                : To solve SQL server City-Branch Model Exercise
 Author(Creator) Name     : Shailendra Yadav
 Developed / Created Date : 31-July-2020
##################################################
*/


use aroha;

create table city
(city_id int not null primary key,
 city_name varchar(30) not null,
 city_population int);

insert into city values('10','Bangalore','2367890');
insert into city values('20','chennai','6474836');
insert into city values('30','Mumbai','78393739');


create table Branch
(B_id int not null primary key,
 B_name varchar(30) not null,
 B_address varchar(40) not null,
 B_phone int,
 city_id int Foreign key references city(city_id));

insert into Branch values('500','btm layout','185, ring road','7890847','10');
insert into Branch values('501','jayanagar','44, 15th main','8909748','10');
insert into Branch values('502','ashok nagar','ashoka pillar','8948599','20');
insert into Branch values('503','mount road','nandanam','8393839','20');


select * from city

--1.	Write a query to list the cities which have more population than Bangalore.

select city_name
from city 
where city_population > (select city_population
						 from city
						 where city_name = 'BANGALORE');


--2. Display all the branch names from Chennai.

select b.b_name 
from   branch b 
	   inner join city c 
	   on b.city_id = c.city_id
	   where c.city_name = 'CHENNAI';



--3. Display a city name which does not have any branches

select city_name
from city
where city_id NOT IN (select city_id 
					  from Branch);


--4.	Display branch name, address and phone number of all the branches where the name starts with either B or M and the city name starts with either B or C.

select b.b_name,
	   b.b_address,
	   b.b_phone 
from branch b 
	 inner join city c on b.city_id = c.city_id
	 where (b.b_name like 'B%' or b.b_name like 'M%')
	 and   (c.city_name like 'B%' or c.city_name like 'C%');


--5. How many branches we have in Bangalore?

select count(b_id)
from branch
where city_id = (select city_id 
	             from city
				 where city_name = 'BANGALORE');


--6. Display the branches which are in the Ring road of any city.

select b_name
from branch
where b_address like '%Ring Road%';


--7. Display the city name, branch name. Order the data based on the city name.

select c.city_name,
       b.b_name
from city c
     inner join Branch b on c.city_id = b.city_id
	 order by c.city_name;


--8. Display the city name and the number of branches in each city.

select c.city_name,count(b.b_name) as numberofbranch
from city c
     inner join Branch b on c.city_id = b.city_id
	 group by c.city_name;


--9. Display the city name which has most number of branches.

select city_name,
	   count(b_id) as 'most number of branches'
from city c,branch b
where c.city_id = b.city_id
group by city_name
having count(b_id)=(select max(a.cb)
					from(select city_name,count(b_id)as cb
						 from city c,branch b
						 where c.city_id=b.city_id
						 group by city_name)a);
						 


--10. Display the city name, population, number of branches in each city.

select c.city_name,
       c.city_population,
	   count(b.b_id) as 'number of branches'
from city c 
     inner join Branch b on c.city_id = b.city_id
	 group by c.city_name,c.city_population;


