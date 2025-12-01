USE sakila_pt;
UNLOCK TABLES;


		# ===================================================== #
		# ====  SELECT com Funções (Agregação e Escalares) ==== #
		# ===================================================== #
        
# === 1. Calcule o valor total (SUM) de todos os pagamentos.
SELECT SUM(valor) AS valor_total_pagamento FROM pagamentos;


# === 2. Calcule a taxa_aluguel média (AVG) de todos os filmes.
SELECT AVG(taxa_aluguel) AS taxa_media_aluguel FROM filmes;


# === 3. Encontre a menor (MIN) e a maior (MAX) duracao de filmes.
SELECT MIN(duracao) AS duracao_minima, MAX(duracao) AS duracao_maxima FROM filmes;


# === 4. Exiba o nome completo de todos os clientes em uma única coluna (use CONCAT()).
SELECT CONCAT(primeiro_nome, ' ', ultimo_nome) AS nome_completo FROM clientes;


# === 5. Exiba os titulos de todos os filmes em letras maiúsculas (use UPPER() ou UCASE()).
SELECT UPPER(titulo) AS titulo_maiusculos FROM filmes;


# === 6. Conte (COUNT) quantos inventarios (cópias de filmes) a loja_id 2 possui.
SELECT COUNT(*) AS total_inventario_loja_2 FROM inventarios WHERE loja_id = 2;


# === 7. Exiba a data_pagamento e o valor de todos os pagamentos, formatando a data como 'dd/MM/yyyy' (use DATE_FORMAT()).
SELECT date_format(data_pagamento, '%d/%m/%Y') AS data_pagamento_formatada, valor FROM pagamentos;


# === 8. Calcule há quantos dias (DATEDIFF) ocorreu o aluguel mais antigo.
SELECT DATEDIFF(curdate(), MIN(data_aluguel)) 
	AS dias_desde_aluguel_mais_antigo FROM alugueis;
	-- DATEDIFF espera 2 valores para tirar a diferenca
	-- nesse caso, o primeiro e CURDATE = currentdate
    -- e o segundo MIN(data-aluguel) = minimo possivel nas data_alguel
    

# === 9. Substitua a palavra 'Documentary' por 'Documentário' na descricao de todos os filmes (use REPLACE()).
SELECT titulo, REPLACE(descricao, 'Documentary', 'Documentario') AS descricao_traduzida FROM filmes;
	-- REPLACE(coluna_original, string_a_encontrar, string_de_substituicao)
	-- para cada linha em filmes, pega o valor da coluna descricao
    -- se encontrar a string exata 'Documentary' dentro dessa descrição, ela automaticamente a substitui por 'Documentário'
    -- isso altera a exibição, o original no banco de dados não é alterada


# === 10. Exiba o titulo e o tamanho (em caracteres) do titulo (use CHAR_LENGTH()) dos 5 filmes com os títulos mais longos.
SELECT titulo, char_length(titulo) AS tamanho_titulo FROM filmes ORDER BY tamanho_titulo DESC LIMIT 5;
