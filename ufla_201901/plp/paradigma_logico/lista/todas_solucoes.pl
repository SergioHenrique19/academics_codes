/* GCC198 - Soluções da lista de exercícios prático de Prolog
 * Sérgio H. M. Garcia */

/* 1) Construa um banco de dados para representar os membros de uma família.
 * Crie o predicado progenitor(X, Y) para representar o relacionamento X
 * é progenitor de Y. Represente em Prolog as relações sexo (masculino ou feminino),
 * irmã, irmão, descendente, mãe, pai, avô, tio e primo. Os predicados progenitor e sexo
 * devem ser fatos no banco de dados, os demais devem ser descritos como regras. */
progenitor(onofre,sergio).
progenitor(tereza,sergio).
progenitor(onofre,silvana).
progenitor(tereza,silvana).

progenitor(sergio,sergioh).
progenitor(sergio,clara).
progenitor(silvana,rafa).

progenitor(sebastiao,vilma).
progenitor(luzia,vilma).

progenitor(vilma,sergioh).
progenitor(vilma,clara).

% fatos dos sexos
homem(onofre).
homem(sebastiao).
homem(sergio).
homem(sergioh).
homem(rafa).

mulher(tereza).
mulher(luzia).
mulher(vilma).
mulher(silvana).
mulher(clara).

% consultas
descendente(X,Y) :- progenitor(Y,X).

mae(X,Y) :- descendente(Y,X), mulher(X).
pai(X,Y) :- descendente(Y,X), homem(X).

irmao(X,Y) :- progenitor(Z,X), progenitor(Z,Y), homem(X), X \== Y.
irma(X,Y) :- progenitor(Z,X), progenitor(Z,Y), mulher(X), X \== Y.

tia(X,Y) :- progenitor(Z,Y), irma(X,Z), mulher(X).

primo(X,Y) :- tia(Z,Y), progenitor(Z,X).


/* 2) Escreva, sem cortes, um predicado separa que separa uma lista de inteiros
 * em duas listas: uma contendo os números positivos (e zero) e outra contendo os números negativos. */
separa([], [], []).
separa([X|Cauda], P, [X|N]) :- separa(Cauda, P, N), X < 0.
separa([X|Cauda], [X|P], N) :- separa(Cauda, P, N), X >= 0.


/* 3) Escreva um predicado segundo(Lista, X) que verifica se X é o segundo elemento de Lista. */
segundo([_,X|_], X).


/* 4) Escreva um predicado iguaisL(Lista1, Lista2) que verifica se Lista1 é igual a Lista2. */
iguais([],[]).
iguais([X|C1],[X|C2]) :- iguais(C1,C2).


/* 5)  Escreva um predicado duplica(E, S) em que o primeiro argumento é uma
 * lista e o segundo argumento é uma lista obtida a partir da primeira duplicando cada um dos seus elementos. */
duplica([], []).
duplica([X|Cauda], [X,X|S]) :- duplica(Cauda, S).


/* 6) Escreva um predicado ultimo(L, X) que é satisfeito quando o termo X é o último elemento da lista L. */
ultimo([X],X).
ultimo([],_).
ultimo([_|Cauda],X) :- ultimo(Cauda, X).


/* 7) Escreva um predicado soma(L, R) que é satisfeito quando o termo R é igual
 * a soma dos elementos da lista L. Assuma que a lista L possua apenas valores numéricos. */
soma([], 0).
soma([X|L], R) :- soma(L, A), R is (A + X).


/* 8) Conserte o predicado fatorial(N, F) para que não entre em loop
 * em chamadas onde N é um número negativo e nem em chamadas verificadoras, onde ambos N e F vêm instanciados. */
fatorial(0, 1) :- !. 
fatorial(N, _) :- N < 0, !, false.
fatorial(N, F) :- M is N - 1, fatorial(M, F1), F is F1*N.


/* 9) Defina um predicado contiguo(L), que testa se uma lista tem dois elementos contíguos iguais. */
contiguo([]) :- false.
contiguo([X,Y|_]) :- X = Y, !.
contiguo([_,B|L]) :- contiguo([B|L]).


/* 10) Defina um predicado particiona(L, L1, L2), que recebe uma lista L de
 * elementos como primeiro argumento e retorna duas listas como resposta.
 * A lista L1 é formada pelos elementos de L que estejam em posições ímpares.
 * A lista L2 é formada pelos elementos de L que estejam em posições pares. */
particiona([], [], []).
particiona([X], [X|L1], L2) :- particiona([], L1, L2).
particiona([X,Y|Cauda], [X|L1], [Y|L2]) :- particiona(Cauda, L1, L2).


/* 11) Defina um predicado mdc(A, B, R) que retorne o máximo divisor comum entre dois números. */
mdc(X,0,Z) :- !, Z = X.
mdc(X,Y,Z) :- R is X mod Y, mdc(Y,R,Z).


/* 12) Escreva um predicado insereOrdenado que tenha três argumentos.
 * O primeiro argumento é uma lista ordenada chamada List (assuma ordem crescente),
 * o segundo é um elemento X e o terceiro argumento é a lista obtida com a inserção
 * de X em List, de modo que esta ainda esteja ordenada. */
insereOrdenado([], A, [A]).
insereOrdenado([X|L], A, [N, X|L]) :- X > A, N is A, !.
insereOrdenado([X|L], A, [N|LO]) :- insereOrdenado(L, A, LO), X < A, N is X.


/* 13) Faça um predicado que indique o enésimo termo de uma lista qualquer.
 * O predicado deve possuir três argumentos: o primeiro argumento é um número
 * que indica a posição do enésimo termo da lista (assuma que o primeiro termo
 * assuma a posição de índice 1 da lista); o segundo argumento é a lista propriamente
 * dita; e o terceiro argumento é o valor do enésimo termo. */
enesimo(_,[],_).
enesimo(1,[C|_],C).
enesimo(N,[_|L],R) :- N1 is N-1, enesimo(N1,L,R).


/* 14) Escreva um predicado remover(L1,X,L2) que é satisfeito quando L2 é a
 * lista obtida pela remoção da primeira ocorrência de X em L1. */
remover([C|T],C,L2) :- L2 = T.
remover([C|T],D,[C|L3]) :- remover(T,D,L3).


/* 15) Escreva um predicado remover_todas(L1,X,L2) que é satisfeito quando
 * L2 é a lista obtida pela remoção de qualquer ocorrência de X em L1. */
remover_todas([],_,[]).
remover_todas([X|T],X,L) :- remover_todas(T,X,L).
remover_todas([C|T],X,[C|T1]) :- X \= C, remover_todas(T,X,T1).


/* 16) Escreva um predicado remover_repetidos(L1,L2) que é satisfeito quando
 * L2 é a lista obtida pela remoção dos elementos repetidos em L1. */
remover_repetidos([],[]).
remover_repetidos([C|T],[C|T1]) :- remover_todas(T,C,L), remover_repetidos(L,T1).


/* 17) Escreva um predicado conjunto(L1, L2) que é satisfeito quando L1 é uma
 * lista formada apenas por elementos presentes em L2. Assuma que o predicado
 * será utilizado apenas com todos os argumentos instanciados. */
conjunto(L1,L2) :- remover_repetidos(L1,L3), remover_repetidos(L2,L4), iguais(L3,L4).


/* 18) Escreva um predicado produto(A, B, P) que é satisfeito quando P é igual
 * ao produto de todos números compreendidos no intervalo [A,B]. */
intervalo(X,Y,P) :- X =:= (Y-1), P is X*Y, !.
intervalo(X,Y,P) :- intervalo((X+1),Y,A), P is X*A.


/* 19) Escreva um predicado inverter(L1,L2) que é satisfeito quando L2
 * possui seus elementos em ordem inversa a L1. */
inverter(X,Y):- inv([],X,Y).

inv(L,[],L).
inv(L,[X|Y],Z) :- inv([X|L],Y,Z).


/* 20) Faça um programa PROLOG que com o estado de um tabuleiro do jogo
 * da velha diga se há vencedor e quem é este vencedor (cruz ou bola). */
velha([[_,_,P],[_,_,P],[_,_,P]], P):- !.
velha([[_,P,_],[_,P,_],[_,P,_]], P):- !.
velha([[P,_,_],[P,_,_],[P,_,_]], P):- !.

velha([[P,P,P],[_,_,_],[_,_,_]], P):- !.
velha([[_,_,_],[P,P,P],[_,_,_]], P):- !.
velha([[_,_,_],[_,_,_],[P,P,P]], P):- !.

velha([[P,_,_],[_,P,_],[_,_,P]], P):- !.
velha([[_,_,P],[_,P,_],[P,_,_]], P):- !.


/* 21) Escreva as seguintes regras em Prolog: */
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

% a) Quem são os alunos do professor X?
prof(X,Y) :- professor(X,D), aluno(Y,D).

% b) Quem são as pessoas que estão associadas a uma universidade X? (alunos e professores)
universidade(X,Y) :- funcionario(Y,X); frequenta(Y,X).


/* 22) Considerando que: 
 * Nota de 7.0 a 10.0 = Aprovado
 * Nota de 5.0 a 6.9 = Recuperação
 * Nota de 0.0 a 4.9 = Reprovado
 * Escreva uma regra para identificar a situação de um determinado aluno. */
nota(joao,5.0). 
nota(maria,6.0). 
nota(joana,8.0). 
nota(mariana,9.0). 
nota(cleuza,8.5). 
nota(jose,6.5). 
nota(jaoquim,4.5). 
nota(mara,4.0). 
nota(mary,10.0).

situacao(X) :- nota(X,Y), Y >= 7.0, Y =< 10.0, write('APROVADO').
situacao(X) :- nota(X,Y), Y >= 5.0, Y =< 6.9, write('RECUPERAÇÃO').
situacao(X) :- nota(X,Y), Y >= 0.0, Y =< 4.9, write('REPROVADO').
