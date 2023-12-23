CREATE DATABASE cronograma;

USE cronograma;

CREATE TABLE aluno (
    id_aluno int not null auto_increment,
    nome varchar(255) not null,
    primary key (id_aluno)
);

INSERT INTO aluno (nome) 
VALUES ('John');

CREATE TABLE tarefa (
    id_tarefa int not null auto_increment,
    descricao text,
    primary key (id_tarefa)
);

ALTER TABLE tarefa
    add column fk_id_aluno int not null;

ALTER TABLE tarefa 
    add foreign key (fk_id_aluno)
    references aluno (id_aluno);

INSERT INTO tarefa (descricao, fk_id_aluno)
VALUES ('Revisar Anotações Anteriores, Leituras Obrigatórias, Resolver Exercícios', 1);

DESCRIBE tarefa;

SELECT a.id_aluno, a.nome, 
t.id_tarefa, t.descricao, t.fk_id_aluno
FROM aluno AS a   
JOIN tarefa AS t  
ON id_aluno = fk_id_aluno;
