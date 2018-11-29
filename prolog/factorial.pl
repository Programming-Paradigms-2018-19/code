factorial(1, 1) :- !.
factorial(N, Result) :-
	Y is N - 1,
	factorial(Y, Something),
	Result is N * Something.
