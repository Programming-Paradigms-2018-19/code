flatten(List, Flat) :-
        flatten(List, Flat, []).

flatten([], Res, Res) :- !.
flatten([Head|Tail], Res, Cont) :-
        !,
        flatten(Head, Res, Cont1),
        flatten(Tail, Cont1, Cont).
flatten(Term, [Term|Cont], Cont).
