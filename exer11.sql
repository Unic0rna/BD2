create database dbDistribuidora;
use dbDistribuidora;

create table tbNota_Fiscal 
(
NF int primary key,
TotalNota decimal(7,2) not null,
DataEmissao date not null
);

create table tbBairro
(
BairroId int primary key auto_increment,
Bairro varchar(200) not null
);

create table tbCidade
(
CidadeId int primary key auto_increment,
Cidade varchar(200) not null
);

create table tbEstado
(
UFId int primary key auto_increment,
UF char(2) not null
);

create table tbEndereco
(
Cep decimal(8,0) primary key,
Logradouro varchar(200) not null,
BairroId int,
CidadeId int,
UFId int,
foreign key (BairroId) references tbBairro(BairroId),
foreign key (CidadeId) references tbCidade(CidadeId),
foreign key (UFId) references tbEstado(UFId)
);

create table tbFornecedor
(
Codigo int primary key auto_increment,
Nome varchar(200) not null,
CNPJ decimal(14,0) unique not null,
Telefone decimal(11,0)
);

create table tbProduto 
(
CodigoBarras decimal(14,0) primary key,
Nome varchar(200) not null,
Valor decimal(7,2) not null,
Qtd int
);

create table tbCliente 
(
Id int primary key auto_increment,
NomeCli varchar(200) not null,
NumEnd smallint not null, 
CompEnd varchar(50),
CepCli decimal (8,0) not null,
foreign key (CepCli) references tbEndereco(cep)
);

create table tbClientePF
(
CPF decimal(11,0) primary key,
RG_Dig decimal(9,0) not null,
RG char(1) not null,
Nasc date not null,
Id int,
foreign key (Id) references tbCliente(Id)
);

create table tbClientePJ
(
Cnpj decimal(14,0) primary key,
IE decimal(11,0) unique,
Id int,
foreign key (Id) references tbCliente(Id)
);

create table tbCompra 
(
NotaFiscal int primary key,
DataCompra date not null,
ValorTotal decimal(7,2) not null,
QtdTotal int not null,
Codigo int,
foreign key (Codigo) references tbFornecedor(Codigo)
);

create table tbItemCompra 
(
NotaFiscal int not null,
CodigoBarras decimal(14,0) not null,
ValorItem decimal(7,2) not null,
Qtd int not null,
primary key (NotaFiscal, CodigoBarras),
foreign key (CodigoBarras) references tbProduto(CodigoBarras),
foreign key (NotaFiscal) references tbCompra(NotaFiscal)
);

create table tbVenda 
(
NumeroVenda int primary key,
DataVenda date not null,
TotalVenda decimal(7,2) not null,
Id int not null,
NF int,
foreign key (Id) references tbCliente(Id),
foreign key (NF) references tbNota_Fiscal(NF)
);

create table tbItemVenda
(
NumeroVenda int,
CodigoBarras decimal(14,0),
ValorItem decimal(7,2) not null,
Qtd int not null,
foreign key (CodigoBarras) references tbProduto(CodigoBarras),
foreign key (NumeroVenda)references tbVenda(NumeroVenda)
);

-- tabela 1
insert into tbFornecedor (Nome,CNPJ,Telefone) values
('Revenda Chico Loco',1245678937123, 11934567897),
('José Faz Tudo S/A', 1345678937123, 11934567898),
('Vadalto Entregas', 1445678937123, 11934567899),
('Astrogildo das Estrela', 1545678937123, 11934567800),
('Amoroso e Doce', 1645678937123, 11934567801),
('Marcelo Dedal', 1745678937123, 11934567802),
('Franciscano Cachaça', 1845678937123, 11934567803),
('Joãozinho Chupeta', 1945678937123, 11934567804);


-- tabela 2

delimiter $$
create procedure cidade()
begin

insert into tbCidade (Cidade)
values 
('Rio de Janeiro'),
('São Carlos'),
('Campinas'),
('Franco da Rocha'),
('Osasco'),
('Pirituba'),
('Lapa'),
('Ponta Grossa');

end $$
delimiter ;

call cidade();

-- tabela 3
delimiter $$
create procedure estado()

begin

insert into tbEstado(UF)
values 
('SP'),
('RJ'),
('RS');

end $$
delimiter ;

-- drop procedure if exists fornecedor;
call estado();

-- tabela 4

delimiter $$
create procedure bairro()
begin

insert into tbBairro (Bairro) values 
('Aclimação'),
('Capão Redondo'),
('Pirituba'),
('Liberdade');

end $$
delimiter ;


call bairro();

-- tabela 5

delimiter $$
create procedure produtos()
begin

insert into tbProduto (CodigoBarras, Nome, Valor, Qtd) values 
(12345678910111, 'Rei de Papel Mache', 54.61, 120),
(12345678910112, 'Bolinha de Sabão', 100.45, 120),
(12345678910113, 'Carro Bate', 44.00, 120),
(12345678910114, 'Bola Furada', 10.00, 120),
(12345678910115, 'Maçã Laranja', 99.44, 120),
(12345678910116, 'Boneco do Hitler', 124.00, 200),
(12345678910117, 'Farinha de Suruí', 50.00, 200),
(12345678910118, 'Zelador de Cemitério', 24.50, 100);

end $$
delimiter ;

call produtos();

-- tabela 6

delimiter $$
create procedure endereco()
begin

insert into tbEndereco (Cep, Logradouro) values
(12345050, 'Rua da Federal'),
(12345051, 'Av Brasil'),
(12345052, 'Rua Liberdade'),
(12345053, 'Av Paulista'),
(12345054, 'Rua Ximbú'),
(12345055,'Rua Piu XI'),
(12345056,'Rua Chocolate'),
(12345057, 'Rua Pão na Chapa');

end $$
delimiter ;
-- drop procedure if exists endereco;
call endereco();

-- tabela 10

delimiter $$
create procedure venda()
begin

insert into tbVenda (DataVenda, TotalVenda) values
('2025-03-26', 54.61),
('2025-03-25', 200.90),
('2025-03-24', 44.00);

end $$
delimiter ;