-module(mymodule2).
-export([sign/1]).

sign(N) when is_number(N) -> 
  if 
    N > 0 -> 1;
    N < 0 -> -1;
    N == 0 -> 0
  end;
sign(N) ->
  "not a number".
