-module(server).
-export([server/0]).
-export([send/2]).


server() -> 
  receive
    {Pid,X} -> Pid ! fac(X),
    server()
  end.


send(To,Message) ->
  To ! {self(),Message},
  receive
    Y -> io:format("Message received: ~p~n", [Y])
  end.


fac(0) -> 1;
fac(N) -> N * fac(N-1).
