#lang racket

(define (cube3 x)
  (* x x x))

(define (pow x y)
  (if (= y 0)
      1
      (* x (pow x (- y 1)))))

(define pow2
  (lambda (x)
    (lambda (y)
      (if (= y 0)
          1
          (* x ((pow2 x) (- y 1)))))))

(define three-to-the (pow 3))
(define eightyone (three-to-the 4))
(define sixteen ((pow 2) 4))

(define ((pow3 x) y)
  (if (= y 0)
      1
      (* x ((pow3 x) (- y 1)))))
