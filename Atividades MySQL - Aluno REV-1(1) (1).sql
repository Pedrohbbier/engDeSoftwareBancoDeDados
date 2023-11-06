/* Exclui o banco de dados "empresa", caso o banco de dados exista */
drop database if exists empresa;

/* Cria o banco de dados "empresa" */
create database empresa;

/* Define o banco de dados "empresa" como o banco de dados atual */
use empresa;

/* Cria a tabela "fornecedores" */
create table fornecedores(
	id_fornecedor int primary key not null,
    nome_fornecedor varchar(50) not null,
    cidade varchar(40) not null,
    uf char(2) not null
);

/* Cria a tabela "unidades" */
create table unidades(
	id_unidade int primary key not null,
    nome_unidade varchar(50) not null
);

/* Cria a tabela "materiais" */
create table materiais(
	id_material int primary key not null,
    foreign key (id_fornecedor) references fornecedores (id_fornecedor),
    id_fornecedor int not null ,
    nome_material varchar(50) not null,
    quantidade_estoque int not null,
    quantidade_estoque_minima int not null,
    id_unidade int not null,
    foreign key (id_unidade) references unidades (id_unidade)
);

/* Cria a tabela "pedidos" */
create table pedidos(
	id_pedido int primary key not null,
    data_pedido datetime not null
);

/* Cria a tabela "itens_pedido" */
create table itens_pedido(
	id_item_pedido int primary key not null,
    id_pedido int not null,
    foreign key (id_pedido) references pedidos (id_pedido),
    id_material int not null,
    foreign key (id_material) references materiais (id_material),
    quantidade_pedida int not null,
    valor_unitario decimal(10,2)
);

/* Insere registros na tabela "Fornecedores" */
insert into fornecedores
(id_fornecedor, nome_fornecedor, cidade, uf)
values
('1', 'ABC Materiais Elétricos', 'Curitiba', 'PR'),
('2', 'XYZ Materiais de Escritório', 'Rio de Janeiro', 'RJ'),
('3', 'Hidra Materiais Hidraulicos', 'São Paulo', 'SP'),
('4', 'HidraX Materiais Elétricos e Hidraulicos', 'Porto Alegre', 'RS');

/* Mostra os registros da tabela "Fornecedores" */
select * from fornecedores;

/* Insere registros na tabela "Unidades" */
insert into unidades
(id_unidade, nome_unidade)
values
('1', 'Unidades'),
('2', 'Kg'),
('3', 'Litros'),
('4', 'Caixa com 12 unidades'),
('5', 'Caixa com 100 unidades'),
('6', 'Metros');

/* Mostra os registros da tabela "Unidades" */
select * from unidades;

/* Insere registros na tabela "Materiais" */
insert into materiais
(id_material , id_fornecedor, nome_material, quantidade_estoque, quantidade_estoque_minima, id_unidade)
values
('1', '1', 'Tomada elétrica 10A padrão novo', '12', '5', '1'),
('2', '1', 'Disjuntor elétrico 25A', '10', '5', '1'),
('3', '2', 'Resma papel branco A4', '32', '20', '4'),
('4', '2', 'Toner impressora HR5522', '6', '10', '1'),
('5', '3', 'Cano PVC 1/2 pol', '6', '10', '6'),
('6', '3', 'Cano PVC 3/4 pol', '8', '10', '6'),
('7', '3', 'Medidor hidráulico 1/2 pol', '3', '2', '1'),
('8', '3', 'Conector Joelho 1/2 pol', '18', '15', '1'),
('9', '1', 'Tomada elétrica 20A padrão novo', '8', '5', '1'),
('10', '2', 'Caneta esferográfica azul', '80', '120', '1'),
('11', '2', 'Grampeador mesa pequeno', '5', '5', '1'),
('12', '2', 'Caneta Marca Texto Amarela', '6', '15', '5'),
('13', '2', 'Lápis Preto HB', '15', '25', '1');

/* Mostra os registros da tabela "Materiais" */
select * from materiais;

/* Insere registros na tabela "Pedidos" */
insert into pedidos
(id_pedido, data_pedido)
values
('1', '2015-02-25'),
('2', '2014-02-10'),
('3', '2015-03-01');

/* Mostra os registros da tabela "Pedidos" */
select * from pedidos;

/* Insere registros na tabela "Itens pedido" */
insert into itens_pedido
(id_item_pedido, id_pedido, id_material, quantidade_pedida, valor_unitario)
values
('1', '1', '10', '100', '0.50'),
('2', '1', '13', '100', '0.25'),
('3', '2', '8', '50', '1.30'),
('4', '3', '11', '5', '76.00');

/* Mostra os registros da tabela "Itens pedidos" */
select * from itens_pedido;

/* 1 - Nome do material e nome da unidade */
create view materiais_e_unidade as
select
    materiais.nome_material,
    unidades.nome_unidade
from
    materiais
join
    unidades ON materiais.id_unidade = unidades.id_unidade;


select * from materiais_e_unidade;

/* 2 - Nome do material e nome da unidade dos materiais vendidos em unidades */

select * from materiais_e_unidade where nome_unidade = "unidades";

/* 3 - Quantidade de materiais por nome de unidade */

create view quantidade_de_materiais_por_nome_de_unidade as select
materiais.quantidade_estoque,
unidades.nome_unidade,
materiais.nome_material,
unidades.id_unidade
from materiais
join unidades on materiais.id_unidade=unidades.id_unidade;


select * from quantidade_de_materiais_por_nome_de_unidade;

/* 4 - Quantidade de materiais por nome de unidade, incluindo as unidade sem nenhum material relacionado */

create view vwQuantidade_nomeund_semund as
select 
    unidades.nome_unidade,
    count(materiais.nome_material) as quantidade_materiais
from
    unidades 
left join
    materiais on unidades.id_unidade = materiais.id_unidade
group by 
    unidades.nome_unidade;

select * from vwQuantidade_nomeund_semund;

/* 5 - Nome do material, nome do fornecedor e nome da unidade */

create view vwNomemat_nomeForn_nomeUnd as select
materiais.nome_material,
fornecedores.nome_fornecedor,
unidades.nome_unidade
from materiais
join fornecedores on materiais.id_fornecedor= fornecedores.id_fornecedor
join unidades ON materiais.id_unidade = unidades.id_unidade;

select * from vwNomemat_nomeForn_nomeUnd;

/* 6 - Nome do material e nome da unidade dos materiais vendidos por metro */

select * from materiais_e_unidade where nome_unidade = "metros";

/* 7 - Nome do material e nome da unidade dos materiais vendidos em caixas com 12 ou com 100 unidades */

select * from materiais_e_unidade where nome_unidade in ("Caixa com 12 Unidades", "Caixa com 100 Unidades");

/* 8 - Nome do material e sua quantidade em estoque */

select nome_material, quantidade_estoque from quantidade_de_materiais_por_nome_de_unidade order by  nome_material, quantidade_estoque;

/* 9 - Nome do material e sua quantidade em estoque, apenas para materiais com menos de 10 unidades em estoque */

select nome_material, quantidade_estoque from quantidade_de_materiais_por_nome_de_unidade where quantidade_estoque < '10' and id_unidade= '1';

/* 10 - Nome do material, sua quantidade em estoque e sua quantidade mínima em estoque */

select nome_material, quantidade_estoque, quantidade_estoque_minima from materiais;

/* 11 - Nome do material, sua quantidade em estoque e sua quantidade mínima em estoque,
apenas para materiais onde a quantidade em estoque esteja abaixo da quantidade mínima em estoque */

select nome_material, quantidade_estoque, quantidade_estoque_minima
from materiais
where quantidade_estoque < quantidade_estoque_minima;

/* 12 - Nome e cidade dos fornecedores */

select nome_fornecedor, cidade
from fornecedores;

/* 13 - Nome e cidade dos fornecedores da cidade de Curitiba */

select nome_fornecedor, cidade
from fornecedores
where cidade = 'Curitiba';


/* 14 - Nome dos fornecedores e seus materiais */

select f.nome_fornecedor, m.nome_material
from fornecedores f
join materiais m on f.id_fornecedor = m.id_fornecedor;

/* 15 - Nome dos fornecedores e seus materiais, inluindo os fornecedores sem nenhum material reacionado */

select f.nome_fornecedor, m.nome_material
from fornecedores f
left join materiais m on f.id_fornecedor = m.id_fornecedor;

/* 16 - Nome dos fornecedores e quantidade de materiais fornecidos pelo mesmo */

select f.nome_fornecedor, count(m.id_material) as quantidade_de_materiais
from fornecedores f
join materiais m on f.id_fornecedor = m.id_fornecedor
group by f.nome_fornecedor;

/* 17 - Nome dos fornecedores e quantidade de materiais fornecidos pelo mesmo,
incluindo os fornecedores sem nenhum material relacionado */

select f.nome_fornecedor, count(m.id_material) as quantidade_de_materiais
from fornecedores f
left join materiais m on f.id_fornecedor = m.id_fornecedor
group by f.nome_fornecedor;

/* 18 - Nome dos fornecedores e quantidade de materiais fornecidos pelo mesmo,
incluindo os fornecedores sem nenhum material relacionado,
apenas para fornecedores com menos de 5 materiais relacionados */

select f.nome_fornecedor, count(m.id_material) as quantidade_de_materiais
from fornecedores f
left join materiais m on f.id_fornecedor = m.id_fornecedor
group by f.nome_fornecedor
having count(m.id_material) < 5;

/* 19 - Nome dos fornecedores, nome do material e sua quantidade em estoque */

select f.nome_fornecedor, m.nome_material, m.quantidade_estoque
from fornecedores f
join materiais m on f.id_fornecedor = m.id_fornecedor;


/* 20 - Nome dos fornecedores, nome do material e sua quantidade em estoque,
apenas para quatidade em estoque entre 10 e 20 */

select f.nome_fornecedor, m.nome_material, m.quantidade_estoque
from fornecedores f
join materiais m on f.id_fornecedor = m.id_fornecedor
where m.quantidade_estoque between 10 and 20;

/* 21 - Nome do fornecedor, nome do material e nome da unidade,
apenas para fornecedores de materiais em unidades ou metros */

select f.nome_fornecedor, m.nome_material, u.nome_unidade
from fornecedores f
join materiais m on f.id_fornecedor = m.id_fornecedor
join unidades u on m.id_unidade = u.id_unidade
where u.nome_unidade in ('Unidades', 'Metros');

/* 22 - Pedidos realizados em 2015 */

select *
from pedidos
where year(data_pedido) = 2015;SELECT *
from pedidos
where year(data_pedido) = 2015;


/* 23 - Pedidos realizados em fevereiro de 2015 */

select *
from pedidos
where year(data_pedido) = 2015 and month(data_pedido) = 2;

/* 24 - Número do pedido e o nome dos materiais constantes no pedido */

select ip.id_pedido, m.nome_material
from itens_pedido ip
join materiais m on ip.id_material = m.id_material;

/* 25 - Materiais que constam nos pedidos */

select distinct m.nome_material
from materiais m
join itens_pedido ip on m.id_material = ip.id_material;

/* 26 - Materiais que não constam nos pedidos */

select id_pedido, count(id_item_pedido) as quantidade_de_itens
from itens_pedido
group by id_pedido;

/* 27 - Número do pedido e a quantidade de itens em cada pedido */

select id_pedido, count(id_item_pedido) as quantidade_de_itens
from itens_pedido
group by id_pedido;


/* 28 - Número do pedido e o valor total do pedido */

select p.id_pedido, sum(ip.quantidade_pedida * ip.valor_unitario) AS valor_total_pedido
from pedidos p
join itens_pedido ip on p.id_pedido = ip.id_pedido
group by p.id_pedido;

/* 29 - Número do pedido e o valor total do pedido, apenas para pedidos com valor total abaixo de 100,00 */

select id_pedido, sum(quantidade_pedida * valor_unitario) as valor_total_pedido
from itens_pedido
group by id_pedido
having valor_total_pedido < 100.00;

/* 30 - Insira mais um fornecedor no banco de dados */

insert into fornecedores (id_fornecedor, nome_fornecedor, cidade, uf)
values
('5', 'Distribuidora de Materiais Curitiba', 'Curitiba', 'PR');

select * from fornecedores;

/* 31 - Insira mais 2 materiais para o fornecedor inserido no item 30 */
insert into materiais (id_material, id_fornecedor, nome_material, quantidade_estoque, quantidade_estoque_minima, id_unidade)
values
('14', '5', 'Borracha', '100', '10', '1'),
('15', '5', 'Apontador', '100', '10', '1');

select * from materiais;

/* 32 - Insira mais um pedido no banco de dados */

insert into pedidos (id_pedido, data_pedido)
values
('4', '2021-10-21'); 

select * from pedidos;

/* 33 - Insira 2 itens de pedido no banco de dados, utilizando os dados inseridos nos itens 30, 31 e 32 */ 

insert into itens_pedido (id_item_pedido, id_pedido, id_material, quantidade_pedida, valor_unitario)
values
('5', '4', '14', '100', '0.40'),
('6', '4', '15', '100', '0.20');

select * from itens_pedido;

/* 34 - Número do pedido e o valor total do pedido inserido no item 32 */

select p.id_pedido, sum(ip.quantidade_pedida * ip.valor_unitario) as valor_total_pedido
from pedidos p
join itens_pedido ip on p.id_pedido = ip.id_pedido
where p.id_pedido = 4
group by p.id_pedido;

/* 35 - Exclua o material "Tomada elétrica 10A padrão novo" do banco de dados */

delete from materiais
where nome_material = 'Tomada elétrica 10A padrão novo';

select * from materiais;

/* 36 - Exclua o material "Lápis Preto HB" do banco de dados */
delete from itens_pedido
where id_material = (select id_material from materiais where nome_material = 'Lápis Preto HB');

delete from materiais
where nome_material = 'Lápis Preto HB';

select * from itens_pedido;
select * from materiais;

/* 37 - Exclua o fornecedor "HidraX Materiais Elétricos e Hidraulicos" do banco de dados */

delete from fornecedores
where nome_fornecedor = 'HidraX Materiais Elétricos e Hidraulicos';

select * from fornecedores;

/* 38 - Exclua o fornecedor "XYZ Materiais de Escritório" do banco de dados */

delete from fornecedores
where nome_fornecedor = 'XYZ Materiais de Escritório';
