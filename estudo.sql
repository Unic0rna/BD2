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

select * from Aluno;
