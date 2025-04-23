use dbBanco;

delete from tbTelefone_cliente where Cpf=12345678911;

select * from tbConta;

update tbConta set TipoConta = 2 where NumeroConta=9879;

update tbCliente set E_mail='Astrogildo@Escola.com' where Nome='Monica';

update tbconta set Saldo=Saldo * 1.10 where numeroconta= 9876;

select Nome, E_mail, Endereço from tbCliente where Nome='Monica';

update tbCliente set Nome='Enildo Candido', 
E_mail='enildo@escola.com' where Nome='Enildo';

update tbConta set Saldo= Saldo - 30;

-- Não da para apagar o registro, pois ela contém chave estrangeira