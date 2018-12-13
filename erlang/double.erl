-module(double).
-export([double/1, double/2]).

double(X) ->
    2 * X.

double(X,X) ->
    X*3.
    
