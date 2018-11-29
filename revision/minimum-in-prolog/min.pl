% min(X,Y,Z) if Z is the miniumum of X and Y

minimum(X,Y,Y) :- X >= Y, !.
minimum(X,_,X).