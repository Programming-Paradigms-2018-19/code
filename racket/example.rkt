#lang racket

(define x (list (list 1 2 3 4) 
                (list 5 6 7 8) 
                (list 9 10 11 12) 
                (list 13 14 15 16)))


(define (replace lst x y)
  (cond
    [(empty? lst) lst]
    [(list? (first lst)) (cons (replace (first lst) x y) (replace (rest lst) x y))]
    [(equal? (first lst) x) (cons y (replace (rest lst) x y))]
    [else (cons (first lst) (replace (rest lst) x y))]))

(define (extract matrix row column number)
  (take (drop (car (take (drop matrix row)1))column)number))

(define (manipulate matrix row column number)
  (replace (replace (extract matrix row column number) 6 99) 7 101))

(define (trans matrix row column number)
  (let ([inner (take matrix row)]
        [remainder (drop matrix row)])
    (cons (car inner) 
          (list 
           (flatten
            (list
             (take (first (take remainder 1))column)
             (manipulate matrix row column number)
             (drop (first (take remainder 1)) (+ column number)))  )            
           (car (drop matrix (- (length matrix) row)))
           
           )
          )
    )
  )

(trans x 1 1 2)