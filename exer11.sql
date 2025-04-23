create database dbDistribuidora;
use dbDistribuidora;

create table tbNota_Fiscal 
(
NF int primary key,
TotalNota decimal(8,2) not null,
Data_emissao date not null
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
BairroId int not null,
CidadeId int not null,
UFId int not null,
foreign key (BairroId) references tbBairro(BairroId),
foreign key (CidadeId) references tbCidade(CidadeId),
foreign key (UFId) references tbEstado(UFId)
);

create table tbFornecedor
(
Codigo int primary key auto_increment,
CNPJ decimal(14,0) unique,
Nome varchar(200) not null,
Telefone decimal(11,0)
);

create table tbProduto 
(
CodigoBarras decimal(14,0) primary key,
Nome varchar(200) not null,
Valor decimal(8,2) not null,
Qtd int
);

create table tbCliente 
(
Id int primary key auto_increment,
NomeCli varchar(200) not null,
NumEnd decimal(6,0) not null, 
CompEnd varchar(50),
CepCli decimal (8,0),
foreign key (CepCli) references tbEndereco(cep)
);

create table tbClientePF
(
CPF decimal(11,0) primary key,
RG decimal(9,0) not null,
RG_Dig char(1) not null,
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
ValorTotal decimal(8,2) not null,
QtdTotal int not null,
Codigo int,
foreign key (Codigo) references tbFornecedor(Codigo)
);

create table tbItemCompra 
(
NotaFiscal int not null,
CodigoBarras decimal(14,0) not null,
ValorItem decimal(8,2) not null,
Qtd int not null,
foreign key (NotaFiscal) references tbCompra(NotaFiscal),
foreign key (CodigoBarras) references tbProduto(CodigoBarras),
primary key (NotaFiscal, CodigoBarras)
);

create table tbVenda 
(
NumeroVenda int primary key,
DataVenda date not null,
TotalVenda decimal(8,2) not null,
Id_Cli int not null,
NF int,
foreign key (Id_Cli) references tbCliente(Id),
foreign key (NF) references tbNota_Fiscal(NF)
);

create table tbItemVenda
(
NumeroVenda int,
CodigoBarras decimal(14,0),
ValorItem decimal(8,2) not null,
Qtd int not null,
primary key (NumeroVenda, CodigoBarras),
foreign key (CodigoBarras) references tbProduto(CodigoBarras),
foreign key (NumeroVenda)references tbVenda(NumeroVenda)
);

-- tabela 1
insert into tbFornecedor (CNPJ,Nome,Telefone) values
(1245678937123,'Revenda Chico Loco', 11934567897),
(1345678937123, 'José Faz Tudo S/A', 11934567898),
(1445678937123, 'Vadalto Entregas', 11934567899),
(1545678937123, 'Astrogildo das Estrela', 11934567800),
(1645678937123, 'Amoroso e Doce', 11934567801),
(1745678937123, 'Marcelo Dedal', 11934567802),
(1845678937123, 'Franciscano Cachaça', 11934567803),
(1945678937123, 'Joãozinho Chupeta', 11934567804);


-- tabela 2

delimiter $$
create procedure cidade(vCidade varchar(200))
begin

insert into tbCidade (Cidade)
values 
(vCidade);

end 
$$

call cidade ('Rio de Janeiro');
call cidade ('São Carlos');
call cidade ('Campinas');
call cidade ('Franco da Rocha');
call cidade ('Osasco');
call cidade ('Pirituba');
call cidade ('Lapa');
call cidade ('Ponta Grossa');


-- tabela 3
delimiter $$
create procedure estado(vUF char(2))
begin

insert into tbEstado(UF)
values 
(vUF);

end 
$$

call estado('SP');
call estado('RJ');
call estado('RS');

select * from tbestado;

-- tabela 4

delimiter $$
create procedure bairro(vBairro varchar(200))
begin

insert into tbBairro (Bairro) values 
(vBairro);

end 
$$

call bairro ('Aclimação');
call bairro ('Capão Redondo');
call bairro ('Pirituba');
call bairro ('Liberdade');

-- tabela 5

delimiter $$
create procedure produtos(vCodigoBarras decimal(14,0), vNome varchar(200), vValor decimal(8,2), vQtd int)
begin

insert into tbProduto (CodigoBarras, Nome, Valor, Qtd) values 
(vCodigoBarras, vNome, vValor, vQtd);

end 
$$

call produtos (12345678910111, 'Rei de Papel Mache', 54.61, 120);
call produtos (12345678910112, 'Bolinha de Sabão', 100.45, 120);
call produtos (12345678910113, 'Carro Bate', 44.00, 120);
call produtos (12345678910114, 'Bola Furada', 10.00, 120);
call produtos (12345678910115, 'Maçã Laranja', 99.44, 120);
call produtos (12345678910116, 'Boneco do Hitler', 124.00, 200);
call produtos (12345678910117, 'Farinha de Suruí', 50.00, 200);
call produtos (12345678910118, 'Zelador de Cemitério', 24.50, 100);

select * from tbProduto;

-- tabela 6

delimiter $$
create procedure endereco(vCep decimal(8,0), vLogradouro varchar(200))
begin

insert into tbEndereco (Cep, Logradouro) values
(vCep, vLogradouro);

end 
$$

call endereco (12345050, 'Rua da Federal');
call endereco (12345051, 'Av Brasil');
call endereco (12345052, 'Rua Liberdade');
call endereco (12345053, 'Av Paulista');
call endereco (12345054, 'Rua Ximbú');
call endereco (12345055,'Rua Piu XI');
call endereco (12345056,'Rua Chocolate');
call endereco (12345057, 'Rua Pão na Chapa');


-- tabela 7

delimiter $$
create procedure clientePF(vCPF decimal(11,0), vRG decimal(9,0), vRG_Dig char(1), vNasc date)
begin

insert into tbClientePF(CPF, RG, RG_Dig, Nasc) values
(vCPF, vRG, vRG_Dig, vNasc);

end 
$$

call clientePF (12345678911,12345678,0,'2000-10-12');
call clientePF (12345678912,12345679,0,'2001-11-21');
call clientePF (12345678913,12345680,0,'2001-06-01');
call clientePF (12345678914,12345681,'X',2004-04-05);
call clientePF (12345678915,12345682,0,'2002-07-15');

-- tabela 8

delimiter $$
create procedure clientePJ(vCnpj decimal(14,0), vIE decimal(11,0))
begin 

insert into tbClientePJ(Cnpj, IE) values
(vCnpj, vIE);

end 
$$

call clientePJ (12345678912345,98765432198);
call clientePJ (12345678912346,98765432199);
call clientePJ (12345678912347,98765432100);
call clientePJ (12345678912348,98765432101);
call clientePJ (12345678912349,98765432102);

-- tabela 9

delimiter $$
create procedure compra(vNotaFiscal int, vDataCompra date, vCodigo int, vQtdTotal int, vValorTotal decimal(8,2))
begin

insert into tbCompra(NotaFiscal, DataCompra, Codigo, QtdTotal, ValorTotal) values
(vNotaFiscal, vDataCompra, vCodigo, vQtdTotal, vValorTotal);

end 
$$

call compra (8459, '2018-05-01', 12345678910111, 700, 21944.00);
call compra (2482, '2020-04-22', 12345678910112, 180, 7290.00);
call compra (21563, '2020-07-12', 12345678910113, 300, 900.00);
call compra (8459, '2018-05-01', 12345678910114, 700, 21944.00);
call compra (156354,'2021-11-23',12345678910115,350);


-- tabela 10

delimiter $$
create procedure venda(vDataVenda date, vTotalVenda decimal(8,2))
begin

insert into tbVenda (DataVenda, TotalVenda) values
(vDataVenda, vTotalVenda);

end 
$$ 

call venda ('2025-03-26', 54.61);
call venda ('2025-03-25', 200.90);
call venda ('2025-03-24', 44.00);

-- tabela 11

-- tabela 12

delimiter $$
create procedure insert_produto(vCodigoBarras decimal(14,0), vNome varchar(200), vValor decimal(7,2), vQtd int)
begin

insert into tbProduto (CodigoBarras, Nome, ValorUnitario, Qtd)
	values (vCodigoBarras, vNome, vValor, vQtd);

end
$$

call insert_produto (12345678910130, 'Camiseta de Poliéster', 35.61, 100);
call insert_produto (12345678910131, 'Blusa Frio Moletom', 200.00, 100);
call insert_produto (12345678910132, 'Vestido Decote Redondo', 144.00, 50);

-- tabela 13

delimiter $$
create procedure delete_produto()
begin

delete CodigoBarras, Nome, ValorUnitario, Qtd from tbProduto where Nome = 'Boneco do Hitler';
delete CodigoBarras, Nome, ValorUnitario, Qtd from tbProduto where Nome = 'Farinha de Suruí';

end
$$

call delete_produto();

-- tabela 14

delimiter $$
create procedure alter_produto()
begin

alter tbProduto 

end
$$