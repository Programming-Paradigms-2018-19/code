revAppend([],X,X).
revAppend([X|Y],Z,W) :- revAppend(Y,[X|Z],W).
