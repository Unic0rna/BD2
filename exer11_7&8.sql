use dbDistribuidora;

delimiter $$
create procedure insertClientePF(vCPF decimal(11,0), vRG decimal(9,0), vRG_Dig char(1), vNasc date)
begin

if not exists (select Id from tbCliente where NomeCli = vNomeCli and NumEnd = vNumEnd and CompEnd = vCompEnd and CepCli = vCepCli) then
    insert into tbCliente(NomeCli,NumEnd,CompEnd,CepCli) values (vNomeCli,vNumEnd,vCompEnd,vCepCli);
end if;


insert into tbClientePF values
(vCPF, vRG, vRG_Dig, vNasc, vId);

end 
$$

call insertClientePF ('Pimpão',325,Null,12345051,12345678911,12345678,0,'2000-10-12','Av Brasil','Lapa','Campinas','SP');
call insertClientePF ('Disney Chaplin',89,'Ap. 12',12345053,12345678912,12345679,0,'2001-11-21','Av Paulista','Penha','Rio de Janeiro','RJ');
call insertClientePF ('Marciano',744,Null,12345054,12345678913,12345680,0,'2001-06-01','Rua Ximbú','Penha','Rio de Janeiro','RJ');
call insertClientePF ('Lança Perfume',128,Null,12345059,12345678914,12345681,'X','2004-04-05','Rua Veia','Jardim Santa Isabel','Cuiabá','MT');
call insertClientePF ('Remédio Amargo',2585,Null,12345058,12345678915,12345682,0,'2002-07-15','Av Nova','Jardim Santa Isabel','Cuiabá','MT');

-- tabela 8
delimiter $$
create procedure insertClientePJ(vId int,vNomeCli,vCNPJ,vIE,vCEP,vLogradouro,vNumEnd,vCompEnd,vBairro,vCidade,vUF char(2))
begin 

insert into tbClientePJ(Cnpj, IE) values
(vCnpj, vIE);

end 
$$

call insertClientePJ (6,'Paganada',12345678912345,98765432198,12345051,'Av Brasil',159,Null,'Lapa','Campinas','SP');
call insertClientePJ (7,'Caloteando',12345678912346,98765432199,12345053,'Av Paulista',69,Null,'Penha','Rio de Janeiro','RJ');
call insertClientePJ (8,'Semgrana',12345678912347,98765432100,12345060,'Rua dos Amores',189,Null,'Sei Lá','Recife','PE');
call insertClientePJ (9,'Cemreais',12345678912348,98765432101,12345060,'Rua dos Amores',5024,'Sala 23','Sei Lá','Recife','PE');
call insertClientePJ (10,'Durango',12345678912349,98765432102,12345060,'Rua dos Amores',1254,Null,'Sei Lá','Recife','PE');