/* Cria o banco de dados "um_para_muitos" */
create database um_para_muitos;

/* Define o banco de dados "um_para_muitos" como o banco de dados atual */
use um_para_muitos;

/* Cria a tabela "funcionarios" */
create table funcionarios(
id_funcionario int not null,
 nome_funcionario varchar (40) not null,
cargo varchar(20),
primary key (id_funcionario)
);

/* Cria a tabela "dependentes" incluindo a chave primária de funcionário como chave estrangeira
de dependentes. Importante observar que é necessário criar um campo id_funcionario que irá
receber id_funcionario da tabela funcionarios e será referenciado como foreign Key (chave
estrangeira).
Importante também observar nesse caso, por ser 1:N (uma para muitos) id_funcionario poderá ser
usado quantas vezes for necessário para incluir dependentes relacionados a ele. */
create table dependentes(
id_dependente int not null,
 id_funcionario int not null,
 nome_dependente varchar (40) not null,
parentesco enum('Filho', 'Filha', 'Cônjuge'),
primary key (id_dependente),
 foreign key (id_funcionario) references funcionarios(id_funcionario)
);

desc funcionarios;
desc dependentes;

/* Insere registros na tabela "funcionarios" */
insert into funcionarios
(id_funcionario, nome_funcionario, cargo)
values
('1', 'Marcelo', 'Auxiliar'),
('2', 'Antonio', 'Gerente'),
('3', 'Pedro', 'Técnico');

/* Mostra os registros da tabela "funcionarios" */
select * from funcionarios;

/* Insere registros na tabela "dependentes" utilizando o id_funcionario, criando a relação com a
tabela funcionarios*/
insert into dependentes
(id_dependente, id_funcionario, nome_dependente, parentesco)
values
('1', '1', 'Sonia', 'Cônjuge'),
('2', '1', 'Ana', 'Filha'),
('3', '1', 'Pedro', 'Filho'),
('4', '2', 'Beatriz', 'Cônjuge');

/* Mostra os registros da tabela "dependentes" */
select * from dependentes;

/*
Integridade referencial é um conceito relacionado à chaves estrangeiras.
Este conceito diz que o valor que é chave estrangeira em uma tabela destino, deve ser chave
primária de algum registro na tabela origem.
Quando essa regra é desrespeitada, então temos o caso em que a integridade referencial é violada.
*/
/* Se tentar inserir um funcionario não cadastrado para um dependente. O comando resultará em
erro devido à constraint "foreign key"
na tabela dependentes. É necessário primeiro cadastrar o funcionário */
insert into dependentes
(id_dependente, id_funcionario, nome_dependente, parentesco)
values
('5', '4', 'Gabriel', 'Filho');

/* Adicionar dependente para o funcionario 3*/
insert into dependentes
(id_dependente, id_funcionario, nome_dependente, parentesco)
values
('5', '3', 'Gabriel', 'Filho');