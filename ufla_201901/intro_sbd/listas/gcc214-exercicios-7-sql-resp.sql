-- 1. Selecione o endereço e o salario do funcionário de nome ‘Luciana S. Santos’.
select endereco, salario
from Funcionario
where nomeFunc='Luciana S. Santos';

-- 2. Selecione o nome e o salário dos funcionários que nasceram entre os anos de 1960 e 1969, inclusive, do sexo feminino e que ganham menos de 1000.
select nomeFunc, salario
from Funcionario
where dataNasc between '1960/01/01' and '1969/12/31' and sexo = 'F' and salario < 1000;

-- 3. Selecione o nome dos dependentes do funcionário de nome ‘João B. Silva’.
select nomeDep
from Funcionario F join Dependente D on F.idFunc=D.idFunc
where nomeFunc='João B. Silva';

-- 4. Selecione o nome dos projetos que o funcionário de nome ‘Frank T. Santos’ trabalha.
select nomeProj
from Funcionario F, Trabalha T, Projeto P 
where nomeFunc='Frank T. Santos' and F.idFunc=T.idFunc and T.idProj=P.idProj;

-- 5. Selecione o nome dos funcionários que trabalham em projetos controlados pelo departamento de nome ‘Construção’.
select nomeFunc
from Funcionario F, Trabalha T, Projeto P, Departamento D
where nomeDepto='Construção' and D.idDepto=P.idDepto and T.idProj=P.idProj and F.idFunc=T.idFunc;

-- 6. Selecione o nome dos funcionários supervisionados pelo funcionário de nome ‘Frank T. Santos’.
select S.nomeFunc
from Funcionario F, Funcionario S
where F.nomeFunc='Frank T. Santos' and F.idFunc=S.idSuperv;

-- 7. Selecione o nome e endereço dos funcionários que não tem nenhum dependente.
select nomeFunc, endereco
from Funcionario
where idFunc not in (select idFunc
		     from Dependente);
                     
-- 8. Selecione o nome dos funcionários que trabalham no departamento de nome ‘Pesquisa’ ou que trabalham no projeto de nome ‘N. Benefícios’.
select nomeFunc
from Funcionario natural join Departamento
where nomeDepto='Pesquisa'
union
select nomeFunc
from Funcionario F, Trabalha T, Projeto P 
where nomeProj='N. Benefícios' and F.idFunc=T.idFunc and T.idProj=P.idProj;

-- 9. Selecione o nome dos funcionários que trabalham em algum projeto controlado pelo departamento cujo gerente é o funcionário de nome ‘Júnia B. Mendes’.
select distinct F.nomeFunc
from Funcionario G, Departamento D, Projeto P, Trabalha T, Funcionario F
where G.nomeFunc='Júnia B. Mendes' and G.idFunc=D.idGerente and D.idDepto=P.idDepto and P.idProj=T.idProj and T.idFunc=F.idFunc;

-- 10. Selecione o nome dos funcionários que trabalham em todos os projetos controlados pelo departamento cujo gerente é o funcionário de nome ‘Júnia B. Mendes’.
select Func.nomeFunc
from Funcionario Func
where not exists (select P.idProj
	          from Projeto P, Departamento D, Funcionario F
                  where F.nomeFunc='Júnia B. Mendes' and F.idFunc=D.idGerente and D.idDepto=P.idDepto and
                        P.idProj not in (select T.idProj
                                         from Trabalha T
                                         where T.idFunc=Func.idFunc));

/* é o mesmo que:                             
select Func.nomeFunc
from Funcionario Func
where not exists (select P.idProj
	          from Projeto P, Departamento D, Funcionario F
                  where F.nomeFunc='Júnia B. Mendes' and F.idFunc=D.idGerente and D.idDepto=P.idDepto)
                  MINUS
                 (select T.idProj
                  from Trabalha T
                  where T.idFunc=Func.idFunc));
 */

-- 11. Selecione o nome dos funcionários e o nome de seus dependentes. Deve incluir o nome dos funcionários sem dependentes.
select nomeFunc, nomeDep
from Funcionario F left outer join Dependente D on F.idFunc=D.idFunc;
 
-- 12. Selecione a quantidade de funcionários que trabalham no departamento que controla o projeto de nome ‘ProdZ’.
select count(*)
from Funcionario natural join Projeto
where nomeProj = 'ProdZ';

-- 13. Selecione o nome dos funcionários e a quantidade de projetos que cada um trabalha mais de 10 horas.
select idFunc, nomeFunc, count(*)
from Funcionario natural join Trabalha
where numHoras > 10
group by idFunc, nomeFunc;

-- 14. Selecione o nome dos funcionários e a quantidade de projetos que cada um trabalha. Selecione apenas os funcionários que trabalham em mais de um projeto.
select idFunc, nomeFunc, count(*)
from Funcionario natural join Trabalha
group by idFunc, nomeFunc
having count(*) > 1;

-- 15. Selecione a soma dos salários dos funcionários que trabalham em departamentos que controlam mais de um projeto. O resultado deve vir agrupado por departamento.
select nomeDepto, sum(salario)
from Funcionario natural join Departamento D
where D.idDepto in (select idDepto
                    from Projeto
	            group by idDepto
                    having count(*) > 1)
group by nomeDepto;

-- 16. Selecione o nome dos funcionários que ganham mais que o maior salário dos funcionários do departamento de nome ‘Construção’. O resultado deve vir ordenado alfabeticamente pelo nome.
select nomeFunc
from Funcionario
where salario > (select max(salario)
		 from Funcionario natural join Departamento
                 where nomeDepto = 'Construção')
order by nomeFunc;

-- 17. Selecione o nome do funcionário e o nome do seu supervisor para todos os funcionários que não são supervisionados pelo funcionario de nome 'Frank T. Santos'.
select F.nomeFunc, S.nomeFunc
from Funcionario F left outer join Funcionario S on S.idFunc = F.idSuperv
where S.nomeFunc != 'Frank T. Santos' or F.idSuperv is null;

-- 18. Aumente em 10% o salários de todos os funcionários que trabalham em mais de um projeto.
update Funcionario
set salario = salario * 1.10
where idFunc in (select idFunc
		 from Trabalha
                 group by idFunc
                 having count(*) > 1);

-- 19. Exclua todos os projetos que não têm funcionários trabalhando neles.
delete from Projeto
where idProj not in (select idProj
		     from Trabalha);

-- 20. Crie uma visão que selecione, para cada departamento, sua identificação, seu nome, mais o nome e o salário de seu gerente. Mostre também um exemplo de como usar a visão criada.
create view DeptoGerente as
select D.idDepto, nomeDepto, nomeFunc, salario
from Departamento D join Funcionario F on D.idGerente = F.idFunc;

select * from DeptoGerente;

select nomeDepto, nomeFunc, nomeProj
from DeptoGerente natural join Projeto;

