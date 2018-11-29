-module(erlangtut).

-export([hello_world/0]).

hello_world() -> io:fwrite("hello, world\n").

c(erlangtut).
erlangtut:hello_world().