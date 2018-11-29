-module(convert).
-export([convert/2]).

convert(M, inch) ->
    M / 2.54;
convert(M, centimeter) ->
    M * 2.54.
