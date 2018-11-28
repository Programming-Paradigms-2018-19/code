-module(calc).
-export([start/1, stop/0, eval/1]).
-export([init/1, handle/2, terminate/1]).

start(Env) ->
    server:start(?MODULE, Env).

init(Env) ->
    io:format("Starting...~n"),
    Env.

stop() ->
    server:stop(?MODULE). 

terminate(_Env) ->
    io:format("Terminating...~n").

eval(Expr) ->
    server:request(?MODULE, {eval, Expr}).

handle({eval, Expr}, Env) ->
    {expr:eval(Env, Expr), Env}.
