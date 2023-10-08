/*Comando da questão 1:*/
create database biblioteca_publica;
use biblioteca_publica;


/*Comando da questão 2:*/

create table categoria(
	idCategoria int primary key not null,
    genero varchar (20)
);

create table autor(
	idAutor int primary key not null,
    nomeAutor varchar(50) not null
);

create table livro(
	idLivro int primary key not null,
	nomeLivro varchar(50) not null,
    dataPublicacao datetime not null,
    nroExemplares int not null,
    idCategoria int not null,
    foreign key (idCategoria) references categoria (idCategoria) on delete cascade on update cascade,
    idAutor int not null auto_increment ,
    foreign key (idAutor) references autor (idAutor) on delete cascade on update cascade
);

create table endereco( /*Tabela do endereço do membro*/
	idEndereco int primary key not null,
    rua varchar(30),
    numero int not null,
    cep numeric(8) not null
);

create table membro(
	idMembro int primary key not null,
    nomeMembro varchar(50) not null,
    cpf numeric(11) not null unique,
	idEndereco int not null,
    foreign key (idEndereco) references endereco (idEndereco)
);

create table emprestimo(
	idEmprestimo int not null,
    dataEmprestimo datetime not null default current_timestamp(),
    dataDevolucao DATETIME AS (DATE_ADD(dataEmprestimo, INTERVAL 7 DAY)), /*Data de devolução após 7 dias*/
    idMembro int not null,
    foreign key (idMembro) references membro (idMembro) on delete cascade on update cascade,
    idLivro int not null,
    foreign key (idLivro) references livro (idLivro)
);

/*Comando da questão 3:*/

insert into categoria(idCategoria , genero)
values
('1' ,'Fantasia'),
('2' ,'Romance'),
('3' ,'Terror'),
('4' ,'Suspense'),
('5','Drama');

insert into autor ( idAutor ,nomeAutor)
values
('1','J.K.Rowling'),
('2','Jane Austen'),
('3','Stephen King'),
('4','C.J.Tudor'),
('5','Susan Lee');

insert into livro (idLivro , nomeLivro , dataPublicacao , nroExemplares , idCategoria) 
values 
('1' , 'Harry Potter e a pedra filosofal' , '1997-06-26','3' , '1' ) ,
('2' , 'Orgulho e preconceito' , '1813-01-28' ,'7' ,'2'),
('3' , 'A dança da morte' , '1978-11-19' ,'5' ,'3'  ),
('4' , 'O homem de giz' , '2018-01-30' ,'12' ,'4' ),
('5' , 'Um drama de verão' , '2022-10-25','2' , '5' );
    
insert into endereco (idEndereco , rua , numero , cep)
values
('1' , 'Rua Ammir' , '648' , '85240050' ),
('2' , 'Rua Espaço' , '456' , '42351687' ),
('3' , 'Rua Dom Pedro','451' , '45239510'),
('4' , 'Rua Napoleão' ,'951' ,'74138516'),
('5' , 'Rua Espanha' ,'136', '42357813');

insert into membro (idMembro, nomeMembro, cpf,idEndereco)
values
('1', 'Pedro','43578139425', '1'),
('2', 'Gustavo','75315982548', '2'),
('3', 'Izabela','53476201680', '3'),
('4', 'James','01201458742', '4'),
('5', 'Ana','46357801201', '5');


insert into emprestimo (idEmprestimo , idMembro , idLivro)
values
('1' , '1' , '1'),
('2','2' , '1' ),
('3' , '3' , '3' ),
('4','4' , '3' ),
('5' , '5' , '2');


select   /*Apenas testando*/
    livro.idLivro,
    livro.nomeLivro,
    autor.nomeAutor,
    categoria.genero,
    membro.nomeMembro,
    emprestimo.idEmprestimo,
    emprestimo.dataDevolucao,
    endereco.cep
from
    livro,
    categoria,
    autor,
    membro,
    emprestimo,
    endereco
where
    livro.idCategoria = categoria.idCategoria
    and livro.idAutor = autor.idAutor
    and emprestimo.idLivro = livro.idLivro
    and emprestimo.idMembro = membro.idMembro
    and emprestimo.idEmprestimo = membro.idMembro
    and endereco.idEndereco = membro.idMembro;
    
/*Comando da questão 4:*/

select autor.nomeAutor
from autor
where nomeAutor like 'A%'; /*Não vai aparecer nada, porque não existe um autor que começa com a letra 'A'*/

/*Comando da questão 5:*/

select livro.nomeLivro
from livro
where nomeLivro like '%sistema%'; /*Não vai aparecer nada, porque não existe um livro com a palavra 'sistema'*/

/*Comando questão 6:*/

select livro.idLivro, livro.nomeLivro
from livro
where dataPublicacao < DATE_SUB(NOW(), interval 5 year);

/*Comando questão 7:*/

select livro.idLivro, livro.nomeLivro, livro.nroExemplares
from livro
where nroExemplares < 5
order by nomeLivro;

/*Comando questão 8:*/

select livro.idLivro, livro.nomeLivro
from livro
where idLivro not in (select distinct idLivro from emprestimo);

/*Comando questão 9:*/

update emprestimo
set dataDevolucao = dataDevolucao - 7;