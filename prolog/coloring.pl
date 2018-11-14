border(r,g). border(r,b).
border(g,r). border(g,b).
border(b,r). border(b,g).

coloring(L,TAA,V,FVG) :-
    border(L,TAA),
    border(L,V),
    border(TAA,V),
    border(V,FVG).
