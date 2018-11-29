%% area_server.erl
%%
%% Code Example
%%
%% This module reimplements the area_server module from a previous code
%% example, but turns it into an "actor".  Actors are, in essence, a lot
%% like objects in object-oriented languages like Java, except for two
%% main differences:
%%
%% (1) Actors run concurrently, separately from anything else in the
%%     system.
%% (2) Instead of calling methods on them, we send messages to them;
%%     similarly, they return their results by sending messages back.
%%
%% Many other processes can send messages to them simultaneously,
%% but they'll only be able to process one message at a time,
%% which means that many of the problems involved in multithreaded
%% programming with shared objects (e.g., having to manage locks)
%% are avoided.  In a large system with many simultaneously-running
%% actors, it may well be possible to keep more cores busy this way.
%%
%% The underlying behaviour of the area_server hasn't changed here from
%% the previous example, except that we hide all the message passing
%% logic (i.e., the forms of the messages being passed back and forth)
%% within a few exported functions that make area_server feel more like
%% a Java object.  Make no mistake, though; this is still running in its
%% own process, concurrent with everything else.
%%
%% Most of the functions require the use of an "area server reference,"
%% which callers can think of as opaque.  In reality, though, it's just
%% the pid of the area server process running underneath.


-module(area_server_2).

-export([start/0, stop/1, rectangle_area/3, circle_area/2]).


start() ->
	spawn(fun run/0).


stop(AreaServer) ->
	call(AreaServer, {self(), stop}).


rectangle_area(AreaServer, Width, Height) ->
	call(AreaServer, {self(), {rectangle, Width, Height}}).


circle_area(AreaServer, Radius) ->
	call(AreaServer, {self(), {circle, Radius}}).


call(AreaServer, Message) ->
	AreaServer ! Message,
	receive
		{area_server_result, Result} ->
			Result
	end.


run() ->
	receive
		{ResponsePid, {rectangle, Width, Height}} ->
			respond(ResponsePid, Width * Height),
			run();
		
		{ResponsePid, {circle, Radius}} ->
			respond(ResponsePid, 3.14159 * Radius * Radius),
			run();
		
		{ResponsePid, stop} ->
			respond(ResponsePid, ok)
	end.


respond(ResponsePid, Result) ->
	ResponsePid ! {area_server_result, Result}.


%% Side question: Why does this sequence of calls lead the Erlang shell
%% to hang?
%%
%%     1> A = area_server:start().
%%     <0.35.0>
%%     2> area_server:stop(A).
%%     ok
%%     3> area_server:rectangle_area(A, 7, 10).
%%     [[THE SHELL HANGS INDEFINITELY HERE]]
