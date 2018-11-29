-module(coroner).
-export([loop/0]).

loop() ->
  process_flag(trap_exit,true),
  receive
    {link,Process} ->
      link(Process),
      io:format("Supervising new process.~n"),
      loop();
    {'EXIT',From,Reason} ->
      io:format("~p died: ~p~n",[From,Reason]),
      io:format("Please start another one.~n"),
      loop();
    _ ->
      io:format("Unexpected message received.~n"),
      loop()	
  end.			
