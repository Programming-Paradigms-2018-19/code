foo :- a, b.

foo :- c, d, e, f.
foo :- g, h.

a:- wr('a1').
a:- wr('a2').
b:- wr('b1').
b:- wr('b2').
c:- wr('c').
d:- wr('d').
e:- wr('e').
f:- wr('f').
g:- wr('g').
h:- wr('h').

wr(X):- write(X), nl.

goal :- foo, fail.
goal.
