#lang racket
(define (dropp n lst)
  (cond
    [(null? lst) lst]
    [(<= n 0) lst]
    [else (dropp (- n 1) (cdr lst))]))

(dropp 2 '(1 2 3 4))

(dropp 0 '(1 2 3 4))

(dropp 10 '(1 2 3 4))