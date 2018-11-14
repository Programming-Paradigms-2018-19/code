stamp(15).
stamp(7).
stamp(3).
stamp(1).

slist([],Limit,0).
slist(X,Limit,Sum) :- slist(Y,Limit,TmpSum),
                      append(Y,[C],X),
                      stamp(C),
                      Sum is TmpSum + C,
                      Sum =< Limit.

validlist(X,Total) :- slist(X,Total,Total),!.
