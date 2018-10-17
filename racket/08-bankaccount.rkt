;;; Program adapted from one in "Structure and Interpretation of Computer Programs"

#lang racket

(define (make-account)
   (let ((my-balance 0))

      ;; return the current balance
      (define (balance)
         my-balance)

      ;; make a withdrawal
     (define (withdraw amount)
        (if (>= my-balance amount)
	   (begin (set! my-balance (- my-balance amount))
		   my-balance)
	   "Insufficient funds"))

     ;; make a deposit
     (define (deposit amount)
        (set! my-balance (+ my-balance amount))
        my-balance)

     ;; the dispatching function -- decide what to do with the request
     (define (dispatch m)
        (cond ((eq? m 'balance) balance)
	      ((eq? m 'withdraw) withdraw)
	      ((eq? m 'deposit) deposit)
	      (else (error "Unknown request -- MAKE-ACCOUNT"  m))))

      dispatch))


;;;   some commands to try:
;;;   (define acct1 (make-account))
;;;   (define acct2 (make-account))
;;;   ((acct1 'balance)) 
;;;   ((acct1 'deposit) 100)
;;;   ((acct1 'withdraw) 30)
;;;   ((acct1 'withdraw) 200)
;;;
;;;   ((acct2 'balance))  ; this is a different account from acct1!
