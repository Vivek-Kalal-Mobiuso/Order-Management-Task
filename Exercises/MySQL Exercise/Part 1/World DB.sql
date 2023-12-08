-- 1
select * from city where ID <= 10 ;
-- 2
select * from city where ID >= 16 AND ID <= 20;
-- 3
select count(ID) from city;
-- 4
select Name , Population from city where Population=(select max(Population) from city);
-- 5
select Name , Population from city where Population=(select min(Population) from city);
-- 6
select Name from city where Population > 670000 and Population < 700000 ;
-- 7
select Name , Population from city 
Order by Population desc 
Limit 10;
-- 8
select Name from city 
Order by Name
Limit 10;
-- 9
select District from city where CountryCode='USA' and Population > '3000000' ;
-- 10
select Name , Population from city where ID IN (5, 23, 432 ,2021);