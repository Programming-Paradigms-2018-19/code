-module(join).
-export([start/0, call/2]). 

start() ->
    spawn(fun() -> loop() end).

loop() ->
    receive
        {bread, {Client,Id}} ->
            receive
                {butter, {Client2,Id2}} ->
                    Client ! {Id,toast},
                    Client2 ! {Id2,toast},
                    loop()
            end
    end.

call(Server,Msg) ->
    Id = make_ref(),
    Server ! {Msg, {self(),Id}},
    receive 
        {Id, Reply} -> Reply 
    end. 

% spawn(fun () -> io:format ("Got ~s~n", [join:call(S,bread)]) end).
% spawn(fun () -> io:format ("Got ~s~n", [join:call(S,bread)]) end).
