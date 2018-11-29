-module(mymodule).
-export([sign/1]).

sign(N) -> 
  if 
    N > 0 -> 1;
    N < 0 -> -1;
    N == 0 -> 0
  end.
