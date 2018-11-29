-module(listaux).
-export([min/1]).
-export([checkmin/2]).

checkmin(Item,TmpMin) ->
  if 
    Item < TmpMin -> Item;
    true -> TmpMin
  end.

min([]) ->
  "no minimum, empty list";
min([H|T]) ->
  lists:foldl(fun listaux:checkmin/2,H,T).
