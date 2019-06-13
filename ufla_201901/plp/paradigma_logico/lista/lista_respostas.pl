/* questao 01 */
progenitor(onofre,sergio).
progenitor(tereza,sergio).
progenitor(sergio,sergioh).
progenitor(sergio,clara).
progenitor(sebastiao,vilma).
progenitor(luzia,vilma).
progenitor(vilma,sergioh).
progenitor(vilma,clara).

homem(onofre).
homem(sebastiao).
homem(sergio).
homem(sergioh).
mulher(clara).
mulher(luzia).
mulher(tereza).
mulher(vilma).

irma(X,Y) :- progenitor(Z,X), progenitor(Z,Y), mulher(X), X \== Y.
irmao(X,Y) :- progenitor(Z,X), progenitor(Z,Y), homem(X), X \== Y.
pai(X,Y) :- progenitor(X,Y), homem(X).
mae(X,Y) :- progenitor(X,Y), mulher(Y).

