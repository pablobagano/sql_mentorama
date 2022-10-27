/*1. Se você é do tempo da Blockbuster, deve lembrar que os filmes mais famosos ou
mais novos eram oferecidos em maior quantidade para aluguel -- já que,
naturalmente, a demanda por eles era maior que a média. Vamos verificar essa
premissa na nossa locadora usando o banco de dados sakila!*/
/* a. Escreva uma consulta que liste, em ordem decrescente, os filmes mais
alugados na nossa locadora. Utilize a tabela rental para isso, relacionando
com a tabela inventory. */

SELECT film.title as id,
		count(rental.rental_id) AS rental
FROM rental
INNER JOIN inventory 
ON rental.inventory_id = inventory.inventory_id
INNER JOIN film 
ON film.film_id = inventory.film_id
GROUP BY id
ORDER BY rental ASC;

/*b. Escreva uma consulta que liste, em ordem decrescente, o número de unidades disponíveis de cada filme na locadora.*/

SELECT film.title AS title,
		COUNT(inventory.inventory_id) AS num_copies
FROM inventory
LEFT JOIN film 
ON inventory.film_id = film.film_id
GROUP BY title
ORDER BY num_copies ASC; 

/*c. Usando subconsultas, relacione as tabelas resultantes dos itens a) e b) e responda: 
os títulos mais alugados de fato correspondem aos que têm maior número de itens disponíveis? 
Qual consulta você usou para chegar a esse resultado? 
Bônus: caso queira, use métricas de descrição estatística (média, percentil) para 
responder à pergunta de forma mais embasada!*/

/* Resposta: Sim. Para obtenção da reposta, estabeleci a razão entre os aluguéis e o número de cópias 
e pude constatar que o número de aluguéis e a quantidade de cópias na locadora têm uma relação linear positiva */
WITH q1 AS(
select film.title as title,
		count(rental.rental_id) as rental
from rental
inner join inventory 
on rental.inventory_id = inventory.inventory_id
inner join film 
on film.film_id = inventory.film_id
GROUP BY title
ORDER BY rental DESC
), 
q2 AS(
SELECT film.title AS title,
		COUNT(inventory.inventory_id) AS num_copies
FROM inventory
LEFT JOIN film 
ON inventory.film_id = film.film_id
GROUP BY title
ORDER BY num_copies ASC
)

SELECT DISTINCT q1.title,
				q1.rental,
				q2.num_copies,
                q1.rental/q2.num_copies AS copies_rent_ratio
                
FROM q1
LEFT JOIN q2
ON q1.title = q2.title;

/*2. A view chamada sales_by_film_category traz o resultado total de vendas em aluguéis por categoria dos filmes. 
Escreva uma consulta que complemente essa tabela com as seguintes métricas para cada categoria:*/ 
-- ● Valor médio do aluguel dos filmes por categoria; 
-- ● Valor médio do custo de reposição dos filmes por categoria; 
-- ● Total de vendas por categoria na loja 1; 
-- ● Total de vendas por categoria na loja 2; (dica: use o comando CASE WHEN) 
-- ● Total de títulos disponíveis por categoria (dica: use a tabela inventory)

CREATE TEMPORARY TABLE category_info AS SELECT category.name AS category,
		COUNT(CASE WHEN rental.staff_id = 2 THEN "STORE2" ELSE NULL END) AS store2,
        COUNT(CASE WHEN rental.staff_id = 1 THEN "STORE1" ELSE NULL END) AS store1,
        AVG(rental_rate) as average_rental,
        AVG(replacement_cost) as replacement_cost,
        COUNT(inventory.inventory_id) as total_amount
	FROM film
    LEFT JOIN film_category
    ON film_category.film_id = film.film_id
    LEFT JOIN category
    ON film_category.category_id = category.category_id
    LEFT JOIN inventory
    ON inventory.film_id = film.film_id
    LEFT JOIN rental
    ON inventory.inventory_id = rental.inventory_id
    GROUP BY category.name;
    
    SELECT category_info.*,
			sales_by_film_category.total_sales
		FROM category_info
        INNER JOIN sales_by_film_category
        ON category_info.category = sales_by_film_category.category
