-module(listaux2).
-export([min/1]).
-export([max/1]).
-export([checkmin/2]).
-export([checkmax/2]).

checkmin(Item,TmpMin) ->
  if 
    Item < TmpMin -> Item;
    true -> TmpMin
  end.

min([]) ->
  "no minimum, empty list";
min([H|T]) ->
  lists:foldl(fun listaux2:checkmin/2,H,T).


checkmax(Item,TmpMin) ->
  if 
    Item > TmpMin -> Item;
    true -> TmpMin
  end.

max([]) ->
  "no minimum, empty list";
max([H|T]) ->
  lists:foldl(fun listaux2:checkmax/2,H,T).

