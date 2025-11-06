CREATE DATABASE IF NOT EXISTS filmesdb CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
-- DROP DATABASE filmesdb;

SELECT DATABASE() filmesdb;
USE filmesdb;
SELECT * FROM filmesdb; -- COLOCAR .nometable PARA PESQUISAR

SHOW CREATE DATABASE filmesdb;

CREATE TABLE obras(
	id_obra BIGINT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    diretor_principal_id INT,
    titulo VARCHAR(255) NOT NULL,
    data_estreia DATE,
    sinopse TEXT,
    status_lancamento ENUM("Lancado", "Nao Lancado", "Sem data") NOT NULL, 
    emissora VARCHAR(255),
	idioma_original VARCHAR(255) NOT NULL,
    classificacao VARCHAR(255),
	streaming_exclusivo BOOLEAN,
    pais_origem VARCHAR(255) NOT NULL,
    nota_media DECIMAL(3,1),
    avaliacao_numero BIGINT 
);

CREATE TABLE filmes(
	obra_id BIGINT,
    duracao_minuto INT,
    formato_audio VARCHAR(255),
    proporcao_tela VARCHAR(255)
);
CREATE TABLE series(
	obra_id BIGINT,
    numero_temporada INT,
    numero_episodio INT,
    data_termino DATE
);
CREATE TABLE animacao(
	obra_id BIGINT,
    tipo_animacao ENUM("3d", "2d", "stop motion", "anime", "claymation")
);

CREATE TABLE generos_obras(
	genero_id BIGINT NOT NULL,
    obra_id BIGINT NOT NULL
);
CREATE TABLE generos(
	genero_id BIGINT NOT NULL,
    nome_genero VARCHAR(255) NOT NULL
);

CREATE TABLE obras_pessoas_personagens(
	obras_id BIGINT NOT NULL,
    pessoas_id BIGINT NOT NULL,
	personagens_id BIGINT,
	papel VARCHAR(255),
    descricao_papel VARCHAR(255) 
);
CREATE TABLE pessoas(
	id_pessoa BIGINT UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nome_real VARCHAR(255),
    nome_artistico VARCHAR(255),
    biografia TEXT,
    genero_sexo ENUM("M", "F", "Outro") NOT NULL,
    data_nascimento DATE,
    nacionalidade VARCHAR(255),
    foto_url VARCHAR(255)
);
CREATE TABLE personagens(
	id_personagens BIGINT UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    descricao TEXT,
    genero_sexo ENUM("M", "F", "Outro") NOT NULL,
    franquia VARCHAR(255),
    estado ENUM("Morto", "Vivo", "Desconhecido"),
    foto_url VARCHAR(255)
);
CREATE TABLE conteudo_promocional(
	obra_id BIGINT UNSIGNED,
    id_arte BIGINT UNSIGNED,
    url VARCHAR(255),
    descricao TEXT,
    tipo VARCHAR(255),
    formato VARCHAR(255),
	data_criacao DATE
);