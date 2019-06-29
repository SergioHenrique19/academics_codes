remover([C|T],C,L2) :- L2 = T.
remover([C|T],D,[C|L3]) :- remover(T,D,L3).