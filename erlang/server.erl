-module(server). 
-export([start/1, loop/2, call/2, cast/2]). 
% Client-server messaging framework. 
% 
% The callback module implements the following callbacks: 
% init() -> InitialState 
% handle_call(Params, State) -> {Reply, NewState} 
% handle_cast(Params, State) -> NewState 
% Return the pid of a new server with the given callback module. 

start(Module) -> 
    spawn(fun() -> loop(Module, Module:init()) end). 

loop(Module, State) -> 
    receive 
        {call, {Client, Id}, Params} -> 
            {Reply, NewState} = Module:handle_call(Params, State), 
            Client ! {Id, Reply}, 
            loop(Module, NewState); 
        {cast, Params} -> 
            NewState = Module:handle_cast(Params, State), 
            loop(Module, NewState) 
    end. 

% Client-side function to call the server and return its reply. 
call(Server, Params) -> 
    Id = make_ref(), 
    Server ! {call, {self(), Id}, Params}, 
    receive 
        {Id, Reply} -> Reply 
    end. 

% Like call, but no reply is returned. 
cast(Server, Params) -> 
    Server ! {cast, Params}. 
