SHOW DATABASES;

-- criar database
-- CREATE DATABASE vini;

-- cria apenas caso nao exista (evita erros)
CREATE DATABASE IF NOT EXISTS vini;

-- exclui database (apenas se existe)
DROP DATABASE IF EXISTS ronan;

-- cria um banco de dados completo
-- usar underline no lugar dos tracos com aspas simples ( 'aula-18' ) -> ( aula_18 )
CREATE DATABASE IF NOT EXISTS aula_180925 CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
-- sempre usar essa linha 

-- MOSTRA O SCRIPT DE CRIACAO DO BANCO COMPLETO COM O CHARSET
SHOW CREATE DATABASE aula_180925;

-- marca um banco de dados para ser utilizado ate que a conexao finalize - IMPORTANTE! 
USE aula_180925;
-- mostra a database ativa
SELECT DATABASE();

-- cria tabela CREATE TABLE 
-- CREATE TABLE nome_tabela ( coluna1 tipo_dados [restricoes], coluna2 tipo_dados [restricoes] ));

CREATE TABLE usuarios(
    -- ultimo elemento sempre termina SEM virgula 
    -- UNSIGNED nao permite numeros negativos e "dobra" a capacidade do campo positivando os negativos ( ex: SIGNED -128 ate +127 ->  UNSIGNED +255 ) 
    -- BIGINT(*QUATRILHOES* DE REGISTROS) > INT(4 bilhoes de registro) > TINYINT(menor registro)
	id_usuario BIGINT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY, 
    nome VARCHAR(255) NOT NULL,
    cpf VARCHAR(14) UNIQUE,
    email VARCHAR(255) UNIQUE,
    data_nascimento DATE,
    admin BOOLEAN DEFAULT FALSE, -- FALSE/0 sao sinonimos, BOOLEAN vai virar TINYINT 
    salario DECIMAL(10,2), -- 10 numeros maximos, 2 desses sao casas decimais
    cargo ENUM('Vendedor', 'Supervisor', 'Gerente'), -- limita a resposta desse atributo 
    senha VARCHAR(255) NOT NULL, -- tratada pelo script depois
    
    -- CAMPOS PARA LOG / AUDITORIA
    criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,
    alterado_em DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deletado_em DATETIME NULL
);