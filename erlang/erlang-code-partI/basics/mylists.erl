-module(mylists).
-export([prod/1,add_at_end/2,map/2,iter_n/2,check/1]).

prod([]) ->
    1;
prod([H|T]) ->
    H * prod(T).

add_at_end([],X) ->
    [X];
add_at_end([H|T],X) ->
    L = add_at_end(T,X),
    [H | L].

%map(F,L) --- F applied to all of the list elements

map(_F,[]) ->
    [];
map(F,[H|T]) ->
    X = F(H),
    [X | map(F,T)].

%iter_n(F,N) --- produce a list F(N), F(N-1), ..., F(0)

iter_n(F,0) ->
    [F(0)];
iter_n(F,N) when N > 0 ->
    L = iter_n(F,N-1),
    X = F(N),
    add_at_end(L,X).

check(X) ->
    case X of
	king -> 13;
	queen -> 12;
	_ -> unknown
    end.
