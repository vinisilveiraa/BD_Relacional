USE sakila_pt;
UNLOCK TABLES;

		# ========================================================== #
		# ====  SELECT Simples (Ordenação, Agrupamento e WHERE) ==== #
		# ========================================================== #

# === 1. Selecione o primeiro_nome e ultimo_nome de todos os atores, ordenados por ultimo_nome (A-Z).
SELECT primeiro_nome, ultimo_nome FROM atores ORDER BY ultimo_nome;


# === 2. Selecione o titulo e ano_lancamento de todos os filmes com classificacao 'PG-13'.
SELECT titulo, ano_lancamento FROM filmes WHERE classificacao = 'PG-13';


# === 3. Conte quantos filmes existem para cada classificacao.
SELECT classificacao, COUNT(*) FROM filme GROUP BY classificacao;
	-- GROUP BY = agrupa resultados da tabela
    -- nesse contexto ele esta agrupando por classificacao


# === 4. Selecione o email e criado_em de todos os clientes que estão ativo = 1, ordenados por criado_em (mais recentes primeiro).
SELECT email, criado_em FROM clientes WHERE ativo = 1 ORDER BY criado_em ASC;


# === 5. Liste os 10 pagamentos de maior valor, ordenados por valor (descendente).
SELECT * FROM pagamentos ORDER BY valor DESC LIMIT 10;


# === 6. Selecione todos os enderecos do bairro 'District 9'.
SELECT * FROM enderecos WHERE bairro = 'District 9';
	-- nao existe

# === 7. Conte quantos clientes estão associados a cada loja_id.
SELECT loja_id, COUNT(*) AS total_clientes FROM clientes GROUP BY loja_id;


# === 8. Liste todos os alugueis realizados pelo funcionario_id 1.
SELECT * FROM alugueis WHERE funcionario_id = 1;


# === 9. Selecione titulo, taxa_aluguel e duracao dos filmes com taxa_aluguel menor que 1.00.
SELECT titulo, taxa_aluguel, duracao FROM filmes WHERE taxa_aluguel < 1.00;


# === 10. Liste todos os paises, ordenados por pais em ordem alfabética.
SELECT * FROM paises ORDER by pais;


