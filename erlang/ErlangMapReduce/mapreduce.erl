%% mapreduce.erl
%%
%% Informatics 102 Spring 2012
%% Code Example
%%
%% This module exports a single function that implements the MapReduce
%% algorithm in Erlang.
%%
%%     mapreduce:mapreduce/3
%%         This function takes three arguments:
%%             1. A list of "jobs", each of which is a two-element tuple,
%%                whose first element is the pid of a process that we'll
%%                ask to participate in the solution and whose second
%%                element is the message we'll send to that process to
%%                ask for its part of that solution.
%%             2. The "combiner" fun that combines a newly-received
%%                intermediate result with the current overall result
%%                to yield a new overall result.
%%             3. The initial result of the "reduce", before any
%%                intermediate results have been received.
%%
%% This implementation has at least one downside: if any of the map
%% processes does not return a response (e.g., because it crashed,
%% because one of the pids was a nonexistent process) the mapreduce
%% function will never return.  A proper implementation would need some
%% kind of timeout mechanism to prevent this problem.

-module(mapreduce).
-export([mapreduce/3]).


%% The mapreduce function is broken down into three steps:
%%
%% 1. Send the message to the various "map" processes.
%% 2. Figure out how many results to expect; we expect each of the
%%    processes to send us exactly one result.
%% 3. Collect and reduce the responses into a final result.  Whatever
%%    this step returns is the result that should be returned from
%%    mapreduce/3.

mapreduce(JobList, CombinerFun, InitialResult) ->
	send_messages(JobList),
	JobCount = length(JobList),
	combine_results(CombinerFun, InitialResult, JobCount).


%% The send_messages function uses lists:foreach to blast a message
%% to every process in our job list.  Note that lists:foreach is like
%% lists:map -- call this fun on every element of a list -- but it's
%% used to generate side effects, so it doesn't return a list of the
%% results.

send_messages(JobList) ->
	lists:foreach(
		fun({Pid, Message}) ->
			Pid ! Message
		end,
		JobList).


%% The combine_results function takes three arguments:
%%
%% 1. The "combiner" fun that combines each intermediate result with the
%%    current result to yield a new result.
%% 2. The current result that has been calculated by combining each of
%%    the intermediate results received so far.
%% 3. The number of responses we have yet to receive.
%%
%% For debugging purposes, I've included io:format calls here, so we can
%% see each of the intermediate results, and the new combined result
%% as it's being calculated.

combine_results(_CombinerFun, ResultSoFar, 0) ->
	io:format("Final result is ~p~n", [ResultSoFar]),
	ResultSoFar;
	
combine_results(CombinerFun, ResultSoFar, RemainingResponseCount)
when RemainingResponseCount > 0 ->
	receive
		OneResult ->
			NewResult = CombinerFun(ResultSoFar, OneResult),
			io:format("Received ~p ... new combined result is ~p~n", [OneResult, NewResult]),
			combine_results(CombinerFun, NewResult, RemainingResponseCount - 1)
	end.
