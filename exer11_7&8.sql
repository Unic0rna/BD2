use dbDistribuidora;

delimiter $$
create procedure insertClientePF(vNomeCli varchar(200), vNumEnd decimal(6,0),vCompEnd varchar(50), vCep decimal(8,0), vCPF decimal(11,0), vRG decimal(9,0), vRG_Dig char(1), vNasc date, vLogradouro varchar(200), vBairro varchar(200),vCidade varchar(200),vUF char(2))
begin

declare idBairro int; 
declare idCidade int;
declare idUf int;

if not exists (select Cep from tbEndereco where Cep = vCep) then

if not exists (select BairroId from tbBairro where bairro = vBairro) then
    insert into tbBairro(Bairro) values (vBairro);
end if;

set idBairro = (select BairroId from tbBairro where Bairro = vBairro);

if not exists (select CidadeId from tbCidade where cidade = vCidade) then
    insert into tbCidade(Cidade) values(vCidade);
end if;

set idCidade = (select CidadeId from tbCidade where Cidade = vCidade);

if not exists (select UFId from tbEstado where Uf = vUf) then
    insert into tbEstado(UF) values(vUF);
end if;

set idUf = (select UfId from tbestado where Uf = vUf);

insert into tbEndereco values (vCep, vLogradouro, idBairro, idCidade, idUf);
end if;

if not exists (select CPF from tbClientePF where CPF = vCPF) then
    insert into tbCliente(NomeCli,NumEnd,CompEnd,CepCli) values (vNomeCli,vNumEnd,vCompEnd,vCepCli);
    
insert into tbClientePF values
(vCPF, vRG, vRG_Dig, vNasc, vId);

end if;


end 
$$

call insertClientePF ('Pimpão',325,Null,12345051,12345678911,12345678,0,'2000-10-12','Av Brasil','Lapa','Campinas','SP');
call insertClientePF ('Disney Chaplin',89,'Ap. 12',12345053,12345678912,12345679,0,'2001-11-21','Av Paulista','Penha','Rio de Janeiro','RJ');
call insertClientePF ('Marciano',744,Null,12345054,12345678913,12345680,0,'2001-06-01','Rua Ximbú','Penha','Rio de Janeiro','RJ');
call insertClientePF ('Lança Perfume',128,Null,12345059,12345678914,12345681,'X','2004-04-05','Rua Veia','Jardim Santa Isabel','Cuiabá','MT');
call insertClientePF ('Remédio Amargo',2585,Null,12345058,12345678915,12345682,0,'2002-07-15','Av Nova','Jardim Santa Isabel','Cuiabá','MT');

-- tabela 8
delimiter $$
create procedure insertClientePJ(vId int,vNomeCli varchar(200),vCNPJ decimal(14,0),vIE decimal(11,0),vCep decimal(8,0),vLogradouro varchar(200),vNumEnd decimal(6,0),vCompEnd varchar(50),vBairro varchar(200),vCidade varchar(200),vUF char(2))
begin 

declare idBairro int; 
declare idCidade int;
declare idUf int;

if not exists (select Cep from tbEndereco where Cep = vCep) then

if not exists (select BairroId from tbBairro where bairro = vBairro) then
    insert into tbBairro(Bairro) values (vBairro);
end if;

if not exists (select CidadeId from tbCidade where cidade = vCidade) then
    insert into tbCidade(Cidade) values(vCidade);
end if;

if not exists (select UFId from tbEstado where Uf = vUf) then
    insert into tbEstado(UF) values(vUF);
end if;

set idBairro = (select BairroId from tbBairro where Bairro = vBairro);
set idCidade = (select CidadeId from tbCidade where Cidade = vCidade);
set idUf = (select UfId from tbestado where Uf = vUf);

insert into tbEndereco values (vCep, vLogradouro, idBairro, idCidade, idUf);
end if;

if not exists (select Cnpj from tbClientePJ where Cnpj = vCnpj) then
    insert into tbCliente(NomeCli,NumEnd,CompEnd,CepCli) values (vNomeCli,vNumEnd,vCompEnd,vCepCli);
    insert into tbClientePJ(Cnpj, IE) values (vCnpj, vIE);
end if;


end 
$$

call insertClientePJ (6,'Paganada',12345678912345,98765432198,12345051,'Av Brasil',159,Null,'Lapa','Campinas','SP');
call insertClientePJ (7,'Caloteando',12345678912346,98765432199,12345053,'Av Paulista',69,Null,'Penha','Rio de Janeiro','RJ');
call insertClientePJ (8,'Semgrana',12345678912347,98765432100,12345060,'Rua dos Amores',189,Null,'Sei Lá','Recife','PE');
call insertClientePJ (9,'Cemreais',12345678912348,98765432101,12345060,'Rua dos Amores',5024,'Sala 23','Sei Lá','Recife','PE');
call insertClientePJ (10,'Durango',12345678912349,98765432102,12345060,'Rua dos Amores',1254,Null,'Sei Lá','Recife','PE');


-- TABELA 9

DELIMITER $$
create Procedure insertCompra(vNota int, vFornecedor varchar(200), vData date, vCodigo decimal(14,0), vValorItem decimal(8,2), vQtd int, vQtdTotal int, vValorTotal decimal(8,2))
BEGIN

declare vdata date;

if EXISTS (select Codigo from tbFornecedor WHERE Nome = vFornecedor) and exists (SELECT CodigoBarras from tbProduto where CodigoBarras = vCodigo) then
    insert into tbCompra values (vNota, str_to_date(vData, '%Y-%m-%d'), vValorTotal, vQtdTotal, (select Codigo from tbFornecedor where Nome = vFornecedor));
    insert into tbItemCompra values ((select NotaFiscal from tbCompra where NotaFiscal = vNota),(select CodigoBarras from tbProduto where CodigoBarras = vCodigo), vQtd);
end if;

end;
$$

call insertCompra(8459, 'Amoroso e Doce', '2018-05-01', 12345678910111, 22.22, 200, 700, 21944.00);
call insertCompra(2482, 'Revenda Chico Loco', '22/04/2020', 12345678910112, 40.50, 180, 180, 7290.00);
call insertCompra(21563, 'Marcelo Dedal', '12/07/2020', 12345678910113, 3.00, 300, 300, 900.00);
call insertCompra(8459, 'Amoroso e Doce', '01/05/2018', 12345678910114, 35.00, 500, 700, 21944.00);
call insertCompra(156354, 'Revenda Chico Loco', '23/11/2021', 12345678910115, 54.00, 350, 350, 18900.00);
-- TABELA 10

-- delimiter $$
-- create Procedure insertCompra(vNota, vFornecedor varchar(200), vData, vCodigo decimal(14,0), vValorItem, vQtd int, vQtdTotal int, vValorTotal)
-- BEGIN



-- end
-- $$