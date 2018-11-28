-module(server).
-export([start/2, stop/1, request/2]).
-export([init/2]).

start(Name, Args) ->
    register(Name, spawn(?MODULE, init, [Name, Args])).

init(Name, Args) ->
    LoopData = Name:init(Args),
    loop(Name, LoopData).


stop(Name) ->
    Name ! stop. 

request(Name, Msg) ->
    Name ! {request, self(), Msg},
    receive
	{reply, Reply} ->
	    Reply
    end.


loop(Name, LoopData) ->
    receive
	{request, From, Msg} ->
	    {Reply, NewLoopData} = Name:handle(Msg, LoopData),
	    From ! {reply, Reply},
	    loop(Name, NewLoopData);
	stop ->
	    Name:terminate(LoopData)
    end.

