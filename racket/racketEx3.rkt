#lang racket
(require scheme/mpair)
(define pr '(a b 34))
(define mpr (mlist 'p 'q 67))

(set-mcar! mpr "cat")

;;; variadic functions

(define last (lambda x (final x)))

(define (final ls)
    (if (null? (cdr ls))
        (car ls)
        (final (cdr ls))))


(define sumsquare (lambda x (foldr + 0 (map square x))))

(define (square x) (* x x))

(sumsquare 3 4)


