use sakila;

select first_name, last_name
from actor;

select CONCAT(UPPER(first_name), ' ', UPPER(last_name)) as ActorName
from actor;

select actor_id, first_name, last_name
from actor
where first_name = "Joe";

select first_name, last_name
from actor
where last_name like '%GEN%';

select first_name, last_name
from actor
where last_name like '%LI%'
order by last_name, first_name;

select country_id, country
from country
where country in ('Afghanistan', 'Bangladesh', 'China');

ALTER TABLE actor
ADD COLUMN description blob;

ALTER TABLE actor DROP COLUMN description ;
  
select last_name, count(*)
from actor
group by last_name;

select last_name, count(*) AS 'Count'
from actor
group by last_name
having Count > 1;


SELECT COUNT(last_name)  FROM actor
WHERE last_name > 1;

update actor
set first_name = 'HARPO'
where first_name = 'GROUCHO' and last_name = 'WILLIAMS';

update actor
set first_name = 'GROUCHO'
where first_name = 'HARPO' and last_name = 'WILLIAMS';

ALTER SCHEMA SAKILA

     CREATE TABLE ADDRESS (ADDRESS_ID  SMALLINT(5)postal_code,
                        ADDRESS    VARCHAR(50),
                        ADDRESS2 VARCHAR(50)district,
                        DISTRICT VARCHAR(20),
                        CITY_ID SMALLINT(5)
                        POSTAL_CODE VARCHAR(10),
                        PHONE VARCHAR(2location0),
                        LOCATION GEOMETRY,
                        LAST_UPDATE TIMESTAMP,
                        PRIMARY KEY (ADDRESS_ID)
                        );



select first_name, last_name, address
from staff, address
where staff.address_id = address.address_id;


SELECT first_name, last_name, sum(amount)
from payment, staff
where payment.staff_id = staff.staff_id;

select title, count(actor_id)
from film, film_actor
where film.film_id = film_actor.film_id;

select count(title)
from film
where title like 'Hunchback Impossible';

select last_name, sum (amount)
from customer, payment
where customer.customer_id = payemnt.customer_id
order by last_name descending;

select title
from film, language
where film.language_id = language.language_id 
and language = 'English' and title in ('K*' or 'Q*');

select first_name, last_name, title
from actor a, film f, film_actor fa
where title = 'Alone Trip' and a.actor_id = fa.actor_id
and f.film_id = fa.film_id;

select first_name, last_name
from actor
where actor_id 
in (
   select actor_id
   from film_actor
   where film_id
   in (
       select film_id
       from film
       where title = 'Alone Trip'
       )
	);

select first_name last_name, email
from customer c
    join address a 
        on c.address_id = a.address_id
    join city t
        on a.city_id = t.city_id
    join country n 
        on n.country_id = t.country_id
where country = 'Canada';
    
select title
from film f
    join film_category fc
        on f.film_id = fc.film_id
    join category c 
		on c.category_id = fc.category_id
where name = 'Family';        

select title from film
where rental_duration = 7
order by title;

select s.store_id, sum(amount)
from payment p
join rental r 
  on p.rental_id = r.rental_id
join inventory i
  on r.inventory_id = i.inventory_id
join store s
  on i.store_id = s.store_id
group by s.store_id;

select s.store_id, t.city, y.country
from store s
join customer c
  on s.store_id = c.store_id
join address a 
  on c.address_id = a.address_id
join city t
  on a.city_id = t.city_id 
join country y
  on t.country_id = y.country_id;
  
select name, sum(amount)
from payment p
join rental r 
  on p.rental_id = r.rental_id
join inventory i
  on r.inventory_id = i.inventory_id
join film_category fc
  on i.film_id = fc.film_id
join category c
  on fc.category_id = c.category_id  
group by name
order by sum(amount) desc
limit 5;

CREATE VIEW TopFiveGenres AS
select name, sum(amount)
from payment p
join rental r 
  on p.rental_id = r.rental_id
join inventory i
  on r.inventory_id = i.inventory_id
join film_category fc
  on i.film_id = fc.film_id
join category c
  on fc.category_id = c.category_id  
group by name
order by sum(amount) desc
limit 5;

select * from TopFiveGenres;

DROP VIEW TopFiveGenres;