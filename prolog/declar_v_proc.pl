% File :   declar_v_proc.pl
% Author : Dave Robertson
% Purpose: Demonstration of declarative and procedural differences.

/*
The order of clauses and/or subgoals in a Prolog program with a  declarative
interpretation doesn't affect its declarative meaning buy often affects the
way the program is executed.  For example, the ancestor relation from the
program in file ancestors.pl was defined as follows:
*/

ancestor(A, B):-
    parent(A, B).
ancestor(A, B):-
    parent(P, B),
    ancestor(A, P).

%   parent(Parent, Child).
%   Parent is the parent of Child.

parent(alan, clive).
parent(andrea, clive).
parent(bruce, clarissa).
parent(betty, clarissa).
parent(clive, dave).
parent(clarissa, dave).
parent(clive, doris).
parent(clarissa, doris).
parent(eddie, greg).
parent(elsie, greg).
parent(fred, greta).
parent(freda, greta).
parent(greg, henry).
parent(greta, henry).

/*
By switching the ordering of the clauses and/or subgoals in this definition
we can obtain 3 different ways of defining the ancestor relation :
 - ancestor1 has the two clauses switched around.
 - ancestor2 has the order of subgoals switched around.
 - ancestor3 has the order of both clauses and subgoals switched around.
*/

ancestor1(A, B):-
    parent(P, B),
    ancestor1(A, P).
ancestor1(A, B):-
    parent(A, B).

ancestor2(A, B):-
    parent(A, B).
ancestor2(A, B):-
    ancestor2(A, P),
    parent(P, B).

ancestor3(A, B):-
    ancestor3(A, P),
    parent(P, B).
ancestor3(A, B):-
    parent(A, B).

/*
All of these variants of ancestor/2 have the same declarative meaning;
the order of clauses or subgoals doesn't affect this.  However, the
way they are executed by the Prolog interpreter is very different,
giving a different external behaviour of the program.  Consider the
following transcript of a Prolog session, in which I give the goal to find
some ancestor of dave using each of the definitions in turn :
----------------------------------------------------------------------
| ?- ['declar_v_proc.pl'].
{consulting /hame/dr/MSC/declar_v_proc.pl...}
{/hame/dr/MSC/declar_v_proc.pl consulted, 10 msec 3008 bytes}

yes
| ?- ancestor(X, dave).

     X=clive ;

     X=clarissa ;

     X=alan ;

     X=andrea ;

     X=bruce ;

     X=betty
yes
| ?- ancestor1(X, dave).

     X=alan ;

     X=andrea ;

     X=bruce ;

     X=betty ;

     X=clive ;

     X=clarissa 
yes
| ?- ancestor2(X, dave).

     X=clive ;

     X=clarissa ;

     X=alan ;

     X=andrea ;

     X=bruce ;

     X=betty
yes
| ?- ancestor3(X, dave).
{ERROR: Cannot expand choicepoint stack}
{Execution aborted}

----------------------------------------------------------------------
Although ancestor1 and ancestor2 return the same values for X, these values
are returned in a different order.  This is because in  ancestor1 the
recursive clause appears before the base case, so the interpreter always
tries to find a solution "the long way" before considering the shorter
alternative.  In ancestor3, the combination of putting the recursive case
first and putting the recursive call to ancestor3 before the step to parent
causes the interpreter to descend through an endless chain of subgoals until
it eventually runs out of memory and drops dead.

The moral of the story is : Your Prolog program may have a nice declarative
                            interpretation but if you want it to execute
                            you must often consider its procedural aspects.
*/
