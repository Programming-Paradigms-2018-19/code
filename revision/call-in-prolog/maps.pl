% map(Predicate, List, NewList).


sq(X,T) :- T is X * X.

map(_,[],[]).
map(Predicate, [H|T], [X|Y]) :- Pred =.. [Predicate,H,X], call(Pred), map(Predicate, T, Y).