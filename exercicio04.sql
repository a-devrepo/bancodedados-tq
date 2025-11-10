CREATE database exercicio04;
USE exercicio04;

CREATE TABLE vendedores(
id  INT  AUTO_INCREMENT PRIMARY KEY,
nome  VARCHAR(100)  NOT NULL,
cidade VARCHAR(50) NOT NULL,
salario DECIMAL(10,2) NOT NULL
);

CREATE TABLE produtos(
id  INT  AUTO_INCREMENT PRIMARY KEY,
nome  VARCHAR(100)  NOT NULL,
preco DECIMAL(10,2) NOT NULL,
categoria  varchar(50) NOT NULL
);

CREATE TABLE vendas(
id  INT  AUTO_INCREMENT PRIMARY KEY,
data_venda  DATE NOT NULL,
quantidade INT NOT NULL,
vendedor_id INT NOT NULL,
produto_id INT NOT NULL,
foreign key(vendedor_id) REFERENCES vendedores(id),
foreign key(produto_id) REFERENCES produtos(id)
);

INSERT INTO vendedores (nome, cidade, salario) VALUES
('Ana Silva', 'São Paulo', 3500.00),
('Bruno Santos', 'Rio de Janeiro', 4200.50),
('Carla Oliveira', 'Belo Horizonte', 3100.00),
('Daniel Costa', 'Curitiba', 4500.75),
('Elaine Pereira', 'Porto Alegre', 3800.00);

INSERT INTO produtos (nome, preco, categoria) VALUES
('Laptop Gamer X', 5800.00, 'Eletrônicos'),
('Smartphone Pro Z', 2999.99, 'Eletrônicos'),
('Mouse Sem Fio Ultra', 150.50, 'Acessórios'),
('Monitor Curvo 27"', 1850.00, 'Eletrônicos'),
('Teclado Mecânico RGB', 320.90, 'Acessórios');

INSERT INTO vendas (data_venda, quantidade, vendedor_id, produto_id) VALUES
('2025-05-15', 1, 1, 1),    -- Maio: Laptop
('2025-06-05', 2, 2, 3),    -- Junho: Mouse
('2025-07-20', 3, 3, 5),    -- Julho: Halteres
('2025-08-10', 1, 4, 2),    -- Agosto: Smart TV
('2025-08-28', 5, 5, 4),    -- Agosto: Cadeira (Quantidade alta)
('2025-09-01', 2, 1, 3),    -- Setembro: Mouse
('2025-09-25', 1, 2, 1),    -- Setembro: Laptop
('2025-10-18', 4, 3, 4),    -- Outubro: Cadeira (Quantidade 4)
('2025-11-05', 1, 4, 5),    -- Novembro: Halteres
('2025-11-10', 1, 5, 2);    -- Novembro (Hoje): Smart TV

-- Total de vendas por vendedor 
SELECT v.nome,
COUNT(v.id) AS total_vendas
FROM vendedores v
INNER JOIN vendas vd ON v.id = vd.vendedor_id
INNER JOIN produtos p ON p.id = vd.produto_id
GROUP BY v.id;


-- Total de vendas por categoria de produto 
SELECT p.categoria,
COUNT(vd.id) AS total_vendas
FROM vendas vd 
INNER JOIN produtos p ON p.id = vd.produto_id
GROUP BY p.categoria;

-- Média de vendas por mês
SELECT MONTH(vd.data_venda) AS mes_venda,
ROUND(AVG(p.preco * vd.quantidade),2) AS media_vendas
FROM vendas vd
INNER JOIN produtos p ON p.id = vd.produto_id 
GROUP BY MONTH(vd.data_venda);

-- Faça uma consulta quer classifique o desempenho dos vendedores
SELECT v.nome,
SUM(p.preco * vd.quantidade) as valor_total_vendas,
CASE
  WHEN SUM(p.preco * vd.quantidade) < 5000.0 THEN 'REGULAR'
  WHEN SUM(p.preco * vd.quantidade) < 10000.0 THEN 'BOM'
  WHEN SUM(p.preco * vd.quantidade) >= 10000.0 THEN 'EXCELENTE'
END AS desempenho
FROM vendedores v
INNER JOIN vendas vd ON v.id = vd.vendedor_id
INNER JOIN produtos p ON p.id = vd.produto_id
GROUP BY v.id, v.nome;
