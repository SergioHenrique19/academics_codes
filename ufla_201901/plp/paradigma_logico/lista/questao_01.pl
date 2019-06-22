% fatos dos progenitores
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
