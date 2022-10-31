/*1. Escreva uma consulta SQL que, com base no total em pagamentos
realizados (coluna amount da tabela payment), divida todos os consumidores
da locadora em 4 grupos. Além disso, com ajuda da função CASE WHEN,
classifique consumidores nesses grupos, do de maiores pagadores ao de
menores, respectivamente em:
○ “Especial”
○ “Fiel”
○ “Ocasional”
○ “Iniciante”
Sua consulta final deve conter as colunas: email, classificacao, total_pago*/
CREATE VIEW customer_groups AS
SELECT c.first_name AS first_name,
		c.last_name AS last_name,
        c.email AS email,
        SUM(p.amount) AS total_sum,
        (CASE 
			WHEN  NTILE(4) OVER (ORDER BY SUM(p.amount) DESC) = "4" THEN "Iniciante"
            WHEN  NTILE(4) OVER (ORDER BY SUM(p.amount) DESC) = "3" THEN "Ocasional"
            WHEN  NTILE(4) OVER (ORDER BY SUM(p.amount) DESC) = "2" THEN "Fiel"
            WHEN  NTILE(4) OVER (ORDER BY SUM(p.amount) DESC) = "1" THEN "Especial"
            ELSE NULL
		END) AS ranking
	FROM customer as c
	INNER JOIN payment as p 
    ON c.customer_id = p.customer_id
    GROUP BY first_name, last_name, email;
    
    SELECT * 
    FROM customer_groups;
/*2. Escreva uma consulta SQL que responda: qual foi a primeira loja da rede a
atingir um total de $10.000 no mês de julho/2005?*/

/* R: A loja 2 foi a primeira, atingindo 10000.09 em 06/07/2005*/

WITH july_query AS (select payment_date,
		staff_id,
        SUM(amount) OVER (PARTITION BY staff_id ROWS UNBOUNDED PRECEDING) AS amounts
from payment
WHERE payment_date LIKE "%2005-07%") 

SELECT * 
FROM july_query 
WHERE amounts >= 10000
ORDER BY amounts ASC, payment_date ASC