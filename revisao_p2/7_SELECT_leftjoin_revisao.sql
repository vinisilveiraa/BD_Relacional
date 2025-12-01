USE sakila_pt;
UNLOCK TABLES;

		# =============================== #
		# ==== SELECT com LEFT JOIN ==== #
		# =============================== #
	
-- 	LEFT JOIN mostra TODAS as linhas da tabela da esquerda, e só as correspondentes da direita.
-- 	Se não existir correspondência, a direita vira NULL.
        
# === 1. Liste todos os atores e os filmes em que atuaram (mostre os atores mesmo que não tenham atuado em nenhum filme).
SELECT
	a.primeiro_nome,
    a.ultimo_nome,
    f.titulo AS filme
FROM atores a
LEFT JOIN filmes_atores fa ON fa.ator_id = a.id_ator
LEFT JOIN filmes f ON f.id_filme = fa.filme_id;


# === 2. Liste todos os clientes e o valor total de seus pagamentos (use SUM e GROUP BY, mostre clientes mesmo que tenham pago $0.00).
SELECT 
	c.id_cliente,
    c.primeiro_nome,
    c.ultimo_nome,
    coalesce(SUM(p.valor), 0) AS total_pago 
    -- coalesce substitui por um valor default caso null (valor, default)
    -- SUM soma todos os valores presentes na 
FROM clientes c
LEFT JOIN pagamentos p ON p.cliente_id = c.id_cliente 
GROUP BY c.id_cliente;
	-- usa SUM para somar todos os valores como total_pago, agrupados com GROUP BY por id_cliente

# === 3. Liste todos os filmes e quantas vezes eles foram alugados (use COUNT e GROUP BY, mostre filmes mesmo que nunca tenham sido alugados).
SELECT 
	f.id_filme,
    f.titulo,
    COUNT(a.id_aluguel) AS total_alugados
FROM filmes f 
LEFT JOIN inventarios i ON i.filme_id = f.id_filme
LEFT JOIN alugueis a ON a.inventario_id = i.id_inventario
GROUP BY f.id_filme;


# === 4. Liste todas as categorias e o número de filmes em cada uma (mostre categorias com 0 filmes).
DESCRIBE categorias;
SELECT 
	c.nome,
	COUNT(f.id_filme) AS total_filme
FROM categorias c 
LEFT JOIN filmes_categorias fc ON fc.categoria_id = c.id_categoria
LEFT JOIN filmes f ON f.id_filme = fc.filme_id
GROUP BY c.id_categoria ORDER BY c.nome;

# === 5. Encontre todos os alugueis que ainda não têm pagamentos associados.
DESCRIBE alugueis;
DESCRIBE pagamentos;
SELECT
	a.*,
    p.valor
FROM alugueis a
LEFT JOIN pagamentos p ON p.aluguel_id = a.id_aluguel 
WHERE valor = 0;


# === 6. Liste todos os paises e as cidades neles cadastradas (mostre países sem cidades).
SELECT 
	p.pais,
    c.cidade
FROM paises p
LEFT JOIN cidades c ON c.pais_id = p.id_pais;

DESCRIBE paises;

# === 7. Liste todos os filmes e o nome do seu idioma_original_id (alguns filmes podem ter idioma_original_id NULO).
SELECT 
	f.titulo,
    i.nome AS idioma_original
FROM filmes f
INNER JOIN idiomas i ON i.id_idioma = f.idioma_original_id;
	-- Nota: essa coluna nao ta preenchida
	
DESCRIBE idiomas;
DESCRIBE filmes;
SELECT * FROM filmes; 


# === 8. Encontre clientes que nunca fizeram um aluguel.
SELECT 
	c.*
FROM clientes c 
LEFT JOIN alugueis a ON a.cliente_id = c.id_cliente 
WHERE a.id_aluguel IS NULL;

-- NOTA: nao tem 


# === 9. Encontre filmes que não possuem cópias no inventario.
SELECT 
	f.*
FROM filmes f
LEFT JOIN inventarios i ON i.filme_id = f.id_filme
WHERE i.id_inventario IS NULL;
	

# === 10. Liste todos os funcionarios e a contagem de alugueis que cada um processou (mostre funcionários com 0 aluguéis).
DESCRIBE funcionarios;
DESCRIBE alugueis;

SELECT 
	CONCAT(f.primeiro_nome, ' ', f.ultimo_nome) AS nome_completo,
    COUNT(a.id_aluguel) AS total_processado
FROM funcionarios f
LEFT JOIN alugueis a ON a.funcionario_id = f.id_funcionario
GROUP BY f.id_funcionario;