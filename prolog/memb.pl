memb(X,[X|_]).
memb(X,[_|T]) :- memb(X,T).
