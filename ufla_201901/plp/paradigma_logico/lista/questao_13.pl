enesimo(_,[],_).
enesimo(1,[C|_],C).
enesimo(N,[_|L],R) :- N1 is N-1, enesimo(N1,L,R).
