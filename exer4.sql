create database dbMarli;
use dbMarli;

create table tbProduto
(
IdProP int primary key,
NomeProd varchar(50) not null,
Qtd int,
DataValidade date not null,
Preço decimal(6,4) not null
);

alter table tbProduto add Peso decimal(6,4);
alter table tbProduto add Cor varchar(50);
alter table tbProduto add Marca varchar(50) not null;

alter table tbProduto drop Cor;
alter table tbProduto modify Peso decimal(6,4) not null;
alter table tbProduto drop DataValidade;

describe tbProduto;