%% 
%% Code Example
%%
%% This module implements a simple Erlang process that prints "I am happy!"
%% every five seconds until it receives a shutup message that shuts it down.
%%
%% To run this code example, evaluate the following expression:
%%
%%     1> Pid = spawn(fun processexample:run/0).
%%     <0.36.0>
%%
%% You will see "I am happy!" printed to the interpreter window repeatedly
%% until you evaluate the following expression:
%%
%%     2> Pid ! shutup.
%%     shutup
%%
%% at which time you'll see an "I am sad..." message printed and then no
%% further messages will be printed.  You can also verify that the process
%% has died like this:
%%
%%     3> erlang:is_process_alive(Pid).
%%     false

-module(processexample).

-export([run/0]).


run() ->
	receive
		shutup ->
			io:format("I am sad...~n"),
			ok
	after 5000 ->
		io:format("I am happy!~n"),
		run()
	end.
