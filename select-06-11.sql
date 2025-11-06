-- Mostra todos os bancos
SHOW TABLES;

SELECT * FROM city; 

SELECT city, last_update FROM city;

-- Criando filtros (=, <>, <, >, <=, >=)
SELECT title, length FROM film
WHERE length > 70; 

SELECT title FROM film WHERE title = 'Academy Dinosaur';

-- Operadores lógicos (AND, OR) 
SELECT title , length FROM film
WHERE length >= 70 AND length <= 100;

SELECT title , length FROM film
WHERE length < 70 OR length = 100;

-- Operadores especiais (BETWEEN, IN, LIKE) 
SELECT title , length FROM film
WHERE length BETWEEN 70 AND 100;

SELECT * FROM sakila.payment
WHERE payment_date BETWEEN '2005-07-01' AND '2005-07-30';

SELECT * FROM sakila.payment
WHERE payment_id IN (1, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100);

SELECT * FROM film
WHERE title LIKE "%ACADEMY%";

SELECT * FROM film
WHERE title LIKE "%ACADEMY";

SELECT * FROM film
WHERE title LIKE "ACADEMY%";

-- exemplo nao executavel 
-- Encontra Luisas e Luizas no BD
SELECT * FROM clientes
WHERE nome LIKE 'Lui_a';
-- Encontra calças e calcas, inclusive calsas 
SELECT * FROM produtos
WHERE nome LIKE 'cal_ca';


-- apelidos 
SELECT
    aluguel.rental_id AS id_aluguel,
    aluguel.rental_date AS data_aluguel,
    aluguel.inventory_id AS inventario_id,
    aluguel.customer_id AS cliente_id,
    customer.first_name,
    customer.last_name,
    aluguel.return_date AS data_devolucao,
    aluguel.staff_id AS funcionario_id,
    staff.first_name AS "Primeiro nome",
    staff.last_name AS ultimo_nome_funcionario,
    aluguel.last_update AS "Ultima atualizacao"
FROM rental AS aluguel
-- aqui vai a especificacao de como o relacionamento acontece (inner join ainda faz parte do select)
-- se utilizarmos apelido, temos que aplicar ele em tudo 
INNER JOIN customer ON customer.customer_id = aluguel.customer_id
INNER JOIN inventory ON inventory.inventory_id = aluguel.inventory_id
INNER JOIN staff ON staff.staff_id = aluguel.staff_id;
-- inner join especifica o ENTRE 

-- relacionamento com relacionamento
SELECT * FROM rental 
INNER JOIN inventory ON inventory.inventory_id = rental.inventory_id
INNER JOIN film ON film.film_id = inventory.film_id
INNER JOIN `language` ON `language`.language_id = film.language_id;
-- colocar `` onde fica azul

SELECT 
	film.film_id,
    film.title,
    category.category_id,
    category.name
FROM film
INNER JOIN film_category ON film_category.film_id = film.film_id
INNER JOIN category ON category.category_id = film_category.category_id
ORDER BY title, name ASC;

INSERT INTO film_category VALUES (1, 8, NOW());

-- Ordenação e Limite 
SELECT * FROM payment 
ORDER BY payment; 

-- ORDER BY pode ordenar ASC = Crescente DESC que e decrecente
-- O select abaixo apresenta os pagamentos do maior para o menor
SELECT * FROM payment 
ORDER BY amount DESC; 

-- Agora alem do criterio acima tambem e organizado a data crescente
SELECT * FROM payment 
ORDER BY amount DESC, payment_date ASC;
 
-- Podemos usar apelados ou "posicoes" do criterio no SELECT
-- SELECT  	1			  2				3		  4
SELECT p.payment_id, c.first_name, c.last_name, amount AS total_pago, payment_date
FROM payment p
INNER JOIN customer c ON c.customer_id = p.customer_id
ORDER BY 2 ASC, total_pago DESC;

-- podemos limitar a quantidade de retorno com limit
SELECT * FROM film
LIMIT 10;

-- offset utilizado para paginacao de resultados
SELECT * FROM film 
LIMIT 10 OFFSET 10;

-- COUNT conta todos os registros e retprma O numero
SELECT COUNT(*) FROM film;

-- GROUP BY para auxiliar na contagem
-- ele e utilizado somente com funcoes de agregacao (juncao de dados)
SELECT COUNT(film.film_id), category.name
FROM film
INNER JOIN film_category ON film_category.film_id = film.film_id
INNER JOIN category ON category.category_id = film_category.category_id
-- agrupa as categorias antes de fazer o select e ordenar 
GROUP BY category.category_id
ORDER BY category.name, name ASC;

SELECT COUNT(film.film_id) as "QTDE", category.name
FROM film
INNER JOIN film_category ON film_category.film_id = film.film_id
INNER JOIN category ON category.category_id = film_category.category_id
WHERE film.title LIKE "%AC%"
GROUP BY category.category_id
ORDER BY category.name, name ASC;


-- resto dos select (pesquisar no classroom)