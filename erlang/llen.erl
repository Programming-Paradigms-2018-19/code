-module(llen).
-export([list_length/1]).

list_length([]) ->
    0;
list_length([_|T]) ->
    1 + list_length(T).

