show tables;
--  2
desc actor;
--  3
Describe actor;
--  3
select first_name , last_name from actor;
--  4
select first_name from actor where last_name = 'Johansson';
--  5
select upper(concat(`first_name`, ' ', `last_name`)) AS `Actor Name` FROM actor;
--  6
select actor_id , first_name , last_name from actor where first_name = 'Joe';
--  7
select count(actor_id) , first_name , last_name from actor group by last_name ;
--  8
select count(actor_id) , first_name , last_name from actor group by last_name ;
--  9
select count(actor_id) , last_name from actor group by last_name;
--  10
select actor.first_name , actor.last_name , address.address 
from actor 
JOIN staff ON staff.address_id = actor.actor_id
JOIN address ON staff.address_id = address.address_id;
