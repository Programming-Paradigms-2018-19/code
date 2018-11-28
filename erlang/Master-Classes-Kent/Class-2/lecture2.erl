-module(lecture2).
-export([for/3,rpc/2,promise/2,yield/1,pmap/1,do/2,peval/1]).

for(Max,Max,F) ->
    [F(Max)];
for(I,Max,F) ->
    [F(I)|for(I+1,Max,F)].

rpc(Pid, Request) ->
    Tag = erlang:make_ref(),
    Pid ! {self(), Tag, Request},
    receive
	{Tag, Response} ->
	    Response
    end.

promise(Pid, Request) ->
    Tag = erlang:make_ref(),
    Pid ! {self(), Tag, Request},
    Tag.

yield(Tag) ->
    receive
	{Tag, Response} ->
	    Response
    end.

pmap(L) ->
   S = self(),
   Pids = [do(S,F) || F <- L],
   [receive {Pid,Val} -> Val end || Pid <- Pids].

do(Parent, F) ->
   spawn(fun() ->
          Parent ! {self(), F()}
         end).

peval({mul, X, Y}) ->
    [Xv,Yv] = pmap([fun() -> peval(X) end,
		    fun() -> peval(Y) end]),
    Xv * Yv.

