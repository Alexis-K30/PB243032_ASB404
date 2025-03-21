SELECT
    f.film_id,
    f.title,
    c.category_id,
    c.name AS category_name
FROM sakila.film f
INNER JOIN sakila.film_category fc ON f.film_id = fc.film_id
INNER JOIN sakila.category c ON fc.category_id = c.category_id
ORDER BY f.film_id;

SELECT 
	f.film_id, 
    f.title, 
    c.category_id, 
    c.name AS category_name
FROM sakila.film f
RIGHT JOIN sakila.film_category fc ON f.film_id = fc.film_id
RIGHT JOIN sakila.category c ON fc.category_id = c.category_id
ORDER BY c.category_id;

SELECT 
	f.film_id AS ID_pelicula, 
    f.title AS Titulo, 
    c.category_id AS Categoria, 
    c.name AS category_name
FROM sakila.film f
LEFT JOIN sakila.film_category fc ON f.film_id = fc.film_id
LEFT JOIN sakila.category c ON fc.category_id = c.category_id
ORDER BY f.film_id;