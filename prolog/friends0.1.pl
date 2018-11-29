likes(wallace, toast).
likes(wallace, cheese).
likes(gromit, cheese).
likes(gromit, cake).
likes(wendolene, sheep).

likes(X,Y) :- likes(X,Z),likes(Y,Z),\+(X = Y).
