is_in(Item,[Item|_]).
is_in(Item,[_|Tail]) :-
    is_in(Item,Tail).

go :- is_in(3,[3,4,5,6,7,3]), fail.
go.
