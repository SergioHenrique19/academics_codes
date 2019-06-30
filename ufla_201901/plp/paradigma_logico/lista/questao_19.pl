inverter(X,Y):- inv([],X,Y).

inv(L,[],L).
inv(L,[X|Y],Z) :- inv([X|L],Y,Z).