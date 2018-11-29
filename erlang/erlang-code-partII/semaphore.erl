-module(semaphore). 
-export([make_semaphore/1, put/1, take/1]). 

loop(N, N, F) ->
    F(N);
loop(I, N, F) -> 
    F(I),
    loop(I+1, N, F).

% Create a new shared counter. 
make_semaphore(N) -> 
    S = spawn(fun() -> sem_loop() end),
    loop(1,N,fun (_) -> put(S) end),
    S.

sem_loop() -> 
    receive 
	{ From, take } ->
	    receive 
		{_, put} -> 
		    From ! self(),
		    sem_loop()
	    end
    end.

% Retrieve counter and increment. 
take(Sem) -> 
    Sem ! {self(), take},
    receive 
        Sem -> ok
    end.

put(Sem) ->
    Sem ! {self(), put}.
