% Alunos
aluno(joao, calculo).
aluno(maria, calculo).
aluno(joel, programacao).
aluno(joel, estrutura).

% Estuda na...
frequenta(joao, puc).
frequenta(maria, puc).
frequenta(joel, ufrj).

% Professors
professor(carlos, calculo).
professor(ana_paula, estrutura).
professor(pedro, programacao).

% Funcionarios
funcionario(pedro, ufrj).
funcionario(ana_paula, puc).
funcionario(carlos, puc).

% Quem são os alunos do professor X?
prof(X,Y) :- professor(X,D), aluno(Y,D).

% Quem são as pessoas que estão associadas a uma universidade X? (alunos e professores)
universidade(X,Y) :- funcionario(Y,X); frequenta(Y,X).
