create database teste; -- Criando banco de dados
use teste; -- Usando banco de dados

/*
DQL: select.

DML: insert, update, delete.

DDL: create, alter, drop.

DCL: grant, revoke.

DTL: begin, commit, rollback.
 */
 
create table Aluno -- Criando tabela
(
Rm int auto_increment, -- Chave primeira com auto incremento que começa com 1 e incrementa 1
Nome varchar(50) not null,
DataNasc date not null,
CPF int,
primary key (Rm,CPF) -- Chave primária composta
);

create table Matricula 
(
Id int primary key auto_increment,
Rm int, 
constraint FK_Matricula foreign key (Rm) references Aluno (Rm) -- Chave estrangeira com nome personalizado
);

create table Curso
(
Id int primary key,
Nome varchar(50) not null,
Especializão varchar(40) not null,
Rm int,
Id_Matricula int,
foreign key (Rm) references Aluno (Rm),
foreign key (Id_Matricula) references Matricula (Id)
);

alter table Aluno modify DataNasc date default current_timestamp not null;

insert into Aluno (Nome,DataNasc,CPF) values -- Adicionando registros a tabela
('Debora','2005-02-10',34324221),
('Rai','2007-07-03',54645634);

-- Trocando informações de registro onde o registro na coluna seja igual ao especificado pelo usuário
update Aluno set Nome = 'Maria Eduarda', DataNasc = '2007-12-24' where Nome = 'Debora';  
delete from Aluno where Nome = 'Camila';

select * from Aluno; -- mostra registros
describe Aluno; -- mostra as informações da tabela


-- Como criar uma procedure com parametros
delimiter $$
create procedure procedimento(vId int,vNome varchar(50), vEspecializão varchar(40))
begin -- Onde começa o código a ser executado

insert into Curso (Id, Nome, Especializão)
values (vId, vNome, vEspecializão);

end -- Onde termina
$$

-- Executando a procedure
call procedimento (1,'Marcio', 'Banco de dados');

-- Como declarar variável pública
set @variavel = 2;
select @variavel;

-- Como declarar variável local e if
delimiter $$
create procedure variavel (var int) -- variavel como parâmetro
begin

declare var2 int; -- variável interna
set var2 = 20;

IF var > 20 THEN -- como declarar if
set var2 = var2 + var;
select var2;

elseif var > 50 then -- como declarar else if
set var2 = var2 * var;
select var2;

ELSE -- como declarar else
set var2 = var2 - var;
select var2;
end if; -- sinaliza o fim do if e do else if

end
$$

call variavel (52); -- () Adicionando o valor ao parâmetro

select Nome from Aluno order by Nome desc; -- ordena os registros em ordem inversa (ele vai de z - a ou 10 - 1)

select Nome, Rm from Aluno limit 2 -- Limita a quantidade de linhas de registros mostrados

-- como colocar mais de uma condição
update Aluno set Nome = 'Henrique', DataNasc = '2004-05-30' where Nome = 'Rai' and Rm = 2;

/* 
and = &&
or = ||
*/