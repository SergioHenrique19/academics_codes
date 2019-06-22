mdc(X,0,Z) :- !, Z = X.
mdc(X,Y,Z) :- R is X mod Y, mdc(Y,R,Z).