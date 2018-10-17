#lang racket

;;; code examples for functions with a variable number of arguments and for quasiquoting

;;; functions with a variable number of arguments
(define (squid a b . c)
  (display a) (newline)
  (display b) (newline)
  (display c) (newline))

(define (average . lst)
  (if (null? lst)
      (error "can't take the average of an empty list")
      (/ (apply + lst) (length lst))))


(define (sixties-bands m)
  (list '(peter paul mary)
        (list 'john 'paul 'george 'ringo m)
        '(simon garfunkle)))


(define (quasibands m)
  `((peter paul mary)
    (john paul george ringo ,m)
    (simon garfunkle)))

(quasibands 'eric)
