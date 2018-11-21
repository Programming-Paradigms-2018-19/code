likes(wallace, toast).
likes(wallace, cheese).
likes(gromit, cheese).
likes(gromit, cake).
likes(wendolene, sheep).

friend(X, Y) :- likes(X, Z), likes(Y, Z), \+(X = Y).

owns(wallace, book(perfume,author(suesskind))). % book is the functor
owns(wendolene, book(russel_the_sheep, author(scotton))). % args to functor are its components
owns(gromit, book(wuthering_heights,
                  author(emily,bronte))).

%book(perfume,suesskind).
%book(russell_the_sheep, scotton).
