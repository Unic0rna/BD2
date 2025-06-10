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

-- EXERCICIO 1
insert into tbFornecedor (CNPJ,Nome,Telefone) values
(1245678937123,'Revenda Chico Loco', 11934567897),
(1345678937123, 'José Faz Tudo S/A', 11934567898),
(1445678937123, 'Vadalto Entregas', 11934567899),
(1545678937123, 'Astrogildo das Estrela', 11934567800),
(1645678937123, 'Amoroso e Doce', 11934567801),
(1745678937123, 'Marcelo Dedal', 11934567802),
(1845678937123, 'Franciscano Cachaça', 11934567803),
(1945678937123, 'Joãozinho Chupeta', 11934567804);


-- EXERCICIO 2

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


-- EXERCICIO 3
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

-- EXERCICIO 4

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

-- EXERCICIO 5

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

-- EXERCICIO 6

delimiter $$
create procedure insertEndereco(vCep decimal(8,0), vLogradouro varchar(200), vBairro varchar(200), vCidade varchar(200), vUf char(2))
begin

declare IdBairro int;
declare IdCidade int;
declare IdEstado int;
declare Logradouro int;

if not exists (select BairroId from tbBairro where bairro = vBairro) then
 insert into tbBairro(Bairro) values (vBairro);
end if;

set IdBairro = (select BairroId from tbBairro where bairro = vBairro);

if not exists (select CidadeId from tbCidade where Cidade = vCidade) then
 insert into tbCidade(Cidade) values (vCidade);
end if;

set IdCidade = (select CidadeId from tbCidade where Cidade = vCidade);

if not exists (select UfId from tbEstado where Uf = vUf) then
 insert into tbEstado(Uf) values (vUf);
end if;

set IdEstado = (select UfId from tbEstado where Uf = vUf);

insert into tbEndereco values
(vCep, vLogradouro,IdBairro, IdCidade, IdEstado);

end 
$$

select * from tbEndereco;
call insertendereco (12345050, 'Rua da Federal', 'Lapa', 'São Paulo', 'SP');
call insertendereco (12345051, 'Av Brasil', 'Lapa', 'Campinas', 'SP');
call insertendereco (12345052, 'Rua Liberdade', 'Consolação', 'São Paulo', 'SP');
call insertendereco (12345053, 'Av Paulista', 'Penha', 'Rio de Janeiro', 'RJ');
call insertendereco (12345054, 'Rua Ximbú', 'Penha', 'Rio de Janeiro', 'RJ');
call insertendereco (12345055,'Rua Piu XI', 'Penha', 'Campinas', 'SP');
call insertendereco (12345056,'Rua Chocolate', 'Aclimação', 'Barra Mansa', 'RJ');
call insertendereco (12345057, 'Rua Pão na Chapa', 'Barra Funda', 'Ponta Grossa', 'RS');
