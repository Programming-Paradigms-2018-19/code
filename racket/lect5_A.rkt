#lang racket
(define (reverse x)
  (if (null? x)
      '()
      (append (reverse (cdr x)) (cons (car x) '()))))

(define (reverse2 x res)
  (if (null? x)
      res
      (reverse2 (cdr x) (cons (car x) res))))

(define (newrev x)
  (reverse2 x '()))

(define (dreverse x)
  (cond ((null? x) '())
        ((not (pair? x)) x)
        (else (append (dreverse (cdr x)) (list (dreverse(car x)))))))

(define (accum op init seq)
  (if (null? seq)
      init
      (op (car seq) (accum op init (cdr seq)))))

(define (app list1 list2)
  (accum cons list2 list1))

(define (len x)
  (accum (lambda (x y) (+ 1 y)) '() x))

define (flatten x)
  (if (null? x)
      '()
    (append (car x) (flatten (cdr x)))))

(define (ac-flatten x)
  (accum append '() x))

(define (ac-map f s)
  (accum (lambda (x y) (cons (f x) y))
         '()
         s))

(define (ac-filter f s)
  (accum (lambda (x y)(if (f x) (cons x y) y))
         '()
         s))

(define (add-n-to-list alist n)
  (ac-map (lambda (x) (+ n x)) alist))

(define (between low high numlist)
  (ac-filter (lambda (n) (and (> n low) (< n high))) numlist))
