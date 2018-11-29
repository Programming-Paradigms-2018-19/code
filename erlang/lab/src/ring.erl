-module(ring).
-export([loop/0]).


loop() ->
  receive
    {setup,N,M} -> 
      Child = spawn_link(fun loop/0),
      Child ! {start,self(),N-1},
      io:format("process ~p running with child ~p ~n", [self(),Child]),
      Child ! {message,N*M};
    {start,StartPID,1} -> 
      Child = StartPID,
      io:format("process ~p running with child ~p ~n", [self(),Child]);
    {start,StartPID,N} -> 
      Child = spawn_link(fun loop/0),
      Child ! {start,StartPID,N-1},
      io:format("process ~p running with child ~p ~n", [self(),Child])
  end,
  receive
    {message,0} ->
      io:format("stopping~n");
    {message,X} ->
      io:format("process ~p: message ~p received~n", [self(),X]),
      Child ! {message,X-1},
      loop()
  end.
