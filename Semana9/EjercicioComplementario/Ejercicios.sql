/*
 * Ejercicio 1
 */
SELECT c.first_name AS Nombre, f.title AS Titulo, re.return_date AS Fecha_devolucion
FROM customer c
INNER JOIN rental re ON c.customer_id = re.customer_id
INNER JOIN inventory i on re.inventory_id = i.inventory_id
INNER JOIN film f ON i.film_id = f.film_id;

/*
 * Ejercicio 2 (No muestra datos debido a que la tabla de payments esta vacía) <-- Tiene sentido o solo no deberia mostrar payments 
 * pero los demás datos si?
 */
SELECT c.first_name AS Nombre, f.title AS Titulo, re.return_date AS Fecha_devolucion, p.amount AS cantidad
FROM customer c
INNER JOIN payment p ON c.customer_id = p.customer_id
INNER JOIN rental re ON p.rental_id = re.rental_id
INNER JOIN inventory i on re.inventory_id = i.inventory_id
INNER JOIN film f ON i.film_id = f.film_id;

/*
 * Ejercicio 3 (Misma situacion, no muestra datos debido a que payment no tiene datos, si se le quita esa parte muestra
 * la tabala sin problema o tambien si se le añaden datos a la tabla payments)
 */
SELECT c.first_name AS Nombre, f.title AS Titulo, re.return_date AS Fecha_devolucion, p.amount AS cantidad, ca.name AS Nombre_Categoria, l.name AS Lenguaje
FROM customer c
INNER JOIN payment p ON c.customer_id = p.customer_id
INNER JOIN rental re ON c.customer_id = re.customer_id
INNER JOIN inventory i on re.inventory_id = i.inventory_id
INNER JOIN film f ON i.film_id = f.film_id
INNER JOIN film_category fc ON f.film_id = fc.film_id
INNER JOIN category ca ON fc.category_id = ca.category_id
INNER JOIN language l ON f.language_id = l.language_id;