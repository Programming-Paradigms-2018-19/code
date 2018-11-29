-module(greeter).
-export([hello/1]).

hello(Name) ->
  io:format("Hello ~p!~n",[Name]).

% Greeter = fun(Name) -> io:format("Hello ~p!~n",[Name]) end.
% Greeter(blubb).
