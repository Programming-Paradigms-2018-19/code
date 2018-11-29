%% counter.erl
%% 
%% Informatics 102 Spring 2012
%% Code Example
%%
%% This module exports a single function that tail-recursively calculates
%% the sum of the integers from Start to End by adding them up.  (It's not
%% an efficient way to solve the problem, of course, as it's possible to do
%% this with a simple formula, but it provides an example of a long-running
%% function that our MapReduce implementation can hook into.

-module(counter).
-export([count/2]).


count(Start, End) ->
	count(0, Start, End).


count(Sum, End, End) ->
	Sum + End;
count(Sum, Current, End) when Current < End ->
	count(Sum + Current, Current + 1, End).
