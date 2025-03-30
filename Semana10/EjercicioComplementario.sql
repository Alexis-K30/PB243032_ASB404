--Literal A de los ejercicios. Creacion de la vista
CREATE VIEW info_tienda AS
SELECT 
	CONCAT(st.first_name, " ", st.last_name) AS STAFF_MANAGER, 
    a.address AS ADDRESS, 
    c.city AS CITY, 
    co.country AS COUNTRY
FROM staff st
JOIN store s ON st.staff_id = s.manager_staff_id
JOIN address a ON s.address_id = a.address_id
JOIN city c ON a.city_id = c.city_id
JOIN country co ON c.country_id = co.country_id
ORDER BY st.first_name;
--Llamada de la vista
SELECT * FROM info_tienda;


--Literal B de los ejercicios. Creacion de la vista
CREATE VIEW info_peliculas AS
SELECT 
	f.title, 
    c.name, 
    GROUP_CONCAT(CONCAT(a.first_name, " ", a.last_name) SEPARATOR ", ") AS Actores
FROM actor a 
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY f.title;
--Llamada de la vista
SELECT * FROM info_peliculas;


--Literal C de los ejercicios. Crecación de la vista
CREATE VIEW peliculas_address AS
SELECT 
	f.title, 
    a.address, 
    c.city, 
    co.country 
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN store s ON i.store_id = s.store_id
JOIN address a ON s.address_id = a.address_id
JOIN city c ON a.address_id = c.city_id
JOIN country co ON c.country_id = co.country_id
GROUP BY f.title;
--Llamada de la vista
SELECT * FROM peliculas_address


--Literal D de los ejercicio. Creacion de la vista
CREATE VIEW peliculas_por_tienda AS
SELECT 
    s.store_id AS ID_TIENDA,
    COUNT(i.film_id) AS TOTAL_PELICULAS
FROM store s
JOIN inventory i ON s.store_id = i.store_id
GROUP BY s.store_id;
--Llamada de la vista
SELECT * FROM peliculas_por_tienda;


--Literal E de los ejercicios. Creacion de la vista
CREATE VIEW peliculas_rentadas_por_tienda AS
SELECT 
    s.store_id AS ID_TIENDA,
    COUNT(r.rental_id) AS PELICULAS_RENTADAS
FROM store s
JOIN inventory i ON s.store_id = i.store_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY s.store_id;
--Llamada de la vista
SELECT * FROM peliculas_rentadas_por_tienda;