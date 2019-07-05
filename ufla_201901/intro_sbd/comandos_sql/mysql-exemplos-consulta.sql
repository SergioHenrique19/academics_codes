use Empresa;

-- lista o nome e o salário de todos os funcionarios
select nomeFunc, salario
from Funcionario;

-- lista o nome e o salário dos funcionários do sexo feminino que ganham mais de 1000
select nomeFunc, salario
from Funcionario
where sexo='F' and salario>1000;

-- lista todos os dados de todos os funcionários
select *
from Funcionario;

-- lista o nome e o salário dos funcionarios que ganham entre 1000 e 2000, inclusive
select nomeFunc, salario
from Funcionario
where salario >= 1000 and salario <= 2000;

select nomeFunc, salario
from Funcionario
where salario between 1000 and 2000;

-- lista o nome e o salário dos funcionários que têm 'Santos' no nome
select nomeFunc, salario
from Funcionario
where nomeFunc like '%Santos%';

-- lista os salários distintos dos funcionários
select distinct salario
from Funcionario;

-- lista o nome dos funcionários e o nome de seus respectivos departamentos
-- Junção usando a condição de junção na cláusula WHERE
select nomeFunc, nomeDepto
from Funcionario, Departamento
where Funcionario.idDepto = Departamento.idDepto;

-- lista o nome dos funcionários e o nome de seus respectivos departamentos
-- Junção usando o operador JOIN (INNER JOIN)
select nomeFunc, nomeDepto
from Funcionario join Departamento on Funcionario.idDepto = Departamento.idDepto;

-- lista o nome dos funcionários e o nome de seus respectivos departamentos
-- Junção natural
select nomeFunc, nomeDepto
from Funcionario natural join Departamento;

-- lista o nome dos funcionários e o nome de seus respectivos departamentos
-- usando alias
select nomeFunc, nomeDepto
from Funcionario as F join Departamento as D on F.idDepto = D.idDepto;

-- lista o nome dos funcionários e o nome de seus respectivos departamentos
-- 'as' é opcional
select nomeFunc, nomeDepto
from Funcionario F join Departamento D on F.idDepto = D.idDepto;

-- lista o nome dos funcionários que pertencem ao departamento de nome 'Pesquisa' ou
-- trabalham em projetos controlados pelo departamento 'Pesquisa'
select nomeFunc
from Funcionario natural join Departamento
where nomeDepto='Pesquisa'
union
select nomeFunc
from Funcionario F, Trabalha T, Projeto P, Departamento D
where nomeDepto='Pesquisa' and D.idDepto=P.idDepto and 
      P.idProj=T.idProj and T.idFunc=F.idFunc;

-- lista o nome dos funcionários que pertencem ao departamento de nome 'Pesquisa' e
-- trabalham em projetos controlados pelo departamento 'Pesquisa'
-- INTERSECT não está implementado no MySQL, mas é padrão SQL
select nomeFunc
from Funcionario natural join Departamento
where nomeDepto='Pesquisa'
in -- intersect
(select nomeFunc
from Funcionario F, Trabalha T, Projeto P, Departamento D
where nomeDepto='Pesquisa' and D.idDepto=P.idDepto and 
      P.idProj=T.idProj and T.idFunc=F.idFunc);

-- lista o ID dos funcionários que não têm dependentes
-- MINUS não está implementado no MySQL, mas é padrão SQL
select idFunc
from Funcionario
minus
select idFunc
from Dependente;

-- lista o ID dos funcionários que não têm dependentes
-- mesma consulta, usando IN (pertence)
select idFunc
from Funcionario
where idFunc NOT IN
  (select idFunc
  from Dependente);

-- lista o nome e o salário dos funcionários que ganham mais do
-- algum funcionario do sexo feminino
select nomeFunc, salario
from Funcionario
where salario > some
   (select salario
	from Funcionario
    where sexo='F');

-- lista o nome e o salário dos funcionários que ganham mais do
-- que todos os funcionários do sexo feminino
select nomeFunc, salario
from Funcionario
where salario > all
   (select salario
	from Funcionario
    where sexo='F');

-- lista o nome dos funcionários que têm dependentes
select distinct nomeFunc
from Funcionario F join Dependente D on F.idFunc=D.idFunc;

-- lista o nome dos funcionários que têm dependentes
-- INEFICIENTE, pois a consulta interna depende da consulta externa
select nomeFunc
from Funcionario F
where exists (select idFunc
              from Dependente D
              where F.idFunc=D.idFunc);

-- lista o nome dos funcionários que NÃO têm dependentes
-- INEFICIENTE, pois a consulta interna depende da consulta externa
select nomeFunc
from Funcionario F
where not exists (select idFunc
                  from Dependente D
		  where F.idFunc=D.idFunc);

-- lista o nome dos funcionários que NÂO têm dependentes
-- MAIS EFICIENTE do que o exemplo anterior com EXISTS, pois
-- o SELECT mais interno não depende do SELECT mais externo
select nomeFunc
from Funcionario
where idFunc not in (select idFunc
                     from Dependente);
                      
-- Tratando valores nulos
-- lista todos os funcionários
-- retorna 8 funcionários
select idFunc, nomeFunc, idSuperv
from Funcionario;

-- lista os funcionários que não têm supervisor
-- retorna 1 funcionario
select idFunc, nomeFunc, idSuperv
from Funcionario
where idSuperv IS NULL;

-- lista os funcionários que têm supervisor
-- retorna 7 funcionários
select idFunc, nomeFunc, idSuperv
from Funcionario
where idSuperv IS NOT NULL;

-- lista os funcionários que são supervisionados pelo func de id = 2
-- retorna 3 funcionários
select idFunc, nomeFunc, idSuperv
from Funcionario
where idSuperv = 2;

-- lista os funcionários que não são supervisionados pelo func de id = 2
-- retorna 4 funcionários
select idFunc, nomeFunc, idSuperv
from Funcionario
where idSuperv != 2;

-- lista os funcionários que não são supervisionados pelo func de id = 2
-- retorna 5 funcionários
select idFunc, nomeFunc, idSuperv
from Funcionario
where idSuperv != 2 OR idSuperv IS NULL;

-- lista o número de funcionários, o maior salário, o menor salário,
-- a média de salários e a soma de salários
select count(*), max(salario), min(salario), avg(salario), sum(salario)
from Funcionario;

-- lista o número de funcionários e a soma de salários dos funcionários
-- do departamento 1
select count(*) as numFuncs, sum(salario) as somaSalarios
from Funcionario
where idDepto=1;

-- count(*) conta tudo, incluindo os nulos
-- count(coluna) conta apenas os valores não nulos da coluna
select count(*), count(idSuperv)
from Funcionario;

-- lista o número de funcionários e a soma de seus salários
-- para cada departamento
select idDepto, count(*), sum(salario)
from Funcionario
group by idDepto;

-- lista o número de funcionários e a soma de seus salário
-- para cada departamento com mais de 2 funcionários
select idDepto, count(*), sum(salario)
from Funcionario
group by idDepto
having count(*) > 2;

-- lista o número de funcionários do sexo masculino e a soma de seus salários
-- para cada departamento com mais de 2 funcionários
select idDepto, count(*), sum(salario)
from Funcionario
where sexo='M'
group by idDepto
having count(*) > 2;

-- lista os funcionários ordenados por nome
select nomeFunc, salario
from Funcionario
order by nomeFunc;

-- lista os funcionários ordenados pelo id de seu departamento
-- e dentro do departamento, ordenados por nome
select nomeFunc, idDepto
from Funcionario
order by idDepto, nomeFunc;

-- lista os funcionários ordenados por nome (ordem decrescente)
select nomeFunc, salario
from Funcionario
order by nomeFunc desc;

-- lista os funcionários ordenados por salário (ordem decrescente)
select nomeFunc, salario
from Funcionario
order by salario desc;

-- lista os funcionários ordenados por salario (decrescente)
-- se houver empate, ordena por nome (crescente)
select nomeFunc, salario
from Funcionario
order by salario desc, nomeFunc asc;

-- Junção interna (INNER JOIN, ou simplesmente JOIN)
-- no resultado, só aparecem as linhas que casam na condição de junção
select nomeFunc, NomeDep
from Funcionario F JOIN Dependente D ON (F.idFunc=D.idFunc)

-- Junção externa (OUTER JOIN)
-- no resultado, aparecem tanto as linhas que casam na condição de junção
-- quanto as que não casam (deixando um NULL explícito),
-- de acordo com a tabela que está à esquerda da junção (LEFT OUTER JOIN)
-- ou à direita (RIGHT OUTER JOIN) ou ambas (FULL OUTER JOIN)
select nomeFunc, NomeDep
from Funcionario F LEFT OUTER JOIN Dependente D ON (F.idFunc=D.idFunc)

-- lista os funcionários que NÃO tem dependentes
select nomeFunc
from Funcionario F LEFT OUTER JOIN Dependente D ON (F.idFunc=D.idFunc)
where nomeDep IS NULL;

-- insere uma linha da tabela funcionário
-- os valores estão na ordem em que as colunas foram definidas na tabela
INSERT INTO Funcionario
VALUES (9,'Ana Amélia','Av. Amazonas, 1175','1945/02/01','F',1100,2,1);

select * 
from Funcionario
where idFunc=9;

-- insere uma linha da tabela funcionário
-- os valores estão na ordem em que as colunas foram definidas na tabela
INSERT INTO Funcionario (idFunc, nomeFunc, salario, idDepto, endereco, dataNasc, sexo, idSuperv)
VALUES (10,'Ana Aparecida',2100,2,'Av. do Contorno, 1005','1985/02/01','F',3);

select * 
from Funcionario
where idFunc=10;

-- insere dados oriundos de outra tabela

create table SumarioFuncDepto (
idDepto INT NOT NULL PRIMARY KEY,
nomeDepto VARCHAR(30) NOT NULL,
numFuncs INT NOT NULL,
somaSalarios DECIMAL(10,2) NOT NULL
);

insert into SumarioFuncDepto
select idDepto, nomeDepto, count(*), sum(salario)
from Funcionario natural join Departamento
group by idDepto, nomeDepto;

select * from SumarioFuncDepto;

-- exclui o funcionário de id = 9
delete from Funcionario
where idFunc=9;

-- exclui todos os funcionários
-- no MySQL, o modo "safe update" deve ser desabilitado
-- Edit --> Preferences --> SQL Editor --> desmarque "Safe Updates"
-- Só passa a valer a partir da próxima conexão
delete from Funcionario;

-- exclui os funcionários do departamento de nome 'Pesquisa'
delete from Funcionario
where idDepto in (select idDepto
                  from Departamento
				  where nomeDepto='Pesquisa');
                  
-- modifica o salário do funcionário de id = 3 para 1.100
update Funcionario
set salario = 1100
where idFunc = 3;

select idFunc, salario
from Funcionario;

-- reajusta em 10% o salário de todos os funcionários do departamento 1
update Funcionario
set salario = salario * 1.1
where idDepto = 1;

-- reajusta em 5% o salário dos funcionários que têm dependentes
update Funcionario
set salario = salario * 1.05
where idFunc in (select idFunc
                 from Dependente);

-- cria uma visão (view) para manter os nomes dos funcionários e 
-- os nomes de seus respectivos departamentos
create view FuncDepto as
select nomeFunc, nomeDepto
from Funcionario natural join Departamento;

-- exemplo de como usar a view para recuperar os funcionários do departamento 'Pesquisa'
select nomeFunc, nomeDepto
from Func_Depto
where nomeDepto='Pesquisa';
