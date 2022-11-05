
/*1. Conhecendo funções de datas, você pode agora conhecer mais sobre
algumas métricas de performance de vendas das lojas. Escreva consultas
que retornem:*/
-- a. A quantidade de aluguéis por mês por loja.
SELECT COUNT(rental.rental_id) total,
		(CASE WHEN payment.staff_id = 1 THEN  "STORE 1" 
              WHEN payment.staff_id = 2 THEN  "STORE 2" ELSE NULL END) AS store,
		EXTRACT(MONTH FROM rental.rental_date) AS month
FROM rental
INNER JOIN payment
ON rental.rental_id = payment.payment_id
GROUP BY MONTH, store; 
-- b. O valor total pago por mês em toda a rede.
select SUM(amount) as total_amount,
		EXTRACT(MONTH FROM payment_date) as month
FROM payment
GROUP BY month;

/* c. A quantidade de aluguéis por semana entre maio e junho de 2005. Qual semana teve a melhor performance?*/

-- A semana de melhor desempenho foi a semana 25, com 1357 aluguéis
WITH weekly_rental AS (SELECT COUNT(rental_id) AS total_amount,
								EXTRACT(MONTH FROM rental_date) AS month,
								EXTRACT(WEEK FROM rental_date) AS week
							FROM rental
                            GROUP BY WEEK, MONTH)

SELECT total_amount,
		week, 
        month
FROM weekly_rental
WHERE month between 5 and 6
ORDER BY total_amount DESC; 

/*2. A gerência da rede deseja entender se no mês de maio de 2005 houve
diferença na recorrência dos consumidores fidelizados (ou seja, que
realizaram mais de um aluguel) entre as duas lojas. Seu desafio é escrever
uma consulta que retorne o número médio de dias entre os aluguéis desses
consumidores, por loja que estão registrados. Dicas de como construir essa
consulta:*/

-- SEGUE ABAIXO QUERY PARA RANKING DE FIDELIDADE, COM MÉDIA DE DIAS INDVIDUAIS
CREATE VIEW customer_query AS (SELECT c.customer_id AS customer,
		c.store_id as store,
		r.rental_date as r_date, 
        lag(r.rental_date) OVER(PARTITION BY c.customer_id) AS previous_rental,
        COUNT(r.rental_id) OVER ( PARTITION BY c.customer_id) AS rentals
 FROM rental as r
 INNER JOIN customer as c
 ON c.customer_id = r.customer_id
 WHERE rental_date LIKE "%2005-05%"
 GROUP BY c.customer_id, r.rental_date, c.store_id, rental_id);
 
 SELECT ROW_NUMBER() OVER (PARTITION BY store 
						ORDER BY AVG(DATEDIFF(r_date, previous_rental)) ASC) AS loyalty_rank,
						customer,
						store,
						AVG(DATEDIFF(r_date, previous_rental)) AS average_days
 FROM customer_query
 WHERE rentals > 2
 GROUP BY customer, store;

/*Com isso, responda: há diferença no número médio de dias entre aluguéis
desse segmento de consumidores para as duas lojas?*/

-- SIM, EMOBRA POUCA. A LOJA 2 APRESENTA UM MÉDIA DE DIAS ENTRE CADA ALUGUEL LIGEIRAMENTE MAIOR, CONFORME QUERY ABAIXO
SELECT store,
		AVG(DATEDIFF(r_date, previous_rental)) AS average_days
	FROM customer_query
    GROUP BY store;

/*3. Reescreva a consulta da tarefa do Módulo 3, dessa vez utilizando um filtro
com expressões regulares: quais filmes disponíveis na locadora têm
indicação de orientação parental (PG ou PG-13)?*/

SELECT film_id,
		title, 
        rating
FROM film 
WHERE REGEXP_LIKE(rating, "PG")