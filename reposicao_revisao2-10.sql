# apaga a db pra garantir a estrutura final 
DROP DATABASE IF EXISTS loja_revisao;

CREATE DATABASE IF NOT EXISTS loja_revisao CHARACTER SET utf8mb4 COLLATE utfmb4_unicode_ci;

# tem que definir o bd a ser usado
USE loja_revisao;

# tabela clientes 
CREATE TABLE IF NOT EXISTS clientes(
	id_cliente BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nome VARCHAR(255) NOT NULL,
    # email tem que ser unico e obrigatorio!
    email VARCHAR(255) NOT NULL UNIQUE,
    cpf VARCHAR(14) NOT NULL UNIQUE,
    telefone VARCHAR(30),
    -- demais camppos do cliente...
    -- registro de log
    
    criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,
    -- somante o sql possui o ON UPDATE
    alterado_em DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    -- em campos de DATA/HORA e importante confirmar que ele aceita null
    deletado_em DATETIME NULL
);

CREATE TABLE IF NOT EXISTS produtos(
	id_produto BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT NOT NULL,
	nome VARCHAR(255) NOT NULL,
    descricao TEXT,
    preco_unitario DECIMAL(10,2) NOT NULL,
    estoque DECIMAL(10,3) DEFAULT 0,
    codigo_barras VARCHAR(50) UNIQUE,
    
	criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,
    -- somante o sql possui o ON UPDATE
    alterado_em DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    -- em campos de DATA/HORA e importante confirmar que ele aceita null
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
    
    -- logs
	criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,
    -- somante o sql possui o ON UPDATE
    alterado_em DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    -- em campos de DATA/HORA e importante confirmar que ele aceita null
    deletado_em DATETIME NULL,
    
    FOREIGN KEY (cliente_id) REFERENCES clientes(id_cliente)
);



