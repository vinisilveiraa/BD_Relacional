USE sakila_pt;
UNLOCK TABLES;
SET SQL_SAFE_UPDATES = 0; -- desativa safe update
	-- SET SQL_SAFE_UPDATES = 1; -- reativa safe update, deixar abaixo do codigo

		# =========================== #
		# ==== Deletar Registros ==== #
		# =========================== #
# Nota: Alguns podem falhar por integridade referencial se não forem removidos na ordem correta

# === 1. Delete o ator 'CARLOS GOMES' (inserido no exercício 1.1).
DELETE FROM filmes_atores
WHERE ator_id = (
	SELECT id_ator FROM atores
    WHERE primeiro_nome = 'Carlos'
      AND ultimo_nome = 'GOMES'
);

DELETE FROM atores WHERE primeiro_nome = 'CARLOS' AND ultimo_nome = 'GOMES';
SELECT * FROM atores WHERE primeiro_nome = 'CARLOS' AND ultimo_nome = 'GOMES';


# === 2. Delete a categoria 'Brasileiro' (inserida no 1.2).
SELECT * FROM categorias;

DELETE FROM filmes_categorias 
	WHERE categoria_id = (
		SELECT id_categoria FROM categorias WHERE nome = 'Brasileiro'
	);
DELETE FROM categorias WHERE nome = 'Brasileiro';


# === 3. Delete o idioma 'Português' (inserido no 1.3).
SELECT * FROM idiomas;
DELETE FROM idiomas WHERE nome = 'Portugues';


# === 4. Delete o pagamento com id_pagamento 5.
SELECT * FROM pagamentos;
DELETE FROM pagamentos WHERE id_pagamento = 5;

# === 5. Delete a associação (filmes_atores) entre o filme_id 1 e o ator_id 10.
SELECT * FROM filmes_atores ORDER BY filme_id;
DELETE FROM filmes_atores
	WHERE filme_id = 1 AND ator_id = 10;


# === 6. Delete o cliente 'JOANA SILVA' (inserido no 1.7), assumindo que ele não possui aluguéis.
SELECT * FROM clientes;
DELETE FROM clientes WHERE primeiro_nome = 'JOANA' AND ultimo_nome = 'SILVA';


# === 7. Delete o endereco 'Rua Copacabana, 10' (inserido no 1.6), assumindo que não está mais em uso.
SELECT * FROM enderecos WHERE logradouro = 'Rua Copacabana, 10';
DELETE FROM enderecos WHERE logradouro = 'Rua Copacabana, 10';


# === 8. Delete o aluguel com id_aluguel 15.
SELECT * FROM alugueis WHERE id_aluguel = 15;
DELETE FROM alugueis WHERE id_aluguel = 15;


# === 9. Delete o filme 'TÍTULO NOVO' (inserido no 1.8), assumindo que foi removido das tabelas de associação.
DESCRIBE filmes;
SELECT id_filme FROM filmes
	WHERE titulo = 'TÍTULO NOVO';

DELETE FROM filmes WHERE id_filme = 1001;


# === 10. Delete a cidade 'Rio de Janeiro' (inserida no 1.5), assumindo que nenhum endereço a utiliza.
DELETE FROM cidades WHERE cidade = 'Rio de Janeiro';
SELECT * FROM cidades WHERE cidade = 'Rio de Janeiro';




SET SQL_SAFE_UPDATES = 1; -- reativa safe update, deixar abaixo do codigo

