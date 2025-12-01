USE sakila_pt;
UNLOCK TABLES;

		# =========================== #
		# ===  Inserir Registros  === #
		# =========================== #

# === 1. Insira um novo ator com o nome 'CARLOS' e sobrenome 'GOMES === #
INSERT INTO atores (primeiro_nome, ultimo_nome) 
VALUES ('Carlos', 'Gomes');

DESCRIBE atores;
SELECT * FROM atores ORDER BY primeiro_nome;


# === 2. Insira uma nova categoria chamada 'Brasileiro'. === #
DESCRIBE categorias;

INSERT INTO categorias (nome) VALUES ('Brasileiro');
SELECT * FROM categorias ORDER BY nome;


# === 3. Insira um novo idioma chamado 'Português'.
DESCRIBE idiomas;

INSERT INTO idiomas (nome) VALUES ('Portugues');
SELECT * FROM idiomas ORDER BY nome;


# === 4. Insira um novo pais chamado 'Brasil'.
DESCRIBE paises;

#INSERT INTO paises (pais) VALUES ('Brasil');
SELECT * FROM paises ORDER BY pais;

#DELETE FROM paises WHERE id_pais = 110;
-- brasil ja existe no id 15


# === 5. Usando o id_pais criado para 'Brasil', insira uma cidade chamada 'Rio de Janeiro'.
DESCRIBE cidades;

INSERT INTO cidades (cidade, pais_id)
	VALUES ('Rio de Janeiro', (SELECT id_pais FROM paises WHERE pais = 'Brasil'));

SELECT * FROM cidades ORDER BY cidade;
	-- SELECT * FROM paises WHERE id_pais = 15;
    
    
# === 6. Usando o id_cidade criado para 'Rio de Janeiro', 
-- insira um endereco (logradouro 'Rua Copacabana, 10', bairro 'Copacabana', cep '22000111', telefone '2199998888').
DESCRIBE enderecos;

INSERT INTO enderecos (logradouro, bairro, cidade_id, codigo_postal, telefone) 
VALUES ('Rua Copacabana, 10', 'Copacabana', (SELECT id_cidade FROM cidades WHERE id_cidade = 110), '22000111', '2199998888');
SELECT * FROM enderecos WHERE cidade_id = 110;


# === 7. Usando o id_endereco anterior e loja_id 1, insira um novo cliente (Ex: 'JOANA', 'SILVA', 'joana@email.com', criado_em = NOW())
DESCRIBE clientes;

INSERT INTO clientes (loja_id, primeiro_nome, ultimo_nome, email, endereco_id, ativo, criado_em) 
VALUES (1, 'JOANA', 'SILVA', 'joana@email.com', (SELECT id_endereco FROM enderecos WHERE bairro = 'Copacabana'), 1, NOW());

SELECT * FROM clientes WHERE primeiro_nome = 'JOANA';


# === 8. Insira um novo filme ('TÍTULO NOVO', 'Descrição...', 2025, idioma_id 1, duracao_aluguel 5, taxa_aluguel 3.99, custo_reposicao 19.99)
DESCRIBE filmes;

INSERT INTO filmes (titulo, descricao, ano_lancamento, idioma_id, duracao_aluguel, taxa_aluguel, custo_reposicao)
VALUES ('TÍTULO NOVO', 'Descrição...', 2025, 1, 5, 3.99, 19.99);

SELECT * FROM filmes WHERE ano_lancamento = 2025;


# === 9. Associe o ator 'CARLOS GOMES' ao 'TÍTULO NOVO' na tabela filmes_atores.
DESCRIBE filmes_atores;

INSERT INTO filmes_atores (ator_id, filme_id)
VALUES (
	(SELECT id_ator FROM atores WHERE primeiro_nome = 'CARLOS' AND ultimo_nome = 'GOMES'),
	(SELECT id_filme FROM filmes WHERE titulo = 'TÍTULO NOVO')
);

SELECT * FROM atores WHERE primeiro_nome = 'CARLOS' AND ultimo_nome = 'GOMES';
SELECT * FROM filmes WHERE titulo = 'TÍTULO NOVO';

SELECT a.primeiro_nome, a.ultimo_nome			-- Seleciona o primeiro nome e sobrenome do ator
FROM filmes_atores fa							-- Tabela de relação entre filmes e atores (tabela ponte)
JOIN atores a ON a.id_ator = fa.ator_id 		-- Junta com a tabela 'ator'  / ON = Condição: liga o ator correto pelo seu ID
JOIN filmes f ON f.id_filme = fa.filme_id		-- Junta com a tabela 'filme' / ON = Condição: liga o filme correto pelo seu ID
WHERE f.titulo = 'TÍTULO NOVO';					-- Filtra para retornar apenas atores desse filme específico


# === 10. Associe o 'TÍTULO NOVO' à categoria 'Brasileiro' na tabela filmes_categorias
DESCRIBE filmes_categorias;

INSERT INTO filmes_categorias (filme_id, categoria_id)
VALUES (
	(SELECT id_filme FROM filmes WHERE titulo = 'TÍTULO NOVO'),
    (SELECT id_categoria FROM categorias WHERE nome = 'Brasileiro')
);

SELECT 
    f.titulo,                 	-- Nome do filme
    c.nome AS categoria      	-- Nome da categoria
FROM filmes_categorias fc    	-- Tabela ponte entre filmes e categorias
JOIN filmes f 
    ON f.id_filme = fc.filme_id    		 -- Liga o filme ao relacionamento
JOIN categorias c
    ON c.id_categoria = fc.categoria_id  -- Liga a categoria ao relacionamento
WHERE c.nome = 'Brasileiro';    -- Filtra
