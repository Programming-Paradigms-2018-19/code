-module(sem).
-compile(export_all).

make_semaphore(N) ->
    spawn(fun () -> semaphore_loop(N) end).

semaphore_loop(N) ->
    receive
	{From,acquire} when N > 0 ->
	    From ! N,
	    semaphore_loop(N-1);
	release ->
	    semaphore_loop(N+1)
    end.

acquire(SEM) ->
    SEM ! {self(), acquire},
    receive N -> N end.

release(SEM) ->
    SEM ! release.

