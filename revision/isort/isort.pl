insert_sort(L1,L2) :-
  insert_sort_intern(L1,[],L2).

insert_sort_intern([],L,L).
insert_sort_intern([H|T],L1,L) :-
  insert(L1,H,L2),
  insert_sort_intern(T,L2,L).

insert([],X,[X]).
insert([H|T],X,[X,H|T]) :-
  X =< H,
  !.
insert([H|T],X,[H|T2]) :-
  insert(T,X,T2).

% or

isort(L, LS) :-
	foldl(insert, [], L, LS).


% foldl(Pred, Init, List, R).
foldl(_Pred, Val, [], Val).
foldl(Pred, Val, [H | T], Res) :-
	call(Pred, Val, H, Val1),
	foldl(Pred, Val1, T, Res).

% insertion in a sorted list
insert([], N, [N]).

insert([H | T], N, [N, H|T]) :-
	N =< H, !.

insert([H | T], N, [H|L1]) :-
	insert(T, N, L1).
