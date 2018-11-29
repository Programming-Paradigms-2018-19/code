-module(doctor).
-export([loop/0]).

loop() ->
  process_flag(trap_exit,true),
  receive
    new ->
      io:format("Creating and supervising new process.~n"),
      register(gun,spawn_link(fun roulette:loop/0)),
      loop();
    {'EXIT',From,Reason} ->
      io:format("~p died: ~p~n",[From,Reason]),
      io:format("Restarting.~n"),
      self() ! new,
      loop();
    _ ->
      io:format("Unexpected message received.~n"),
      loop()	
  end.			
