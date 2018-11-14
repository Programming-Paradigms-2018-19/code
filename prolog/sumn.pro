sumn(0,0).
sumn(N,F) :- NAUX is N - 1, sumn(NAUX,FAUX), F is N + FAUX.
