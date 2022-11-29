/*1.	Escreva um código que crie um procedimento armazenado no seu banco de dados, que represente um caso comum de inserção de dados em uma ou mais tabelas.
Na questão 3 da tarefa do módulo 12 você indicou algumas possibilidades de inserção de dados neste banco de dados; escolha uma dessas possibilidades para explorar em um procedimento aqui!
Ele deverá obrigatoriamente:
a.	Inserir dados em pelo menos uma tabela, respeitando as limitações (constraints) estabelecidas nessa tabela.
b.	Representar um processo aplicável no mundo real.
c.	Possuir pelo menos um parâmetro de entrada.
d.	Conter uma transação dentro das operações que realiza.*/

-- O procedimento abaixo alimenta a tablela 'Captadores'

DELIMITER $$

CREATE PROCEDURE pickup_insert (IN id_captador INT, IN tipo_captador VARCHAR(100), 
								IN fabricante VARCHAR(100), IN material VARCHAR(100), IN handwired INT)
BEGIN
	START TRANSACTION;
	INSERT INTO guitars_inventory.captadores VALUES (id_captador, tipo_captador, fabricante, material, handwired);
	COMMIT;
END $$ 
DELIMITER ;

/*2.	Com o procedimento criado e salvo no item 1, escreva uma consulta SQL 
que utilize esse procedimento para efetuar operações no banco de dados.*/

CALL pickup_insert(1, 'P90', 'Seymour Duncan', 'Alnico', 1)  