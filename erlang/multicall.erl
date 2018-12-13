-module(multicall).
-export([multicall/1,test/0]).

multicall(Calls) ->
    Parent = self(),
    Pids = [worker(Parent,Call) || Call <- Calls],
    wait_all(Pids).

worker(Parent, {Server, Params}) ->
    spawn(fun() ->
		  Result = server:call(Server,Params),
		  Parent ! {self(), Result}
	  end).

wait_all(Pids) ->
    [receive {Pid,Result} -> Result end || Pid <- Pids].

test() ->
    Sequence1 = sequence2:make_sequence(),
    Sequence2 = sequence2:make_sequence(),
    sequence2:get_next(Sequence2),
    Sequence3 = sequence2:make_sequence(),
    Calls = [{Sequence2,get_next}, {Sequence2,get_next}, {Sequence2,get_next}],
    multicall(Calls).
    
