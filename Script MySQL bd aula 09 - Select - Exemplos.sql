/* Exclui o banco de dados "locadora", caso o banco de dados exista */
drop database if exists locadora;

/* Cria o banco de dados "locadora", com definições com permitem a utilização de acentos e símbolos ("character set utf8mb4")
e a comparação entre caracteres acentuados e que não diferenciam maiúsculas e minúsculas ("utf8mb4_0900_ai_ci") */
create database locadora
character set utf8mb4
collate utf8mb4_0900_ai_ci;

/* Define o banco de dados locadora como o banco de dados atual */
use locadora;

/* Cria a tabela filmes */
create table filmes(
	id int not null auto_increment,
    titulo varchar (50) not null,
	genero enum ('Ação', 'Animação', 'Comédia', 'Drama', 'Romance', 'Suspense', 'Terror'),
    ano year,
    duracao tinyint unsigned,
    pais varchar(20),
    classificacao varchar(5),
	primary key(id)
);

/* Descreve a estrutura da tabela filmes*/
describe filmes;

/* Insere registros na tabela filmes */
insert into filmes
(titulo, genero, ano, duracao, pais, classificacao)
values
('O Garoto', 'Comédia', '1921', '53', 'Estados Unidos', 'Livre'),
('Uma Sombra na Nuvem', 'Ação', '2020', '79', 'Estados Unidos', '14'),
('Toy Story', 'Animação', '1995', '81', 'Estados Unidos', 'Livre'),
('A Família Addams', 'Animação', '2019', '84', 'Canadá', 'Livre'),
('Lucy', 'Ação', '2014', '85', 'Alemanha', '16'),
('Minha Mãe é Uma Peça: O Filme', 'Comédia', '2013', '85', 'Brasil', '12'),
('O Mentiroso', 'Comédia', '1997', '86', 'Estados Unidos', 'Livre'),
('Ameaça no Espaço', 'Ação', '2020', '92', 'Canadá', '16'),
('Monstros S.A.', 'Animação', '2001', '92', 'Estados Unidos', 'Livre'),
('Teu Mundo Não Cabe Nos Meus Olhos', 'Drama', '2018', '93', 'Brasil', '10'),
('Meu Malvado Favorito', 'Animação', '2010', '93', 'Estados Unidos', 'Livre'),
('Missão Cupido', 'Romance', '2017', '94', 'Brasil', '14'),
('Pé Pequeno', 'Animação', '2018', '94', 'Estados Unidos', 'Livre'),
('Sexta-Feira 13: Bem-Vindo A Crystal Lake', 'Terror', '2009', '94', 'Estados Unidos', '18'),
('Alguém Como Você', 'Romance', '2001', '95', 'Estados Unidos', '12'),
('A Hora do Pesadelo ', 'Terror', '2010', '95', 'Estados Unidos', '14'),
('Um Tio Quase Perfeito', 'Comédia', '2016', '96', 'Brasil', 'Livre'),
('O Sol Também é uma Estrela', 'Romance', '2019', '96', 'Estados Unidos', '12'),
('15 Minutos De Guerra', 'Drama', '2018', '97', 'Bélgica', '14'),
('Premonição', 'Terror', '2000', '98', 'Canadá', '14'),
('John Wick - De Volta Ao Jogo', 'Suspense', '2014', '98', 'China', '16'),
('Como Treinar o Seu Dragão', 'Animação', '2010', '98', 'Estados Unidos', 'Livre'),
('Carrie, A Estranha ', 'Terror', '1976', '98', 'Estados Unidos', '16'),
('Amor em Obras', 'Romance', '2019', '98', 'Nova Zelândia', '10'),
('Madrugada Dos Mortos', 'Terror', '2004', '100', 'Canadá', '18'),
('A Vigilante Do Amanhã: Ghost In The Shell', 'Ação', '2017', '100', 'China', '14'),
('Procurando Nemo', 'Animação', '2003', '100', 'Estados Unidos', 'Livre'),
('Minha Vida Em Marte', 'Comédia', '2018', '102', 'Brasil', '12'),
('Uma Segunda Chance Para Amar', 'Comédia', '2019', '103', 'Estados Unidos', '12'),
('Ela Dança, Eu Danço', 'Romance', '2006', '103', 'Estados Unidos', '12'),
('Curtindo A Vida Adoidado', 'Comédia', '1986', '104', 'Estados Unidos', '12'),
('Desejo De Matar', 'Suspense', '2018', '104', 'Estados Unidos', '18'),
('O Exterminador Do Futuro', 'Ação', '1984', '106', 'Estados Unidos', '14'),
('Cidades De Papel', 'Drama', '2015', '106', 'Estados Unidos', '12'),
('Sequestro Internacional', 'Ação', '2019', '108', 'Estados Unidos', '14'),
('Psicose', 'Suspense', '1960', '108', 'Estados Unidos', '14'),
('Central Do Brasil', 'Drama', '1998', '109', 'Brasil', '12'),
('As Férias Da Minha Vida', 'Comédia', '2006', '109', 'Estados Unidos', '10'),
('Um Tira No Jardim De Infância', 'Comédia', '1990', '109', 'Estados Unidos', '12'),
('Lugares Escuros', 'Drama', '2015', '109', 'Estados Unidos', '16'),
('A Bela E A Fera', 'Romance', '2014', '110', 'Alemanha', '12'),
('Top Gun - Ases Indomáveis', 'Ação', '1986', '110', 'Estados Unidos', 'Livre'),
('Como Eu Era Antes De Você', 'Romance', '2016', '110', 'Estados Unidos', '12'),
('Assalto ao Banco da Espanha', 'Ação', '2020', '113', 'Espanha', '14'),
('Procura-se', 'Suspense', '2020', '113', 'Estados Unidos', '16'),
('Velocidade Máxima', 'Ação', '1994', '114', 'Estados Unidos', '14'),
('Os Incríveis', 'Animação', '2004', '115', 'Estados Unidos', 'Livre'),
('Um Bom Ano', 'Romance', '2006', '115', 'Estados Unidos', '10'),
('A Vida É Bela', 'Drama', '1997', '115', 'Itália', 'Livre'),
('Carros', 'Animação', '2006', '117', 'Estados Unidos', 'Livre'),
('O Rei Leão', 'Animação', '2019', '118', 'Estados Unidos', 'Livre'),
('Beleza Americana', 'Drama', '1999', '118', 'Estados Unidos', '18'),
('Doentes de Amor', 'Comédia', '2017', '119', 'Estados Unidos', '12'),
('O Exterminador Do Futuro: Gênesis', 'Ação', '2015', '122', 'Canadá', '12'),
('P.S. Eu Te Amo', 'Romance', '2007', '123', 'Estados Unidos', '12'),
('Estrelas Além Do Tempo', 'Drama', '2016', '124', 'Estados Unidos', 'Livre'),
('A Cabana', 'Drama', '2017', '127', 'Estados Unidos', '12'),
('Parasita', 'Suspense', '2019', '131', 'Coréia do Sul', '16'),
('O Amor Não Tira Férias', 'Romance', '2006', '133', 'Estados Unidos', '10'),
('Forrest Gump', 'Drama', '1994', '137', 'Estados Unidos', '14');

/* Trabalhando com selects. O resultado de um select é chamado de "Result set". */

/* Filtrando colunas */

/* Mostra todos os registros da tabela filmes. 
Por padrão, o MySQL mostra os registros em ordem de chave primária. */
select * from filmes;

/* Mostra os registros da tabela filmes em ordem crescente de título.
O padrão de classificação é ascendente. Assim o "asc" é opcional. */
select * from filmes order by titulo asc;

/* Mostra os registros da tabela filmes em ordem decrescente de título. */
select * from filmes order by titulo desc;

/* Mostra apenas os campos titulo e ano da tabela filmes em ordem crescente de título. */
select titulo, ano from filmes order by titulo;

/* Mostra apenas os campos titulo e ano da tabela filmes em ordem crescente de ano. */
select titulo, ano from filmes order by ano;

/* Mostra apenas os campos titulo e ano da tabela filmes em ordem crescente de ano
e em ordem crescente de título. */
select titulo, ano from filmes order by ano, titulo;

/* Mostra apenas os campos titulo e ano da tabela filmes em ordem crescente de ano
e em ordem decrescente de título. */
select titulo, ano from filmes order by ano, titulo desc;

/* Filtrando linhas */

/* Mostra todos os filmes lançados em 2018. */
select titulo, ano from filmes where ano = '2018' order by titulo;

/* Mostra todos os filmes lançados após 2018. */
select titulo, ano from filmes where ano > '2018' order by ano, titulo;

/* Mostra todos os filmes lançados em 2018 ou após 2018. */
select titulo, ano from filmes where ano >= '2018' order by ano, titulo;

/* Mostra todos os filmes lançados antes de 2018. */
select titulo, ano from filmes where ano < '2018' order by ano, titulo;

/* Mostra todos os filmes lançados antes de 2018 ou em 2018. */
select titulo, ano from filmes where ano <= '2018' order by ano, titulo;

/* Mostra todos os filmes lançados em um ano diferente de 2018. */
select titulo, ano from filmes where ano != '2018' order by ano, titulo;

/* Mostra todos os filmes lançados em um ano diferente de 2018. */
select titulo, ano from filmes where ano <> '2018' order by ano, titulo;

/* Mostra todos os filmes lançados entre 2015 e 2018. */
select titulo, genero, ano from filmes where ano between '2015' and '2018' order by ano, titulo;

/* Mostra todos os filmes lançados em 2015 ou 2018. */
select titulo, genero, ano from filmes where ano in ('2015', '2018') order by ano, titulo;

/* Mostra todos os filmes, exceto os lançados em 2015 ou 2018. */
select titulo, genero, ano from filmes where ano not in ('2015', '2018') order by ano, titulo;

/* Mostra todos os filmes com classificação entre 10 e 12 anos. */
select titulo, classificacao from filmes where classificacao between '10' and '12' order by titulo;

/* Mostra todos os filmes com classificação livre, 10 anos ou 12 anos. */
select titulo, classificacao from filmes where classificacao in ('Livre', '10', '12') order by titulo;

/* Mostra todos os filmes com classificação diferente de livre, 10 anos ou 12 anos. */
select titulo, classificacao from filmes where classificacao not in ('Livre', '10', '12') order by titulo;

/* Mostra os filmes de Romance lançados em 2006. */
select titulo, genero, ano from filmes where genero = 'Romance' and ano = '2006' order by titulo;

/* Mostra os filmes de Animação ou Terror. */
select titulo, genero, ano from filmes where genero = 'Animação' or genero = 'Terror';

/* Mostra os filmes de Animação ou Terror. */
select id, titulo, genero, ano from filmes where genero = 'Animação' or genero = 'Terror' order by genero, ano;

/* O comando "like" é utilizado para mostrar registros com um determinado conteúdo no início,
no meio ou final de um campo. */

/* Mostra os filmes com a palavra "amor" no início do campo. */
select titulo, genero from filmes where titulo like 'amor%';

/* Mostra os filmes com a palavra "amor" no fim do campo. */
select titulo, genero from filmes where titulo like '%amor';

/* Mostra os filmes com a palavra "amor" em qualquer posição do campo. */
select titulo, genero from filmes where titulo like '%amor%';

/* Mostra os filmes que não possuem a palavra "amor" em qualquer posição do campo. */
select titulo, genero from filmes where titulo not like '%amor%';

/* Mostra os filmes com a letra "e" em qualquer posição do campo.
Mostra, inclusive, caracteres acentuados. */
select titulo, genero from filmes where titulo like '%e%';

/* Mostra os filmes com a letra "m" como segundo caracter do campo.
Foi utilizado 1 sublinhado.*/
select titulo, genero from filmes where titulo like '_m%';

/* Mostra os filmes com a letra "v" como terceiro caracter do campo.
Foram utilizados 2 sublinhados. */
select titulo, genero from filmes where titulo like '__v%';

/* Mostra os gêneros de cada filme. */
select genero from filmes;

/* Mostra apenas as ocorrências distintas de gênero na tabela filmes. */
select distinct genero from filmes;

/* Mostra apenas as ocorrência distintas de país na tabela filmes. */
select distinct pais from filmes;

/* Funções de agregação. */

/* Mostra a quantidade de titulos da tabela filmes. */
select count(*) from filmes;

/* Mostra a quantidade de titulos do gênero "Animação". */
select count(*) from filmes where genero = 'Animação';

/* Mostra qual o ano mais recente de um filme. */
select max(ano) from filmes;

/* Mostra qual o ano mais antigo de um filme. */
select min(ano) from filmes;

/* Mostra qual o ano mais antigo de um filme de terror. */
select min(ano) from filmes where genero = 'Terror';

/* Mostra a soma da duração dos filmes de Suspense. */
select sum(duracao) from filmes where genero = 'Suspense';

/* Mostra a média de duração dos filmes de Comédia. */
select avg(duracao) from filmes where genero = 'Comédia';

/* Agrupando registros */

/* Mostra os registro agrupados por gênero. */
select genero from filmes
group by genero;

/* Mostra os registro agrupados por gênero, contando os registros. */
select genero, count(titulo) from filmes
group by genero;

/* Mostra os registro agrupados por gênero, contando os registros, apenas para a classificação "Livre". */
select genero, count(titulo) from filmes
where classificacao = 'Livre'
group by genero;

/* Mostra os registro agrupados por gênero, contando os registros, apenas para a classificação "Livre"
e que possuam 3 ou mais registros na contagem. O comando "having" deve ser usado para a mesma coluna do "group by".*/
select genero, count(titulo) from filmes
where classificacao = 'Livre'
group by genero
having count(titulo) >= 3;

/* Mostra os registros agrupados por ano e a contagem de registros por ano, classificados pela contagem. */
select ano, count(*) as Total_por_ano from filmes
group by ano
order by count(*);
/* Decrescente */
select ano, count(*) as Total_por_ano from filmes
group by ano
order by count(*) desc;

/* Mostra os registros agrupados por ano e a contagem de registros por ano, classificados pela contagem.
e que possuam 5 ou mais registros na contagem. */
select ano, count(*) as Total_por_ano from filmes
group by ano
having count(ano) >=5
order by count(*);

/* Exclui  a tabela de filmes. */
drop table filmes;

/* Exclui o banco de dados locadora. */
drop database locadora;

