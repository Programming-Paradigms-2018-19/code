(define (zip lst1 lst2)
   (define (helper lst1 lst2 result)
     (cond 
        [(null? lst1) result]
        [(null? lst2) result]
        [else
            (helper (cdr lst1) (cdr lst2)
              (cons (list (car lst1) (car lst2)) result) )
        ]
      ))

      (reverse (helper lst1 lst2 '())))