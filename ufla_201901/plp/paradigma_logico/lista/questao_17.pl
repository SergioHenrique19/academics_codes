remover_todas(_,[],[]).
remover_todas(X,[X|T],L) :- remover_todas(X,T,L).
remover_todas(X,[C|T],[C|T1]) :- X \= C, remover_todas(X,T,T1).

remover_repetidos([],[]).
remover_repetidos([C|T],[C|T1]) :- remover_todas(C,T,L),
                                   remover_repetidos(L,T1).

iguais([],[]).
iguais([X|C1],[X|C2]) :- iguais(C1,C2).

conjunto(L1,L2) :- remover_repetidos(L1,L3),remover_repetidos(L2,L4),iguais(L3,L4).
