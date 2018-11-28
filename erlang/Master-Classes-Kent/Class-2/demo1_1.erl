-module(demo1_1).
-export([area/0]).

area() ->
   receive
     {square,X} ->
       io:format("~p~n",[X*X]);
     {rectangle,X,Y} ->
       io:format("~p~n",[X*Y])
   end,
   area().
