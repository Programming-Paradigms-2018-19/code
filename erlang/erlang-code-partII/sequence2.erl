-module(sequence2). 
-export([make_sequence/0, get_next/1, reset/1]). 
-export([init/0, handle_call/2, handle_cast/2]). 
-export([test/0,go/1]). 

% API 
make_sequence()          -> server:start(sequence2). 
get_next(Sequence)       -> server:call(Sequence, get_next). 
reset(Sequence)          -> server:cast(Sequence, reset). 

% Server callbacks 
init()                   -> 0. 
handle_call(get_next, N) -> {N, N + 1}. 
handle_cast(reset, _)    -> 0. 

% Unit test: Return ‘ok’ or throw an exception. 
test() -> 
    0 = init(), 
    {6, 7} = handle_call(get_next, 6), 
    0 = handle_cast(reset, 101), 
    ok. 

go(N) ->
    Pid = self(),
    S = make_sequence(),
    loop(1,N,fun(_) -> spawn(fun() -> loop(1,100,fun(_) -> get_next(S) end), Pid ! die end) end),
    loop(1,N,fun(_) -> wait() end),
    F = N * 100,
    F = get_next(S),
    ok.

loop(N, N, F) ->
    F(N);
loop(I, N, F) -> 
    F(I),
    loop(I+1, N, F).

wait() ->
    receive
        die -> void
    end.
