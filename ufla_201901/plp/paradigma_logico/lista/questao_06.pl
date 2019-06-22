ultimo([X],X).
ultimo([],_).
ultimo([_|Cauda],X) :- ultimo(Cauda, X).