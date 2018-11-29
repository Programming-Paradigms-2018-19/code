  sum([],0).
  sum([H|T],S) :- sum(T, S1), S is S1 + (H * H).
