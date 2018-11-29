%% counterprocess.erl
%%
%% Informatics 102 Spring 2012
%% Code Example
%%
%% This module implements a "counter" process, which is capable of calculating
%% the sum of the integers between two arbitrary integers M and N (inclusive).
%% This process doesn't do it very intelligently -- it literally sums the
%% integers one by one, instead of using a mathematical formula -- but this
%% gives us a testbed we can use with our mapreduce algorithm.
%%
%% Once you start the process, you can ask it to calculate a sum by calling
%% count/3 (which waits for a result) or countasync/3 (which doesn't wait for
%% a result, but instead lets it arrive in the calling process' mailbox).
%%
%% Also, you can send it a message of the form {count, Start, End, ReplyPid},
%% where Start and End are integers and ReplyPid is the pid of the process to
%% which the reply should be sent.  This also asks it to calculate a sum;
%% you'd use this mechanism when using this server with mapreduce, since
%% our mapreduce implementation explicitly sends messages to each process.
%% (A more generic implementation would have allowed funs to be passed into
%% it, which would have allowed us to call our countasync/3 function instead.)

-module(counterprocess).
-export([start/0, stop/1, count/3, countasync/3]).


start() ->
	spawn(fun run/0).


stop(CounterPid) ->
	CounterPid ! {stop, self()},
	receive
		ok ->
			ok
	end.


count(CounterPid, Start, End) ->
	CounterPid ! {count, Start, End, self()},
	receive
		{ok, Sum} ->
			Sum
	end.


countasync(CounterPid, Start, End) ->
	CounterPid ! {count, Start, End, self()}.


run() ->
	receive
		{stop, ReplyPid} ->
			ReplyPid ! ok;
		
		{count, Start, End, ReplyPid} ->
			Sum = counter:count(Start, End),
			ReplyPid ! {ok, Sum},
			run()
	end.
