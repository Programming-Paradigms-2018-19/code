%listeq(A,A) :- lst(A).
%lst([]).
%lst([_|_]).

listeq([],[]).
listeq([X|Y],[A|B]) :- X=A, listeq(Y,B).