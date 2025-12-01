USE sakila_pt;
UNLOCK TABLES;

		# =============================== #
		# === SUBQUERY (subconsultas) === #
		# =============================== #
	
    
# === 1. Liste todos os filmes da categoria 'Action'.
SELECT titulo
FROM filmes 
WHERE id_filme IN (
	SELECT filme_id 
    FROM filmes_categorias
    WHERE categoria_id = (
		SELECT id_categoria FROM categorias WHERE nome = 'Ação'
    )
);

SELECT * FROM categorias;

# === 2. Liste os atores que atuaram no filme 'ALIEN CENTER'.
SELECT * FROM filmes ORDER BY titulo;

SELECT primeiro_nome, ultimo_nome FROM atores 
WHERE id_ator IN (
	SELECT ator_id FROM filmes_atores 
    WHERE filme_id = (
    SELECT id_filme FROM filmes WHERE titulo = 'A BUSCA EM BERLIM'
    -- nao existe ALIEN CENTER
    )
);


# === 3. Encontre os clientes que moram no mesmo pais que o cliente 'MARY SMITH'.
SELECT * FROM clientes
WHERE endereco_id IN (
    SELECT id_endereco  FROM enderecos
    WHERE cidade_id IN (
        SELECT cidade_id FROM enderecos
        WHERE id_endereco = (
            SELECT endereco_id FROM clientes WHERE primeiro_nome = 'MARY' AND ultimo_nome = 'SMITH'
        )
    )
);


# === 4. Encontre filmes com taxa_aluguel maior que a média de todas as taxas de aluguel.
SELECT * FROM filmes
WHERE taxa_aluguel > (
	SELECT  AVG(taxa_aluguel) FROM filmes
);


# === 5. Liste os clientes que fizeram mais de 30 pagamentos.
SELECT * FROM clientes
WHERE id_cliente IN (
	SELECT cliente_id FROM pagamentos GROUP BY cliente_id HAVING COUNT(*) > 30
);


# === 6. Encontre filmes que existem no inventario da loja 1, mas não da loja 2 (use EXISTS ou IN).
SELECT * FROM filmes 
WHERE id_filme IN (
		SELECT filme_id FROM inventarios WHERE loja_id = 1
)
AND id_filme NOT IN (
	SELECT filme_id FROM inventarios WHERE loja_id 
);


# === 7. Encontre atores que não atuaram em nenhum filme (use NOT IN ou NOT EXISTS).
SELECT * FROM atores 
WHERE id_ator NOT IN (
	SELECT ator_id FROM filmes_atores
);


# === 8. Mostre o id_cliente e o valor do pagamento mais alto que cada cliente já fez.
SELECT cliente_id, MAX(valor) FROM pagamentos GROUP BY cliente_id;


# === 9. Encontre o cliente que gastou (SUM) o maior valor em pagamentos.
SELECT cliente_id, SUM(valor) AS total_gasto
FROM pagamentos 
GROUP BY cliente_id ORDER BY total_gasto ASC 
LIMIT 1;


# === 10. (Na cláusula SELECT) Liste cada filme e, em uma segunda coluna, mostre a taxa_aluguel média de todos os filmes.
SELECT titulo,
	(SELECT AVG(taxa_aluguel) FROM filmes) AS media_geral
FROM filmes;

