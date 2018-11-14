likes(wallace,cheese).
likes(gromit,cheese).
likes(wendolene,sheep).

friend(X,Y) :- likes(X,Z),likes(Y,Z),\+(X=Y).
