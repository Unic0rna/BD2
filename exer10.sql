use dbBanco;

delete from tbTelefone_cliente where Cpf=12345678911;

select * from tbConta;

update tbConta set TipoConta = 2 where NumeroConta=9879;

update tbCliente set E_mail='Astro@Escola.com' where Nome='Monica';

update tbconta set saldo=501.66 where numeroconta=9876;

select Nome, E_mail, Endereço from tbCliente where Nome='Monica';

update tbCliente set Nome='Enildo Candido', 
E_mail='enildo@escola.com' where Nome='Enildo';

update tbConta set Saldo=(Saldo-30);

set foreign_key_checks = 0;

delete from tbConta where NumeroConta=9878;

set foreign_key_checks = 1;

select * from tbconta;