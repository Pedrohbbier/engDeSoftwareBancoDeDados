create database bibliotecaPublica;
use bibliotecaPublica;

create table Categoria(
Id_Categoria int primary key not null,
genero varchar(50)
);

create table Autor(
nome_autor varchar (100) not null,
Id_Autor int primary key not null
);

create table Livro(
Id_Livro int primary key not null,
titulo_livro varchar (100) not null,
publicacao datetime not null,
exemplares tinyint unsigned,
Id_Categoria int not null, 
Id_Autor int not null,
foreign key (Id_Categoria) references Categoria (id_Categoria),
foreign key (Id_Autor) references Autor (id_Autor)
);

create table Membro(
Id_Membro int primary key not null,
nome_membro varchar (100),
cpf numeric(11) not null unique
);

create table endereco(
id_endereco int primary key not null,
Id_Membro int not null,
Bairro varchar (100),
Rua varchar (100),
numero_casa int,
foreign key (Id_Membro) references Membro (Id_Membro)
);

create table emprestimo(
id_emprestimo int primary key not null,
Id_Livro int not null,
Id_Membro int not null,
data_emprestimo datetime not null default current_timestamp(),
data_devolucao datetime not null,
foreign key (Id_Livro) references Livro (Id_Livro),
foreign key (Id_Membro) references Membro (Id_Membro)
);

insert into Categoria 
(Id_categoria, genero)
values
('1','Fantasia'),
('2', 'Terror'),
('3', 'Romance'),
('4', 'Drama'),
('5', 'Suspense');

insert into Autor
(Id_Autor, nome_autor)
values
('1', 'JRR Tolkien'),
('2', 'Stephen King'),
('3', 'Neil Gaiman'),
('4', 'William Shakespeare'),
('5', 'Edgar Allan Poe');

insert into Livro
(Id_livro, titulo_livro, publicacao, exemplares, Id_Categoria, Id_Autor)
values
('1', 'Senhor dos Aneis: A Sociedade do Anel', '1954-07-29','10','1','1'),
('2', 'O Cemiterio', '1983-11-14', '17', '2', '2'),
('3', 'Deuses Americanos', '2003-06-19', '30', '3', '3'),
('4', 'Romeu e Julieta', '1597-10-11', '12', '4','4'),
('5','Historias Extraordinarias', '1985-05-23','21','5','5');

insert into Membro
(Id_Membro, nome_membro, cpf)
values
('1','Andre Carlos','15682468743'),
('2','Geovana Cardoso','68463754234'),
('3','Leandro Gomes','85325685423'),
('4','Rafael Guilherme','15824683578'),
('5','Leandra Candida','07536864324');

insert into Endereco
(id_endereco, Id_Membro, Bairro, Rua, numero_casa)
values
('1','1','Battel','Avenida Iguaçu','530'),
('2','2','Ganchinho','Rua Alan Kardek','610'),
('3','3','Agua Verde','Rua Buenos Aires','310'),
('4','4','Sitio Cercado','Rua Horizona','80'),
('5','5','Centro','Rua Brigadeiro Franco','143');

insert into emprestimo
(id_emprestimo, Id_Livro, Id_Membro, data_emprestimo, data_devolucao)
values
('1','1','1','2023-02-13','2023-02-23'),
('2','2','2','2023-06-17','2023-06-27'),
('3','3','3','2023-09-16','2023-09-26'),
('4','4','4','2023-02-10','2023-02-20'),
('5','5','5','2023-12-12','2023-12-22');

select nome_autor from Autor where nome_autor like 'a%'; 

select titulo_livro from Livro where titulo_livro like '%sistema%';

select id_Livro, titulo_livro from Livro where publicacao < date_sub(now(), interval 5 year);

select titulo_livro from Livro where exemplares < 5 order by titulo_livro;

select Id_Livro, titulo_livro from Livro where Id_Livro not in (select distinct Id_Livro from emprestimo);

update emprestimo
set data_devolucao = current_date;

update emprestimo
set data_devolucao = date_add(data_devolucao, interval 1 month);

delete from membro
where Id_Membro not in (select distinct Id_Membro from emprestimo);

delete from categoria
where Id_Categoria not in (select distinct Id_Categoria from Livro);

/*Continuando a A2:/

/*1) Listar o título do livro e o nome do autor para todos os livros cadastrados na base*/

select titulo_livro, a.nome_autor from Livro l
join Autor a on l.id_autor = a.id_autor;

/*2) Listar a data de empréstimo, o nome do membro que emprestou, e o título do livro de todos os empréstimos feitos neste ano.*/
select e.data_emprestimo, m.nome_membro, l.titulo_livro from emprestimo e
join Membro m on e.id_membro = m.id_membro
join Livro l on  e.id_livro = l.id_livro
where year (e.data_emprestimo) = year(curdate());

/*3) Listar o nome da categoria e o título do livro de todos os livros cadastrados na base.*/
select c.genero, l.titulo_livro from Livro l
join Categoria c on l.id_categoria = c.id_categoria;

/*4) Listar o título do livro, a data de empréstimo e a data da devolução real de todos os livros da base.*/
select l.titulo_livro, e.data_emprestimo, e.data_devolucao from Livro l
join emprestimo e on l.id_livro = e.id_livro;

/*5) Listar a data de empréstimo, data da devolução real, nome do membro que emprestou, título do livro, nome da categoria e nome do autor (ou autores) de todos os empréstimos realizados*/
select e.data_emprestimo, e.data_devolucao, m.nome_membro, l.titulo_livro, c.genero, a.nome_autor from emprestimo e
join Membro m on e.id_membro = m.id_membro
join Livro l on e.id_livro = l.id_livro
join categoria c on l.id_livro = c.id_categoria
left join Autor a on l.Id_Autor = a.Id_Autor
group by e.id_emprestimo;

/*6) Contar quantos livros estão cadastrados na base.*/
select count(*) as total_livros from Livro;

/*7) Contar quantos empréstimos foram feitos no ano passado.*/
select count(*) as emprestimos_ano_passado from emprestimo
where year(data_emprestimo) = year(curdate()) - 1;

/*8) Listar o nome da categoria e a quantidade de livros por categoria.*/
select c.genero, count(l.id_livro) as qtd_livros from categoria c
left join Livro l on c.id_categoria = l.id_categoria
group by c.id_categoria;

/*9) Listar o título do livro e o nome do membro de todos os livros emprestados na semana corrente, agrupados e ordenados por data de empréstimo*/
select l.titulo_livro, m.nome_membro from emprestimo e
join membro m on e.id_membro = m.id_membro
join Livro l on e.id_livro = l.id_livro
where yearweek(e.data_emprestimo, 1) = yearweek(curdate(), 1)
order by e.data_emprestimo;

/*10) Listar o total de livros emprestados no ano atual, agrupados e ordenados cronologicamente por mês, sendo que o nome do mês deve ser apresentado por extenso.*/
select monthname(e.data_emprestimo) as mes, count(*) as total_de_emprestimos from emprestimo e
where year(e.data_emprestimo) = year(curdate())
group by mes
order by month(e.data_emprestimo);

/*Nome: Pedro Henrique Boldori Bier e Gustavo Cirino*/
/*Curso: Engenharia de software*/
