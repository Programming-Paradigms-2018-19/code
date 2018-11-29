stamp(15).
stamp(7).
stamp(3).
stamp(1).

slist([]).
slist(X) :- slist(Y),append(Y,[C],X),stamp(C).

sumlist([],0).
sumlist([H|T],Sum) :- sumlist(T,TmpSum),Sum is H + TmpSum.

validlist(X,Total) :- slist(X),sumlist(X,Total),!.
