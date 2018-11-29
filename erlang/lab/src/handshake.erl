-module(handshake).
-export([srv_init/0]).
-export([client/0]).


srv_init() ->
  receive
    {Pid,syn} -> Pid ! synack
  end,
  receive
    {Pid,ack} -> ok
  end,
  srv_loop().


srv_loop() -> 
  receive
    {Pid,X} -> 
      Pid ! fac(X),
      srv_loop()
  end,
  receive
    {Pid,fin} -> 
      Pid ! ack,
      Pid ! fin,
      receive
        {Pid,ack} -> ok
      end,
      srv_terminate()
  end.


srv_terminate() -> ok.


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
