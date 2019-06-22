/* soma n primeiros elementos */
s(1,1) :- true.
s(N,S) :- N > 1,
          Aux is (N-1),
          write('*'),
          s(Aux,Parcial),
          S is (N+Parcial).

/* fatorial */
fatorial(0,1).

fatorial(X,Y) :- X > 0,
                 X1 is X-1,
                 fatorial(X1,Y1),
                 Y is X*Y1.

/* achando rotas */
ligado(a,b,5). ligado(a,c,10). ligado(a,g,75). ligado(c,d,10). 
ligado(d,g,15). ligado(d,e,5). ligado(g,f,20). ligado(e,f,5). 
ligado(b,f,25). ligado(b,e,5). ligado(b,f,25).

rota(X,Y,C) :- ligado(X,Y,C).

rota(X,Y,C) :- ligado(X,Z,C1), 
               rota(Z,Y,C2), C is (C1 + C2).
