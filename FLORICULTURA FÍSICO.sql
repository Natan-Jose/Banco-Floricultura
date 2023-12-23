CREATE DATABASE floricultura;

USE floricultura;

CREATE TABLE cliente (
    rg_cliente varchar(10) not null unique,
    nome varchar(255) not null,
    primary key (rg_cliente)
);

INSERT INTO cliente 
(rg_cliente, nome)
VALUES 
('31.263.389', 'Jonas'), 
('22.975.233', 'Gel'),
('26.945.080', 'Thomas'),
('14.172.875', 'Laura'), 
('15.306.485', 'Carlos'),
('42.767.229', 'Isabel');

CREATE TABLE endereco (
    id_endereco int not null auto_increment,
    rua varchar(255),
    numero varchar(255),
    bairro varchar(255),
    cidade varchar(255),
    sigla_estado varchar(2),
    pais varchar(255),
    primary key (id_endereco)
);

ALTER TABLE endereco 
    add column fk_rg_cliente varchar(10) not null;

ALTER TABLE endereco 
    add foreign key (fk_rg_cliente) 
    references cliente (rg_cliente);

INSERT INTO endereco 
(rua, numero, bairro, cidade, sigla_estado, pais, fk_rg_cliente)
VALUES 
('Avenida Principal', '123', 'Centro', 'São Paulo', 'SP', 'Brasil', '31.263.389'),
('Rua das Flores', '456', 'Jardins', 'Rio de Janeiro', 'RJ', 'Brasil', '22.975.233'),
('Rua da Liberdade', '789', 'Barra', 'Porto Alegre', 'RS', 'Brasil', '26.945.080'),
('Avenida das Rosas', '567', 'Jardim', 'Belo Horizonte', 'MG', 'Brasil', '14.172.875'),  
('Rua dos Pinheiros', '789', 'Vila Nova', 'Curitiba', 'PR', 'Brasil', '15.306.485'),  
('Avenida dos Eucaliptos', '123', 'Centro', 'Fortaleza', 'CE', 'Brasil', '42.767.229');  

CREATE TABLE telefone ( 
id_telefone int not null auto_increment,
celular varchar(15),
fixo varchar(14) default 'Não aplicável',
primary key (id_telefone)
);

ALTER TABLE telefone
add column fk_rg_cliente varchar(10) not null;

ALTER TABLE telefone 
add foreign key (fk_rg_cliente) 
references cliente (rg_cliente);

INSERT INTO telefone
(celular, fixo, fk_rg_cliente)
VALUES 
('(81) 95555-5555', '(81) 4444-4444', '31.263.389'),  
('(11) 91234-5678', '(21) 9876-5432', '22.975.233'),  
('(82) 99876-5432', '(51) 1234-5678', '26.945.080'), 
('(31) 95555-5555', '(31) 4444-4444', '14.172.875'),  
('(41) 91234-5678', '(41) 9876-5432', '15.306.485'),  
('(85) 91234-5678', '(85) 9876-5432', '42.767.229');  

CREATE TABLE produto (
    id_produto int not null auto_increment,
    nome_produto varchar(255),
    tipo varchar(255),
    preco decimal(10, 2),
    quantidade_estoque int,
    primary key (id_produto)
);

INSERT INTO produto
(nome_produto, tipo, preco, quantidade_estoque)
VALUES
('Rosas Vermelhas', 'Flor', 15.99, 50),
('Vaso de Cerâmica', 'Vaso', 10.50, 100),
('Suculenta', 'Planta', 12.75, 30),
('Girassóis Amarelos', 'Flor', 12.99, 40),
('Cacto Decorativo', 'Planta', 8.75, 25);

CREATE TABLE compra (
    id_compra int not null auto_increment,
    data date,
    valor_total decimal(10, 2),
    produtos_comprados text,
    primary key (id_compra)
);

ALTER TABLE compra
add column fk_id_produto int not null;

ALTER TABLE compra
add foreign key (fk_id_produto) 
references produto (id_produto);

ALTER TABLE compra
add column fk_rg_cliente varchar(10) not null;

ALTER TABLE compra 
add foreign key (fk_rg_cliente) 
references cliente (rg_cliente);

INSERT INTO compra 
(data, valor_total, produtos_comprados, fk_id_produto, fk_rg_cliente) 
VALUES 
('2018-08-03',  15.99, 'Rosas Vermelhas', '1', '31.263.389'), -- Jonas
('2019-04-02',  12.99, 'Girassóis Amarelos', '4', '31.263.389'); -- Jonas

describe endereco;
describe telefone;
describe compra;

SELECT COUNT(*) FROM cliente;

SELECT compra.id_compra,cliente.nome,
produto.nome_produto, compra.data, compra.valor_total,
compra.fk_id_produto, compra.fk_rg_cliente
FROM compra 
JOIN cliente ON cliente.rg_cliente = compra.fk_rg_cliente
JOIN produto ON produto.id_produto = compra.fk_id_produto;

