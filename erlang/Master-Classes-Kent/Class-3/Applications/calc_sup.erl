-module(calc_sup).
-behaviour(supervisor).

-export([start_link/1]).
-export([init/1]).


start_link(Env) ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, Env).

init(Env) ->
    SupFlags = {one_for_one, 10, 3600},
    ChildSpec = {calc, {calc, start, [Env]},
	      permanent, 2000, worker, [calc_gen]},

    {ok, {SupFlags, [ChildSpec]}}.

