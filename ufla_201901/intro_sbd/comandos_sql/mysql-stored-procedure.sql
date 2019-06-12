use Empresa;

/* Cria um stored procedure */

DELIMITER // 
CREATE PROCEDURE ObtemTodosFuncs() 
BEGIN 
   SELECT * FROM Funcionario; 
END // 
DELIMITER ; 

/* Chama um stored procedure */

CALL ObtemTodosFuncs();

/* Exclui um procedure existente */ 
DROP PROCEDURE ObtemTodosFuncs;

/* Declara uma variavel (inicializada com NULL) */
/* Deve ser declarada dentro de um bloco BEGIN END */
/* E' valida somente dentro do bloco */
DECLARE x INT;

/* Declara uma variavel inicializada com um valor especifico */
DECLARE y CHAR DEFAULT 'A';
DECLARE z, w NUMERIC(8,2) DEFAULT 1234.56;

/* Um valor pode ser atribuido a uma variavel usando o comando SET ou o comando SELECT INTO */
SET y = 'B';
SET z = 6543.21;

SELECT count(*) INTO x
FROM Funcionario;

/* Cria um store procedure com parametro */
/* Modos: IN, OUT, INOUT */
/* IN: se o parametro for alterado dentro de um stored procedure sua variavel externa correspondente nao e' alterada */
/* OUT: parametro retorna um valor, ou seja, altera a variavel externa correspondente */
/* INOUT: combinacao de IN e OUT */

/* Exemplo: retorna nomes dos funcionarios de um determinado departamento passado como parametro */
DELIMITER // 
CREATE PROCEDURE FuncsDeDepto(IN pIdDepto DECIMAL(2)) 
BEGIN 
   SELECT NomeFunc
   FROM Funcionario
   WHERE idDepto = pIdDepto; 
END // 
DELIMITER ; 

/* chama procedimento para retornar os funcionarios do depto 1 */
CALL FuncsDeDepto(1);
/* chama procedimento para retornar os funcionarios do depto 2 */
CALL FuncsDeDepto(2);

/* Exemplo: retorna o numero de funcionarios de um departamento, dado seu nome */
DELIMITER // 
CREATE PROCEDURE NoFuncsDeDepto(IN pNomeDepto varchar(30), OUT pNumFuncs DECIMAL(4)) 
BEGIN 
   SELECT Count(*) INTO pNumFuncs
   FROM Funcionario NATURAL JOIN Departamento
   WHERE nomeDepto = pNomeDepto; 
END // 
DELIMITER ; 

/* chama procedimento para retornar o numero de funcionarios do departamento 'Pesquisa' */
/* variavel comecando com @ e' uma variavel de sessao, ela existe ate o fim da sessao */
CALL NoFuncsDeDepto('Pesquisa', @numFuncs);
SELECT @numFuncs AS numFuncs; 

/* Principais comandos MySQL */
/* Sintaxe do comando IF:

IF expression THEN commands 
[ELSEIF expression THEN commands] 
[ELSE commands] 
END IF; 

/* Sintaxe do comando CASE: (equivale a um aninhamento de IF ELSEIF ...)

CASE 
WHEN expression THEN commands 
… 
WHEN expression THEN commands 
ELSE commands 
END CASE; 

/* Sintaxe do comando WHILE:

WHILE expression DO 
  commands 
END WHILE; 

/* Sintaxe do comando REPEAT

REPEAT 
  commands; 
UNTIL expression 
END REPEAT; 


/* Exemplo: converte a letra inicial de cada palavra da string passada como parametro para maiuscula e 
   retorna a string convertida */ 
DELIMITER $$ 
CREATE PROCEDURE Capitalize(INOUT str VARCHAR(1024)) 
BEGIN 
   DECLARE i INT DEFAULT 1; 
   DECLARE myc, pc CHAR(1); 
   DECLARE outstr VARCHAR(1000) DEFAULT str; 
   WHILE i <= CHAR_LENGTH(str) DO   /* CHAR_LENGTH(str) retorna o tamanho da string str */
      SET myc = SUBSTRING(str, i, 1);  /* SUBSTRING(str,i,1) retorna a substring de str comecando na posicao i com 1 caracter) */
      SET pc = CASE WHEN i = 1 THEN ' ' 
               ELSE SUBSTRING(str, i - 1, 1) 
               END; 
      IF pc IN (' ', '&', '''', '_', '?', ';', ':', '!', ',', '-', '/', '(', '.') THEN 
         SET outstr = INSERT(outstr, i, 1, UPPER(myc)); /* substitui o caractere da posicao i de outstr por myc convertido para maiuscula */
      END IF; 
      SET i = i + 1; 
   END WHILE; 
   SET str = outstr; 
END$$ 
DELIMITER ; 

/* chama procedimento */
SET @str = 'converte as iniciais desta string para maiusculas'; 
CALL Capitalize(@str); 
SELECT @str;  /* resultado: 'Converte As Iniciais Desta String Para Maiusculas' */

/* Funcoes de string */
/* http://dev.mysql.com/doc/refman/5.6/en/string-functions.html */

/* Exemplo:  Lista os aniversariantes de cada mês */
DELIMITER // 
CREATE PROCEDURE Aniversariantes()
BEGIN
   SELECT CASE EXTRACT(MONTH FROM dataNasc) 
             WHEN 01 THEN 'JAN'
             WHEN 02 THEN 'FEV'
             WHEN 03 THEN 'MAR'
             WHEN 04 THEN 'ABR'
             WHEN 05 THEN 'MAI'
             WHEN 06 THEN 'JUN'
             WHEN 07 THEN 'JUL'
             WHEN 08 THEN 'AGO'
             WHEN 09 THEN 'SET'
             WHEN 10 THEN 'OUT'
             WHEN 11 THEN 'NOV'
             WHEN 12 THEN 'DEZ'
          END AS mes, GROUP_CONCAT(nomeFunc) AS funcionarios
    FROM Funcionario
    GROUP BY mes;
END // 
DELIMITER ; 

/* chama procedimento */
CALL Aniversariantes();

/* Exemplo: cria um novo funcionario passando seus dados como parametros.
            O ID do funcionario é gerado automaticamente (atributo auto increment) */
DELIMITER $$
CREATE PROCEDURE CadastraFuncionario(
   pNomeFunc VARCHAR(50),
   pEndereco VARCHAR(80),
   pDataNasc DATE,
   pSexo CHAR(1),
   pSalario DECIMAL(8,2),
   pIdSuperv INT,
   pIdDepto INT
)
BEGIN 
   INSERT INTO Funcionario (nomeFunc, endereco, dataNasc, sexo, salario, idSuperv, idDepto)
   VALUES               (pNomeFunc, pEndereco, pDataNasc, pSexo, pSalario, pIdSuperv, pIdDepto);
END$$
DELIMITER ;

/* chama procedimento */
CALL CadastraFuncionario('João Manoel Silva', 'Av. Brasil, 88', '1955-05-10', 'M', 1500.00, 4, 1);

SELECT * FROM Funcionario;

/* CURSORES SQL */
/* Exemplo: ajusta o salário de todos os funcionários de acordo com o total de horas trabalhadas em projetos.
            Se o funcionário trabalhou 40h ou mais ele receberá um reajuste de 50%,
            senão se ele trabalhou entre 20 e 40h ele receberá um reajuste de 20%.
            Caso contrário, o salário não será alterado. */
DELIMITER // 
CREATE PROCEDURE AjustaSalarioHoras()
BEGIN

  DECLARE done INT DEFAULT FALSE;

  DECLARE vIdFunc INT;
  DECLARE vNumHoras decimal(6,1);

  DECLARE HorasTrabalhadas CURSOR FOR 	
	SELECT T.idFunc, Sum(T.numHoras) 
	FROM Trabalha T
	GROUP BY T.idFunc;

  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

  OPEN HorasTrabalhadas;

  read_loop: LOOP
    FETCH HorasTrabalhadas INTO vIdFunc, vNumHoras;
    
    IF done THEN
      LEAVE read_loop;
    END IF;
    
    IF vNumHoras >= 40 THEN
        UPDATE Funcionario SET salario = salario * 1.5 where idFunc = vIdFunc;
    ELSEIF vNumHoras >= 20 and vNumHoras < 40 THEN
        UPDATE Funcionario set salario = salario * 1.2 where idFunc = vIdFunc;
    END IF;
  END LOOP;

  CLOSE HorasTrabalhadas;
 
END // 
DELIMITER ; 

SELECT idFunc, nomeFunc, salario FROM Funcionario;

/* chama procedimento */
CALL AjustaSalarioHoras();

SELECT idFunc, nomeFunc, salario FROM Funcionario;


/* Mais informacoes em http://forums.mysql.com/read.php?98,358569 */
