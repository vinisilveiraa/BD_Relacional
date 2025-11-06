# =============== #
# Reposicao 02/10 #
# =============== #

CREATE DATABASE IF NOT EXISTS loja CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE loja;

SELECT DATABASE();
	# DROP DATABASE loja;

# DROP TABLE IF EXISTS clientes;
CREATE TABLE IF NOT EXISTS clientes (
	id_cliente BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
    nome VARCHAR(255) NOT NULL,
    cpf VARCHAR(14) UNIQUE,
    email VARCHAR(255) UNIQUE,
    data_nascimento DATE,
    
    criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,
    alterado_em DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deletado_em DATETIME NULL
);

# DROP TABLE IF EXISTS produtos;
CREATE TABLE IF NOT EXISTS produtos (
	id_produto BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
    nome_produto VARCHAR(255) NOT NULL,
    preco_unitario DECIMAL(10,2),
    estoque INT,
    data_cadastro DATE,
    venda_status ENUM('ativo', 'inativo'),
    
	criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,
    alterado_em DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deletado_em DATETIME NULL
);

# DROP TABLE IF EXISTS vendas;
CREATE TABLE IF NOT EXISTS vendas (
	id_venda BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
	cliente_id BIGINT UNSIGNED NOT NULL,
    produto_id BIGINT UNSIGNED NOT NULL, 
    data_venda DATETIME,
    valor_total DECIMAL(10,2),
    forma_pagamento VARCHAR(255),
    
    FOREIGN KEY (produto_id) REFERENCES produtos(id_produto),
    FOREIGN KEY (cliente_id) REFERENCES clientes(id_cliente)
);

DESCRIBE clientes;
SHOW CREATE DATABASE loja;


# ============================= #
# ==== Renomeando Clientes ==== #
# ============================= #

RENAME TABLE clientes TO usuarios;
ALTER TABLE usuarios 
CHANGE id_cliente id_usuario BIGINT UNSIGNED AUTO_INCREMENT NOT NULL;
# CHANGE nome_antigo nome_novo (atributos)
# tbm atualiza atributos entao tem que repetir tudo
# nao precisa repetir primary key, a definicao continua

DESCRIBE vendas;
SHOW CREATE TABLE vendas; # fk ainda referencia a usuarios

ALTER TABLE vendas
CHANGE cliente_id usuario_id BIGINT UNSIGNED NOT NULL;
# denovo, repetir atributos

SHOW CREATE TABLE vendas; 
# fk renomeada ainda referencia a usuarios :D

# ============================ #
# ====== Add/Mod Campos ====== #
# ============================ #

ALTER TABLE usuarios ADD COLUMN ativo TINYINT;
ALTER TABLE produtos ADD COLUMN ativo TINYINT;
ALTER TABLE vendas ADD COLUMN ativo TINYINT;

DESCRIBE usuarios;

ALTER TABLE usuarios MODIFY COLUMN ativo CHAR(1);
ALTER TABLE produtos MODIFY COLUMN ativo CHAR(1);
ALTER TABLE vendas MODIFY COLUMN ativo CHAR(1);

DESCRIBE usuarios;

# =========================== #
# ====== Gerenciamento ====== #
# =========================== #

SELECT user, host FROM mysql.user;
# ve todos

CREATE USER 'vini'@'localhost' IDENTIFIED BY '123';
# cria 'usuario'@'host' identificado por 'senha'
GRANT SELECT, INSERT, UPDATE, DELETE ON loja.* TO 'vini'@'localhost';
# permissoes crud
DROP USER 'vini'@'localhost';
# deleta