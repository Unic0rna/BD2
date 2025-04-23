create database dbDebora;
use dbDebora;

create table tbUsuario 
(
IdUsuario int primary key,
NomeUsuario varchar(45),
DataNascimento date
);

create table tbCliente
(
CódigoCli smallint primary key,
Nome varchar(50),
Endereco varchar(60)
);

create table tbEstado
(
Id int primary key,
Uf char(2)
);

create table tbProduto
(
Barras decimal(13,0) primary key,
Valor decimal(8,4),
Descricao varchar(100)
);

describe tbProduto;

show tables;
show databases;

alter table tbCliente modify Nome varchar(58);
alter table tbProduto add Qtd int;

drop table tbEstado;
alter table tbUsuario drop DataNascimento;