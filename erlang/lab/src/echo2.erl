-module(echo2).
-export([loop/0]).
-export([send/2]).

loop() -> 
  receive
    {Pid,X} -> Pid,
    Pid ! X,
    loop()
  end.

send(To,Message) ->
  To ! {self(),Message},
  receive
    Y -> io:format("Message received: ~p~n", [Y])
  end.
