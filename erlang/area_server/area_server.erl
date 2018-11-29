%%
%% Code Example
%%
%% This module implements a simple Erlang server process that calculates the
%% area of either a rectangle or a circle.
%%
%% To execute the server, evaluate the following expression:
%%
%%     1> AreaServerPid = spawn(fun area_server:run/0).
%%     <0.31.0>
%%
%% To ask it to calculate the area of a rectangle, then receive its response,
%% evaluate these expressions:
%%
%%     2> AreaServerPid ! {self(), {rectangle, 3, 5}}.
%%     {<0.29.0>, {rectangle, 3, 5}}
%%     3> flush().
%%     Shell got 15
%%     ok
%%
%% The flush() function, when called from the shell, prints the values of
%% any messages in the shell process' mailbox (and also removes them from
%% the mailbox).  When testing message passing from the shell, this can be
%% a very handy tool for seeing what you got, without having to write
%% receive expressions and associate variables with the messages.
%%
%% To shut the server down, evaluate these expressions:
%%
%%     4> AreaServerPid ! {self(), stop}.
%%     {<0.29.0>, stop}
%%     5> flush().
%%     Shell got ok
%%     ok


-module(area_server).

-export([run/0]).


run() ->
	receive
		{ResponsePid, {rectangle, Width, Height}} ->
			ResponsePid ! (Width * Height),
			run();
		
		{ResponsePid, {circle, Radius}} ->
			ResponsePid ! (3.14159 * Radius * Radius),
			run();
		
		{ResponsePid, stop} ->
			ResponsePid ! ok
	end.


%% A fair question to ask at this point is why you would move a simple
%% calculation like this area calculation into a separate process.  The
%% truthful answer is that you probably wouldn't; in practice, you'd gain
%% very little (there's not enough work to make it worth gaining concurrency,
%% as the overhead of the message passing is very likely more work than the
%% area calculation).  But this serves as a simple example of a server
%% process that can be spawned, can do work, and can be shut down.
