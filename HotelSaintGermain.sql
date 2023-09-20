/*Criação do banco de dados HotelSaintGermain*/
create database HotelSaintGermain;

/*Usar banco de dados*/
use HotelSaintGermain;

/*Criação da tabela cliente*/
create table Cliente (
	IdCliente int primary key auto_increment ,
    Nome varchar (100) not null ,
    CPF numeric (11) unique ,
    Sexo char(1),
    DtaNasci datetime not null,
    cidade varchar(30) null,
    Uf char(2),
    Pais varchar(20) default 'Brasil',
    DtaCadastro datetime not null default current_timestamp()
);

insert into Cliente (IdCliente , Nome , CPF , Sexo , DtaNasci , cidade , Uf , Pais )
values ('1' , 'Gustavo Cirino' , '32745577930' , 'M' , '2005-02-28' , 'Curitiba' , 'PR' , 'Brasil');

insert into Cliente (IdCliente , Nome , CPF , Sexo , DtaNasci , cidade , Uf , Pais )
values ('2' , 'Giovane Camargo' , '12783567559' , 'M' , '2005-11-27' , 'Curitiba' , 'PR' , 'Brasil');

insert into Cliente (IdCliente , Nome , CPF , Sexo , DtaNasci , cidade , Uf , Pais )
values ('3' , 'Maria' , '02747277336' , 'F' , '1998-07-09' , 'Campo Largo' , 'PR' , 'Brasil');

insert into Cliente (IdCliente , Nome , Sexo , DtaNasci , cidade , Pais ) /*estrangeira*/
values ('4', 'Shakira' , 'F' , '1977-02-02' , 'Barranquila' , 'Colômbia');

insert into Cliente (IdCliente , Nome , Sexo , DtaNasci , cidade , Pais ) /*estrangeiro*/
values ('5' , 'Lionel Messi' , 'M' , '1987-06-24' , 'Rosária' , 'Argentina');

select * from Cliente;


/*Criação da tabela Reserva*/
create table Reserva(
	NroReserva int primary key unique,
    IdCliente int,
    DataHora datetime not null default current_timestamp(),
    Periodo tinyint not null,
    foreign key (IdCliente) references Cliente(IdCliente)
);

insert into Reserva (NroReserva , IdCliente , Periodo) values ('1' , '1' , '5');
insert into Reserva (NroReserva , IdCliente , Periodo) values ('2' , '2' , '3');
insert into Reserva (NroReserva , IdCliente , Periodo) values ('3' , '3' , '10');
insert into Reserva (NroReserva , IdCliente , Periodo) values ('4' , '4' , '20');
insert into Reserva (NroReserva , IdCliente , Periodo) values ('5' , '5' , '13');

select * from Reserva;

create table Quarto(
	NroQuarto int primary key not null unique ,
    Andar int not null,
    Tipo char(1) null,
    Descricao varchar (100),
    VlrDiaria decimal (6,2), /*5 = quantidade de digitos , 2 = decimal*/
    NroReserva int unique,
    foreign key (NroReserva) references Reserva (NroReserva)
);

insert into Quarto (NroQuarto , Andar , Tipo , VlrDiaria , NroReserva)
values ('20' , '2' , 'S' , '1000.00' , '1');

insert into Quarto (NroQuarto , Andar , Tipo , VlrDiaria , NroReserva)
values ('25' , '2' , 'T' , '1500.00' , '2');

insert into Quarto (NroQuarto , Andar , Tipo , VlrDiaria , NroReserva)
values ('15' , '1' , 'D' , '1200.00' , '3');

insert into Quarto (NroQuarto , Andar , Tipo , Descricao , VlrDiaria , NroReserva)
values ('35' , '2' , 'T' , 'Travesseiro de pena de ganso' , '1500.00' , '4');

insert into Quarto (NroQuarto , Andar , Tipo , Descricao , VlrDiaria , NroReserva)
values ('42' , '3' , 'T' , 'Segurança na porta do quarto' , '1500.00' , '5');

select * from Quarto;

/*Criação da tabela Telefone, precisa de uma tabela para talefone pois é multivalorado(Um cliente pode ter mais de um telefone)*/
create table Telefone(
	Numero varchar(20),
    IdCliente int,
    primary key (Numero, IdCliente),
    foreign key (IdCliente) references Cliente(IdCliente)
);

/*Criação da tabela Ocupacao*/
create table Ocupacao (
	NroReserva int primary key,
    NroQuarto int,
    foreign key (NroQuarto) references Quarto (NroReserva),
    Entrada datetime,
    Saida datetime,
    foreign key (NroReserva) references Reserva(NroReserva)
);

/*Criação da tabela Restaurante*/
create table Restaurante (
	IdRestaurante int primary key,
    Prato int, /*Cada prato vai ter um número*/
    Preco decimal(5,2)
);

/*Criação da tabela OcupacaoRestaurante*/
create table OcupacaoRestaurante(
	NroReserva int,
    IdRestaurante int,
    DataHora datetime,
    Quantidade tinyint,
    primary key (NroReserva, IdRestaurante, DataHora),
    foreign key (NroReserva) references Reserva(NroReserva),
    foreign key (IdRestaurante) references Restaurante(IdRestaurante)
);


