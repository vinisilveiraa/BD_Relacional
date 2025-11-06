SHOW DATABASES;

-- criar database
-- CREATE DATABASE vini;

-- cria apenas caso nao exista (evita erros)
	-- CREATE DATABASE IF NOT EXISTS vini;
-- exclui database (apenas se existe)
	-- DROP DATABASE IF EXISTS ronan;

-- cria um banco de dados completo
-- usar underline no lugar dos tracos com aspas simples ( 'aula-18' ) -> ( aula_18 )
CREATE DATABASE IF NOT EXISTS dbsistema CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci; -- ci determina se e CASE INSENSITIVE ou nao
-- sempre usar essa linha 

-- MOSTRA O SCRIPT DE CRIACAO DO BANCO COMPLETO COM O CHARSET
SHOW CREATE DATABASE dbsistema;

-- marca um banco de dados para ser utilizado ate que a conexao finalize - IMPORTANTE! 
USE dbsistema;

-- mostra as databases ativa
SELECT DATABASE();

	-- DROP DATABASE IF EXISTS dbsistema;

-- cria tabela CREATE TABLE 
-- CREATE TABLE nome_tabela ( coluna1 tipo_dados [restricoes], coluna2 tipo_dados [restricoes] ));

-- boa pratica: criar um drop table antes de criar a tabela (usa quando for implementar, apagando o anterior que serviria para testes)
DROP TABLE IF EXISTS usuarios; 
CREATE TABLE IF NOT EXISTS usuarios(
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

SELECT * FROM usuarios; -- mostra a table criada
DESCRIBE usuarios; -- descreve, SO FUNCIONA EM TABELA

ALTER TABLE usuarios ADD COLUMN genero ENUM("Feminino","Masculino","Outro","Prefiro Não Declarar");
ALTER TABLE usuarios DROP COLUMN genero;

ALTER TABLE usuarios 
	ADD COLUMN genero ENUM("Feminino","Masculino","Outro","Prefiro Não Declarar") 
	AFTER data_nascimento; -- especifica onde adicionar
    -- SET nao usamos pq ele e outra tabela N:M 
    -- SET permite null e multiselecao
    
ALTER TABLE usuarios 
	CHANGE COLUMN nome nome_completo VARCHAR(255) NOT NULL;

-- ALTER TABLE modifica uma tabela, PRECISA ABRIR ALTER TABLE ANTES DE ESPECIFICAR A ACAO
	-- Modificar uma coluna:
			ALTER TABLE usuarios
			ADD COLUMN novo_tipo_dados VARCHAR(255);
            
	-- Modificar uma coluna:
			ALTER TABLE usuarios
			MODIFY COLUMN novo_tipo_dados INT;
            
	-- Trocar nome
			ALTER TABLE usuarios 
            CHANGE COLUMN novo_tipo_dados nome_trocado VARCHAR(255); -- colocar nome antigo, nome novo e depois especificar novamente todos os tipos
            
	-- Remover uma coluna:
			ALTER TABLE usuarios DROP COLUMN nome_trocado;
            
	-- Adicionar uma restrição:
			-- ALTER TABLE nome_tabela ADD CONSTRAINT nome_restricao UNIQUE (coluna);
            
	-- Remover uma restrição:
			-- ALTER TABLE nome_tabela DROP CONSTRAINT nome_restricao;

CREATE TABLE IF NOT EXISTS produtos(
	id_produto BIGINT UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
	nome VARCHAR(255) NOT NULL,
    valor DECIMAL(10,2) NOT NULL,
    quantidade DECIMAL (6,3) NOT NULL,
    validade DATE NULL, -- CAMPOS DATA E HORA PRECISAM SER ESPECIFICADOS NULL CASO SEJAM
    
    data_criacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    alterado_em DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	deletado_em DATETIME NULL
);
CREATE TABLE IF NOT EXISTS categorias(
	id_categoria BIGINT UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    
    data_criacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    alterado_em DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deletado_em DATETIME NULL
);

CREATE TABLE IF NOT EXISTS produtos_categorias(
	produto_id BIGINT UNSIGNED NOT NULL,
    categoria_id BIGINT UNSIGNED NOT NULL,
    
    data_criacao DATETIME DEFAULT CURRENT_TIMESTAMP,
	alterado_em DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deletado_em DATETIME NULL,
    
    -- CRIANDO CHAVE PRIMARIA COMPOSTA dentro da table
    PRIMARY KEY (produto_id, categoria_id),
    FOREIGN KEY (produto_id) REFERENCES produtos(id_produto)
);

	-- criando um relacionamento depois da tabela ja criada 
    -- informar o nome do bd no script e uma boa pratica, mas pouco usada para comandos simples
ALTER TABLE dbsistema.produtos_categorias
ADD CONSTRAINT fk_produtos_categorias_categorias -- ao fazer o alter table e obrigatorio informar o nome do relacionamento
FOREIGN KEY (categoria_id) REFERENCES categorias (id_categoria);

-- NA ABA DE CIMA database -> reverse engineer -> next toda vida
-- isso cria um modelo
