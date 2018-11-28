-module(server1).
-export([start/0, go/0]).

start() ->
    spawn(server1, go, []).

go() ->
    register(calc, self()),
    loop().

loop() ->
    receive
	{From, eval, Expr} ->
	    From ! {self(), eval(Expr)},
	    loop()
    end.

eval({num, N}) ->
    N;
eval({add,X,Y}) ->
    eval(X) + eval(Y);
eval({mul,X,Y}) ->
    eval(X) * eval(Y).

		
