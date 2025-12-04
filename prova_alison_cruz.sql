-- Crie a base de dados loja.
CREATE DATABASE loja;

USE loja;

-- Dentro da base criada, crie a tabela produtos.
CREATE TABLE produtos(
id          INT,
nome        VARCHAR(100)    NOT NULL,
preco       DECIMAL(10,2)   NOT NULL,
quantidade  INT             NOT NULL   
);

ALTER TABLE produtos
ADD CONSTRAINT PK_produtos_id PRIMARY KEY (id);
ALTER TABLE produtos
MODIFY COLUMN id INT NOT NULL AUTO_INCREMENT;

-- Insira 3 produtos na tabela.
INSERT INTO produtos (nome, preco, quantidade) VALUES
('Teclado Mecânico RGB', 359.90, 50);

INSERT INTO produtos (nome, preco, quantidade) VALUES
('Mouse Gamer Sem Fio', 129.50, 120);

INSERT INTO produtos (nome, preco, quantidade) VALUES
('Monitor LED 24 polegadas', 980.00, 30);

-- Atualize o preço de um produto específico.
UPDATE produtos SET preco = 400.00 WHERE id = 1;

-- Remova da tabela um produto pelo id.
DELETE FROM produtos WHERE id = 2;

-- Selecione todos os produtos ordenados pelo preço do maior para o menor.
SELECT 
    nome, preco, quantidade
FROM
    produtos
ORDER BY preco DESC;

-- Selecione apenas produtos com preço maior que 100
SELECT 
    nome, preco, quantidade
FROM
    produtos
WHERE
    preco > 100.00;

-- Selecione produtos cujo id esteja entre 2 e 5.
SELECT 
    id, nome, preco, quantidade
FROM
    produtos
WHERE
    id BETWEEN 2 AND 5;

-- Crie a tabela categorias
CREATE TABLE categorias(
id    int,
nome  varchar(50)
);

ALTER TABLE categorias
ADD CONSTRAINT PK_categorias_id PRIMARY KEY(id);
ALTER TABLE categorias
MODIFY COLUMN id INT NOT NULL AUTO_INCREMENT;

-- E depois adicione uma coluna categoriaId em produtos como chave estrangeira
ALTER TABLE produtos
ADD COLUMN categoria_id INT;

ALTER TABLE produtos
ADD CONSTRAINT FK_categoria_id FOREIGN KEY (categoria_id) REFERENCES categorias(id);

INSERT INTO categorias (nome) VALUES
('Hardware'),
('Periféricos'),
('Softwares e Licenças'),
('Eletrônicos');

UPDATE produtos SET categoria_id = 2 WHERE id = 1;
UPDATE produtos SET categoria_id = 2 WHERE id = 3;

/* 
 Faça uma consulta com INNER JOIN mostrando:
• nome do produto
• nome da categoria
*/
SELECT p.nome AS nome_produto, c.nome AS nome_categoria
FROM produtos p
INNER JOIN categorias c ON c.id = p.categoria_id;

-- Faça uma consulta usando LEFT JOIN retornando todos os produtos mesmo sem categoria
SELECT 
    p.nome AS nome_produto, c.nome AS nome_categoria
FROM
    produtos p
        LEFT JOIN
    categorias c ON c.id = p.categoria_id;

-- Crie uma view chamada view_produtos_caros com produtos acima de 100 reais.
CREATE VIEW view_produtos_caros AS
    SELECT 
        p.id AS produto_id,
        p.nome AS nome_produto,
        p.preco AS preco_produto,
        p.quantidade AS quantidade,
        c.nome AS categoria_produto
    FROM
        produtos p
            LEFT JOIN
        categorias c ON c.id = p.categoria_id
    WHERE
        p.preco > 100.00;

-- Exiba a soma total dos preços de todos os produtos
SELECT 
    SUM(preco) AS SOMA_TOTAL
FROM
    produtos;

-- Agrupe os produtos por categoria mostrando a quantidade de produtos em cada categoria.
SELECT 
    c.nome AS nome_categoria,
    COUNT(c.id) AS quantidade_por_categoria
FROM
    produtos p
        INNER JOIN
    categorias c ON c.id = p.categoria_id
GROUP BY c.id , c.nome;

-- Crie as seguintes tabelas normalizadas para um relacionamento N:N entre produtos e pedidos:
-- produtos (id, nome, preco)
ALTER TABLE produtos
DROP COLUMN quantidade;

ALTER TABLE produtos
DROP FOREIGN KEY FK_categoria_id;

ALTER TABLE produtos
DROP COLUMN categoria_id;

-- pedidos (id, dataPedido, cliente)
CREATE TABLE pedidos(
id             INT,
data_pedido    DATE,
cliente        INT
);

ALTER TABLE pedidos
ADD CONSTRAINT PK_pedidos_id PRIMARY KEY(id);
ALTER TABLE pedidos
MODIFY COLUMN id INT NOT NULL AUTO_INCREMENT;

/*
Crie a tabela associativa pedido_produto com:
▪ id
▪ pedidoId (FK)
▪ produtoId (FK)
▪ quantidade
*/
CREATE TABLE pedido_produto(
id          INT,
pedido_id   INT,
produto_id  INT,
quantidade  INT
);

ALTER TABLE pedido_produto
ADD CONSTRAINT PK_pedido_produto PRIMARY KEY(id);
ALTER TABLE pedido_produto
MODIFY COLUMN id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE pedido_produto
ADD CONSTRAINT FK_pedido_produto_pedido_id 
FOREIGN KEY (pedido_id) REFERENCES pedidos(id);

ALTER TABLE pedido_produto
ADD CONSTRAINT FK_pedido_produto_produto_id 
FOREIGN KEY (produto_id) REFERENCES produtos(id);

ALTER TABLE pedido_produto
MODIFY COLUMN pedido_id INT NOT NULL;

ALTER TABLE pedido_produto
MODIFY COLUMN produto_id INT NOT NULL;

INSERT INTO produtos (nome, preco) VALUES
('Processador AMD Ryzen 7', 1899.90),
('Placa Mãe B550', 750.00),
('Fonte ATX 750W 80 Plus Gold', 680.50),
('Headset Gamer USB com LED', 199.99),
('Mousepad XXL Speed', 89.90),
('Licença Microsoft Office 365 Anual', 459.90),
('Antivírus Premium - 1 ano', 129.00),
('Projetor Portátil Full HD', 2500.00),
('Câmera Mirrorless Profissional', 7999.00),
('Smartwatch Série 7', 1350.00);

INSERT INTO pedidos (data_pedido, cliente) VALUES
('2025-12-06', 108), 
('2025-12-06', 109), 
('2025-12-07', 101), 
('2025-12-07', 110), 
('2025-12-08', 111), 
('2025-12-08', 108), 
('2025-12-09', 112), 
('2025-12-09', 113), 
('2025-12-10', 109), 
('2025-12-10', 114); 

/*
Inserir dados no relacionamento N:N Insira registros que representem 
dois pedidos contendo múltiplos produtos, incluindo diferentes quantidades
*/
INSERT INTO pedido_produto (pedido_id, produto_id, quantidade) VALUES
(1, 4, 1),
(1, 1, 1),
(2, 9, 1),
(3, 6, 1),
(4, 5, 4),
(5, 8, 1),
(5, 4, 1),
(6, 13, 1),
(7, 5, 2),
(7, 4, 2),
(8, 10, 1),
(9, 3, 1),
(9, 11, 2),
(10, 7, 5);

-- Consulta N:N – Listar todos os pedidos com seus produtos
SELECT 
    p.id,
    p.data_pedido,
    prod.nome,
    pedprod.quantidade,
    (pedprod.quantidade * preco) AS preco_total
FROM
    pedidos p
        INNER JOIN
    pedido_produto pedprod ON p.id = pedprod.pedido_id
        INNER JOIN
    produtos prod ON prod.id = pedprod.produto_id;

-- Calcular o valor total de cada pedido (agregação + join)
SELECT 
    p.id AS id_pedido,
    SUM((pedprod.quantidade * preco)) AS valor_total
FROM
    pedidos p
        INNER JOIN
    pedido_produto pedprod ON p.id = pedprod.pedido_id
        INNER JOIN
    produtos prod ON prod.id = pedprod.produto_id
GROUP BY p.id
ORDER BY valor_total DESC;

/*
Subconsulta – Listar produtos acima da média de preço
Monte uma consulta que retorne apenas os produtos cujo preço é
maior que a média geral de preços
*/
SELECT 
    id, nome, preco
FROM
    produtos
WHERE
    preco > (SELECT 
            AVG(preco)
        FROM
            produtos);

/*
Subconsulta correlacionada – Produtos mais caros que
qualquer produto de uma categoria específica
Liste todos os produtos cujo preço seja maior que todo preço dos
produtos da tabela categorias onde nome = 'Eletrônicos'.
*/
ALTER TABLE produtos
ADD COLUMN categoria_id INT;

ALTER TABLE produtos
ADD CONSTRAINT FK_categoria_id FOREIGN KEY (categoria_id) REFERENCES categorias(id);

update produtos set categoria_id = 4 WHERE id IN (11,12,13);
update produtos set categoria_id = 1 WHERE id IN (4,5,6);
update produtos set categoria_id = 2 WHERE id IN (1,3,7,8);
update produtos set categoria_id = 3 WHERE id IN (9,10);

SELECT 
    p.nome AS nome_produto_mais_caro, p.preco
FROM
    produtos p
        INNER JOIN
    categorias c ON c.id = p.categoria_id
WHERE
    c.nome = 'Eletrônicos'
        AND p.preco = (SELECT 
            MAX(preco)
        FROM
            produtos p
                INNER JOIN
            categorias c ON c.id = p.categoria_id
        WHERE
            c.nome = 'Eletrônicos');
            
/*
• Criar view avançada com subconsulta
Crie uma view chamada vw_pedidos_resumo exibindo:
• id do pedido
• quantidade total de itens
• valor total
• data do pedido
• média de preço dos produtos do pedido
Utilize agregações e junções.
*/
CREATE VIEW vw_pedidos_resumos AS
    SELECT 
        ped.id AS id_pedido,
        SUM(pedprod.quantidade) AS quantidade_total_itens,
        SUM((pedprod.quantidade * prod.preco)) AS valor_total,
        ped.data_pedido,
        ROUND(AVG(prod.preco), 2) AS media_precos_produtos
    FROM
        pedidos ped
            INNER JOIN
        pedido_produto pedprod ON ped.id = pedprod.pedido_id
            INNER JOIN
        produtos prod ON prod.id = pedprod.produto_id
    GROUP BY ped.id , ped.data_pedido;

SELECT * FROM vw_pedidos_resumos;

-- Encontrar o produto mais vendido. Ordenado do mais vendido para o menos vendido.
SELECT 
    p.id,
    p.nome,
    SUM(pedprod.quantidade) AS quantidade_total_vendida
FROM
    produtos p
        INNER JOIN
    pedido_produto pedprod ON p.id = pedprod.produto_id
GROUP BY p.id , p.nome
ORDER BY quantidade_total_vendida DESC;

-- Relatório mensal – Agrupar pedidos por mês
SELECT 
    YEAR(p.data_pedido) AS ano,
    MONTH(p.data_pedido) AS mes,
    COUNT(*) AS quantidade_pedidos
FROM
    pedidos p
        INNER JOIN
    pedido_produto pedprod ON p.id = pedprod.pedido_id
GROUP BY mes , ano;

/* Cálculo financeiro: Arredondamento e função matemática.
Ordene pelo preço final com imposto.*/
SELECT 
    p.nome,
    p.preco,
    ROUND((p.preco * 0.12) + p.preco, 2) AS preco_acrescido_imposto,
    ROUND(p.preco - (p.preco * 0.5), 2) AS preco_desconto
FROM
    produtos p
ORDER BY preco_acrescido_imposto;

/*
Filtragem com HAVING (condições em agregações) Liste categorias 
que possuem mais de 5 produtos associados na tabela produtos.
*/
INSERT INTO produtos (nome,preco,categoria_id) VALUES
('Smart TV LG 50',4000.00,4),
('Amazon Fire Stick',200.00,4),
('Soundbar JBL',1000.00,4),
('Robô Aspirador WAP',2000.00,4);

SELECT 
    c.nome AS categoria, COUNT(c.id) quantidade_produtos
FROM
    produtos prod
        INNER JOIN
    categorias c ON c.id = prod.categoria_id
GROUP BY c.nome , c.id
HAVING COUNT(c.id) > 5;

/*
Verificar integridade referencial – Encontrar registros órfãos
Encontre produtos que possuem categoriaId preenchido, mas cuja
categoria não existe na tabela categorias.
*/
SELECT 
    prod.nome 
FROM
    produtos prod
        LEFT JOIN
    categorias c ON c.id = prod.categoria_id
    WHERE c.id IS NULL;
    
/*
Criar uma tabela histórica com trigger (conceito prático)
Escreva o comando SQL que cria a tabela:
produtos_historico (id, produtoId, precoAntigo, precoNovo,
dataAlteracao)
E escreva o SQL do trigger que insere na tabela histórica toda vez
que o preço de um produto é atualizado
*/

CREATE TABLE produtos_historico (
id INT,
produto_id INT,
preco_antigo DECIMAL(10,2) NOT NULL,
preco_novo DECIMAL(10,2) NOT NULL,
data_alteracao DATE NOT NULL
);

ALTER TABLE produtos_historico
ADD CONSTRAINT PK_produtos_historico PRIMARY KEY(id);
ALTER TABLE produtos_historico
MODIFY COLUMN id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE produtos_historico
ADD CONSTRAINT FK_produtos_historico_produto_id
FOREIGN KEY (produto_id) REFERENCES produtos(id);

delimiter $$
CREATE TRIGGER trg_log_produtos
BEFORE UPDATE ON produtos
FOR EACH ROW
BEGIN
  IF NEW.preco <> OLD.preco THEN
    INSERT INTO produtos_historico(produto_id, preco_antigo,preco_novo,data_alteracao)
    VALUES(OLD.id,OLD.preco,NEW.preco,NOW());
  END IF;
END $$
delimiter ;

UPDATE produtos 
SET 
    preco = 3000.00
WHERE
    id = 3;

SELECT 
    id, produto_id, preco_antigo, preco_novo, data_alteracao
FROM
    produtos_historico;

/* Consulta com CASE WHEN (categorização de dados)
Mostre:
• nome do produto
• preço
• classificação:
o "BARATO" para preços < 50
o "MÉDIO" para preços entre 50 e 200
o "CARO" para preços > 200 */
SELECT 
    p.nome,
    p.preco,
    CASE
        WHEN p.preco < 50.00 THEN 'BARATO'
        WHEN p.preco <= 200.00 THEN 'MÉDIO'
        ELSE 'CARO'
    END AS classificacao
FROM
    produtos p;

/*
Funções de data – Consultar pedidos dos últimos 7 dias
Retorne todos os pedidos com:
dataPedido >= NOW() - INTERVAL 7 DAY
*/
SELECT 
    ped.id, ped.data_pedido
FROM
    pedidos ped
WHERE
    ped.data_pedido >= NOW() - INTERVAL 7 DAY;

/*
Juntar 3 tabelas + filtros + ordenação complexa
Liste:
• nome do cliente
• id do pedido
• nome do produto
• total (quantidade * preco)
Somente para pedidos feitos no último mês, onde o total do produto
seja maior que 100.
Ordene por cliente, depois por valor decrescente.
*/

CREATE TABLE clientes (
id INT NOT NULL UNIQUE,
nome VARCHAR(100),
cpf CHAR(11) NOT NULL UNIQUE
);

INSERT INTO clientes (id, nome, cpf) VALUES
(108, 'João Silva', '12345678901'),
(109, 'Maria Souza', '23456789012'),
(101, 'Pedro Santos', '34567890123'),
(110, 'Ana Costa', '45678901234'),
(111, 'Rafaela Oliveira', '56789012345'),
(112, 'Lucas Pereira', '67890123456'),
(113, 'Beatriz Almeida', '78901234567'),
(114, 'Guilherme Rocha', '89012345678');

UPDATE pedidos SET data_pedido = '2025-11-09' WHERE id = 8;
UPDATE pedidos SET data_pedido = '2025-11-10' WHERE id = 9;
UPDATE pedidos SET data_pedido = '2025-11-10' WHERE id = 10;

SELECT *
FROM
    pedidos p
        INNER JOIN
    pedido_produto pedprod ON p.id = pedprod.pedido_id
        INNER JOIN
    produtos prod ON prod.id = pedprod.produto_id
        INNER JOIN
	clientes cli ON cli.id = p.cliente
	where month(p.data_pedido) = (month(curdate()) - 1)
    and (prod.preco * pedprod.quantidade) > 100.00; 
    
/*
Subconsulta para encontrar o segundo maior preço
Usando subconsulta (não pode usar LIMIT):
Retorne o produto com o segundo maior preço da tabela
produtos.
*/
SELECT 
    prod.id, prod.nome, prod.preco
FROM
    produtos prod
WHERE
    prod.preco = (SELECT 
            MAX(prod.preco)
        FROM
            produtos prod
        WHERE
            prod.preco < (SELECT 
                    MAX(prodsub.preco)
                FROM
                    produtos prodsub));
/*
Criar tabela normalizada (3FN) a partir de uma tabela
desnormalizada
Dada uma tabela única:
tabela_dados (cliente, cpf, produto, categoria, preco, quantidade)
Crie:
• tabela clientes
• tabela produtos
• tabela categorias
• tabela associativa vendas
Desenhe as chaves primárias e estrangeiras necessárias
*/
DROP TABLE pedido_produto;
DROP TABLE produtos_historico;
DROP TABLE produtos;
DROP TABLE categorias;
DROP TABLE clientes;

CREATE TABLE categorias (
id   INT,
nome VARCHAR(50) NOT NULL UNIQUE
);

ALTER TABLE categorias
ADD CONSTRAINT PK_categorias PRIMARY KEY(id);
ALTER TABLE categorias
MODIFY COLUMN id INT NOT NULL AUTO_INCREMENT;

CREATE TABLE produtos (
id           INT,
nome         VARCHAR(100) NOT NULL,
preco        DECIMAL(10,2) NOT NULL,
categoria_id INT
);

ALTER TABLE produtos
ADD CONSTRAINT PK_produtos PRIMARY KEY(id);
ALTER TABLE produtos
MODIFY COLUMN id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE produtos
ADD CONSTRAINT FK_produtos_categoria_id FOREIGN KEY(categoria_id)
REFERENCES categorias(id);

CREATE TABLE clientes (
id           INT,
nome         VARCHAR(100) NOT NULL,
cpf          CHAR(11) NOT NULL UNIQUE
);

ALTER TABLE clientes
ADD CONSTRAINT PK_clientes PRIMARY KEY(id);
ALTER TABLE clientes
MODIFY COLUMN id INT NOT NULL AUTO_INCREMENT;

CREATE TABLE vendas (
id           INT,
cliente_id   INT,
produto_id   INT,
quantidade   INT NOT NULL
);

ALTER TABLE vendas
ADD CONSTRAINT PK_vendas PRIMARY KEY(id);
ALTER TABLE vendas
MODIFY COLUMN id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE vendas
ADD CONSTRAINT FK_vendas_cliente_id FOREIGN KEY(cliente_id)
REFERENCES clientes(id);

ALTER TABLE vendas
ADD CONSTRAINT FK_vendas_produto_id FOREIGN KEY(produto_id)
REFERENCES vendas(id);