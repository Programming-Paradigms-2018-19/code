#lang racket

(define ((f x)y)
  (+ x y))

(define (dub x) (* 2 x))

(define (thrice f) (lambda (x) (f(f(f x)))))

((thrice dub) 5)
((thrice dub)((thrice dub) 5))
((thrice dub)((thrice dub)((thrice dub) 5)))
((thrice (thrice dub)) 5)
((thrice (thrice (thrice dub))) 5)
(((thrice thrice) dub)  5)

