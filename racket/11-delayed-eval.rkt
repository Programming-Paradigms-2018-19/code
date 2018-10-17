#lang racket

;;; code for Racket lecture on delayed evaluation.

;;; Haskell uses lazy evaluation to pass parameters.  This has the
;;; same semantics as call-by-name, but can be more efficient since
;;; parameters are evaluated at most once.  
;;; Racket of course uses call-by-value.  
;;; However, we can simulate call-by-name by wrapping
;;; each parameter in a lambda (also known traditionally as a 'thunk').


;; Suppose that we have a function 'longwait' that takes a really long
;; time to compute its answer.  (So OK, this one doesn't take long at
;; all, but imagine that it does.  We'll put a print statement in just
;; so you know it's been called.)

(define (longwait x)
  (display "doing very long computation on x=")
  (display x)
  (display " ... go get a latte and come back.\n")
  (+ x 1))

;; if we pass b and c to test in the ordinary way (i.e. call-by-value)
;; the arguments will always be evaluated, whether we need them or not
(define (test1 a b c)
  (if a
      (+ b b c)
      c))

;; (test1 #t (longwait 10) (longwait 20))
;; (test1 #f (longwait 10) (longwait 20))

;; the same function, using thunks
(define (test2 a b c)
  (if a
      (+ (b) (b) (b) (c))
      (c)))

;; (test2 #t  (lambda () (longwait 10))  (lambda () (longwait 20)))
;; (test2 #f  (lambda () (longwait 10))  (lambda () (longwait 20)))


;; memoization (no side effects key to this having reasonable semantics)

;; Racket has built-in functions 'delay' and 'force'.  For example:
;;    (define d (delay (+ 3 4)))
;;    (force d)
;;

;; now we can define the function in a way that evaluates the argument
;; only if needed, and evaluates it at most once

;; the same function, using thunks
(define (test3 a b c)
  (if a
      (+ (force b) (force b) (force b) (force c))
      (force c)))

;; (test3 #t  (delay (longwait 10))  (delay (longwait 20)))
;; this time (longwait 10) only gets evaluated once

;; (test3 #f  (delay (longwait 10))  (delay (longwait 20)))
;; and this time not at all, of course

;; We can write our own version of delay and force (with not quite as
;; nice syntax - we need to wrap the argument to my-delay in a lambda):

;; first define a structure to hold a delayed expression.
;; is-evaluated is true if the expression has been evaluated already,
;; and false if not.  value is either a lambda (if is-evaluated is
;; false) or the resulting value (if is-evaluated is true).
(struct delay-holder (is-evaluated value) #:transparent #:mutable)

;; make a delayed expression
(define (my-delay f) 
  (delay-holder #f f))

;; force an expression to be evaluated, if it's not already
(define (my-force holder)
  (cond ((delay-holder-is-evaluated holder) (delay-holder-value holder))
        (else (set-delay-holder-is-evaluated! holder #t)
              (set-delay-holder-value! holder ((delay-holder-value holder)))
              (delay-holder-value holder))))

;; examples:
;; (define d (my-delay (lambda () (display "in delayed lambda ... ") (+ 3 4))))
;; (my-force d)

;; Or we could use a macro to provide the same syntax as Racket.


