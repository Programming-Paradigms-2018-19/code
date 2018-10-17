; Lecture: Thunks, Laziness, Streams, Memoization

#lang racket

(provide (all-defined-out))

;;;;;; zero-argument functions (thunks) delay evaluation

(define (factorial-normal x)
  (if (= x 0)
      1
      (* x (factorial-normal (- x 1)))))

(define (my-if-bad e1 e2 e3)
  (if e1 e2 e3))

(define (factorial-bad x)
  (my-if-bad (= x 0)
             1
             (* x 
                (factorial-bad (- x 1)))))

(define (my-if-strange-but-works e1 e2 e3)
  (if e1 (e2) (e3)))

(define (factorial-okay x)
  (my-if-strange-but-works (= x 0)
			   (lambda () 1)
			   (lambda () (* x (factorial-okay (- x 1))))))

;;;;;; thunking can help or hurt performance

; this is a silly addition function that purposely runs slows for 
; demonstration purposes
(define (slow-add x y)
  (letrec ([slow-id (lambda (y z)
                      (if (= 0 z)
                          y
                          (slow-id y (- z 1))))])
    (+ (slow-id x 50000000) y)))

; multiplies x and result of y-thunk, calling y-thunk x times
(define (my-mult x y-thunk) ;; assumes x is >= 0
  (cond [(= x 0) 0]
        [(= x 1) (y-thunk)]
        [#t (+ (y-thunk) (my-mult (- x 1) y-thunk))]))

; these calls: great for 0, okay for 1, bad for > 1        
;(my-mult 0 (lambda () (slow-add 3 4)))
;(my-mult 1 (lambda () (slow-add 3 4)))
;(my-mult 2 (lambda () (slow-add 3 4)))

; these calls: okay for all
;(my-mult 0 (let ([x (slow-add 3 4)]) (lambda () x)))
;(my-mult 1 (let ([x (slow-add 3 4)]) (lambda () x)))
;(my-mult 2 (let ([x (slow-add 3 4)]) (lambda () x)))

;;;;;; can use mutation for lazy evaluation:
;;;;;; "best of both worlds" for remembering pure-computation results

(define (my-delay th) 
  (mcons #f th)) ;; a one-of "type" we will update /in place/

(define (my-force p)
  (if (mcar p)
      (mcdr p)
      (begin (set-mcar! p #t)
             (set-mcdr! p ((mcdr p)))
             (mcdr p))))

; these calls: great for 0, okay for 1, okay for > 1
;(my-mult 0 (let ([x (my-delay (lambda () (slow-add 3 4)))]) (lambda () (my-force x))))
;(my-mult 1 (let ([x (my-delay (lambda () (slow-add 3 4)))]) (lambda () (my-force x))))
;(my-mult 2 (let ([x (my-delay (lambda () (slow-add 3 4)))]) (lambda () (my-force x))))

;;;;;; streams (uses of streams are below definitions of streams,
;;;;;; but we'll discuss uses before definitions)

;; define some streams

;(define ones-really-bad (cons 1 ones-really-bad))
(define ones-bad (lambda () (cons 1 (ones-bad))))

(define ones (lambda () (cons 1 ones)))

(define nats
  (letrec ([f (lambda (x) (cons x (lambda () (f (+ x 1)))))])
    (lambda () (f 1))))

(define powers-of-two
  (letrec ([f (lambda (x) (cons x (lambda () (f (* x 2)))))])
    (lambda () (f 2))))

(define (stream-maker fn arg)
  (letrec ([f (lambda (x) 
                (cons x (lambda () (f (fn x arg)))))])
    (lambda () (f arg))))
(define nats2  (stream-maker + 1))
(define powers2 (stream-maker * 2))

;; code that uses streams

(define (number-until stream tester)
  (letrec ([f (lambda (stream ans)
                (let ([pr (stream)])
                  (if (tester (car pr))
                      ans
                      (f (cdr pr) (+ ans 1)))))])
    (f stream 1)))

(define four (number-until powers-of-two (lambda (x) (= x 16))))

;;;;; memoization

(define (fibonacci1 x)
  (if (or (= x 1) (= x 2))
      1
      (+ (fibonacci1 (- x 1))
         (fibonacci1 (- x 2)))))

(define (fibonacci2 x)
  (letrec ([f (lambda (acc1 acc2 y)
                (if (= y x)
                    (+ acc1 acc2)
                    (f (+ acc1 acc2) acc1 (+ y 1))))])
    (if (or (= x 1) (= x 2))
        1
        (f 1 1 3))))

(define fibonacci3
  (letrec([memo null] ; list of pairs (arg . result) 
          [f (lambda (x)
               (let ([ans (assoc x memo)])
                 (if ans 
                     (cdr ans)
                     (let ([new-ans (if (or (= x 1) (= x 2))
                                        1
                                        (+ (f (- x 1))
                                           (f (- x 2))))])
                       (begin 
                         (set! memo (cons (cons x new-ans) memo))
                         new-ans)))))])
    f))
