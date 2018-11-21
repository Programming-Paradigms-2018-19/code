likes(wallace, toast).
likes(wallace, cheese).
likes(gromit, cheese).
likes(gromit, cake).
likes(wendolene, sheep).

friend(wallace,X) :- likes(X,cheese).

%friend(wallace,X) :- likes(X,cheese),\+(X=wallace).

%friend(X, Y) :- likes(X, Z), likes(Y, Z), \+(X = Y).
