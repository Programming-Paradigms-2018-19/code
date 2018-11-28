-module(calc).
-export([start/0, stop/0, execute/1]).
-export([init/0]).

start() ->
    spawn(calc, init, []).

init() ->
    io:format("starting...~n"),
    register(calc, self()),
    loop().

loop() ->
    receive
	{request, From, Expr} ->
	    From ! {reply, expr:eval(Expr)},
	    loop();
	stop ->
	    io:format("terminating...~n")
    end.

stop() ->
    calc ! stop.

execute(X) ->
    calc ! {request, self(), X},
    receive
	{reply, Reply} ->
	    Reply
    end.
