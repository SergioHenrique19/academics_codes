remover_todas(_,[],[]).
remover_todas(X,[X|T],L) :- remover_todas(X,T,L).
remover_todas(X,[C|T],[C|T1]) :- X \= C, remover_todas(X,T,T1).
