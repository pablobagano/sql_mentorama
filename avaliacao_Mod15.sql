CREATE USER 'vendas' IDENTIFIED BY 'vendas1234'; 
CREATE USER 'inventario' IDENTIFIED BY 'inventario1234'; 

CREATE ROLE 'consulta';
CREATE ROLE 'operacao'; 

GRANT SELECT ON guitars_inventory.* TO 'consulta'; 
GRANT SELECT, INSERT, ALTER, DROP, CREATE ON guitars_inventory TO 'operacao';

GRANT 'consulta' TO 'vendas';
GRANT 'operacao' TO 'inventario'; 