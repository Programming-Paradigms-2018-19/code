#lang racket

;; Here's a garden-variety recursive function:
(define (fact1 n)
  (if (= n 0)
      1
      (* n (fact1 (- n 1)))))

;; We could also write this as
(define fact2 
  (lambda (n)
    (if (= n 0)
        1
        (* n (fact2 (- n 1))))))

;; Note what fact2 is bound to!  Remember that lambdas capture their environment
;; of definition, so fact2 must be in that environment.

;; Does this work?
(define fact3 "this is an impostor function!!!")
(let ((fact3 (lambda (n)
               (if (= n 0)
                   1
                   (* n (fact3 (- n 1)))))))
  (fact3 6))

;; Aargh!  Wrong binding for the recursive call!  

;; Racket provides another version of let for this:
(letrec ((fact4 (lambda (n)
               (if (= n 0)
                   1
                   (* n (fact4 (- n 1)))))))
  (fact4 6))

;; now this works

;; The obvious way to implement letrec is to use side effects -- create the variables
;; to be bound (e.g. fact4), bind them temporarily to the value 'undefined', and then 
;; set the variable to the correct value of the expression.  And this is what Racket 
;; does -- see http://docs.racket-lang.org/reference/let.html

;; It's a bit hard to notice the 'undefined' value, since Racket in recent versions
;; checks for an undefined variable error.  
;; This is a complete fudge but does "work around" the problem:
(define bad bad)
;; and then look at the value of 'bad'

;; But here is some code that will actually print the value of the elusive 
;; variable when it is undefined!
(letrec ((x (begin (display x) (display "\n") 42))) x)
