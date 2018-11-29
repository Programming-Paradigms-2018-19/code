#lang racket

(define (map fun lst)
  (if (null? lst)
      '()
      (cons (fun (car lst))
            (map fun (cdr lst)))))

(define (filter p? lst)
  (cond
    [(null? lst)      '()]
    [(p? (car lst))    (cons (car lst)
                             (filter p? (cdr lst)))]
    [else              (filter p? (cdr lst))]))

(map (lambda (x) (+ x 1)) '(1 2 3))
(filter (lambda (x) (= x 2)) '(1 2 3 4 5))