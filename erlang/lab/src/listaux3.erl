-module(listaux3).
-export([min/1]).
-export([max/1]).
-export([minmax/1]).
-export([checkmin/2]).
-export([checkmax/2]).
-export([checkminmax/2]).

checkmin(Item,TmpMin) ->
  if 
    Item < TmpMin -> Item;
    true -> TmpMin
  end.

min([]) ->
  "no minimum, empty list";
min([H|T]) ->
  lists:foldl(fun listaux3:checkmin/2,H,T).


checkmax(Item,TmpMin) ->
  if 
    Item > TmpMin -> Item;
    true -> TmpMin
  end.

max([]) ->
  "no minimum, empty list";
max([H|T]) ->
  lists:foldl(fun listaux3:checkmax/2,H,T).


checkminmax(Item,{TmpMin,TmpMax}) ->
  if 
    Item < TmpMin -> {Item,TmpMax};
    Item > TmpMax -> {TmpMin,Item};
    true -> {TmpMin,TmpMax}
  end.

minmax([]) ->
  "no minmax, empty list";
minmax([H|T]) ->
  lists:foldl(fun listaux3:checkminmax/2,{H,H},T).
