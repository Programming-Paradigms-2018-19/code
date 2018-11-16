Welcome to DrRacket, version 6.10 [3m].
Language: Racket, with debugging; memory limit: 128 MB.
> (((oneorthree cdr) 8) '(q w e r t y))
'(r t y)
> (((oneorthree cdr) 1) '( q w e r t y))
'(r t y)
> (((oneorthree cdr) 0) '( q w e r t y))
'(w e r t y)
> 