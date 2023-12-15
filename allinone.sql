INSERT INTO film (film_id, title, rental_rate, rental_duration, language_id)
VALUES (1005, 'Lord of the Rings: Brotherhood of the Ring', 4.99, 14, 1);

INSERT INTO actor (actor_id, first_name, last_name)
VALUES
  (1001, 'Elijah', 'Wood'),
  (1002, 'Ian', 'McKellen'),
  (1003, 'Viggo', 'Mortensen');

INSERT INTO film_actor (actor_id, film_id)
VALUES
  (1001, 1005),
  (1002, 1005),
  (1003, 1005);
  
  INSERT INTO film (film_id, title, rental_rate, rental_duration, language_id)
VALUES
  (1006, 'Lord of the Rings: Fellowship of the Ring', 4.99, 14, 1),
  (1007, 'Lord of the Rings: The Two Towers', 4.99, 14, 1),
  (1008, 'Lord of the Rings: The Return of the King', 4.99, 14, 1);
  
  INSERT INTO inventory (film_id, store_id)
VALUES
  (1006, 1),
  (1007, 1),
  (1008, 1);
  
  
--1
  UPDATE film
SET
  rental_duration = 3,
  rental_rate = 9.99
WHERE
  film_id IN (1006, 1007, 1008);
  
--2
  WITH CustomerToUpdate AS (
  SELECT
    c.customer_id
  FROM
    customer c
    JOIN rental r ON c.customer_id = r.customer_id
    JOIN payment p ON c.customer_id = p.customer_id
  GROUP BY
    c.customer_id
  HAVING
    COUNT(DISTINCT r.rental_id) >= 10
    AND COUNT(DISTINCT p.payment_id) >= 10
  LIMIT 1
)
UPDATE customer
SET
  first_name = 'Nikita',
  last_name = 'Ilyin',
  email = 'mycoolemail218@example.com',
  address_id = (SELECT address_id FROM address ORDER BY random() LIMIT 1)
WHERE
  customer_id IN (SELECT customer_id FROM CustomerToUpdate); 

--3

WITH CustomerToUpdate AS (
  SELECT
    c.customer_id
  FROM
    customer c
    JOIN rental r ON c.customer_id = r.customer_id
    JOIN payment p ON c.customer_id = p.customer_id
  GROUP BY
    c.customer_id
  HAVING
    COUNT(DISTINCT r.rental_id) >= 10
    AND COUNT(DISTINCT p.payment_id) >= 10
  LIMIT 1
)

UPDATE customer
SET
  create_date = current_date
WHERE
  customer_id IN (SELECT customer_id FROM CustomerToUpdate);
  
--1  
DELETE FROM rental
WHERE inventory_id IN (SELECT inventory_id FROM inventory WHERE film_id = 1005);
DELETE FROM inventory
WHERE film_id = 1005;

--2
DELETE FROM payment WHERE customer_id = 1;
DELETE FROM rental WHERE customer_id = 1; 
