DROP DATABASE IF EXISTS levelupg;
CREATE DATABASE IF NOT EXISTS levelupg CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE levelupg;

CREATE TABLE generos (
    id_genero BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nome VARCHAR(100) NOT NULL UNIQUE,
    descricao TEXT,
    
	criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,
    alterado_em DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deletado_em DATETIME NULL
);

CREATE TABLE IF NOT EXISTS jogos(
	id_jogo BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nome VARCHAR(255) NOT NULL,
    genero_id BIGINT UNSIGNED NOT NULL,
    classificacao ENUM('Livre', '+10', '+12', '+14', '+16', '+18'),
    descricao TEXT,
    preco_unitario DECIMAL(10,2),
    estoque INT DEFAULT 0,
	codigo_barras VARCHAR(50) UNIQUE,
    
	criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,
    alterado_em DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deletado_em DATETIME NULL,

    CONSTRAINT fk_genero FOREIGN KEY (genero_id) REFERENCES generos(id_genero)
);

CREATE TABLE IF NOT EXISTS plataformas(
	id_plataforma BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nome VARCHAR(255) NOT NULL,
    descricao TEXT,
    status_plataforma ENUM('Ativa','Descontinuada')
);

CREATE TABLE IF NOT EXISTS jogo_plataforma(
	plataforma_id BIGINT UNSIGNED NOT NULL,
    jogo_id BIGINT UNSIGNED NOT NULL,
    
    PRIMARY KEY (plataforma_id, jogo_id),
	CONSTRAINT fk_plataforma_jogo FOREIGN KEY (plataforma_id) REFERENCES plataformas(id_plataforma),
	CONSTRAINT fk_jogo_plataforma FOREIGN KEY (jogo_id) REFERENCES jogos(id_jogo)
);

CREATE TABLE IF NOT EXISTS clientes(
	id_cliente BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nome VARCHAR(255) NOT NULL,
    nome_social VARCHAR(255),
    email VARCHAR(255) NOT NULL UNIQUE,
    cpf VARCHAR(14) NOT NULL UNIQUE,
    telefone VARCHAR(30),
    nascimento DATE,
    
    cep VARCHAR(10),
    logradouro VARCHAR(255),
    numero VARCHAR(5),
    complemento VARCHAR(255),
    bairro VARCHAR(255),
    cidade VARCHAR(255),
    estado VARCHAR(2),
    
    criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,
    alterado_em DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deletado_em DATETIME NULL
);

CREATE TABLE IF NOT EXISTS vendas(
	id_venda BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    cliente_id BIGINT UNSIGNED NOT NULL,
    data_venda DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    forma_pagamento ENUM('dinheiro', 'credito', 'debito', 'pix'),
    observacoes TEXT,
    desconto_total DECIMAL(10,2) DEFAULT 0,
    total_venda DECIMAL(10,2) NOT NULL,

    criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,
    alterado_em DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deletado_em DATETIME NULL,
    
    CONSTRAINT fk_cliente_venda FOREIGN KEY (cliente_id) REFERENCES clientes(id_cliente)
);

CREATE TABLE IF NOT EXISTS items_vendas(
	id_venda_jogo BIGINT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    venda_id BIGINT UNSIGNED NOT NULL,
	jogo_id BIGINT UNSIGNED NOT NULL,
    quantidade DECIMAL(10,3) NOT NULL,
    preco_unitario DECIMAL(10,2) NOT NULL,
    desconto DECIMAL(10,2) DEFAULT 0,
    subtotal DECIMAL(10,2) DEFAULT 0 NOT NULL,
    
	FOREIGN KEY (jogo_id) REFERENCES jogos(id_jogo),
	FOREIGN KEY (venda_id) REFERENCES vendas(id_venda)
);

DESCRIBE vendas;

-- CRUD COM SQL 

-- C -> CREATE = INSERT -> Insere dados em uma tabela
#	INSERT INTO tabela (campo1, campo2, campo3)
#		VALUES (valor1, 'valor2', 'YYYY-mm-dd');
    
INSERT INTO generos (nome) VALUES ('Ação');
INSERT INTO generos (nome) VALUES ('RPG'), ('Mundo Aberto');

INSERT INTO clientes (id_cliente, nome, email, cpf ) VALUES (NULL, 'joaozinho', 'xxjoaozinho.ultrakill@gmail.com', '392.696.195-01');

INSERT INTO clientes (nome, nome_social, email, cpf, telefone, nascimento, cep, logradouro, numero, complemento, bairro, cidade, estado) 
	VALUES ('robertinho', NULL, 'robertinho@gmail.com', '123.432.325-12', '(14)99640-0323', '2001-02-11', '12.333-121', 'Rua bucetais do norte', '302', 'casa', 'sao jose pererecao', 'roraima', 'sp');
    
-- R -> READ = SELECT -> Vizualiza todos os dados presentes na tabela, mostra todos os campos e todos os dados
#	SELECT * FROM tabela;

SELECT * FROM generos;
SELECT nome, telefone FROM clientes;
SELECT * FROM clientes;