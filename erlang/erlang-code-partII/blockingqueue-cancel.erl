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
-export([make_queue/0, put/2, take/1, cancel/1]).

% Unit test
-export([test/0]).

make_queue() -> spawn(fun() -> queue_loop(ok) end).

queue_loop(Status) ->
    receive 
	% received request of queued item
	{From, Id, take} ->
	    % if queue was canceled, return failure
	    if (Status == cancel) ->
		    From ! {Id, cancel},
		    queue_loop(Status);
	       % otherwise, wait until someone adds something
	       % and then return it.  If, in the meantime
	       % the queue is canceled, just quit
	       true ->
		    receive 
			{put, Element} -> 
			    From ! {Id, ok, Element},
			    queue_loop(ok);
			cancel ->
			    From ! {Id, cancel},
			    queue_loop(cancel)
		    end
	    end
    end.

take(Q) ->
    Id = make_ref(),
    Q ! {self(), Id, take},
    receive
	{Id, ok, Element} -> {ok,Element};
	{Id, cancel}      -> cancel
    end.

put(Q,Element) ->
    Q ! {put, Element}, 
    ok.

cancel(Q) ->
    Q ! cancel,
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
    cancel(testqueue),
    cancel = take(testqueue),
    cancel = take(testqueue),
    ok.
		  
