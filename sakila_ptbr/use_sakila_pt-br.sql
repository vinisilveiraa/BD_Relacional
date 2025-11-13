USE sakila_pt;

SELECT SUM(valor), AVG(valor), MAX(valor), MIN(valor) FROM pagamentos
WHERE data_pagamento < '2006-02-15'
GROUP BY funcionario_id;

-- SELECT * FROM pagamentos WHERE valor = 0.00;

-- alteracao da vizualizacao 
SELECT CONCAT(primeiro_nome, ' ', ultimo_nome) AS nome, email 
FROM clientes;

SELECT LOWER(titulo), titulo FROM filmes;

SELECT * FROM filmes WHERE LOWER(titulo) = LOWER('A Batalha do Golfo');

-- DATE FORMAT - consultar apostila!
SELECT 
	id_pagamento, -- seleciona id_pagamento
    CONCAT(clientes.primeiro_nome, ' ', clientes.ultimo_nome) AS cliente, -- junta o primeiro nome ao ultimo, coloca na coluna clientes
    DATE_FORMAT(data_pagamento, '%d/%m/%y') AS data_pagamento, -- troca formato da data_pagamento, coloca na coluna data_pagamento
    valor, -- seleciona valor tbm
    FORMAT(valor, 2, 'pt_BR') AS valor_pt
FROM pagamentos
INNER JOIN clientes ON pagamentos.cliente_id = clientes.id_cliente;
-- "Junte as linhas das duas tabelas onde o cliente_id da tabela de pagamentos for igual ao id_cliente da tabela de clientes."

-- SUBQUERY - Podemos inserir SELECTs, dentro de outros SELECTs
-- para ampliar o poder de consulta em lugares que o JOIN não resolve



-- exibir clientes com pagamentos acima da media
SELECT 
	-- Concatena primeiro e último nome do cliente em uma única coluna
	CONCAT(c.primeiro_nome, ' ', c.ultimo_nome) AS nome_cliente,
    -- Mostra a data do pagamento
    p.data_pagamento,
    -- Mostra o valor do pagamento
    p.valor
FROM clientes c 
-- Faz um INNER JOIN para relacionar cada pagamento ao respectivo cliente
INNER JOIN pagamentos p ON c.id_cliente = p.cliente_id
WHERE 
	-- Filtra apenas pagamentos cujo valor seja MAIOR do que a média geral
	p.valor > (
        -- Subconsulta: calcula a média de todos os pagamentos registrados
        SELECT AVG(valor)
        FROM pagamentos
    );
    
-- select dentro do from - usamos o resultado de um select para fazer novos filtros.ALTER
SELECT resultado.nome_cliente, resultado_valor 
FROM (
	SELECT 	CONCAT(c.primeiro_nome, ' ', c.ultimo_nome) AS nome_cliente,
		p.data_pagamento,
		p.valor
	FROM clientes c 
	INNER JOIN pagamentos p ON c.id_cliente = p.cliente_id
	WHERE 
		p.valor > (
			SELECT AVG(valor)
			FROM pagamentos
		) -- fim do select interno
	) AS resultado
WHERE resultado.valor < 6;

-- select dentro do select dentro do select
