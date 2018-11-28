
-module(counter1).
-import(gen_server_lite,[start/2,rpc/2]).
-export([start/0,tick/1,read/0,handle/2]).

start() -> start(counter1, 0).

tick(N)  -> rpc(counter1, {tick, N}).
read()   -> rpc(counter1, read).

handle({tick,N}, State) -> {ack, State+N};
handle(read, State)     -> {State, State}.

