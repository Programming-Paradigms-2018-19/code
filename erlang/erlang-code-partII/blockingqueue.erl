-module(blockingqueue).
% Compiler directive, so that our put method does not clash with the
% built-in one.
-compile({no_auto_import,[put/2]}).

% Blocking queue implementation.
% 
% methods to make a queue (returns the PID of the process
% managing the queue), add an element to a queue (never blocks),
% take an element from a queue (blocks until an element is available,
% or returns premature if the queue is canceled), and cancel
% a queue, which causes all blocked takers to return (and all
% future ones to return immediately.
-export([make_queue/0, put/2, take/1]).

% Unit test
-export([test/0]).

make_queue() -> spawn(fun() -> queue_loop() end).

queue_loop() ->
    receive 
	% received request of queued item
	{From, Id, take} ->
	    receive 
		{put, Element} -> 
		    From ! {Id, Element},
		    queue_loop()
	    end
    end.

take(Q) ->
    Id = make_ref(),
    Q ! {self(), Id, take},
    receive
	{Id, Element} -> {ok,Element}
    end.

put(Q,Element) ->
    Q ! {put, Element}, 
    ok.

% Unit test
test() ->
    Q = make_queue(),
    register(testqueue,Q),
    spawn(fun() -> 
		  put(testqueue,"hello"), 
		  {ok,"bob"} = take(testqueue),
		  put(testqueue,"bye")
	  end),
    {ok,"hello"} = take(testqueue),
    put(testqueue,"bob"),
    {ok,"bye"} = take(testqueue),
    ok.
		  
