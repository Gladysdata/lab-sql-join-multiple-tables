USE sakila ;

#Write a query to display for each store its store ID, city, and country.
SELECT store.store_id, city.city, country.country FROM store
JOIN address ON
store.address_id = address.address_id
JOIN city ON
address.city_id = city.city_id
JOIN country ON
city.country_id = country.country_id;

#Write a query to display how much business, in dollars, each store brought in
SELECT store.store_id, SUM(payment.amount) AS 'Business' FROM store
JOIN staff ON
store.store_id = staff.store_id
JOIN payment ON
staff.staff_id = payment.staff_id
GROUP BY store.store_id ;

#What is the average running time of films by category
SELECT category.name AS 'Film category', AVG(film.length) AS 'Average running time' FROM film
JOIN film_category ON
film.film_id = film_category.film_id
JOIN category ON
film_category.category_id = category.category_id
GROUP BY category.name ;

#Which film categories are longest
SELECT category.name AS 'Film category', ROUND(AVG(film.length)) AS 'Average running time' FROM film
JOIN film_category ON
film.film_id = film_category.film_id
JOIN category ON
film_category.category_id = category.category_id
GROUP BY category.name
ORDER BY AVG(film.length) DESC ;

#Display the most frequently rented movies in descending order
SELECT film.title, COUNT(rental.inventory_id) AS 'Number of times movie was rented' FROM rental
JOIN inventory ON
rental.inventory_id = inventory.inventory_id
JOIN film ON
inventory.film_id = film.film_id
GROUP BY film.title
ORDER BY COUNT(rental.inventory_id) DESC ;

#List the top five genres in gross revenue in descending order
SELECT category.name, ROUND(SUM(payment.amount)) AS 'Gross revenue' 
FROM category
JOIN film_category ON
category.category_id = film_category.category_id
JOIN inventory ON
film_category.film_id = inventory.film_id
JOIN rental ON
inventory.inventory_id = rental.inventory_id
JOIN payment ON
rental.rental_id = payment.rental_id
GROUP BY category.name
ORDER BY ROUND(SUM(payment.amount)) DESC
LIMIT 5 ;

#Is "Academy Dinosaur" available for rent from Store 1
SELECT inventory.store_id, film.title, COUNT(film.film_id) AS 'Number of copies available' FROM film
JOIN inventory ON
film.film_id = inventory.film_id
WHERE film.title IN('ACADEMY DINOSAUR') AND inventory.store_id = 1
GROUP BY inventory.store_id ;