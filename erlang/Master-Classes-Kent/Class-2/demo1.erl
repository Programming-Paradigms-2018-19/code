-module(demo1).
-export([area/0]).

area() ->
   receive
     {square,X} ->
       X*X;
     {rectangle,X,Y} ->
       X*Y
   end,
   area().
