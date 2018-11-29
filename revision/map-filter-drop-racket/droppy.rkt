#lang racket
(require racket/set)

(define (thing matrix row column number)
  (take (drop (car(take (drop matrix row)1))column)number))

(define mat '((1 2 3 x 5 6 7 8 9) 
              (2 2 3 y 5 6 7 8 9)
              (3 2 3 z 5 6 7 8 g)
              (4 2 3 4 5 6 7 8 9)
              (5 2 3 4 5 6 7 8 9)
              (6 2 3 4 5 6 7 8 9)
              (7 2 3 a (set 1 5) 6 7 8 9)
              (8 2 3 b 5 6 7 8 9)
              (9 2 3 c 5 6 7 8 9)))

(flatten (list (thing mat 6 6 3)
               (thing mat 7 6 3)
               (thing mat 8 6 3)))

(thing mat 4 4 4)