foo :- a, !, b(0). % extra-logical primitive

foo :- c, d, e, f. % green cuts - red cuts
foo :- g, h.

a.
b(1).
c.
d.
e.
f.
g.
h.
