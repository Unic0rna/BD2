create database dbBanco;
use dbBanco;

create table tbBanco
(
Codigo int primary key,
Nome varchar(50)
); 

create table tbCliente
(
CPF bigint primary key,
Nome varchar(50) not null,
Sexo char(1) not null,
Endereço varchar(50) not null
); 

create table tbAgencia
(
CodBanco int,
foreign key (CodBanco) references tbBanco(Codigo),
NumeroAgencia int primary key, 
Endereço varchar(50) not null
); 

create table tbConta
(
NumeroConta int primary key, 
Saldo decimal(7,2), 
TipoConta smallint,
NumAgencia int,
foreign key(NumAgencia) references tbAgencia(NumeroAgencia)
); 

create table tbHistorico
(
CPF bigint,
foreign key (CPF) references tbCliente(CPF),
NumeroConta int,
foreign key(NumeroConta) references tbConta(NumeroConta),
DataInicio date
);

create table tbTelefone_cliente
(
Cpf bigint,
foreign key (Cpf) references tbCliente(CPF),
telefone bigint primary key
); 

insert into tbBanco values
(1,'Banco do Brasil'),
(104, 'Caixa Economica Federal'),
(801, 'Banco Escola');

insert into tbAgencia values
(1, 123, 'Av Paulista,78'),
(104, 159, 'Rua Liberdade,124'),
(801, 401,'Rua vinte três,23'),
(801, 485, 'Av Marechal,68');

insert into tbCliente values
(12345678910, 'Enildo', 'M', 'Rua Grande,75'),
(12345678911, 'Astrogildo', 'M', 'Rua Pequena,789'),
(12345678912, 'Monica', 'F', 'Av Larga,148'),
(12345678913, 'Cascão', 'M', 'Av Principal,369');

insert into tbConta values
(9876, 456.05, 1, 123),
(9877, 321.00, 1, 123),
(9878, 100.00, 2, 485),
(9879, 5589.48, 1, 401);

insert into tbHistorico values
(12345678910, 9876, '2001-04-15'),
(12345678911, 9877, '2011-03-10'),
(12345678912, 9878, '2021-03-11'),
(12345678913, 9879, '2000-07-05');

insert into tbTelefone_cliente values
(12345678910, 912345678), 
(12345678911, 912345679),
(12345678912, 912345680),
(12345678913, 912345681);

alter table tbCliente add E_mail varchar(140);

describe tbcliente;

select CPF, Endereço from tbCliente where Nome='Monica';

select NumeroAgencia, Endereço from tbAgencia where CodBanco=801;

select * from tbCliente where Sexo='M';

