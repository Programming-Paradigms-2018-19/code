-module(echo).
-export([loop/0]).

loop() -> 
  receive
    X -> io:format("~p~n", [X]),
    loop()
  end.
