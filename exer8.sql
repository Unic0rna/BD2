use dbEscola;

create table tbEst
(IdUf tinyint primary key,
NomeUfs char(2) not null,
NomeEstado char(40) not null);

alter table tbEndereco add constraint Fk_IdUf_TbEndereco foreign key(IdUf) references tbest(IdUf);

alter table tbest drop column NomeEstado;

rename table tbest to tbEstado;

alter table tbEstado rename column NomeUfs to NomeUf;

alter table tbendereco add IdCid int;

create table tbCidade 
(IdCid int primary key, 
NomeCidade varchar(50) not null);

alter table tbCidade modify column NomeCidade varchar(250) not null;

alter table tbendereco add constraint Fk_IdCid_tbEndereço foreign key(IdCid) references tbcidade(IdCid);
