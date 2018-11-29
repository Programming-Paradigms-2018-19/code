path(1,2).
path(2,5).
path(1,3).
path(3,6).
path(6,7).
path(7,8).
path(3,4).
path(4,8).

%route(Start,End) :-
%	path(Start,End).

route(Start,End,[Start,End]) :-
    path(Start,End).

%route(Start,End) :-
%	path(Start,Somewhere),
%	route(Somewhere,End).

route(Start,End, [Start|SomePath]) :-
    path(Start,Somewhere),
    route(Somewhere,End,SomePath).