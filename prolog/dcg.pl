/*	File:	dcg.pl
	Author:	Dave Robertson
	Purpose:Some Definite Clause Grammar examples (pinched from
		Sterling & Shapiro, "The Art of Prolog" and from the
		Quintus Prolog User Manual.
*/

%	A SIMPLE EXAMPLE (from Sterling & Shapiro)
%----------------------------------------------------------------------

%	Grammar rules.

sentence --> noun_phrase, verb_phrase.

noun_phrase --> noun_phrase2.
noun_phrase --> determiner, noun_phrase2.

noun_phrase2 --> noun.
noun_phrase2 --> adjective, noun_phrase2.

verb_phrase --> verb.
verb_phrase --> verb, noun_phrase.

%	Vocabulary

determiner --> [the].
determiner --> [a].

adjective --> [decorated].

noun --> [pieplate].
noun --> [surprise].

verb --> [contains].

%	Sample of behaviour
%	-------------------
%	a - Parsing a sentence.
%
%	| ?-  phrase(sentence, [the,decorated,pieplate,contains,a,surprise]).
%
%	yes
%
%	b - Generating sentences.
%
%	| ?-  phrase(sentence, X).
%
% 	    X=[pieplate,contains] ;
%
% 	    X=[pieplate,contains,pieplate] ;
%
% 	    X=[pieplate,contains,surprise] 
%	yes


%	COMPUTING A PARSE TREE (From Sterling & Shapiro)
%----------------------------------------------------------------------

%	Grammar rules.

sentence(sent(N,V)) --> noun_phrase(N), verb_phrase(V).

noun_phrase(np(N)) --> noun_phrase2(N).
noun_phrase(np(D,N)) --> determiner(D), noun_phrase2(N).

noun_phrase2(np2(N)) --> noun(N).
noun_phrase2(np2(A,N)) --> adjective(A), noun_phrase2(N).

verb_phrase(vp(V)) --> verb(V).
verb_phrase(vp(V,N)) --> verb(V), noun_phrase(N).

%	Vocabulary

determiner(det(the)) --> [the].
determiner(det(a)) --> [a].

adjective(adj(decorated)) --> [decorated].

noun(noun(pieplate)) --> [pieplate].
noun(noun(surprise)) --> [surprise].

verb(verb(contains)) --> [contains].

%	Sample of behaviour
%	-------------------
%	a - Parsing a sentence.
%
%| ?- phrase(sentence(X), [the,decorated,pieplate,contains,a,surprise]).
%
%    X=sent(np(det(the),np2(adj(decorated),np2(noun(pieplate)))),
%           vp(verb(contains),np(det(a),np2(noun(surprise)))))
%yes
%
%	b - Generating sentences.
%
%| ?- phrase(sentence(X), Y).
%
%    X=sent(np(np2(noun(pieplate))),vp(verb(contains)))
%    Y=[pieplate,contains] ;
%
%    X=sent(np(np2(noun(pieplate))),vp(verb(contains),np(np2(noun(pieplate)))))
%    Y=[pieplate,contains,pieplate] ;
%
%    X=sent(np(np2(noun(pieplate))),vp(verb(contains),np(np2(noun(surprise)))))
%    Y=[pieplate,contains,surprise] 
%yes



%	PARSING AND COMPUTING AN ARITHMETIC EXPRESSION (from Quintus manual).
%----------------------------------------------------------------------------

%	Grammar rules.

expr(Z) --> term(X), "+", expr(Y), {Z is X + Y}.
expr(Z) --> term(X), "-", expr(Y), {Z is X - Y}.
expr(X) --> term(X).

term(Z) --> number(X), "*", term(Y), {Z is X * Y}.
term(Z) --> number(X), "/", term(Y), {Z is X / Y}.
term(Z) --> number(Z).

number(C) --> "+", number(C).
number(C) --> "-", number(X), {C is -X}.

%	Vocabulary.

number(X) --> [C], {"0" =< C, C =< "9", X is C - "0"}.

%	Sample of behaviour
%	-------------------
%
%	| ?- phrase(expr(Z), "-2+3*5+1").
%
%	     Z=14 
%	yes

