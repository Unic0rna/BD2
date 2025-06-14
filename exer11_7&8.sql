use dbDistribuidora;

-- EXERCICIO 7

delimiter $$
create procedure insertClientePF(vNomeCli varchar(200), vNumEnd decimal(6,0),vCompEnd varchar(50), vCep decimal(8,0), vCPF decimal(11,0), vRG decimal(9,0), vRG_Dig char(1), vNasc date, vLogradouro varchar(200), vBairro varchar(200),vCidade varchar(200),vUF char(2))
begin

declare idBairro int; 
declare idCidade int;
declare idUf int;
declare idCli int;

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
    
		insert into tbCliente(NomeCli,NumEnd,CompEnd,CepCli) values (vNomeCli,vNumEnd,vCompEnd,vCep);
		set idCli = last_insert_id();
	insert into tbClientePF values
	(vCPF, vRG, vRG_Dig, vNasc, idCli);

	end if;
end 
$$
select * from tbCliente;
call insertClientePF ('Pimpão',325,null,12345051,12345678911,12345678,0,'2000-10-12','Av Brasil','Lapa','Campinas','SP');
call insertClientePF ('Disney Chaplin',89,'Ap. 12',12345053,12345678912,12345679,0,'2001-11-21','Av Paulista','Penha','Rio de Janeiro','RJ');
call insertClientePF ('Marciano',744,null,12345054,12345678913,12345680,0,'2001-06-01','Rua Ximbú','Penha','Rio de Janeiro','RJ');
call insertClientePF ('Lança Perfume',128,null,12345059,12345678914,12345681,'X','2004-04-05','Rua Veia','Jardim Santa Isabel','Cuiabá','MT');
call insertClientePF ('Remédio Amargo',2585,null,12345058,12345678915,12345682,0,'2002-07-15','Av Nova','Jardim Santa Isabel','Cuiabá','MT');

select * from tbClientePF;

-- EXERCICIO 8
delimiter $$
create procedure insertClientePJ(vId int,vNomeCli varchar(200),vCNPJ decimal(14,0),vIE decimal(11,0),vCep decimal(8,0),vLogradouro varchar(200),vNumEnd decimal(6,0),vCompEnd varchar(50),vBairro varchar(200),vCidade varchar(200),vUF char(2))
begin 

	declare idBairro int; 
	declare idCidade int;
	declare idUf int;
	declare PjId int;

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
		insert into tbCliente(NomeCli,NumEnd,CompEnd,CepCli) values (vNomeCli,vNumEnd,vCompEnd,vCep);
		set PjId = last_insert_id();
		insert into tbClientePJ values (vCnpj, vIE, PjId);
	end if;
end 
$$

call insertClientePJ (6,'Paganada',12345678912345,98765432198,12345051,'Av Brasil',159,Null,'Lapa','Campinas','SP');
call insertClientePJ (7,'Caloteando',12345678912346,98765432199,12345053,'Av Paulista',69,Null,'Penha','Rio de Janeiro','RJ');
call insertClientePJ (8,'Semgrana',12345678912347,98765432100,12345060,'Rua dos Amores',189,Null,'Sei Lá','Recife','PE');
call insertClientePJ (9,'Cemreais',12345678912348,98765432101,12345060,'Rua dos Amores',5024,'Sala 23','Sei Lá','Recife','PE');
call insertClientePJ (10,'Durango',12345678912349,98765432102,12345060,'Rua dos Amores',1254,Null,'Sei Lá','Recife','PE');

SELECT * FROM tbClientePJ;

-- EXERCICIO 9

DELIMITER $$
create Procedure insertCompra(vNota int, vFornecedor varchar(200), vData varchar(12), vCodigo decimal(14,0), vValorItem decimal(8,2), vQtd int, vQtdTotal int, vValorTotal decimal(8,2))
BEGIN

	if exists (select Codigo from tbFornecedor WHERE Nome = vFornecedor) and exists (SELECT CodigoBarras from tbProduto where CodigoBarras = vCodigo) then
    
		if not exists (select NotaFiscal from tbCompra where NotaFiscal = vNota) then
			insert into tbCompra values (vNota, (select str_to_date(vData, '%d/%m/%Y')), vValorTotal, vQtdTotal, (select Codigo from tbFornecedor where Nome = vFornecedor)); 
		end if;
	   
		if not exists (select NotaFiscal, CodigoBarras from tbItemCompra where NotaFiscal = vNota and CodigoBarras = vCodigo) then
			insert into tbItemCompra values ((select NotaFiscal from tbCompra where NotaFiscal = vNota),(select CodigoBarras from tbProduto where CodigoBarras = vCodigo), VValorItem, vQtd);
		end if;
	end if;

end;
$$

select * from tbCompra;
select * from tbItemcompra;
call insertCompra(8459, 'Amoroso e Doce', '01/05/2018', 12345678910111, 22.22, 200, 700, 21944.00);
call insertCompra(2482, 'Revenda Chico Loco', '22/04/2020', 12345678910112, 40.50, 180, 180, 7290.00);
call insertCompra(21563, 'Marcelo Dedal', '12/07/2020', 12345678910113, 3.00, 300, 300, 900.00);
call insertCompra(8459, 'Amoroso e Doce', '01/05/2018', 12345678910114, 35.00, 500, 700, 21944.00);
call insertCompra(156354, 'Revenda Chico Loco', '23/11/2021', 12345678910115, 54.00, 350, 350, 18900.00);


-- EXERCICIO 10
select * from tbNota_Fiscal;
delimiter $$
create Procedure insertVenda(vNumVenda int, vCliente varchar(100), vCodigo varchar(15), vValorItem decimal(8,2), vQtd int, vTotal decimal(8,2))
BEGIN

declare vData timestamp default current_timestamp();

	if exists (select Id from tbCliente where NomeCli = vCliente) and exists (select CodigoBarras from tbProduto where CodigoBarras = vCodigo) then
    
		if not exists (select NumeroVenda from tbVenda where NumeroVenda = vNumVenda) then
			insert into tbVenda(NumeroVenda, DataVenda, TotalVenda, Id_Cli) values (vNumVenda, vData, vTotal, (select Id from tbCliente where NomeCli = vCliente));
        end if;
        
        if not exists (select NumeroVenda from tbItemVenda where NumeroVenda = vNumVenda) then
			insert into tbItemVenda values ((select NumeroVenda from tbVenda where NumeroVenda = vNumVenda), (select CodigoBarras from tbProduto where CodigoBarras = vCodigo), vValorItem, vQtd);
        end if;
	end if;
end
$$

select * from tbVenda;
select * from tbItemVenda;

call insertVenda (1, 'Pimpão', 12345678910111, 54.61, 1, 54.61);
call insertVenda (2, 'Lança Perfume', 12345678910112, 100.45, 2, 200.90);
call insertVenda (3, 'Pimpão', 12345678910113, 44.00, 1, 44.00);

-- EXERCICIO 11
delimiter $$
create procedure insertNota (vNota int, vCliente varchar(50))
begin

declare vData timestamp default current_timestamp();
declare vtotal decimal(8,2);
declare clienteId int;

	if exists(select Id from tbCliente where NomeCli = vCliente) then
		set clienteId = (select Id from tbCliente where NomeCli = vCliente);
		
		if not exists (select NF from tbNota_Fiscal where NF = vNota) then
			set vtotal = (select sum(TotalVenda) from tbVenda where Id_Cli = clienteId group by Id_Cli);
			insert into tbNota_Fiscal values (vNota, vtotal, vData);
            update tbVenda set NF = vNota where Id_Cli = (select Id from tbCliente where NomeCli = vCliente);
		end if;
    end if;
end
$$
select * from tbCliente;
select * from tbNota_Fiscal;
select * from tbVenda;
call insertNota (359, 'Pimpão');
call insertNota (360, 'Lança Perfume');

-- EXERCICIO 12
call produtos(12345678910130, 'Camiseta de Poliéster', 35.61, 100);
call produtos(12345678910131, 'Blusa Frio Moletom', 200.00, 100);
call produtos(12345678910132, 'Vestido Decote Redondo', 144.00, 50);

select * from tbproduto;

-- EXERCICIO 13
delimiter $$
create procedure deleteProduto (vCod decimal(14,0), vNome varchar(50), vValor decimal(8,2), vQtd int)
begin	
		delete from tbProduto where CodigoBarras = vCod;
end;
$$

CALL deleteProduto(12345678910116, 'Boneco do Hitler', 124.00, 200);
CALL deleteProduto(12345678910117, 'Farinha de Suruí', 50.00, 200);

-- EXERCICIO 14
delimiter $$
create procedure updateProduto(vCod decimal(14,0), vNome varchar(50), vValor decimal(8,2))
begin
	update tbProduto set Nome = vNome, Valor = vValor where CodigoBarras = vCod;
end;
$$

call updateProduto(12345678910111, 'Rei de Papel Mache', 64.50);
call updateProduto(12345678910112, 'Bolinha de Sabão', 120.00);
call updateProduto(12345678910113, 'Carro Bate Bate', 64.00);

-- EXERCICIO 15
delimiter $$
create procedure selectProduto ()
begin
	select * from tbProduto;
end;
$$

call selectProduto();

-- EXERCICIO 16
create table tbProdutoHistorico like tbProduto;
describe tbProdutoHistorico;

-- EXERCICIO 17
alter table tbProdutoHistorico add column Ocorrencia varchar(20);
alter table tbProdutoHistorico add column Atualizacao datetime;

-- EXERCICIO 18
alter table tbProdutoHistorico drop primary key;
alter table tbProdutoHistorico add primary key (CodigoBarras, Ocorrencia, Atualizacao);

-- EXERCICIO 19
delimiter $$
create trigger insertHistProduto after insert on tbProduto
	for each row
begin
	insert into tbProdutoHistorico
		set CodigoBarras = new.CodigoBarras,
			Nome = new.Nome,
            Valor = new.Valor,
            Qtd = new.Qtd,
            Ocorrencia = "Novo",
            Atualizacao = current_timestamp();
end;
$$
select * from tbProdutoHistorico;
insert into tbProduto values (12345678910119, 'Agua mineral', 1.99, 500);

-- EXERCICIO 20
delimiter $$
create trigger alterHistProduto after update on tbProduto
	for each row
begin
	insert into tbProdutoHistorico
		set CodigoBarras = new.CodigoBarras,
        Nome = new.Nome,
		Valor = new.Valor,
		Qtd = new.Qtd,
        Ocorrencia = "Atualizado",
        Atualizacao = current_timestamp();
end;
$$

select * from tbProduto;
update tbProduto set Valor = 2.99 where CodigoBarras = 12345678910119;

-- EXERCICIO 21
select * from tbProduto;

-- EXERCICIO 22
