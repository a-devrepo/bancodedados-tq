CREATE DATABASE exercicio03;

USE exercicio03;

CREATE TABLE atores(
id  INT  AUTO_INCREMENT PRIMARY KEY,
nome  VARCHAR(100)  NOT NULL,
sexo  CHAR(10)
);

CREATE TABLE filmes(
id  INT  AUTO_INCREMENT PRIMARY KEY,
titulo  VARCHAR(100) NOT NULL,
genero  VARCHAR(20) NOT NULL,
sinopse VARCHAR(200) NOT NULL
);

CREATE TABLE filmes_atores(
ator_id INT NOT NULL,
filme_id INT NOT NULL,
personagem VARCHAR(100) NOT NULL,
PRIMARY KEY(ator_id,filme_id),
FOREIGN KEY(ator_id) REFERENCES atores(id),
FOREIGN KEY(filme_id) REFERENCES filmes(id)
);


INSERT INTO atores (nome, sexo) VALUES
('Ana Paula Arósio', 'Feminino'),
('Wagner Moura', 'Masculino'),
('Fernanda Montenegro', 'Feminino'),
('Lázaro Ramos', 'Masculino'),
('Sônia Braga', 'Feminino'),
('Rodrigo Santoro', 'Masculino'),
('Alice Braga', 'Feminino'),
('Selton Mello', 'Masculino'),
('Cléo Pires', 'Feminino'),
('Gabriel Leone', 'Masculino');

INSERT INTO filmes (titulo, genero, sinopse) VALUES
('Central do Brasil', 'Drama', 'Uma ex-professora escreve cartas para analfabetos na estação Central do Brasil, no Rio de Janeiro, e acompanha um menino em busca de seu pai.'),
('Tropa de Elite', 'Ação', 'Um capitão do BOPE é encarregado de treinar o substituto para sua saída e combater o crime nas favelas do Rio de Janeiro.'),
('Cidade de Deus', 'Crime', 'A vida de dois amigos que crescem em uma violenta favela do Rio de Janeiro, um buscando ser fotógrafo e o outro se envolvendo com o crime.'),
('O Auto da Compadecida', 'Comédia', 'As aventuras de João Grilo e Chicó, dois nordestinos pobres que vivem de trapaças, enfrentando o diabo, cangaceiros e figuras religiosas.'),
('Aquarius', 'Drama', 'Uma crítica de música viúva se recusa a vender seu apartamento para uma construtora que planeja erguer um novo prédio no local.'),
('Carandiru', 'Drama', 'Baseado em fatos reais, relata a rotina do maior presídio da América Latina antes do famoso massacre.'),
('Dom', 'Drama/Crime', 'A história real de um rapaz de classe média que se torna um dos criminosos mais procurados do Rio de Janeiro.'),
('Lisbela e o Prisioneiro', 'Romance/Comédia', 'Um matador de aluguel se apaixona por uma moça que sonha em ter um amor de cinema.'),
('O Cheiro do Ralo', 'Comédia Dramática', 'Um homem é dono de uma loja que compra objetos usados e desenvolve uma filosofia cínica sobre a humanidade.'),
('Bingo: O Rei das Manhãs', 'Biografia/Drama', 'A história de Arlindo Barreto, que interpretou o palhaço Bozo e enfrentou problemas pessoais com drogas e fama.');


INSERT INTO filmes_atores (ator_id, filme_id, personagem) VALUES
(3, 1, 'Dora'),                 
(2, 2, 'Capitão Nascimento'),   
(4, 3, 'Dadinho/Zelito'),       
(8, 4, 'Chicó'),                
(5, 5, 'Clara'),                
(6, 6, 'Deusdete'),             
(10, 7, 'Pedro Machado (Dom)'), 
(8, 8, 'Leléu'),                
(2, 9, 'Lourenço'),             
(6, 10, 'Bingo');

# Liste todos os filmes por ordem alfabética de gênero
SELECT id, titulo, genero, sinopse
FROM filmes
ORDER BY genero ASC;

# Liste todos os filmes com gênero Ação ou Romance
SELECT id, titulo, genero, sinopse
FROM filmes
WHERE genero LIKE '%romance%' OR genero LIKE '%ação%' ;

# Liste todos os atores do sexo masculino
SELECT id, nome, sexo
FROM atores
WHERE sexo = 'Masculino';

# Liste todos os atores do sexo feminino
SELECT id, nome, sexo
FROM atores
WHERE sexo = 'Feminino';

# Liste os atores, os filmes que eles fizeram e o personagem que fizeram em cada filme
SELECT a.nome, f.titulo, f.genero, fa.personagem
FROM atores a
INNER JOIN filmes_atores fa ON a.id =  fa.ator_id
INNER JOIN filmes f ON f.id =  fa.filme_id;

# Crie uma Visão da consulta anterior
CREATE VIEW vw_filmes_atores
AS
SELECT a.nome AS nome_ator, 
f.titulo AS nome_filme,
f.genero AS genero_filme, 
fa.personagem
FROM atores a
INNER JOIN filmes_atores fa ON a.id =  fa.ator_id
INNER JOIN filmes f ON f.id =  fa.filme_id;



             