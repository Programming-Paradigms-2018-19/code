; Lecture: Macros

#lang racket

(provide (all-defined-out))

;;;; some example macros

;; a cosmetic macro -- adds then, else
(define-syntax my-if 
  (syntax-rules (then else)
    [(my-if e1 then e2 else e3)
     (if e1 e2 e3)]))

;; a macro to replace an expression with another one
(define-syntax comment-out
  (syntax-rules ()
    [(comment-out ignore instead) instead]))

;; makes it so users do *not* write the thunk when using my-delay
(define-syntax my-delay
  (syntax-rules ()
    [(my-delay e)
     (mcons #f (lambda () e))]))

;;;;; some macro uses

(define seven (my-if #t then 7 else 14))
; SYNTAX ERROR: (define does-not-work (my-if #t then 7 then 9))
; SYNTAX ERROR: (define does-not-work (my-if #t then 7 else else))

(define no-problem (comment-out (car null) #f))

(define x (begin (print "hello") (* 3 4)))

(define p (my-delay (begin (print "hi") (* 3 4))))

; just do this (a my-force macro serves no purpose (see slides) !)
(define (my-force th)
  (if (mcar th)
      (mcdr th)
      (begin (set-mcar! th #t)
             (set-mcdr! th ((mcdr th)))
             (mcdr th))))

; (my-force p)
; (my-force p)

;;;;; more examples

;; a loop that executes body hi - lo times
;; notice use of local variables
(define-syntax for
  (syntax-rules (to do)
    [(for lo to hi do body)
     (let ([l lo]
           [h hi])
       (letrec ([loop (lambda (it)
                        (if (> it h)
                            #t
                            (begin body (loop (+ it 1)))))])
         (loop l)))]))

;; let2 allows up to two local bindings (with let* semantics) with fewer parentheses
;; than let*
(define-syntax let2
  (syntax-rules ()
    [(let2 () body)
     body]
    [(let2 (var val) body)
     (let ([var val]) body)]
    [(let2 (var1 val1 var2 val2) body)
     (let ([var1 val1])
       (let ([var2 val2])
         body))]))

;; the special ... lets us take any number of arguments
;; Note: nothing prevents infinite code generation except
;; the macro definer being careful
(define-syntax my-let*
  (syntax-rules ()
    [(my-let* () body)
     body]
    [(my-let* ([var0 val0]
               [var-rest val-rest] ...)
              body)
     (let ([var0 val0])
       (my-let* ([var-rest val-rest] ...)
                body))]))

