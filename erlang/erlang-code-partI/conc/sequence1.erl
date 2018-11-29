-module(sequence1). 
-export([make_sequence/0, get_next/1, reset/1, go/1]). 

% Create a new shared counter. 
make_sequence() -> 
    spawn(fun() -> sequence_loop(0) end). 

sequence_loop(N) -> 
    receive 
        {From, get_next} -> 
            From ! {self(), N}, 
            sequence_loop(N+1); 
        reset -> 
            sequence_loop(0)
    end. 

% Retrieve counter and increment. 
get_next(Sequence) -> 
    Sequence ! {self(), get_next},
    receive 
        {Sequence, N} -> N
    end.

% Re-initialize counter to zero. 
reset(Sequence) -> Sequence ! reset. 

% Make lots of parallel sequence-getters
loop(N, N, F) ->
    F(N);
loop(I, N, F) -> 
    F(I),
    loop(I+1, N, F).

wait() ->
    receive
        die -> void
    end.

go(N) ->
    Pid = self(),
    S = make_sequence(),
    loop(1,N,fun(_) -> spawn(fun() -> loop(1,100,fun(_) -> get_next(S) end), Pid ! die end) end),
    loop(1,N,fun(_) -> wait() end),
    F = N * 100,
    F = get_next(S),
    ok.
