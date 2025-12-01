USE sakila_pt;
UNLOCK TABLES;

		# ================================ #
		# ====  SELECT com INNER JOIN ==== #
		# ================================ #

--  INNER JOIN mostra SOMENTE as linhas que têm correspondência nas duas tabelas.
-- importante definir um caminho claro, cliente>endereco>cidade>pais
        
# === 1. Liste o titulo do filme e o nome do idioma de cada filme.
SELECT
    f.titulo,       -- Queremos o título (da tabela 'filme')
    i.nome          -- Queremos o nome do idioma (da tabela 'idioma')
FROM filmes f         -- Comece na tabela 'filme'
INNER JOIN idiomas i        -- Junte com a tabela 'idioma'
	ON f.idioma_id = i.id_idioma; -- A ligação entre elas é o ID do idioma


# === 2. Liste o primeiro_nome do cliente e o logradouro do seu endereco.
SELECT c.primeiro_nome, 
	   e.logradouro
FROM clientes c 
INNER JOIN enderecos e 
ON c.endereco_id = e.id_endereco;


# === 3. Liste a data_aluguel e o primeiro_nome do cliente que realizou o aluguel.
SELECT a.data_aluguel, c.primeiro_nome
	FROM alugueis a
    INNER JOIN clientes c
    ON a.cliente_id = c.id_cliente;


# === 4. Liste o primeiro_nome do funcionario e o id_loja onde ele trabalha.
DESCRIBE funcionarios;
SELECT f.primeiro_nome, f.loja_id FROM funcionarios f;
	-- Nota: Esta informação já está diretamente na tabela "funcionario", não requer JOIN.

# === 5. Liste o nome da cidade e o nome do pais correspondente.
DESCRIBE cidades;
SELECT c.cidade, p.pais
	FROM cidades c
	INNER JOIN paises p
	ON c.pais_id = p.id_pais;


# === 6. Liste o titulo do filme e o primeiro_nome dos atores que participam dele (requer 3 tabelas: filmes, filmes_atores, atores).
SELECT f.titulo, a.primeiro_nome 
	FROM filmes f 
    INNER JOIN filmes_atores fa ON f.id_filme = fa.filme_id
    INNER JOIN atores a ON fa.ator_id = a.id_ator;
		-- tem que fazer o caminho, primeiro pega oq esta entre filmes e filmes_atores e depois dos filmes_atores vc pega os atores

# === 7. Liste o titulo do filme e o nome da categoria a que ele pertence (requer 3 tabelas).
SELECT f.titulo, c.nome
	FROM filmes f
    INNER JOIN filmes_categorias fc ON f.id_filme = fc.filme_id
    INNER JOIN categorias c ON fc.categoria_id = c.id_categoria;


# === 8. Liste o valor do pagamento e o primeiro_nome do funcionario que o registrou.
SELECT p.valor, f.primeiro_nome 
	FROM pagamentos p
    INNER JOIN funcionarios f ON p.funcionario_id = f.id_funcionario;


# === 9. Liste o id_inventario, o id_loja e o titulo do filme correspondente.
DESCRIBE inventarios;
SELECT f.titulo, i.id_inventario, i.loja_id -- id loja ja esta na tabela, nao precisa de inner
	FROM inventarios i 
    INNER JOIN filmes f 
    ON i.filme_id = f.id_filme;


# === 10. Liste o primeiro_nome do cliente, seu logradouro, cidade e pais (requer 4 tabelas).
SELECT cli.primeiro_nome, e.logradouro, ci.cidade, p.pais
	FROM clientes cli 
    INNER JOIN enderecos e ON cli.endereco_id = e.id_endereco
    INNER JOIN cidades ci ON e.id_endereco = ci.id_cidade
    INNER JOIN paises p ON ci.pais_id = p.id_pais;