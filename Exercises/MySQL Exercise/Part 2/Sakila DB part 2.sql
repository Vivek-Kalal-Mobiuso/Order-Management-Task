select count(actor_id) from actor group by first_name ;
-- 2
SELECT
    actor.actor_name,
    COUNT(flim_actor.actor_id) AS Total_Film
FROM
    actor
INNER JOIN
    film_actor ON actor.actor_id = film_actor.actor_id
GROUP BY
    a.actor_id, a.actor_name
ORDER BY
    film_count DESC
LIMIT 1;
-- 3
select avg(length) as Average from film f
inner join film_category fc
ON f.film_id=fc.film_id
group by fc.category_id;

-- 4 How many copies of the film “Hunchback Impossible” exist in the inventory system? (6) 
select count(*) as Copies from film f
inner join inventory inn
on f.film_id = inn.film_id
where f.title = 'Hunchback Impossible';

-- 5 Using the tables “payment” and “customer” and the JOIN command, list the total paid by each customer. 
-- List the customers alphabetically by last name
select sum(amount) , last_name from payment p
inner join customer c 
on p.customer_id = c.customer_id
group by c.customer_id
order by c.last_name ;

