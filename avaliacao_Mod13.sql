-- Nenhum banco de dados faz sentido sem… os dados em si!
/*No módulo anterior você criou seu primeiro banco de dados próprio, e agora chegou 
a hora de ele de fato armazenar informações.*/

-- Revise o conteúdo das últimas aulas, e depois disso:

/*1.	Adicione linhas às tabelas do seu banco de dados, respeitando as regras de negócio, 
regras de sistema e constraints que você definiu para o banco de dados e as tabelas na tarefa do módulo anterior.*/
/*a.	Considere o volume de dados necessário para cada uma das suas tabelas. 
Elas deverão ter no mínimo 10 e no máximo 50 linhas cada.*/

/*b.	Não se preocupe em inserir dados reais, os dados podem ser fictícios. 
Ferramentas como http://mockaroo.com podem te ajudar nesse processo.*/

INSERT INTO guitars_inventory.guitarras (modelo, marca, tipo_corpo, tipo_madeira, ano_fabricacao, id_captador)
	VALUES ('Les Paul', 'Orville', 'Sólido', 'Mogno' '1986', '1'),
			('Stratocaster', 'Fender', 'Sólido', 'Alder', '1954', '4'),
            ('Soloist', 'Jackson', 'Sólido', 'Basswood', '1983', '6'),
            ('ES-335', 'Gibson', 'Semi Sólido', 'Maple', '1961', '2'),
            ('Les Paul','Gibson','Sólido','Mogno','1959', '6'),
            ('Telecaster','Fender','Sólido','Alder','1954', '7'),
            ('Telecaster','Fender','Sólido','Alder', '1951', '7'),
            ('Rambler','Gretsch','Semi Sólido','Maple','1960', '8'),
            ('Jetglo 360-12','Rickenbacker','Semi Sólido','Alder','1967', '5'),
            ('Casino','Epiphone','Semi Sólido','Maple','1967', '9');
            
INSERT INTO guitars_inventory.madeira (tipo_madeira, origem, densidade_m3)
	VALUES ('Alder','EUA','53'),
			('Walnut','EUA','57'),
            ('Basswood','EUA','42'),
            ('Mogno','BR','56'),
            ('Poplar', 'EUA', '35'),
            ('Koa', 'Hawaii', '60'),
            ('Maple', 'EUA/CAN', '60'),
            ('Swamp Ash','EUA','54'),
            ('Cherry','EUA','63'),
            ('Korina','CAM','55');
            
            
INSERT INTO guitars_inventory.captadores (id_captador, tipo_captador,fabricante, material, handwired)
	VALUES (default, 'Humbucker', 'Gibson', 'Alnico', '1'),
			(default, 'P90', 'Gibson', 'Alnico', '1'),
            (default, 'Single Coils', 'Fender', 'Alnico', '1'),
            (default, 'Single Coils', 'Fender', 'Ceramic', '1'),
            (default, 'Humbucker', 'Orvile', 'Alnico', '0'),
            (default, 'Humbucker', 'DiMarzio', 'Alnico', '0'),
            (default, 'Lipstick Single Coil', 'Fender', 'Ceramic', '1'),
            (default, 'Humbucker', 'Fullterton', 'Alnico', '1');


/*2.	Com base nas tabelas e dados definidos, escreva de 3 consultas diferentes que apliquem 
os conhecimentos dos módulos 1 a 11 do curso (linguagem de consulta de dados).*/
-- a.	Pense em qualquer pergunta de negócio ou aplicação que pode ser respondida a partir de seus dados!
/*b.	Adicione um comentário logo antes da consulta que explique o objetivo daquele código 
(ou seja, qual é o comportamento esperado a partir daquela consulta SQL).*/

-- O Codigo abaixo retorna as guitarras fabricadas antes de 1960, portanto, mais raras
SELECT modelo,
		marca,
        ano_fabricacao
FROM guitarras
WHERE ano_fabricacao <= '1959';

-- O código abaixo retorna guitarras equipadas com capatadores humbucker
SELECT g.modelo,
		g.marca,
        c.tipo_captador
	FROM guitarras AS g 
 INNER JOIN capatadores as c	
ON guitarras.tipo_captador = captadores.tipo_captador
WHERE c.tipo_captador = 'Humbucker';

-- O código abaixo retorna as guitarras madeiras de alta densidade

SELECT g.modelo,
		g.marca,
        m.tipo_madeira
	FROM guitarras as g
 INNER JOIN madeira as m
 ON guitarras.tipo_madeira = madeira.tipo_madeira
 WHERE m.densidade_m3 > 55;