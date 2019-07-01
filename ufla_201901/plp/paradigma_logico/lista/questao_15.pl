remover_todas([],_,[]).
remover_todas([X|T],X,L) :- remover_todas(T,X,L).
remover_todas([C|T],X,[C|T1]) :- X \= C, remover_todas(T,X,T1).
