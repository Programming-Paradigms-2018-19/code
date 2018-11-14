sum_to(1,1) :- !.
sum_to(N,Result) :- TmpN is N-1, sum_to(TmpN,TmpRes), Result is TmpRes + N.
