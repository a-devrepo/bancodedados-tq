CREATE DATABASE exercicio01;

USE exercicio01;

CREATE TABLE funcionario (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(11) NOT NULL,
    matricula VARCHAR(10) NOT NULL,
    data_admissao DATE NOT NULL
);

INSERT INTO funcionario (nome, cpf, matricula, data_admissao)
VALUES ('Ana Paula Souza', '12345678901', 'MAT001', '2022-03-15');

INSERT INTO funcionario (nome, cpf, matricula, data_admissao)
VALUES ('Bruno Henrique Lima', '23456789012', 'MAT002', '2025-07-22');

INSERT INTO funcionario (nome, cpf, matricula, data_admissao)
VALUES ('Carla Mendes Oliveira', '34567890123', 'MAT003', '2025-10-10');

INSERT INTO funcionario (nome, cpf, matricula, data_admissao)
VALUES ('Diego Ramos Silva', '45678901234', 'MAT004', '2024-11-05');

INSERT INTO funcionario (nome, cpf, matricula, data_admissao)
VALUES ('Eduarda Castro Nunes', '56789012345', 'MAT005', '2024-06-01');

SELECT nome, cpf, matricula, data_admissao
FROM funcionario
ORDER BY data_admissao DESC;

SELECT nome, cpf, matricula, data_admissao
FROM funcionario
WHERE nome LIKE 'A%';

SELECT nome, cpf, matricula, data_admissao
FROM funcionario
WHERE nome LIKE 'A%' OR nome LIKE 'P%';

SELECT nome, cpf, matricula, data_admissao
FROM funcionario
WHERE data_admissao BETWEEN '2025-01-01' AND '2025-01-31';

SELECT nome, cpf, matricula, data_admissao
FROM funcionario
WHERE matricula LIKE '%1234%';

SELECT nome, cpf, matricula, data_admissao
FROM funcionario
WHERE nome NOT LIKE '%Ana%';

UPDATE funcionario
SET data_admissao = '2023-01-20'
WHERE id = 1;

UPDATE funcionario
SET cpf = '14387450238', matricula = 'MAT010'
WHERE id = 1;

DELETE FROM funcionario
WHERE id = 1;

SELECT id AS id_funcionario,
nome AS nome_funcionario, 
cpf AS cpf_funcionario, 
matricula AS matricula_funcionario, 
data_admissao AS data_de_admissao_funcionario 
FROM funcionario
WHERE data_admissao >= '2025-10-01'