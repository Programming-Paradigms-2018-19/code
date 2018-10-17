#lang racket

(require rackunit
         "exampleTest.rkt")

(define file-tests
  (test-suite
   "Tests for exampleTest.rkt"
   
   (check-equal? (my-+ 1 1) 2 "Simple addition")
   (check-equal? (my-* 1 2) 2 "Simple multiplication")
   
   (test-case
    "List has length 4 and all elements even"
    (let ([lst (list 2 4 6 9)])
      (check = (length lst) 4)
      (for-each
       (lambda (elt)
         (check-pred even? elt))
       lst)))
   )
  )

;(require rackunit/text-ui)

;(run-tests file-tests)

(require rackunit/gui)
(test/gui file-tests)