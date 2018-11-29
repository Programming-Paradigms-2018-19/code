-module(translate2).
-export([loop/0]).
-export([translate/2]).

loop() ->
  receive
    {Pid, "casa"} -> 
      Pid ! "house",      
      loop();
    {Pid, "blanca"} -> 
      Pid ! "white",      
      loop();
    {Pid, _} -> 
      Pid ! "?",		
      loop()			
  end.				

translate(To,Word) ->
  To ! {self(),Word},
  receive
    Translation -> Translation
  end.
