fac(1,1).
fac(N,F) :- NAUX is N - 1, fac(NAUX,FAUX), F is N * FAUX.
