#lang Racket
(define (twice f) (lambda (x) (f (f x))))

(define ((tw f) x) (f (f x)))

(define (((oneorthree f) n) x)
  (if (= n 0)
      (f x)
      (f (f (f x)))
   )
 )