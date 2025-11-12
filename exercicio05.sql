CREATE DATABASE exercicio05;

USE exercicio05;

CREATE TABLE medicos (
id  INT  AUTO_INCREMENT PRIMARY KEY,
nome  VARCHAR(100)  NOT NULL,
crm  VARCHAR(10) NOT NULL
);

CREATE TABLE pacientes (
id  INT  AUTO_INCREMENT PRIMARY KEY,
nome  VARCHAR(100)  NOT NULL,
data_nascimento  DATE NOT NULL,
sexo  CHAR(1) NOT NULL,
cpf  CHAR(11) NOT NULL
);

CREATE TABLE consultas (
id  INT,
medico_id INT NOT NULL,
paciente_id INT NOT NULL,
data  DATE NOT NULL,
local VARCHAR(100)  NOT NULL,
laudo TEXT NOT NULL,
valor DOUBLE NOT NULL,
PRIMARY KEY(id, medico_id,paciente_id),
FOREIGN KEY(medico_id) REFERENCES medicos(id),
FOREIGN KEY(paciente_id) REFERENCES pacientes(id)
);

INSERT INTO medicos (nome, crm) VALUES
('Dr. Ana Souza', '12345/SP'),
('Dr. Bruno Costa', '67890/RJ'),
('Dr. Carla Ferreira', '11223/MG'),
('Dr. Daniel Gomes', '44556/PR'),
('Dr. Elisa Santos', '77889/SC'),
('Dr. Fábio Almeida', '99001/BA'),
('Dr. Gabriela Lima', '22334/DF'),
('Dr. Hugo Pereira', '55667/PE'),
('Dr. Isabela Rocha', '88990/RS'),
('Dr. Jorge Mendes', '33445/GO');

INSERT INTO pacientes (nome, data_nascimento, sexo, cpf) VALUES
('João Silva', '1990-05-15', 'M', '11122233301'),
('Maria Oliveira', '1985-11-20', 'F', '22233344402'),
('Pedro Dantas', '2001-03-01', 'M', '33344455503'),
('Camila Nunes', '1978-07-25', 'F', '44455566604'),
('Lucas Vieira', '1995-01-10', 'M', '55566677705'),
('Juliana Melo', '1982-09-30', 'F', '66677788806'),
('Rafael Barros', '2005-04-12', 'M', '77788899907'),
('Sofia Ribeiro', '1965-02-08', 'F', '88899900008'),
('Guilherme Pires', '1999-06-06', 'M', '99900011109'),
('Larissa Motta', '1970-12-18', 'F', '00011122210');

INSERT INTO consultas (id, medico_id, paciente_id, data, local, laudo, valor) VALUES
(1, 1, 1, '2025-10-01', 'Hospital Central - Sala 101', 'Check-up completo. Exames de alta complexidade solicitados.', 750.00),
(5, 5, 2, '2025-10-05', 'Clínica Especializada - Ala B', 'Procedimento cirúrgico menor realizado com sucesso.', 1200.00),
(10, 10, 3, '2025-10-10', 'Consultório Privado - Setor A', 'Avaliação psiquiátrica inicial e plano de tratamento.', 550.00),
(15, 2, 4, '2025-10-15', 'Unidade de Cardiologia - Sala 3', 'Teste ergométrico e acompanhamento de arritmia complexa.', 820.00),
(20, 7, 5, '2025-10-20', 'Centro Dermatológico - Sala 5', 'Biópsia e remoção de lesão de pele suspeita.', 950.00),
(2, 2, 6, '2025-10-02', 'Clínica Geral - Box 2', 'Consulta de rotina, prescrição de vitaminas.', 180.00),
(3, 3, 7, '2025-10-03', 'Ambulatório - Sala 4', 'Retorno de exames laboratoriais, tudo normal.', 220.00),
(4, 4, 8, '2025-10-04', 'Posto de Saúde - Sala 1', 'Vacinação e orientações gerais.', 150.00),
(6, 6, 9, '2025-10-06', 'Hospital Central - Sala 102', 'Queixa de dor de cabeça, diagnóstico de enxaqueca.', 300.00),
(7, 7, 10, '2025-10-07', 'Clínica Especializada - Ala C', 'Sintomas gripais, tratamento medicamentoso.', 190.00),
(8, 8, 1, '2025-10-08', 'Consultório Privado - Setor B', 'Consulta pediátrica de rotina (criança).', 250.00),
(9, 9, 2, '2025-10-09', 'Unidade de Cardiologia - Sala 1', 'Reavaliação de pressão arterial, ajustes na medicação.', 280.00),
(11, 1, 4, '2025-10-11', 'Hospital Central - Sala 101', 'Controle de diabetes, novos exames solicitados.', 320.00),
(12, 3, 5, '2025-10-12', 'Clínica Geral - Box 3', 'Lesão no joelho, encaminhamento para fisioterapia.', 210.00),
(13, 5, 6, '2025-10-13', 'Ambulatório - Sala 4', 'Consulta oftalmológica, mudança de grau dos óculos.', 350.00),
(14, 8, 7, '2025-10-14', 'Posto de Saúde - Sala 2', 'Exame de rotina ginecológico.', 230.00),
(16, 4, 9, '2025-10-16', 'Hospital Central - Sala 103', 'Dor abdominal, solicitada ultrassonografia.', 400.00),
(17, 6, 10, '2025-10-17', 'Clínica Especializada - Ala D', 'Avaliação nutricional e plano alimentar.', 170.00),
(18, 9, 8, '2025-10-18', 'Consultório Privado - Setor C', 'Revisão odontológica e limpeza.', 200.00),
(19, 10, 3, '2025-10-19', 'Unidade de Cardiologia - Sala 2', 'Eletrocardiograma de controle.', 290.00);

-- Listar todos os pacientes e suas respectivas consultas
SELECT 
    p.nome AS paciente, 
    c.data, 
    c.local, 
    c.valor
FROM
    pacientes p
        INNER JOIN
    consultas c ON c.paciente_id = p.id;

-- Listar todos os médicos e suas respectivas consultas
SELECT 
    m.nome AS medico, 
    c.data, 
    c.local, 
    c.valor
FROM
    medicos m
        INNER JOIN
    consultas c ON c.medico_id = m.id;

-- Listar quantidade de consultas realizadas por cada paciente
SELECT 
    p.nome AS paciente, 
    COUNT(c.id) quantidade_de_consultas
FROM
    pacientes p
        INNER JOIN
    consultas c ON c.paciente_id = p.id
GROUP BY p.id , p.nome;

-- Listar quantidade de consultas realizadas por cada médico
SELECT 
    m.nome AS medico, 
    COUNT(c.id) quantidade_de_consultas
FROM
    medicos m
        INNER JOIN
    consultas c ON c.medico_id = m.id
GROUP BY m.id , m.nome;

/*
Criar uma view que exiba os campos:
Id da consulta
Nome do paciente (caixa alta)
Nome do médico (caixa alta)
Sexo por extenso (M – Masculino e F – Feminino)
CPF
Data da consulta no formato dia/mês/ano
Resumo:
  Nome do paciente – Laudo
*/
CREATE VIEW vw_dados_consultas AS
    SELECT 
        c.id AS id_consulta,
        UPPER(p.nome) AS paciente,
        IF(p.sexo = 'F',
			'Feminino',
            'Masculino') AS sexo,
        p.cpf AS CPF,
        UPPER(m.nome) AS medico,
        DATE_FORMAT(c.data, '%d/%m/%Y') AS data,
        CONCAT(p.nome, ' - ', c.laudo) AS resumo
    FROM
        pacientes p
            INNER JOIN
        consultas c ON c.paciente_id = p.id
            INNER JOIN
        medicos m ON m.id = c.medico_id;

-- Listar as consultas realizadas com valor acima de 500 reais
SELECT 
    c.id,
    c.paciente_id,
    c.medico_id,
    c.local,
    c.data,
    c.laudo,
    c.valor
FROM
    consultas c
WHERE
    c.valor > 500.0;

-- Listar as consultas realizadas com valor acima da media de consultas
SELECT 
    c.id,
    c.paciente_id,
    c.medico_id,
    c.local,
    c.data,
    c.laudo,
    c.valor
FROM
    consultas c
WHERE
    c.valor > (SELECT 
            AVG(valor)
        FROM
            consultas);

-- Somatório do valor das consultas por médico
SELECT 
    m.nome AS medico, 
    CONCAT('R$',SUM(c.valor)) AS somatório_valor_consultas
FROM
    medicos m
        INNER JOIN
    consultas c ON c.medico_id = m.id
GROUP BY m.id , m.nome;
            
-- Somatório do valor das consultas por paciente
SELECT 
    p.nome AS paciente, 
    CONCAT('R$',SUM(c.valor)) AS somatorio_valor_consultas
FROM
    pacientes p
        INNER JOIN
    consultas c ON c.paciente_id = p.id
GROUP BY p.id , p.nome;

/*
O somatório do valor das consultas por Medico onde:
Se o valor da consulta é maior do que a media então
exiba “Valor maior que a media” senão exiba “Valor
menor que a média
*/
SELECT 
    m.nome AS medico,
    CONCAT('R$', SUM(c.valor)) AS somatorio_valor_consultas,
    CASE
        WHEN
            (SUM(c.valor)) > (SELECT AVG(valor) FROM consultas)
        THEN
            'Valor maior que a média'
        ELSE 'Valor menor que a média'
    END AS classificacao
FROM
    medicos m
        INNER JOIN
    consultas c ON c.medico_id = m.id
GROUP BY m.id , m.nome