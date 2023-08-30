/* Cria o banco de dados "muitos_para_muitos" */
create database muitos_para_muitos;

/* Define o banco de dados "muitos_para_muitos" como o banco de dados atual */
use muitos_para_muitos;

/* Cria a tabela "estudantes" */
create table estudantes(
id_estudante int not null,
 nome_estudante varchar (40) not null,
primary key (id_estudante)
);

/* Cria a tabela "disciplinas" */
create table disciplinas(
id_disciplina int not null,
 nome_disciplina varchar (40) not null,
primary key (id_disciplina)
);

/* Cria a tabela "estudante_notas" */
/* No caso de uma relação N:N (muitos para muitos) será criada uma nova entidade (tabela) que
receberá as duas chaves primária das entidades (tabelas estudantes e disciplinas), como chaves
estrangeiras da tabela estudante_notas. Importante observar que é necessário criar dois campos,
um campo id_estudante e um campo id_disciplina que irão receber respectivamente id_estudante
da tabela estudantes e id_disciplina da tabela disciplinas e os dois campos serão referenciados como
foreign Key (chave estrangeira).
Importante também observar nesse caso, por ser N:N (muitos para muitos) id_estudante e
id_disciplinas poderão ser usados quantas vezes forem necessáras para incluir as notas dos
estudantes e das disciplinas.
Esta tabela não terá uma chave primária*/
create table estudante_notas(
id_estudante int not null,
 id_disciplina int not null,
 nota decimal(3,1),
foreign key (id_estudante) references estudantes(id_estudante),
 foreign key (id_disciplina) references disciplinas(id_disciplina)
);

/* Insere registros na tabela "disciplinas" */
insert into disciplinas
(id_disciplina, nome_disciplina)
values
('1', 'Banco de dados'),
('2', 'Algoritmos de programação'),
('3', 'Programação de computadores');

/* Mostra os registros da tabela "disciplinas" */
select * from disciplinas;

/* Insere registros na tabela "estudantes" */
insert into estudantes
(id_estudante, nome_estudante)
values
('1', 'André'),
('2', 'Bernardo'),
('3', 'Carolina');

/* Mostra os registros da tabela "estudantes" */
select * from estudantes;

/* Insere registros na tabela "estudante_notas" utilizando o id_estudante e id_disciplina, criando a
relação com as tabelas estudantes e disciplinas*/
insert into estudante_notas
(id_estudante, id_disciplina, nota)
values
('1', '1', '10'),
('1', '2', '9.5'),
('1', '3', '7'),
('2', '1', '6.5'),
('2', '2', '8'),
('2', '3', '9'),
('3', '1', '9'),
('3', '2', '9.5'),
('3', '3', '10');

/* Mostra os registros da tabela "notas dos estudantes" */
select * from estudante_notas;

/*
Integridade referencial é um conceito relacionado à chaves estrangeiras.
Este conceito diz que o valor que é chave estrangeira em uma tabela destino, deve ser chave
primária de algum registro na tabela origem.
Quando essa regra é desrespeitada, então temos o caso em que a integridade referencial é violada.
*/
/* Tenta inserir um registro na tabela "notas" para um aluno não existente. O comando resultará
em erro devido à constraint "foreign key" para o aluno na tabela notas. É necessário primeiro
cadastrar o estudante */
insert into estudante_notas
(id_estudante, id_disciplina, nota)
values
('4', '3', '7.5');

/* Tenta inserir um registro na tabela "notas" para uma disciplina não existente. O comando
resultará em erro devido à constraint "foreign key" para o aluno na tabela disciplinas. É necessário
primeiro cadastrar a disciplina */
insert into estudante_notas
(id_aluno, id_disciplina, nota)
values
('1', '4', '7.5');
