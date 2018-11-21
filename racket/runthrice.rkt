Welcome to DrRacket, version 6.0.1 [3m].
Language: racket; memory limit: 128 MB.
"start"
> ((thrice(thrice dub)) 3)
1536
> ((thrice dub) 3)
24
> (((thrice thrice) dub) 3)
402653184
> (dub 2)
4
> ((thrice dub) 3)
24
> (dub 2)
4
> ((thrice dub) 2
               )
16
> (dub 1)
2
> ((thrice dub) 1)
8
> ((thrice(thrice dub)) 1)
512
> ((thrice(thrice (thrice dub))) 1)
134217728
> (((thrice thrice) dub) 1)
134217728
> 