create database dbJose;
use dbJose;

create table tbProduto
(
IdProd int primary key,
NomeProd varchar(50) not null,
Qtd int,
DataValidade date not null,
Preço decimal(4,2) not null
);

create table tbCliente 
(
Código int primary key,
NomeCli varchar(50) not null,
DataNascimento date
);
