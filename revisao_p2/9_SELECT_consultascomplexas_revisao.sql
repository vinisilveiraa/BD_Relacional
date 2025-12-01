USE sakila_pt;
UNLOCK TABLES;

		# ============================================== #
		# === SELECT com WHERE, INNER JOIN e Funções === #
		# ===         (Consultas  Complexas)         === #
        # ============================================== #
	
    
# === 1. Liste o nome completo (CONCAT) dos clientes (JOIN enderecos, cidades) que moram na cidade 'London' (WHERE).
SELECT 
	CONCAT(c.primeiro_nome, ' ', c.ultimo_nome) AS nome_completo,
    ci.cidade
FROM clientes c
INNER JOIN enderecos e ON e.id_endereco = c.endereco_id
INNER JOIN cidades ci ON ci.id_cidade = e.cidade_id
WHERE ci.cidade = 'London';
-- Nota: nao tem london

DESCRIBE clientes;
DESCRIBE enderecos;
SELECT * FROM cidades;


# === 2. Calcule o total arrecadado (SUM valor) por cada funcionario (JOIN funcionarios), mas apenas para pagamentos feitos em agosto de 2005 (WHERE).
SELECT f.id_funcionario, SUM(p.valor) AS total_arrecadado
FROM funcionarios f 
INNER JOIN pagamentos p ON p.funcionario_id = f.id_funcionario 
WHERE p.data_pagamento BETWEEN '2005-08-01' AND '2005-08-31'
GROUP BY f.id_funcionario;

DESCRIBE funcionarios;
DESCRIBE pagamentos;


# === 3. Liste os titulos dos filmes (JOIN filmes_categorias, categorias) da categoria 'Horror' (WHERE) que têm duracao maior que 180 minutos (WHERE).
SELECT 
	f.titulo
FROM filmes f
INNER JOIN filmes_categorias fc ON fc.filme_id = f.id_filme
INNER JOIN categorias c ON c.id_categoria = fc.categoria_id
WHERE c.nome = 'Terror' -- nao tem horror
  AND duracao > 180;
  

# === 4. Conte (COUNT) quantos alugueis (JOIN clientes) foram feitos por clientes cujo ultimo_nome começa com 'S' (WHERE LIKE).
SELECT
	COUNT(*)
FROM alugueis a 
INNER JOIN clientes c ON a.cliente_id = c.id_cliente
WHERE c.ultimo_nome LIKE 'S%';

DESCRIBE alugueis;


# === 5. Calcule a taxa_aluguel média (AVG) por categoria (JOIN filmes, filmes_categorias), mas apenas para filmes com classificacao 'PG' (WHERE).
SELECT
	c.nome,
	AVG(f.taxa_aluguel) AS media_taxa
FROM categorias c
INNER JOIN filmes_categorias fc ON c.id_categoria = fc.categoria_id
INNER JOIN filmes f ON fc.filme_id = f.id_filme
WHERE f.classificacao = 'PG'
GROUP BY c.id_categoria;

DESCRIBE filmes_categorias;
DESCRIBE categorias;
DESCRIBE filmes;


# === 6. Liste os nomes dos atores (JOIN filmes_atores, filmes) que atuaram em filmes lançados (WHERE ano_lancamento) em 2006.
SELECT
	a.primeiro_nome, a.ultimo_nome, f.titulo, f.ano_lancamento
FROM atores a
INNER JOIN filmes_atores fa ON a.id_ator = fa.ator_id
INNER JOIN filmes f ON f.id_filme = fa.filme_id
WHERE f.ano_lancamento = '2006';

DESCRIBE atores;


# === 7. Calcule o total (SUM) de pagamentos (JOIN clientes, enderecos, cidades, paises) recebidos de clientes do 'Canadá' (WHERE pais = 'Canada').
SELECT 
	SUM(p.valor)
FROM pagamentos p 
INNER JOIN clientes c ON p.cliente_id = c.id_cliente
INNER JOIN enderecos e ON e.id_endereco = c.endereco_id
INNER JOIN cidades ci ON ci.id_cidade = e.cidade_id
INNER JOIN paises pa ON pa.id_pais = ci.pais_id
WHERE pa.pais = 'Canadá';

DESCRIBE pagamentos;
DESCRIBE paises;


# === 8. Liste os filmes.titulo (JOIN inventarios) que têm mais de 7 cópias (GROUP BY filme_id HAVING COUNT(*) > 7) na loja_id 1 (WHERE).
SELECT
	f.titulo
FROM filmes f
INNER JOIN inventarios i ON i.filme_id = f.id_filme
WHERE i.loja_id = 1
GROUP BY i.filme_id HAVING COUNT(*) > 7;

DESCRIBE inventarios;


# === 9. Mostre o nome completo (CONCAT) do gerente (JOIN lojas, funcionarios) da loja (JOIN enderecos) cujo bairro é 'Woodridge' (WHERE).
SELECT
	CONCAT(f.primeiro_nome, ' ', f.ultimo_nome) AS nome_gerente,
    e.bairro
FROM funcionarios f
INNER JOIN lojas l ON l.funcionario_gerente_id = f.id_funcionario
INNER JOIN enderecos e ON l.endereco_id = e.id_endereco
WHERE e.endereco_id = 'Woodridge';
-- nao existe
	
    
DESCRIBE funcionarios;
DESCRIBE lojas;
DESCRIBE enderecos;
SELECT * FROM lojas;


# === 10. Encontre o valor máximo (MAX) de pagamento (JOIN alugueis, inventarios, filmes) recebido por um filme da classificacao 'NC-17' (WHERE).
SELECT 
	MAX(p.valor) AS maior_pagamento
FROM pagamentos p 
INNER JOIN alugueis a ON p.aluguel_id = a.id_aluguel
INNER JOIN inventarios i ON a.inventario_id = i.id_inventario
INNER JOIN filmes f ON i.filme_id = f.id_filme
WHERE f.classificacao = 'NC-17';

DESCRIBE pagamentos;
DESCRIBE alugueis;
DESCRIBE inventarios;
DESCRIBE filmes;
