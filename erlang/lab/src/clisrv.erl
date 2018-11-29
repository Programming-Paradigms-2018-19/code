-module(clisrv).
-export([server/0]).
-export([client/0]).


server() -> 
  receive
    {Pid,X} -> Pid ! fac(X),
    server()
  end.


client() ->
  facsrv ! {self(),5},
  receive
    Y1 -> io:format("Message received: ~p~n", [Y1])
  end,
  facsrv ! {self(),10},
  receive
    Y2 -> io:format("Message received: ~p~n", [Y2])
  end.
  

fac(0) -> 1;
fac(N) -> N * fac(N-1).
