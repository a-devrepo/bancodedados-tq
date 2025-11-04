CREATE DATABASE bd_oficina;

USE bd_oficina;

CREATE TABLE clientes
  (
     id       INT AUTO_INCREMENT PRIMARY KEY,
     nome     VARCHAR(100) NOT NULL,
     cpf      VARCHAR(11) NOT NULL,
     telefone VARCHAR(11) NOT NULL
  );

CREATE TABLE veiculos
  (
     id         INT AUTO_INCREMENT PRIMARY KEY,
     modelo     VARCHAR(50) NOT NULL,
     fabricante VARCHAR(50) NOT NULL,
     ano        INT NOT NULL,
     placa      VARCHAR(7) NOT NULL,
     cor        VARCHAR(10) NOT NULL,
     cliente_id INT NOT NULL,
     FOREIGN KEY (cliente_id) REFERENCES clientes (id)
  ); 

CREATE TABLE mecanicos(
	id         INT AUTO_INCREMENT PRIMARY KEY,
    nome 		VARCHAR(100)	NOT NULL
);

CREATE TABLE servicos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    responsavel_id INT NOT NULL,
    FOREIGN KEY (responsavel_id)
        REFERENCES mecanicos (id)
);

CREATE TABLE execucao_servico(
id         INT AUTO_INCREMENT PRIMARY KEY,
data_servico DATE NOT NULL,
preco		DECIMAL(10,2) NOT NULL,
descricao VARCHAR(100),
veiculo_id	INT NOT NULL,
servico_id	INT NOT NULL,
FOREIGN KEY (veiculo_id) REFERENCES veiculos(id), 
FOREIGN KEY (servico_id) REFERENCES servicos(id)
);

INSERT INTO clientes (nome, cpf, telefone) VALUES 
('Maria Silva', '12345678901', '11987654321'),
('João Souza', '98765432109', '21998877665'),
('Pedro Soares', '19034576387', '21989437418');

INSERT INTO veiculos (modelo, fabricante, ano, placa, cor, cliente_id) VALUES 
('Fiesta', 'Ford', 2018, 'ABC1234', 'Preto', 1),
('Corolla', 'Toyota', 2022, 'XYZ5678', 'Prata', 1);
INSERT INTO veiculos (modelo, fabricante, ano, placa, cor, cliente_id) VALUES 
('Gol', 'Volkswagen', 2015, 'DEF9012', 'Vermelho', 2);
INSERT INTO veiculos (modelo, fabricante, ano, placa, cor, cliente_id) VALUES 
('Cronos', 'Fiat', 220, 'KRT6302', 'Preto', 3);

INSERT INTO mecanicos (nome) VALUES 
('João Santos'),
('Pedro Alves'),
('José Silva');

INSERT INTO servicos (nome, responsavel_id) VALUES 
('Troca de Óleo', 1), 
('Revisão Geral', 2),
('Alinhamento e Balanceamento', 3);

INSERT INTO execucao_servico (data_servico, preco, descricao, veiculo_id, servico_id) VALUES 
('2025-10-20', 150.00, 'Troca de óleo e filtro', 1, 1);

INSERT INTO execucao_servico (data_servico, preco, descricao, veiculo_id, servico_id) VALUES 
('2025-10-25', 550.00, 'Verificação completa do motor e freios', 3, 2);

INSERT INTO execucao_servico (data_servico, preco, descricao, veiculo_id, servico_id) VALUES 
('2025-10-27', 120.00, 'Alinhamento e balanceamento das 4 rodas', 2, 3);

-- Veículos com nome do cliene dono
SELECT v.modelo, v.fabricante ,c.nome AS nome_cliente
FROM veiculos v
INNER JOIN clientes c
ON v.cliente_id = c.id;

-- Liste todos os serviços realizados, mostrando o veículo, o cliente e o mecânico responsável
SELECT v.modelo AS modelo_veiculo, c.nome AS cliente, m.nome AS mecanico_responsavel
FROM execucao_servico es
INNER JOIN veiculos v
ON es.veiculo_id = v.id
INNER JOIN clientes c
ON v.cliente_id = c.id
INNER JOIN servicos s
ON s.id = es.servico_id
INNER JOIN mecanicos m
ON s.responsavel_id = m.id;

-- Liste os serviços realizados por um mecânico específico (por exemplo, "Carlos")
SELECT s.nome, es.descricao
FROM execucao_servico es
INNER JOIN servicos s
ON es.servico_id = s.id
INNER JOIN mecanicos m
ON s.responsavel_id = m.id
WHERE m.nome = 'José Silva';

-- Mostre todos os veículos que já realizaram serviços acima de R$500,00
SELECT v.modelo, v.fabricante, v.cor, v.placa, v.ano 
FROM execucao_servico es
INNER JOIN veiculos v
ON es.veiculo_id = v.id
WHERE es.preco > 500.0;

-- Crie uma VIEW chamada vw_servicos_realizados
CREATE VIEW vw_servicos_realizados
AS
SELECT 
c.nome AS nome_cliente, 
v.modelo AS modelo_veiculo, 
es.descricao AS descricao_servico, 
m.nome AS mecanico_responsavel,
es.preco AS valor,
es.data_servico AS data_do_servico
FROM execucao_servico es
INNER JOIN veiculos v
ON es.veiculo_id = v.id
INNER JOIN clientes c
ON v.cliente_id = c.id
INNER JOIN servicos s
ON s.id = es.servico_id
INNER JOIN mecanicos m
ON s.responsavel_id = m.id;

-- Faça uma consulta na view retornando apenas os serviços realizados por “João” (cliente)
-- ordenados pela data do serviço
SELECT
nome_cliente,
modelo_veiculo,
descricao_servico,
mecanico_responsavel,
valor,
data_do_servico   
FROM vw_servicos_realizados
WHERE nome_cliente like 'João%'