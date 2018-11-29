-module(msort).
-export([splitmerge/0]).
-export([sorter/0]).
-export([send/2]).


splitmerge() ->
  receive
    {Pid,List} -> 
      register(sorter1,spawn(fun sorter/0)),
      register(sorter2,spawn(fun sorter/0)),
      {List1,List2} = lists:split(length(List) div 2,List),
      sorter1 ! {self(),sorter1,List1},
      sorter2 ! {self(),sorter2,List2}
  end,
  receive
    {sorter1,SList1} -> ok
  end,
  receive
    {sorter2,SList2} -> ok
  end,
  Pid ! lists:merge(SList1,SList2),
  splitmerge().


sorter() -> 
  receive
    {Pidsm,SorterID,Listsm} -> 
      Pidsm ! {SorterID,lists:sort(Listsm)}
  end.


send(To,Message) ->
  To ! {self(),Message},
  receive
    Y -> 
      lists:foreach(fun(X) -> io:format("~p ", [X]) end,Y),
      io:format("~n")
  end.
