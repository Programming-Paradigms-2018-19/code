sumntr(0,F,TMP) :- F is TMP.
sumntr(N,F,TMP) :- N > 0, NAUX is N - 1, TMPAUX is TMP + NAUX, sumntr(NAUX,F,TMPAUX).

