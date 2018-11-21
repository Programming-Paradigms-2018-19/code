sum_to(1,1) :- !.
sum_to(N,Result) :- TmpN is N-1, sum_to(TmpN,TmpRes), Result is TmpRes + N.

# sum_to(N,1) :- N =< 1.
# sum_to(N,Result) :- N > 1,
#                     TmpN is N-1, 
#                     sum_to(TmpN,TmpRes), 
#                     Result is TmpRes + N.
