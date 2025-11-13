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

