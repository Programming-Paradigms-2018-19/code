-module(masterslave).
-export([master/1]).


master(Slaves) ->
  receive
    create -> 
      Child = spawn(fun slave/0),
      io:format("New slave process ~p created~n",[Child]),
      master([Child|Slaves]);
    {send,X} ->
      lists:foreach(fun(To) -> To ! X end,Slaves),
      master(Slaves);
    kill ->
      lists:foreach(fun(To) -> To ! terminate end,Slaves),
      master([]);
    terminate ->
      lists:foreach(fun(To) -> To ! terminate end,Slaves)
  end.

slave() ->
  receive
    terminate ->
      io:format("process ~p finishing~n", [self()]);
    X ->
      io:format("process ~p received message ~p~n", [self(),X]),
      slave()
  end.
