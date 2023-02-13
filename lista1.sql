 create table Livro (
    CodigoLivro number(5) primary key,
    Titulo varchar2(30),
    Editora varchar2(20),
    Cidade varchar2(30),
    DataEdicao date,
    Versao number(3),
    CodAssunto number(5),
    Preco number(5, 2),
    DataCadastro date,
    lancamento Char(1)
);

create table Assunto (
    CodAssunto number(5) primary key,
    descricao varchar2(40),
    descontopromocao char(1)
);

create table AutorLivro (
    codigoLivro number(5) not NULL,
    codAutor number(5) not NULL
);

create table Autor (
    CodAutor number(5) primary key,
    Nomeautor varchar2(20),
    datanascimento date,
    CidadeNasc varchar2(20),
    sexo char(1)
);

alter table
    AutorLivro
add
    constraint pk_cod_livro_autor primary key (codigolivro, codAutor);

alter table
    AutorLivro
add
    constraint fk_codlivro_livro foreign key (codigolivro) references Livro;

alter table
    AutorLivro
add
    constraint fk_autorlivro_codautor foreign key (codAutor) references Autor;

alter table
    Livro
add
    constraint fk_livro_codAssunto foreign key (CodAssunto) references Assunto;


    --2 - Escreva os comandos necessários para incluir 2 linhas em cada tabela listada acima.A inclusão dos registros de dados devem obedecer a uma ordem ? Porque ?
-- R: As inserções devem ocorrer em determina ordem, toda vez que houver chave estrangeira definida em alguma tabela,
--     pois essa chave fará referência ao campo de uma outra tabela, onde ela(fk) é chave primaria,
--     logo o registro já deve existir na tabela onde esse campo é pk, para poder ser referenciado como fk em outra tabela.
insert into
    Assunto
values
    (10, 'SISTEMA DA INFORMAÇÃO', 'N');

insert into
    Assunto
values
    (5, 'ENGENHARIA DE SOFTWARE', 'S');

insert into
    Autor
values
    (
        1,
        'Jose Miguel',
        date'1950-02-01',
        'VOTORANTIM',
        'M'    
    );

insert into
    Autor
values
    (
        2,
        'Maria jose ',
        date'1950-02-01',
        'VOTORANTIM',
        'M'
        
    );

    insert into
    Livro
values
    (
        3,
        'INTRODUCAO A BANCOS DE DADOS',
        'SARAIVA',
        'SÃO PAULO',
        DATE '1980-02-03',
        1,
        5,
        78.45,
        DATE '2022-02-10',
        'N'
    );

    insert into
    Livro
values
    (
        7,
        ' JAVASCRIPT PARA LEIGOS',
        'SEINAO',
        'SÃO PAULO',
        DATE '1981-02-03',
        2,
        10,
        20,
        DATE '2022-02-10',
        'N'
    );

     insert into AutorLivro 
     values (7,2);

     insert into AutorLivro 
     values (3,2);

--3 - Adicionar uma nova coluna de nome Nacionalidade na tabela Autor.

alter table
    Autor
add
    Nacionalidade varchar2(30);

--4 - Alterar a coluna Titulo da tabela Livros de 30 para 40 posições.
alter table
    Livro
modify
    Titulo varchar2(40);

--5 - Incluir uma restrição de domínio para a coluna descontopromocao da tabela assunto de forma a aceitar apenas ‘ S ’ ou ‘ N ’.
alter table
    Assunto
add
    check (descontopromocao in ('S', 'N'));

--6 - Alterar o campo editora da tabela livros mudando para ‘ Editora LTC ’ para o livro de código 3.


update Livro
set editora = ' Editora LTC'
where codigoLivro = 3;

--7 - Excluir os livros com codassunto igual a 10 e anoedição menor que 1980;

delete from Livro 
where codassunto = 10 and to_char(DataEdicao, 'yyyy') < '1980';

--8 -.Listar o título dos livros que possuam a palavra “ Banco de Dados ’ em qualquer posição do Título.

select titulo from Livro
where titulo like '%BANCOS DE DADOS%';



--9 - Listar o nome dos autores que nasceram entre 1950 e 1970 ordenado pela cidade e depois pelo nome.

select nomeautor from autor
where extract(year from datanascimento)  between '1950' and '1970'
order by cidadenasc,nomeautor;



--10 - Listar a quantidade de livros existentes por assunto.Exibir o código do assunto e a qtde de livros.

select codassunto , count(*) as total_por_assunto
from livro
group by codassunto;


--11 - Listar o título do livro e a descrição do assunto a qual ele pertence.



select livro.titulo, assunto.descricao
from livro inner join assunto 
on livro.codassunto = assunto.codassunto;

--12 - Listar o código do livro,titulo,código e nome dos autores de cada livro 


select livro.codigolivro, livro.titulo, autor.codautor, autor.nomeautor
from livro inner join autorlivro
on livro.codigolivro = autorlivro.codigolivro
inner join autor
on autorlivro.codautor=autor.codautor;





--13 - Listar o código dos autores que tem mais de 3 livros publicados.

select codautor , count(*) as qtde_livros_publicados
from autorlivro
group by codautor
having count(*) > 3;