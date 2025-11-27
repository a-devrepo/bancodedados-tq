CREATE DATABASE universidade_bd;

USE universidade_bd;

CREATE TABLE alunos 
( 
 id INT,
 nome VARCHAR(100) NOT NULL,  
 data_nascimento DATE NOT NULL,  
 cpf CHAR(11) NOT NULL UNIQUE
);
 
CREATE TABLE armarios 
( 
 id INT,
 aluno_id INT
); 

CREATE TABLE professores 
( 
 id INT,
 nome VARCHAR(100) NOT NULL,  
 cpf CHAR(11) NOT NULL UNIQUE,  
 departamento_id INT
); 

CREATE TABLE escritorios 
( 
 id INT,
 professor_id INT
); 

CREATE TABLE disciplinas 
( 
 id INT,
 nome VARCHAR(100) NOT NULL,  
 professor_id INT, 
 curso_id INT  
); 

CREATE TABLE equipamentos 
( 
 id INT,
 nome VARCHAR(100) NOT NULL,
 tecnico_id INT
); 

CREATE TABLE portateis 
( 
 id INT  NOT NULL
);

CREATE TABLE criticos 
( 
 id INT
);

CREATE TABLE tecnicos 
( 
 id INT,  
 nome VARCHAR(100) NOT NULL,  
 cpf CHAR(11) NOT NULL UNIQUE 
); 

CREATE TABLE turmas 
( 
 id INT,
 disciplina_id INT, 
 curso_id INT  
);  

CREATE TABLE grupos 
( 
 id INT,
 projeto_id INT  
); 

CREATE TABLE projetos 
( 
 id INT,
 nome VARCHAR(50) NOT NULL,
 professor_id INT,  
 grupo_id INT NOT NULL
); 

CREATE TABLE praticas_turmas 
( 
 id INT,
 turma_id INT,  
 equipamento_id INT  
); 

CREATE TABLE matriculas
( 
 aluno_id INT,  
 turma_id INT,  
 data_inscricao DATE NOT NULL,  
 nota_final DOUBLE  
); 

CREATE TABLE aluno_grupos 
( 
 aluno_id INT,  
 grupo_id INT
); 

CREATE TABLE cursos 
( 
 id INT,
 departamento_id INT  
); 

CREATE TABLE departamentos 
( 
 id INT,
 nome VARCHAR(50) NOT NULL  
);

CREATE TABLE livros 
( 
 id INT,
 titulo VARCHAR(100) NOT NULL
); 

CREATE TABLE autores 
( 
 id INT,
 nome VARCHAR(100) NOT NULL
);

CREATE TABLE livros_autores 
( 
 livro_id INT,
 autor_id INT
);

CREATE TABLE emprestimos 
( 
 id INT,
 aluno_id INT,
 livro_id INT,
 data_emprestimo DATE NOT NULL,
 data_previsao_devolucao DATE NOT NULL
);

-- Adicionando PK

ALTER TABLE alunos
ADD CONSTRAINT PK_alunos_id PRIMARY KEY (id);
ALTER TABLE alunos
MODIFY COLUMN id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE armarios
ADD CONSTRAINT PK_armarios_id PRIMARY KEY (id);
ALTER TABLE armarios
MODIFY COLUMN id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE professores
ADD CONSTRAINT PK_professores_id PRIMARY KEY (id);
ALTER TABLE professores
MODIFY COLUMN id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE escritorios
ADD CONSTRAINT PK_escritorios_id PRIMARY KEY (id);
ALTER TABLE escritorios
MODIFY COLUMN id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE disciplinas
ADD CONSTRAINT PK_disciplinas_id PRIMARY KEY (id);
ALTER TABLE disciplinas
MODIFY COLUMN id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE equipamentos
ADD CONSTRAINT PK_equipamentos_id PRIMARY KEY (id);
ALTER TABLE equipamentos
MODIFY COLUMN id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE portateis
MODIFY COLUMN id INT NOT NULL;
ALTER TABLE portateis
ADD CONSTRAINT PK_portateis_id PRIMARY KEY (id);

ALTER TABLE criticos
MODIFY COLUMN id INT NOT NULL;
ALTER TABLE criticos
ADD CONSTRAINT PK_criticos_id PRIMARY KEY (id);

ALTER TABLE tecnicos
ADD CONSTRAINT PK_tecnicos_id PRIMARY KEY (id);
ALTER TABLE tecnicos
MODIFY COLUMN id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE turmas
ADD CONSTRAINT PK_turmas_id PRIMARY KEY (id);
ALTER TABLE turmas
MODIFY COLUMN id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE grupos
ADD CONSTRAINT PK_grupos_id PRIMARY KEY (id);
ALTER TABLE grupos
MODIFY COLUMN id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE cursos
ADD CONSTRAINT PK_cursos_id PRIMARY KEY (id);
ALTER TABLE cursos
MODIFY COLUMN id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE projetos
ADD CONSTRAINT PK_projetos_id PRIMARY KEY (id);
ALTER TABLE projetos
MODIFY COLUMN id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE praticas_turmas
ADD CONSTRAINT PK_praticas_turmas_id PRIMARY KEY (id);
ALTER TABLE praticas_turmas
MODIFY COLUMN id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE departamentos
ADD CONSTRAINT PK_departamentos_id PRIMARY KEY (id);
ALTER TABLE departamentos
MODIFY COLUMN id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE livros
ADD CONSTRAINT PK_livros_id PRIMARY KEY (id);
ALTER TABLE livros
MODIFY COLUMN id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE autores
ADD CONSTRAINT PK_autores_id PRIMARY KEY (id);
ALTER TABLE autores
MODIFY COLUMN id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE livros_autores
ADD CONSTRAINT PK_autores_livrosautores_id PRIMARY KEY (autor_id,livro_id);

ALTER TABLE emprestimos
ADD CONSTRAINT PK_emprestimos_id PRIMARY KEY (id);
ALTER TABLE emprestimos
MODIFY COLUMN id INT NOT NULL AUTO_INCREMENT;

-- Adicionando FK

ALTER TABLE professores
ADD CONSTRAINT  FK_departamento_id FOREIGN KEY (departamento_id) REFERENCES departamentos(id);

ALTER TABLE armarios
ADD CONSTRAINT  FK_aluno_armario_id FOREIGN KEY (aluno_id) REFERENCES alunos(id);

ALTER TABLE escritorios
ADD CONSTRAINT  FK_professor_id FOREIGN KEY (professor_id) REFERENCES professores(id);

ALTER TABLE disciplinas
ADD CONSTRAINT  FK_professor_disciplina_id FOREIGN KEY (professor_id) REFERENCES professores(id),
ADD CONSTRAINT  FK_curso_disciplina_id FOREIGN KEY (curso_id) REFERENCES cursos(id);

ALTER TABLE equipamentos
ADD CONSTRAINT  FK_tecnico_id FOREIGN KEY (tecnico_id) REFERENCES tecnicos(id);

ALTER TABLE portateis
ADD CONSTRAINT  FK_equipamento_portatil_id FOREIGN KEY (id) REFERENCES equipamentos(id);

ALTER TABLE criticos
ADD CONSTRAINT  FK_equipamento_critico_id FOREIGN KEY (id) REFERENCES equipamentos(id);

ALTER TABLE turmas
ADD CONSTRAINT  FK_turma_disciplina_id FOREIGN KEY (disciplina_id) REFERENCES disciplinas(id),
ADD CONSTRAINT  FK_turma_curso_id FOREIGN KEY (curso_id) REFERENCES cursos(id);

ALTER TABLE grupos
ADD CONSTRAINT  FK_grupo_projeto_id FOREIGN KEY (projeto_id) REFERENCES projetos(id);

ALTER TABLE projetos
ADD CONSTRAINT  FK_projeto_professor_id FOREIGN KEY (professor_id) REFERENCES disciplinas(id),
ADD CONSTRAINT  FK_projeto_grupo_id FOREIGN KEY (grupo_id) REFERENCES grupos(id);

ALTER TABLE praticas_turmas
ADD CONSTRAINT  FK_pratica_turma_id FOREIGN KEY (turma_id) REFERENCES turmas(id),
ADD CONSTRAINT  FK_pratica_equipamento_id FOREIGN KEY (equipamento_id) REFERENCES equipamentos(id);

ALTER TABLE matriculas
ADD CONSTRAINT  FK_aluno_matricula_id FOREIGN KEY (aluno_id) REFERENCES alunos(id),
ADD CONSTRAINT  FK_turma_matricula_id FOREIGN KEY (turma_id) REFERENCES turmas(id); 

ALTER TABLE aluno_grupos
ADD CONSTRAINT  FK_aluno_grupos_id FOREIGN KEY (aluno_id) REFERENCES alunos(id),
ADD CONSTRAINT  FK_grupos_aluno_id FOREIGN KEY (grupo_id) REFERENCES grupos(id);

ALTER TABLE aluno_grupos
ADD CONSTRAINT  FK_aluno_grupo_id FOREIGN KEY (aluno_id) REFERENCES alunos(id),
ADD CONSTRAINT  FK_grupo_aluno_id FOREIGN KEY (grupo_id) REFERENCES grupos(id);

ALTER TABLE cursos
ADD CONSTRAINT  FK_departamento_curso_id FOREIGN KEY (departamento_id) REFERENCES departamentos(id);

ALTER TABLE livros_autores
ADD CONSTRAINT  FK_autor_livrosautores_id FOREIGN KEY (autor_id) REFERENCES autores(id),
ADD CONSTRAINT  FK_livro_livrosautores_id FOREIGN KEY (livro_id) REFERENCES livros(id);

ALTER TABLE emprestimos
ADD CONSTRAINT  FK_aluno_emprestimos_id FOREIGN KEY (aluno_id) REFERENCES alunos(id),
ADD CONSTRAINT  FK_livro_emprestimos_id FOREIGN KEY (livro_id) REFERENCES livros(id);

INSERT INTO departamentos (nome) VALUES
('Tecnologia da Informação'),
('Engenharia Civil'),
('Artes e Humanidades');

INSERT INTO tecnicos (nome, cpf) VALUES
('Pedro Rocha', '12345678901'), 
('Julia Mendes', '98765432109');

INSERT INTO professores (nome, cpf, departamento_id) VALUES
('Ana Silva', '11122233344', 1), 
('João Costa', '55566677788', 1),  
('Helena Lima', '99900011122', 2);  

INSERT INTO alunos (nome, data_nascimento, cpf) VALUES
('Maria Oliveira', '2000-05-15', '11111111111'), 
('Carlos Souza', '1999-10-20', '22222222222'),  
('Felipe Santos', '2001-01-01', '33333333333'); 

INSERT INTO cursos (departamento_id) VALUES
(1), 
(2); 

INSERT INTO escritorios (professor_id) VALUES
(1), 
(2); 

INSERT INTO disciplinas (nome, professor_id, curso_id) VALUES
('Redes II', 2, 1),      
('Banco de Dados', 1, 1), 
('Projeto de Estruturas', 3, 2); 

INSERT INTO turmas (disciplina_id, curso_id) VALUES
(1, 1), 
(2, 1); 

INSERT INTO equipamentos (nome, tecnico_id) VALUES
('Servidor SVR-01', 1),   
('Kit de Redes Cisco', 2), 
('Computador Portátil A', 1);

INSERT INTO portateis (id) VALUES
(3);

INSERT INTO criticos (id) VALUES
(1);

INSERT INTO armarios (id, aluno_id) VALUES
(42, 1), 
(10, 2);

INSERT INTO matriculas (aluno_id, turma_id, data_inscricao, nota_final) VALUES
(1, 1, '2024-02-01', 9.5), 
(1, 2, '2024-02-01', 7.8), 
(2, 1, '2024-02-01', 6.0); 

INSERT INTO praticas_turmas (turma_id, equipamento_id) VALUES
(1, 2);

INSERT INTO autores (nome) VALUES
('Ana Silva'), 
('Jorge Amado'), 
('Stephen King'); 

INSERT INTO livros (titulo) VALUES
('Banco de Dados Relacional'), 
('O Processo'),               
('A Coisa');                  

INSERT INTO livros_autores (livro_id, autor_id) VALUES
(1, 1),
(2, 2),
(3, 3);

INSERT INTO emprestimos (aluno_id, livro_id, data_emprestimo, data_previsao_devolucao) VALUES
(1, 1, '2025-11-15', '2025-12-15'), 
(2, 3, '2025-11-10', '2025-12-10'); 

-- Consultas

-- Quem ocupa o armário número 42
SELECT
	ar.id AS armario,
    a.nome AS aluno_responsavel
FROM
    alunos a
JOIN 
    armarios ar ON a.id = ar.aluno_id
WHERE
    ar.id = 42;

-- Quais matérias a aluna Maria Oliveira cursou e quais notas obteve
SELECT
    d.nome AS disciplina,
    m.nota_final AS nota_final
FROM
    alunos al
JOIN
    matriculas m ON al.id = m.aluno_id
JOIN
    turmas t ON m.turma_id = t.id
JOIN
    disciplinas d ON t.disciplina_id = d.id
WHERE
    al.nome = 'Maria Oliveira';
    
-- Quais livros foram escritos por Ana Silva
SELECT
    l.titulo AS livro_escrito
FROM
    autores a
JOIN
    livros_autores la ON a.id = la.autor_id
JOIN
    livros l ON la.livro_id = l.id
WHERE
    a.nome = 'Ana Silva';
    
-- Quais equipamentos a turma de REDES II usou nas práticas
SELECT 
d.nome as turma,
e.nome as equipamento_usado
FROM disciplinas d
INNER JOIN turmas t ON t.disciplina_id = d.id
INNER JOIN praticas_turmas pt ON t.id = pt.turma_id
INNER JOIN equipamentos e ON e.id = pt.equipamento_id
WHERE d.nome = 'REDES II';

-- Qual técnico é responsável pelo servidor SVR-01
SELECT 
e.nome AS equipamento,
t.nome AS tecnico_responsavel
FROM equipamentos e
INNER JOIN tecnicos t ON e.tecnico_id = t.id
WHERE e.nome = 'Servidor SVR-01';
