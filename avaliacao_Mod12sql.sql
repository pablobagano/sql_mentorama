/*
Criando o banco de dados guitars_inventory
*/

-- Criar o banco de dados
CREATE DATABASE IF NOT EXISTS guitars_inventory;

-- Definir como padrão do MySQL Workbench
USE guitars_inventory;

-- Criar a tabela de madeiras de guitarra
CREATE TABLE IF NOT EXISTS guitars_inventory.madeira (
	tipo_madeira VARCHAR(100) NOT NULL PRIMARY KEY,
    origem VARCHAR(255),
    densidade_m3 INT
)
COMMENT "Tabela que armazena dados sobre a madeira das guitarras";

-- Criar a tabela de Guitarras
CREATE TABLE IF NOT EXISTS guitars_inventory.guitarras (
	id_modelo VARCHAR(100) NOT NULL PRIMARY KEY,
    marca VARCHAR(100),
    tipo_corpo VARCHAR(100),
    tipo_madeira VARCHAR(100) NOT NULL,
    ano_fabricacao DATE NOT NULL,
    id_captador INT NOT NULL,
    tipo_captador VARCHAR(100),
    id_ponte INT NOT NULL,
    tipo_ponte VARCHAR(100),
    FOREIGN KEY (tipo_madeira) REFERENCES madeira(tipo_madeira),
    FOREIGN KEY (id_captador) REFERENCES captadores(id_captador),
    FOREIGN KEY (tipo_captador) REFERENCES captadores(tipo_captador),
    FOREIGN KEY (id_ponte) REFERENCES ponte(id_ponte),
    FOREIGN KEY (tipo_ponte) REFERENCES ponte(tipo_ponte)
    
) 
COMMENT "Tabela que armazena dados das guitarras";

-- Criar a tabela de captadores
CREATE TABLE IF NOT EXISTS guitars_inventory.capatadores (
	id_captador INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    tipo_capatador VARCHAR(100) NOT NULL,
    fabricante VARCHAR(100) NOT NULL,
    material VARCHAR(100) NOT NULL,
    handwired INT -- 0 para False, 1 para True
)
COMMENT "Tabela que armazena dados dos captadores das guitarras";

-- Criar a tabela de pontes de guitarras
CREATE TABLE IF NOT EXISTS guitars_inventory.ponte (
	id_ponte INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    tipo_ponte VARCHAR(100) NOT NULL,
	fabricante VARCHAR(100) NOT NULL,
    material VARCHAR(100) NOT NULL,
    fixa INT -- 0 para False, 1 para True
)
COMMENT "Tabela que armazena dados das pontes das guitarras";

