/* Script de resolucao das questoes da lista 07 
   By Sérgio H. M. Garcia - 05-06-19 */

use Empresa;

/* [1] Selecione o endereço e o salario do funcionário de nome ‘Luciana S. Santos’ */
SELECT endereco, salario FROM Funcionario WHERE nomeFunc='Luciana S. Santos';

/* [2] Selecione o nome e o salário dos funcionários que nasceram  entre os anos de 1960 e 1969, inclusive, do sexo feminino e que ganham menos de 1000 */
SELECT nomeFunc, salario FROM Funcionario WHERE dataNasc between "1960-01-01" and "1969-12-31" and sexo = 'F' and salario < 1000;

/* [3] Selecione o nome dos dependentes do funcionário de nome ‘João B. Silva’ */
SELECT nomeDep FROM Dependente join Funcionario on Funcionario.idFunc = Dependente.idFunc WHERE Funcionario.nomeFunc = 'João B. Silva';

/* [4] Selecione o nome dos projetos que o funcionário de nome ‘Frank T. Santos’ trabalha */
SELECT nomeProj FROM Projeto natural join Trabalha join Funcionario on Funcionario.idFunc = Trabalha.idFunc WHERE Funcionario.nomeFunc = 'Frank T. Santos';

/* [5] Selecione o nome dos funcionários que trabalham em projetos controlados pelo departamento de nome ‘ Construção’ */
