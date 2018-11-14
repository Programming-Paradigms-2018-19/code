  
/* ************************************************ */
/*                                                  */
/* Logic Programming                                */
/* Lecture 4                                        */
/* Example 1                                        */
/*                                                  */
/* An implementation of a Java-style for loop.      */
/*                                                  */
/* ************************************************ */


/* ************************************************ */
/*                                                  */
/*   for_loop/3                                     */
/*      Arg 1: counter (integer)                    */
/*      Arg 2: upper bound (integer)                */
/*      Arg 3: step (number)                        */
/*   Summary: An implementation of a Java-style for */
/*            loop. True if Arg1 > Arg2 otherwise   */
/*            Arg1 is stepped by the value of Arg3. */
/*   Author: P J Hancox                             */
/*   Date: 24 September 2012                        */
/*                                                  */
/* ************************************************ */


% 1 - terminating (base case)
for_loop(Counter, End, _Step) :-
     Counter > End,
     write_message(message('Stopped when Counter is: ', Counter)).
% 2 - recursive
for_loop(Counter, End, Step) :-
     Counter =< End,
     write_message(message('Counter is: ', Counter)),
     Counter1 is Counter + Step,
     for_loop(Counter1, End, Step). 


/* ************************************************ */
/*                                                  */
/*   write_message/1                                */
/*      Arg 1: message (structure)                  */
/*   Summary: Display message with 2 parts (texts). */
/*   Author: P J Hancox                             */
/*   Date: 24 September 2012                        */
/*                                                  */
/* ************************************************ */

write_message(message(Text1, Text2)) :-
     write(Text1),
     write(' : '),
     write(Text2), 
     nl.


/* ************************************************ */
/*                                                  */
/*                  End of program                  */
/*                                                  */
/* ************************************************ */
     