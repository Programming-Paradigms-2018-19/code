#lang racket
(define (reverse x)
  (revhelp x empty))

(define (revhelp x res)
  (if (null? x)
      res
      (revhelp (cdr x) (cons (car x) res))))

(define (nums n)
  (if (= n 0)
      '()
      (cons n (nums (- n 1)))))

(reverse (nums 100000))


