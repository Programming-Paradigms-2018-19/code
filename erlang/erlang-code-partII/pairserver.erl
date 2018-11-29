-module(pairserver). 
-export([make_pair/0, push/2, pop/1, peek/1, swap/1, test/0]). 

% Create a new shared counter. 
make_pair() -> 
    spawn(fun() -> pair_loop(0,0) end). 

pair_loop(N,M) -> 
    receive 
        {From, peek} -> 
            From ! {self(), N}, 
            pair_loop(N,M); 
        {From, pop} -> 
            From ! {self(), N}, 
            pair_loop(M,0); 
        {push, P} -> 
            pair_loop(P,N);
	swap ->
	    pair_loop(M,N)
    end. 

% See the top element of the pair
peek(Pair) ->
    Pair ! {self(), peek},
    receive 
        {Pair, N} -> N
    end.

% Pop the top element of the pair
pop(Pair) ->
    Pair ! {self(), pop},
    receive 
        {Pair, N} -> N
    end.

% Push a new element on top
push(Pair,N) -> Pair ! {push, N}.

% Push a new element on top
swap(Pair) -> Pair ! swap.

% testing code
test() ->
    P = make_pair(),
    push(P,1), push(P,2),
    2 = pop(P),
    1 = peek(P),
    swap(P),
    0 = pop(P),
    1 = pop(P),
    ok.
