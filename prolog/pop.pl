pop(usa,313).
pop(italy,61).
pop(uk,63).

area(usa,9.826).
area(italy,0.301).
area(uk,0.243).

density(X,Y) :- pop(X,P),area(X,A),Y is P/A.
