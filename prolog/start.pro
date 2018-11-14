  
/* ************************************************ */
/*                                                  */
/* Logic Programming                                */
/* Lecture 4                                        */
/* Example 2                                        */
/*                                                  */
/* True if there is a path from start node to end   */
/* node.                                            */
/*                                                  */
/* ************************************************ */


/* ************************************************ */
/*                                                  */
/*   path/2                                         */
/*      Arg 1: node (atomic)                        */
/*      Arg 2: node (atomic)                        */
/*   Summary: There exists a path from Arg1 to      */
/*            Arg2.                                 */
/*   Author: P J Hancox                             */
/*   Date: 24 September 2012                        */
/*                                                  */
/* ************************************************ */

path(a,1).
path(a,3).

path(1,2).
path(1,4).

path(2,5).

path(3,4).

path(4,5).


/* ************************************************ */
/*                                                  */
/*   route/2                                        */
/*      Arg 1: node (atomic)                        */
/*      Arg 2: node (atomic)                        */
/*   Summary: True if there is a direct or indirect */
/*            path between two nodes.               */
/*   Author: P J Hancox                             */
/*   Date: 24 September 2012                        */
/*                                                  */
/* ************************************************ */

% 1 - boundary
route(Start, End) :-
     path(Start, End).
% 2 - recursive
route(Start, End) :-
     path(Start, Via),
     route(Via, End).
 
 
/* ************************************************ */
/*                                                  */
/*                  End of program                  */
/*                                                  */
/* ************************************************ */
     