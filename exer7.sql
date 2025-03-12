-- Debora
create database dbEscola;
use dbEscola;

create table tbCliente
(
IdCli int primary key,
NomeCli varchar(50) not null,
NumEnd smallint,
DataCadastro datetime default current_timestamp
);

alter table tbCliente add CPF bigint unique not null;
alter table tbCliente add Cep decimal(5,0);

create database dbEmpresa;

create table tbEndereco
(
Cep decimal(5,0) primary key,
Logradouro varchar(250) not null,
IdUf tinyint
);

alter table tbCliente add constraint Fk_Cep_TbCliente foreign key (Cep) references tbendereco(Cep);

describe tbCliente;

show databases;
drop database dbEmpresa;
