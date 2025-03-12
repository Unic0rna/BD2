create database dbDesenvolvimento;
use dbDesenvolvimento;

create table tbProduto
(
IdProd int primary key,
NomeProd varchar(50) not null,
Qtd int,
DataValidade date not null,
Preço decimal(5,2) not null
);

alter table tbProduto add Peso decimal(4,2);
alter table tbProduto add Cor varchar(50);
alter table tbProduto add Marca varchar(50) not null;

alter table tbProduto drop Cor;
alter table tbProduto modify Peso decimal(4,2) not null;

/*A coluna Cor já havia sido apagada anteriormente*/ 

create database dbLojaGrande;
create database dbLojica;
alter table tbProduto add Cor varchar(50);

use dbLojica;
create table tbCliente
(
NomeCli varchar(50) not null,
CodigoCli int primary key,
DataCadastro date not null
);


use dbLojaGrande;
create table tbFuncionario
(
NomeFunc varchar(50) not null,
CodigoFunc int primary key,
DataCadastro datetime not null default current_timestamp
);

drop database tbLojaGrande;
alter table tbCliente add CPF decimal(11,0) not null unique;