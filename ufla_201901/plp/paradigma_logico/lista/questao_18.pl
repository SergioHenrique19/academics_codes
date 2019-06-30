intervalo(X,Y,P) :- X =:= (Y-1), P is X*Y, !.
intervalo(X,Y,P) :- intervalo((X+1),Y,A), P is X*A.
