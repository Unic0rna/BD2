create database dbSilvana;
use dbSilvana;

create table tbVenda
(
NF int primary key auto_increment,
DataValidade datetime not null
);

alter table tbVenda add Preço decimal(6,4) not null;
alter table tbVenda add Qtd smallint;

alter table tbVenda drop column DataValidade;
alter table tbVenda add DataVenda datetime default current_timestamp;

create table tbProduto
(
CodigoB decimal(13,0) primary key,
NomeProd varchar(50) not null
);

alter table tbVenda add CodigoB decimal(13,0);
alter table tbVenda add foreign key (CodigoB) references tbProduto(CodigoB);