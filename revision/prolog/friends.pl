likes(cat, python).
likes(pig, python).
likes(mouse, ruby).

friend(X, Y) :- \+(X = Y), likes(X, Z), likes(Y, Z).
