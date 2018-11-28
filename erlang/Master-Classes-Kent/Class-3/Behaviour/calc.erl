-module(calc).
-export([start/1, stop/0, eval/1]).
-export([init/1]).

start(Env) ->
    register(calc, spawn(calc, init, [Env])).

stop() ->
    calc ! stop. 

eval(Expr) ->
    calc ! {request, self(), {eval, Expr}},
    receive
	{reply, Reply} ->
	    Reply
    end.

init(Env) ->
    io:format("Starting...~n"),
    loop(Env).

loop(Env) ->
    receive
	{request, From, {eval, Expr}} ->
	    From ! {reply, expr:eval(Env, Expr)},
	    loop(Env);
	stop ->
	    io:format("Terminating...~n")
    end.

