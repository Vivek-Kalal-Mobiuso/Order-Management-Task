-- Q1 Write a query in SQL to display the code, name, continent and GNP for all the countries whose country name last second word is 'd’, using “country” table. (22 rows) 
select Code , Name , Continent , GNP from country where substring(Name,length(Name)-1,1)='d';

-- Q2 Write a query in SQL to display the code, name, continent and GNP of the 2nd and 3rd highest GNP from “country” table.
select code, name, continent, GNP
from country
order by GNP desc
LIMIT 2 OFFSET 1;

