factr(N,F,TMP) :- N > 1, NAUX is N - 1, TMPAUX is TMP * NAUX, factr(NAUX,F,TMPAUX).
factr(1,F,TMP) :- F is TMP.
