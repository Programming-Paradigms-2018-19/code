% File :    util.pl
% Author :  Dave Robertson (after Bratko p190)
% Purpose : A map colouring program

% THE PROBLEM : To find a way of colouring a map using only 4 colours in
%		such a way that no pair of neighbouring countries are
%		the same colour.
%**********************************************************************

% Predicate : colour_countries(-List).
% Returns a List of terms of the form:
% 	Country/Colour where - Country is the name of some country.
%			     - Colour is the map colour for that country.
% This program gives the following behaviour:
%
% | ?- colour_countries(X).
%
%     X=[austria/red,belgium/green,denmark/yellow,france/red,
%        germany/blue,italy/blue,netherlands/yellow,portugal/blue,
%        spain/yellow,switzerland/yellow]
%yes

% colour_countries/1 works by first using setof/3 to construct a list of terms
% of the form :	Country/Var where - Country is the name of a country
%				    Var is a variable
% It then uses colours/2 to bind each Var in this list to an appropriate colour

colour_countries(Colours):-
	setof(Country/_, X^ngb(Country,X), Colours),
	colours(Colours).

% Predicate : colours(+List)
% Succeeds when, given a List of elements of form Country/Colour, a value
% for each Colour can be found such that the Country to which it is attached
% has no neighbour of the same colour.

	% If there are no elements left in the list then just succeed.
colours([]).
	% For a list with head Country/Colour and tail Rest, colour all
	% the Rest then select a value for Colour from the list of candidates
	% then check that there is no country in Rest which neighbours
	% the Country just coloured and has the same Colour.,
colours([Country/Colour|Rest]):-
	colours(Rest),
	member(Colour, [yellow,blue,red,green]),
	\+ (member(Country1/Colour, Rest), neighbour(Country, Country1)).


% Predicate : neighbour(Country, Neighbour)
% Succeeds if Neighbour is a neighbour of Country

neighbour(Country, Country1):-
	ngb(Country, Neighbours),
	member(Country1, Neighbours).


% Predicate : ngb(Country, Neighbours).
% Determines the list of Neighbours of a Country.

ngb(portugal, [spain]).
ngb(spain, [portugal,france]).
ngb(france, [spain,belgium,switzerland,germany,italy]).
ngb(belgium, [france,germany,netherlands]).
ngb(netherlands, [belgium,germany]).
ngb(germany, [netherlands,belgium,france,switzerland,austria,denmark]).
ngb(switzerland, [france,germany,austria,italy]).
ngb(austria, [germany,switzerland,italy]).
ngb(italy, [france,switzerland,austria]).
ngb(denmark, [germany]).


% Predicate : member(Element, List)
% Standard membership utility

member(X, [X|_]).
member(X, [_|T]):-
	member(X, T).
