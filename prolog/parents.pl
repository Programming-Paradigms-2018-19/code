parent(adam,0).
parent(eve,0).
parent(X,2) :- \+(X = adam), \+(X = eve).
