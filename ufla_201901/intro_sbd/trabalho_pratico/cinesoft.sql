SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema cinesoft
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS cinesoft DEFAULT CHARACTER SET utf8 ;
USE cinesoft;

-- -----------------------------------------------------
-- Table cinesoft.Cliente
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS cinesoft.Cliente (
  cpf INT NOT NULL,
  nome VARCHAR(45) UNIQUE NOT NULL,
  telefone VARCHAR(20) NOT NULL,
  email VARCHAR(45) NOT NULL,
  dataNascimento DATE NOT NULL,
  dataCadastro DATE NOT NULL,
  PRIMARY KEY (cpf))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table cinesoft.Compra
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS cinesoft.Compra (
  idCompra INT NOT NULL,
  data DATE NOT NULL,
  precoBruto DECIMAL(5,2) NOT NULL,
  precoLiquido DECIMAL(5,2) NOT NULL,
  clienteCPF INT NOT NULL,
  PRIMARY KEY (idCompra, clienteCPF),
  INDEX fk_Compra_Cliente1_idx (clienteCPF ASC),
  CONSTRAINT fk_Compra_Cliente1
    FOREIGN KEY (clienteCPF)
    REFERENCES cinesoft.Cliente (cpf)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table cinesoft.Produto
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS cinesoft.Produto (
  idProduto INT NOT NULL,
  nome VARCHAR(45) NOT NULL,
  preco DECIMAL(5,2) NOT NULL,
  quantidade INT NOT NULL,
  PRIMARY KEY (idProduto))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table cinesoft.Contem
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS cinesoft.Contem (
  idProduto INT NOT NULL,
  idCompra INT NOT NULL,
  quantidade INT NOT NULL,
  precoVenda DECIMAL(4,2) NOT NULL,
  PRIMARY KEY (idProduto, idCompra),
  INDEX fk_Produto_has_Compra_Compra1_idx (idCompra ASC),
  INDEX fk_Produto_has_Compra_Produto1_idx (idProduto ASC),
  CONSTRAINT fk_Produto_has_Compra_Produto1
    FOREIGN KEY (idProduto)
    REFERENCES cinesoft.Produto (idProduto)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Produto_has_Compra_Compra1
    FOREIGN KEY (idCompra)
    REFERENCES cinesoft.Compra (idCompra)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table cinesoft.Filme
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS cinesoft.Filme (
  idFilme INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(45) NOT NULL,
  genero VARCHAR(15) NOT NULL,
  classificacaoIndicativa INT NOT NULL,
  dataEstreia DATE NOT NULL,
  dataFinal DATE NULL,
  PRIMARY KEY (idFilme))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table cinesoft.Sessao
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS cinesoft.Sessao (
  idSessao INT NOT NULL,
  horario TIME NOT NULL,
  idioma TINYINT(1) NOT NULL,
  tipoImagem TINYINT(1) NOT NULL,
  idFilme INT NOT NULL,
  PRIMARY KEY (idSessao, idFilme),
  INDEX fk_Sessao_Filme1_idx (idFilme ASC),
  CONSTRAINT fk_Sessao_Filme1
    FOREIGN KEY (idFilme)
    REFERENCES cinesoft.Filme (idFilme)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table cinesoft.Ingresso
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS cinesoft.Ingresso (
  idIngresso INT NOT NULL,
  data DATE NOT NULL,
  precoBruto DECIMAL(5,2) NOT NULL,
  precoLiquido DECIMAL(5,2) NOT NULL,
  cpf INT NOT NULL,
  idSessao INT NOT NULL,
  poltrona VARCHAR(3) NOT NULL,
  PRIMARY KEY (idIngresso, cpf, idSessao),
  INDEX fk_Ingresso_Cliente1_idx (cpf ASC),
  INDEX fk_Ingresso_Sessao1_idx (idSessao ASC),
  CONSTRAINT fk_Ingresso_Cliente1
    FOREIGN KEY (cpf)
    REFERENCES cinesoft.Cliente (cpf)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Ingresso_Sessao1
    FOREIGN KEY (idSessao)
    REFERENCES cinesoft.Sessao (idSessao)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table cinesoft.Carteirinha
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS cinesoft.Carteirinha (
  idCarteirinha INT NOT NULL,
  validade DATE NOT NULL,
  clienteCPF INT NOT NULL,
  idJovem TINYINT(1) NULL,
  estudante TINYINT(1) NULL,
  fidelidade TINYINT(1) NULL,
  categoria VARCHAR(1) NULL,
  PRIMARY KEY (idCarteirinha, clienteCPF),
  INDEX fk_Carteirinha_Cliente1_idx (clienteCPF ASC),
  CONSTRAINT fk_Carteirinha_Cliente1
    FOREIGN KEY (clienteCPF)
    REFERENCES cinesoft.Cliente (cpf)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- B
ALTER TABLE Cliente ADD COLUMN endereco VARCHAR(100);
ALTER TABLE Cliente DROP COLUMN endereco;
RENAME TABLE Compra to Venda;
RENAME TABLE Venda to Compra;
DROP TABLE Contem;

-- C 
INSERT INTO Cliente
VALUES (1,"Otávio de Lima Soares", "(35) 3214-2665", "olima94@gmail.com", "2000-02-22", "2019-06-19");
INSERT INTO Cliente
VALUES (2,"Kaio Vinicius de Morais", "(35) 9958-7788 ", "kaiocomk34@gmail.com", "1999-02-12", "2019-06-19");
INSERT INTO Cliente
VALUES (3,"Otávio Augusto", "(35) 3222-2665", "otavio@gmail.com", "1998-02-22", "2019-06-19");
INSERT INTO Cliente
VALUES (4,"Fabio Junio Rolin de Oliveira", "(35) 3221-2665", "fabiojunio@gmail.com", "1998-01-01", "2019-06-19");
INSERT INTO Cliente
VALUES (5,"Sérgio Herique Menta Garcia", "(35) 3223-2665", "sergio@gmail.com", "1998-09-25", "2019-06-19");

INSERT INTO Filme (nome, genero, classificacaoIndicativa, dataEstreia, dataFinal)
VALUES ("Endgame", "Ação", 16, "2019-06-19", "2019-07-19");
INSERT INTO Filme (nome, genero, classificacaoIndicativa, dataEstreia, dataFinal)
VALUES ("Five Feet Apart", "Romance", 16, "2019-06-26", "2019-07-08");
INSERT INTO Filme (nome, genero, classificacaoIndicativa, dataEstreia, dataFinal)
VALUES ("Jurassic World", "Ação", 0, "2019-07-19", "2019-07-26");
INSERT INTO Filme (nome, genero, classificacaoIndicativa, dataEstreia, dataFinal)
VALUES ("Django Libre", "Ação", 16, "2019-08-19", "2019-08-26");
INSERT INTO Filme (nome, genero, classificacaoIndicativa, dataEstreia, dataFinal)
VALUES ("Transformers", "Ação", 12, "2019-09-19", "2019-10-19");
INSERT INTO Filme (nome, genero, classificacaoIndicativa, dataEstreia, dataFinal)
VALUES ("Avatar", "Ação", 12, "2019-10-19", "2019-11-19");

INSERT INTO Sessao
VALUES (1, "13:40:00", 0, 1, 1);
INSERT INTO Sessao
VALUES (2, "17:00:00", 1, 0, 2);
INSERT INTO Sessao
VALUES (3, "20:40:00", 1, 1, 3);
INSERT INTO Sessao
VALUES (4, "22:00:00", 0, 0, 4);
INSERT INTO Sessao
VALUES (5, "21:30:00", 1, 1, 5);

INSERT INTO Produto
VALUES (1, "Pipoca", 11.50, 300);
INSERT INTO Produto
VALUES (2, "Refrigerante", 7.50, 1000);
INSERT INTO Produto
VALUES (3, "Chocolate", 3.00, 500); 
INSERT INTO Produto
VALUES (4, "Suco", 9.00, 100); 
INSERT INTO Produto
VALUES (5, "Chiclete", 00.50, 200);

INSERT INTO Ingresso
VALUES (1, "2019-06-19", 20.00, 10.00, 1, 1, "H2");
INSERT INTO Ingresso
VALUES (2, "2019-05-20", 20.00, 20.00, 2, 5, "H23");
INSERT INTO Ingresso
VALUES (3, "2019-05-01", 20.00, 10.00, 3, 4, "H4"); 
INSERT INTO Ingresso
VALUES (4, "2019-05-20", 20.00, 20.00, 4, 3, "J2");  
INSERT INTO Ingresso
VALUES (5, "2019-06-19", 20.00, 10.00, 5, 2, "L17");

INSERT INTO Carteirinha (idCarteirinha, validade, clienteCPF, idJovem)
VALUES (1, "2020-06-19", 1, 1);
INSERT INTO Carteirinha (idCarteirinha, validade, clienteCPF, estudante)
VALUES (2, "2020-06-19", 2, 1);
INSERT INTO Carteirinha (idCarteirinha, validade, clienteCPF, idJovem)
VALUES (3, "2020-06-19", 3, 1);
INSERT INTO Carteirinha (idCarteirinha, validade, clienteCPF, estudante)
VALUES (4, "2020-06-19", 4, 1);
INSERT INTO Carteirinha (idCarteirinha, validade, clienteCPF, fidelidade, categoria)
VALUES (5, "2020-06-19", 5, 1, "A");

INSERT INTO Compra
VALUES (1, "2019-06-19", 11.50, 11.50, 1);
INSERT INTO Compra
VALUES (2, "2019-06-19", 9.00, 9.00, 2);
INSERT INTO Compra
VALUES (3, "2019-06-19", 12.00, 12.00, 3);
INSERT INTO Compra
VALUES (4, "2019-06-19", 2.50, 2.50, 4);
INSERT INTO Compra
VALUES (5, "2019-06-19", 23.00, 18.40, 5);

INSERT INTO Contem
VALUES (1, 1, 1, 11.50);
INSERT INTO Contem
VALUES (4, 2, 1, 9.00);
INSERT INTO Contem
VALUES (3, 3, 4, 3.00);
INSERT INTO Contem
VALUES (5, 4, 5, 00.50);
INSERT INTO Contem
VALUES (1, 5, 2, 11.50);

-- D
UPDATE Produto
SET preco = preco*1.10
WHERE idProduto = 1;

UPDATE Sessao
SET idioma = 1
where idSessao = 1;

UPDATE Filme
SET dataFinal = "2019-08-26"
where idFilme = 1;

UPDATE Filme
SET classificacaoIndicativa = 18
where idFilme = (select idFilme from Sessao where horario = "22:00:00");

UPDATE Cliente
SET email = "otaviolima@hotmail.com"
where cpf = 1;

-- E
DELETE  FROM Carteirinha
where clienteCPF = (select cpf from Cliente where nome = "Otávio de Lima Soares");

DELETE FROM Produto where idProduto = 4;

DELETE FROM Contem where idCompra = 3;

DELETE FROM Compra where idCompra = 4;

DELETE FROM Ingresso
where cpf = (select cpf FROM Cliente WHERE nome = "Kaio Vinicius de Morais");

-- F
-- Retorna o titulo do filme e a sessao em que o mesmo será exibido, sem NULL
SELECT Filme.nome, Sessao.horario FROM Filme JOIN Sessao ON Filme.idFilme = Sessao.idSessao;

-- Retorna o titulo dos filmes e suas classificacoes ordenados por esta
SELECT Filme.nome AS Titulo, Filme.classificacaoIndicativa AS Classificacao
FROM Filme ORDER BY classificacaoIndicativa;

-- Retorna o nome e o gênero do filme em ordem alfabética
SELECT nome, genero FROM Filme ORDER BY nome;

-- Retorna os produtos de quantidade vendida igual a 1
SELECT idProduto, count(*) FROM Contem WHERE quantidade = 1 GROUP BY idProduto;

-- Retorna produtos vendidos em mais de uma compra
SELECT Contem.idProduto, Produto.nome FROM Contem JOIN Produto ON
Produto.idProduto = Contem.idProduto GROUP BY Contem.idProduto HAVING COUNT(Contem.idProduto) > 1;

-- Retorna o titulo do filme e a sessao em que o mesmo será exibido, com NULL
SELECT nome, Sessao.horario FROM Filme LEFT OUTER JOIN Sessao ON (Filme.idFilme = Sessao.idFilme);

-- Retorna soma dos ingressos vendidos entre no mes 05
SELECT sum(precoLiquido) FROM Ingresso NATURAL JOIN Sessao WHERE data LIKE "2019-05%";

-- Retorna nome do cliente e a validade de sua carteirinha se for ID Jovem
SELECT C.nome, D.validade FROM Cliente AS C JOIN Carteirinha AS D ON C.cpf = D.clienteCPF
WHERE D.idJovem IS NOT NULL;

-- Retorna nome do cliente e a validade de sua carteirinha se for fidelidade ou estudante
SELECT C.nome, D.validade FROM Cliente AS C JOIN Carteirinha AS D ON C.cpf = D.clienteCPF
WHERE D.fidelidade IS NOT NULL
UNION
SELECT C.nome, D.validade FROM Cliente AS C JOIN Carteirinha AS D ON C.cpf = D.clienteCPF
WHERE D.estudante;

-- Retorna compras com valor entre 8 e 12 "reais"
SELECT idCompra AS Compra, data AS Data, precoLiquido AS Preco FROM Compra
WHERE precoLiquido BETWEEN 8 AND 12;

-- Retorna titulo e classificacao indicativa de 12 ou 16
SELECT nome, classificacaoIndicativa FROM Filme
WHERE classificacaoIndicativa = 12 OR classificacaoIndicativa = 16;

-- Retorna cliente, que tem ID Jovem, e sua poltrona
SELECT Cli.nome, Ing.poltrona FROM Cliente AS Cli JOIN Ingresso AS Ing ON Cli.cpf = Ing.cpf
WHERE Cli.cpf IN
(SELECT Clih.cpf FROM Cliente AS Clih JOIN Carteirinha AS Id ON Id.clienteCPF = Clih.cpf
WHERE Id.idJovem IS NOT NULL);

-- G
CREATE VIEW sessaoFilme as
select nome, horario
from Filme natural join Sessao;

CREATE VIEW produtoCliente as
select idProduto, clienteCPF
from Compra natural join Contem;

CREATE VIEW carteirinhaCliente as
select nome, idCarteirinha
from Cliente natural join Carteirinha;

-- H
CREATE USER 'otavio'@'localhost' IDENTIFIED BY '0192';
CREATE USER 'kaiocomK'@'localhost' IDENTIFIED BY '0193';
GRANT ALL ON cinesoft TO 'otavio'@'localhost';
REVOKE INSERT ON cinesoft FROM 'otavio'@'localhost';
GRANT ALL ON cinesoft.Cliente TO 'kaiocomK'@'localhost';
REVOKE UPDATE ON cinesoft.Cliente FROM 'kaiocomK'@'localhost';

-- I
DELIMITER // 
CREATE PROCEDURE CompraDoCliente(IN pCpf INT) 
BEGIN 
   SELECT nome,idCompra
   FROM Compra JOIN Cliente ON Compra.clienteCPF = Cliente.cpf
   WHERE pCpf = clienteCPF; 
END // 
DELIMITER ;

CALL CompraDoCliente(1);

DELIMITER //
CREATE PROCEDURE ProdutosEstoque()
BEGIN
	SELECT nome AS Produto, quantidade AS Quantidade, preco AS Preco
    FROM Produto WHERE quantidade > 0;
END //
DELIMITER ;

CALL ProdutosEstoque();

DELIMITER //
CREATE PROCEDURE ListarFilmesClassificacao(IN classIndic INT)
    BEGIN
		SELECT nome, classificacaoIndicativa FROM Filme WHERE classificacaoIndicativa = classIndic;
    END //
DELIMITER ;

call ListarFilmesClassificacao(16);

-- J
DELIMITER //
CREATE TRIGGER antes_Filme_insercao
BEFORE INSERT ON Filme FOR EACH ROW
BEGIN
	IF(new.classificacaoIndicativa = 0) THEN
		SET new.classificacaoIndicativa = 0;
	ELSEIF(new.classificacaoIndicativa = 10) THEN
		SET new.classificacaoIndicativa = 10;
	ELSEIF(new.classificacaoIndicativa = 12) THEN
		SET new.classificacaoIndicativa = 12;
	ELSEIF(new.classificacaoIndicativa = 14) THEN
		SET new.classificacaoIndicativa = 14;
	ELSEIF(new.classificacaoIndicativa = 16) THEN
		SET new.classificacaoIndicativa = 16;
	ELSEIF(new.classificacaoIndicativa = 18) THEN
		SET new.classificacaoIndicativa = 18;
	ELSEIF(new.classificacaoIndicativa NOT IN (0,10,12,14,16,18)) THEN
		SIGNAL SQLSTATE '45000'
        SET message_text = 'Caracter invalido para classificacao indicativa, informe 0, 10, 12, 14, 16 ou 18.';
	END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER antes_Filme_atualizacao
BEFORE UPDATE ON Filme FOR EACH ROW
BEGIN
	IF new.dataFinal < old.dataEstreia THEN
		SIGNAL SQLSTATE '45000'
        SET message_text = 'INVALIDO: data final antes da estreia';
	END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER antes_Produto_exclusao
BEFORE DELETE ON Produto FOR EACH ROW
BEGIN
	IF old.quantidade > 0 THEN
		SIGNAL SQLSTATE '02000'
        SET message_text = 'INVALIDO: exclusao';
	END IF;
END //
DELIMITER ;
