create database dbComercio;
use dbComercio;

create table tbCliente
(
Id int primary key,
NomeCli varchar(200) not null,
NumEnd decimal(6,0) not null,
CompEnd varchar(50)
);

create table tbClientePF
(
CPF decimal(11,0) primary key,
RG decimal(9,0),
Rgdig char(1),
Nascimento date not null
);