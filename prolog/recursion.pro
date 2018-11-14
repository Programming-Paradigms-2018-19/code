is_in(X,[X|_]).
is_in(X,[_|Y]) :- is_in(X,Y).
