/* Cria o banco de dados "um_para_um" */
create database um_para_um;

/* Define o banco de dados "um_para_um" como o banco de dados atual */
use um_para_um;

/* Cria a tabela "maridos" */
create table maridos(
id_marido int not null,
 nome_marido varchar (40) not null,
data_nascimento date,
primary key (id_marido)
);

/* Cria a tabela "esposas" incluindo a chave primária de marido como chave estrangeira de esposas.
Importante observar que é necessário criar um campo id_marido que irá receber id_marido da
tabela maridos e referenciado como foreign Key (chave estrangeira).
Importante também observar que id_marido ganha estado de Único, com o parâmetro unique,
sendo assim, só poderá ser usado uma vez apenas na tabela esposa, já que a relação é 1:1*/
create table esposas(
id_esposa int not null,
 id_marido int not null unique,
 nome_esposa varchar (40) not null,
data_nascimento date,
primary key (id_esposa),
 foreign key (id_marido) references maridos(id_marido)
);

desc maridos;
desc esposas;

/* Insere registros na tabela "maridos" */
insert into maridos
(id_marido, nome_marido, data_nascimento)
values
('1', 'Marcelo', '1969-03-02'),
('2', 'Antonio', '1977-12-30'),
('3', 'Pedro', '1992-06-25');

/* Mostra os registros da tabela "maridos" */
select * from maridos;

/* Insere registros na tabela "esposas" utilizando o id do marido, criando a relação com a tabela
maridos*/
insert into esposas
(id_esposa, id_marido, nome_esposa, data_nascimento)
values
('1', '1', 'Sonia', '1973-03-28'),
('2', '2', 'Ana', '1981-11-15');

/* Mostra os registros da tabela "esposas" */
select * from esposas;

/* Tenta inserir um marido já cadastrado para uma esposa. O comando resultará em erro, devido
a constraint "unique" para a coluna "id_marido" na tabela "esposas" */
insert into esposas
(id_esposa, id_marido, nome_esposa, data_nascimento)
values
('3', '1', 'Beatriz', '1973-03-28');


/*
Integridade referencial é um conceito relacionado à chaves estrangeiras.
Este conceito diz que o valor que é chave estrangeira em uma tabela destino, deve ser chave
primária de algum registro na tabela origem.
Quando essa regra é desrespeitada, então temos o caso em que a integridade referencial é violada.
*/
/* Se tentar inserir um marido não cadastrado para uma esposa. O comando resultará em erro
devido à constraint "foreign key" na tabela esposas. É necessário primeiro cadastrar o marido */
insert into esposas
(id_esposa, id_marido, nome_esposa, data_nascimento)
values
('3', '4', 'Beatriz', '1973-03-28');

/* Se o marido está incluído na tabela maridos e não foi utilizado para inclusão em um registro de
esposa, então poderá ser adicionado como marido para a esposa id=3 */
insert into esposas
(id_esposa, id_marido, nome_esposa, data_nascimento)
values
('3', '3', 'Beatriz', '1973-03-28');

select * from esposas;
/* Fim Script um para um */