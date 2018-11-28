-module(client1).
-export([calc/1, test/0]).

test() ->
    22 = calc({add, 
	       {num, 10}, 
	       {mul,{num,3},{num,4}}}),
    horray.

calc(X) ->
    Pid = whereis(calc),
    Pid ! {self(), eval, X},
    receive
	{Pid, Reply} ->
	    Reply
    end.
