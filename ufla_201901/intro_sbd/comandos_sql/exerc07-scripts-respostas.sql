/* Script de resolucao das questoes da lista 07 
   By Sérgio H. M. Garcia - 05-06-19 */

use Empresa;

/* [1] Selecione o endereço e o salario do funcionário de nome ‘Luciana S. Santos’ */
SELECT endereco, salario FROM Funcionario
WHERE nomeFunc='Luciana S. Santos';

/* [2] Selecione o nome e o salário dos funcionários que nasceram  entre os anos de 1960 e 1969, 
	inclusive, do sexo feminino e que ganham menos de 1000 */
SELECT nomeFunc, salario FROM Funcionario
WHERE dataNasc BETWEEN "1960-01-01" AND "1969-12-31" AND sexo = 'F' AND salario < 1000;

/* [3] Selecione o nome dos dependentes do funcionário de nome ‘João B. Silva’ */
SELECT nomeDep FROM Dependente JOIN Funcionario ON Funcionario.idFunc = Dependente.idFunc
WHERE Funcionario.nomeFunc = 'João B. Silva';

/* [4] Selecione o nome dos projetos que o funcionário de nome ‘Frank T. Santos’ trabalha */
SELECT nomeProj FROM Projeto NATURAL JOIN Trabalha JOIN Funcionario ON Funcionario.idFunc = Trabalha.idFunc
WHERE Funcionario.nomeFunc = 'Frank T. Santos';

/* [5] Selecione o nome dos funcionários que trabalham em projetos controlados pelo
	departamento de nome ‘ Construção’ */
SELECT nomeFunc FROM Funcionario F, Trabalha T, Projeto P, Departamento D
WHERE nomeDepto = 'Construção' AND D.idDepto=P.idDepto AND P.idProj=T.idProj AND T.idFunc=F.idFunc;

/* [6] Selecione o nome dos funcionários supervisionados pelo funcionário de nome ‘Frank T. Santos’. */
SELECT nomeFunc FROM Funcionario
WHERE idSuperv = (SELECT idFunc FROM Funcionario WHERE nomeFunc = 'Frank T. Santos');

/* [7] Selecione o nome e endereço dos funcionários que não tem nenhum dependente */
SELECT nomeFunc, endereco FROM Funcionario
WHERE idFunc NOT IN (SELECT idFunc FROM Dependente);

/* [8] Selecione o nome dos funcionários que trabalham no departamento de nome ‘Pesquisa’ ou
	que trabalham no projeto de nome ‘N. Benefícios’ */
SELECT nomeFunc FROM Funcionario NATURAL JOIN Departamento WHERE nomeDepto = 'Pesquisa'
UNION
SELECT nomeFunc FROM Funcionario JOIN 
(Trabalha NATURAL JOIN Projeto) ON Funcionario.idFunc = Trabalha.idFunc
WHERE Projeto.nomeProj = 'N. Benefícios';

/*Questão 21 */
DELIMITER //
CREATE PROCEDURE atualizaSalario(IN idDeptoA INT, acres DECIMAL(8,2))	
BEGIN 
    UPDATE Funcionario 
    SET salario = salario * acres
    WHERE idDepto = idDeptoA;
END //
DELIMITER ;

/*Questão 22 */
DELIMITER //
CREATE PROCEDURE adicionaFuncinProj(IN idFuncA INT, IN idProjA INT, IN nHoras DECIMAL(6,1))
BEGIN
    INSERT INTO Trabalha VALUES(idFuncA, idProjA, nHoras);
END //
DELIMITER ;
