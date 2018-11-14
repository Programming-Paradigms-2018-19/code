is_integer(0).
is_integer(X) :- is_integer(Y), X is Y+1.

idiv(X,Y,Result) :- is_integer(Result),
                    Prod1 is Result*Y,
                    Prod2 is (Result+1)*Y,
                    Prod1 =< X, Prod2 > X,
                    !.
