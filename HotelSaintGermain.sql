/*Criação do banco de dados HotelSaintGermain*/
create database HotelSaintGermain;

/*Usar banco de dados*/
use HotelSaintGermain;

/*Criação da tabela cliente*/
create table Cliente (
	IdCliente int primary key auto_increment ,
    Nome varchar (100) not null ,
    CPF numeric (11) unique null ,
    Sexo char(1),
    DtaNasci datetime not null,
    cidade varchar(20) null,
    Uf char(2) default 'PR',
    Pais varchar(20) default 'Brasil',
    Tipo int check (Tipo in (1, 2)),
    DtaCadastro datetime not null default current_timestamp()
);

/*Criação da tabela Reserva*/
create table Reserva(
	NroReserva int primary key,
    IdCliente int,
    DataHora datetime not null,
    Periodo tinyint not null,
    foreign key (IdCliente) references Cliente(IdCliente)
);

/*Criação da tabela Telefone*/
create table Telefone(
	Numero varchar(20),
    IdCliente int,
    primary key (Numero, IdCliente),
    foreign key (IdCliente) references Cliente(IdCliente)
);

/*Criação da tabela Ocupacao*/
create table Ocupacao (
	NroReserva int primary key,
    Entrada datetime,
    Saida datetime,
    foreign key (NroReserva) references Reserva(NroReserva)
);

/*Criação da tabela Restaurante*/
create table Restaurante (
	IdRestaurante int primary key,
    Prato varchar(50),
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

/*Mostrar tabela Cliente*/
describe Cliente;

/*Mudar algo na tabela Cliente*/
alter table Cliente 
	/*Adicionar campo Profissao na tabela Cliente*/
	add Profissao varchar(30) not null, 
    /*Adicionar campo Obs na tabela Cliente*/
    add Obs varchar(500);

/*Mudar algo na tabela Cliente*/
alter table Cliente
	/*Modifica campo nome na tebela Cliente*/
	modify column Nome varchar(40) unique,
	/*Modifica campo Sexo na tebela Cliente*/
	modify column Sexo char(2) not null;

/*Mostrar tabela Cliente*/
describe Cliente;

