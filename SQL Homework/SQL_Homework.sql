-- Homework Assignment

use sakila;

-- 1a. Display the first and last names of all actors from the table actor. 
select 
first_name as 'First Name',
last_name as 'Last Name'
from actor;

-- 1b. Display the first and last name of each actor in a single column in upper case letters. Name the column Actor Name. 
select
concat(upper(first_name), ' ', upper(last_name)) as 'Actor Name'
from actor;

-- 2a. You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe." What is one query would you use to obtain this information?
select
actor_id as 'Actor ID', 
first_name as 'First Name',
last_name as 'Last Name'
from actor
where first_name like 'Joe%';

-- 2b. Find all actors whose last name contain the letters GEN:
select
first_name as 'First Name',
last_name as 'Last Name'
from actor
where last_name like '%GEN%';

-- 2c. Find all actors whose last names contain the letters LI. This time, order the rows by last name and first name, in that order:
select
last_name as 'Last Name',
first_name as 'First Name'
from actor
where last_name like '%LI%';

-- 2d. Using IN, display the country_id and country columns of the following countries: Afghanistan, Bangladesh, and China:
select
country_id as 'Country ID',
country as 'Country'
from country
where country in ('Afghanistan', 'Bangladesh', 'China');

-- 3a. Add a middle_name column to the table actor. Position it between first_name and last_name. Hint: you will need to specify the data type.
alter table actor
add middle_name varchar(20) after first_name;

describe actor;


-- 3b. You realize that some of these actors have tremendously long last names. Change the data type of the middle_name column to blobs.
alter table actor
modify middle_name blob;

describe actor;

-- 3c. Now delete the middle_name column.
alter table actor
drop middle_name;

describe actor;

-- 4a. List the last names of actors, as well as how many actors have that last name.
select
last_name as 'Last Name',
count(last_name)
from actor
group by last_name;

-- 4b. List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors
select
last_name as 'Last Name',
count(last_name) as 'Last Name Count'
from actor
group by last_name
having count(last_name) >=2;

-- 4c. Oh, no! The actor HARPO WILLIAMS was accidentally entered in the actor table as GROUCHO WILLIAMS, the name of Harpo's second 
-- cousin's husband's yoga teacher. Write a query to fix the record.
update actor
set first_name = 'HARPO'
where first_name = 'Groucho' and last_name = 'Williams';

-- 4d. Perhaps we were too hasty in changing GROUCHO to HARPO. It turns out that GROUCHO was the correct name after all! 
-- In a single query, if the first name of the actor is currently HARPO, change it to GROUCHO. Otherwise, change the first name to MUCHO GROUCHO, 
-- as that is exactly what the actor will be with the grievous error. BE CAREFUL NOT TO CHANGE THE FIRST NAME OF EVERY ACTOR TO MUCHO GROUCHO, 
-- HOWEVER! (Hint: update the record using a unique identifier.)
select 
first_name as 'First Name',
last_name as 'Last Name',
actor_id as 'Actor ID Number'
from actor
where first_name = 'harpo' and last_name = 'Williams';

update actor
set first_name = 'Groucho'
where first_name = 'Harpo' and last_name = 'Williams'; 

-- 5a. You cannot locate the schema of the address table. Which query would you use to re-create it? 
-- Hint: https://dev.mysql.com/doc/refman/5.7/en/show-create-table.html
SHOW CREATE TABLE tbl_name;

-- 6a. Use JOIN to display the first and last names, as well as the address, of each staff member. Use the tables staff and address:
select staff.first_name as 'First Name', 
	staff.last_name as 'Last Name', 
    staff.address_id as 'Actor Address ID Number', 
    address.address as 'Street', 
    address.address2 as 'Address 2nd Line', 
    address.city_id as 'City ID Number', 
    address.postal_code as 'Zip Code',
    address.district as 'District',
    address.location as 'Location'
from staff
inner join address
on staff.address_id = address.address_id;

-- 6b. Use JOIN to display the total amount rung up by each staff member in August of 2005. Use tables staff and payment. 
select
	s.first_name as 'First Name',
    s.last_name as 'Last Name',
    sum(p.amount) as 'Total Rung Up'
from staff s
inner join payment p
using (staff_id)
where p.payment_date between '2005-08-01' and '2005-08-31'
group by p.staff_id
order by last_name;

-- 6c. List each film and the number of actors who are listed for that film. Use tables film_actor and film. Use inner join.
select
	f.title as 'Film Title',
    count(fa.actor_id) as 'Number of Actors in Film'
from film f
inner join film_actor fa
using (film_id)
group by f.title;

-- 6d. How many copies of the film Hunchback Impossible exist in the inventory system?
select 
	f.title as 'Film Title',
    count(i.film_id) as 'Number of Copies'
from film f
inner join inventory i
using (film_id)
where title = 'Hunchback Impossible'
group by f.title;

-- 6e. Using the tables payment and customer and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name:
select 
	c.last_name,
    c.first_name,
    sum(p.amount)
from customer c
inner join payment p
using (customer_id)
group by c.customer_id
order by c.last_name asc;

-- 7a. The music of Queen and Kris Kristofferson have seen an unlikely resurgence. As an unintended consequence, films starting with the letters K and Q have also soared in popularity. 
-- Use subqueries to display the titles of movies starting with the letters K and Q whose language is English. 
select title
from film
where language_id in
	(
		select language_id
        from film
        where language_id = '1'
	);

-- 7b. Use subqueries to display all actors who appear in the film Alone Trip.
select first_name, last_name
from actor
where actor_id in
	(
		select actor_id
        from film_actor
        where film_id in
			(
				select film_id
                from film
                where title = 'Alone Trip'
			)
	);

-- 7c. You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian customers. Use joins to retrieve this information.
select first_name, last_name, email
from customer
where address_id in
	(
		select address_id
        from address
        where city_id in
			(
				select city_id
                from city
                where country_id in
					(
						select country_id
                        from country
                        where country = 'Canada'
					)
			)
	);

-- 7d. Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as famiy films.
select title
from film
where film_id in
	(
		select film_id
        from film_category
        where category_id in
			(
				select category_id
                from category
                where name = 'Family'
			)
	);

-- 7e. Display the most frequently rented movies in descending order.
select 
	f.title as 'Title',
	count(r.rental_id) as 'Number of Times Rented'
from inventory i
join film f
using (film_id)
join rental r
using (inventory_id)
group by f.title
order by 'Number of Times Rented' desc; 

-- 7f. Write a query to display how much business, in dollars, each store brought in.
select 
	sto.store_id as 'Store Number', 
	sum(p.amount) as 'Revenue ($)'
from payment p
join staff s
using (staff_id)
join store sto
using (store_id)
group by sto.store_id;

-- 7g. Write a query to display for each store its store ID, city, and country.
select
	sto.store_id as 'Store Number',
    c.city as 'City',
    cou.country as 'Country'
from store sto
join address a
using (address_id)
join city c
using (city_id)
join country cou
using (country_id);

-- 7h. List the top five genres in gross revenue in descending order. (Hint: you may need to use the following tables: category, film_category, inventory, payment, and rental.)
select
	sum(p.amount) as 'Gross Revenue ($)',
    c.name as 'Genre'
from payment p
join rental r
using (rental_id)
join inventory i
using (inventory_id)
join film_category fc
using (film_id)
join category c
using (category_id)
group by c.name;

-- 8a. In your new role as an executive, you would like to have an easy way of viewing the Top five genres by gross revenue. Use the solution from the problem above to create a view. 
-- If you haven't solved 7h, you can substitute another query to create a view.
CREATE VIEW Top_5_Revenue_By_Genre AS
(select
	sum(p.amount) as 'Gross Revenue ($)',
    c.name as 'Genre'
from payment p
join rental r
using (rental_id)
join inventory i
using (inventory_id)
join film_category fc
using (film_id)
join category c
using (category_id)
group by c.name, p.amount desc);

-- 8b. How would you display the view that you created in 8a?
SELECT * FROM Top_5_Revenue_By_Genre;

-- 8c. You find that you no longer need the view top_five_genres. Write a query to delete it.
DROP VIEW Top_5_Revenue_By_Genre;
