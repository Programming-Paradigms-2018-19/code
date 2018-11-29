module Fibonacci (
lazyFib,
fib
) where

lazyFib :: Int -> Int -> [Int]
lazyFib x y = x:(lazyFib y (x + y))

fib :: Int -> Int
fib x = head (drop (x - 1) (lazyFib 1 1))
