USE sakila_pt;
UNLOCK TABLES;
SET SQL_SAFE_UPDATES = 0; -- desativa safe update
	-- SET SQL_SAFE_UPDATES = 1; -- reativa safe update, deixar abaixo do codigo


		# =========================== #
		# === Atualizar Registros === #
		# =========================== #

# === 1. Atualize o ultimo_nome da ator 'PENELOPE GUINESS' (id 1) para 'PENEZELOPE CRUZ'
SELECT * FROM atores WHERE id_ator = 1;
UPDATE atores SET ultimo_nome = 'CRUZ' WHERE id_ator = 1;


# === 2. Atualize o email da cliente 'MARY SMITH' (id 1) para 'mary.smith.new@email.com'
SELECT * FROM clientes WHERE id_cliente = 1;
UPDATE clientes SET email = 'mary.smith.new@email.com' WHERE id_cliente = 1;


# === 3. Aumente a taxa_aluguel em $1,00 para todos os filmes com classificacao 'R'
SELECT * FROM filmes;
SELECT titulo, taxa_aluguel, classificacao FROM filmes WHERE classificacao = 'R' ORDER BY taxa_aluguel;
UPDATE filmes SET taxa_aluguel = taxa_aluguel + 1 
WHERE classificacao = 'R';


# === 4. Mude o endereco_id do cliente 'JARED ELY' (id 15) para 20.
SELECT * FROM clientes WHERE id_cliente = 15;
UPDATE clientes SET endereco_id = 20 WHERE id_cliente = 15;


# === 5. Atualize a classificacao do filme 'ACE GOLDFINGER' (id 2) para 'PG-13'.
SELECT * FROM filmes WHERE id_filme = 2;
UPDATE filmes SET classificacao = 'PG-13' WHERE id_filme = 2;


# === 6. Atualize o telefone do endereco com id_endereco 10 para '11987654321';
SELECT * FROM enderecos WHERE id_endereco = 10;
UPDATE enderecos SET telefone = 11987654321 WHERE id_endereco = 10;


# === 7. Marque o cliente 'WILLIAM BROWN' (id 16) como ativo = 0.
SELECT * FROM clientes WHERE primeiro_nome = 'WILLIAM';
UPDATE clientes SET ativo = 0 WHERE primeiro_nome = 'WILLIAM';


# === 8. Atualize o funcionario_gerente_id da loja 1 para o funcionario_id 2.
		-- SELECT * FROM lojas;
		-- UPDATE lojas SET funcionario_gerente_id = 2 WHERE id_loja = 1;
# o funcionario_gerente_id e unique, portanto nao da pra repetir nem executar esse codigo


# === 9. Para o aluguel com id_aluguel 100, registre a data_devolucao como a data e hora atuais (use NOW()).
SELECT * FROM alugueis WHERE id_aluguel = 100;
UPDATE alugueis SET data_devolucao = NOW() WHERE id_aluguel = 100;


# === 10. Diminua o custo_reposicao em 10% para todos os filmes lançados (ano_lancamento) antes de 2005.
SELECT * FROM filmes WHERE ano_lancamento < 2005;
UPDATE filmes SET custo_reposicao = custo_reposicao * 0.90 WHERE ano_lancamento < 2005;
# nao tem filmes antes de 2005


SET SQL_SAFE_UPDATES = 1; -- reativa safe update, manter no final